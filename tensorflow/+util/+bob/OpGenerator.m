classdef OpGenerator < util.mixin.Base
  %OPGENERATOR Summary of this class goes here
  %   Detailed explanation goes here

%TODO implement the following fields:
%   deprecation
%   is_aggregate
%   is_stateful
%   is_commutative
%   allows_uninitialized_input
%   control_output
%   unknown_fields
%   descriptor_function

  properties (Access=private)
    reserved_keywords = { ...
      'switch', 'function', 'while', 'if', 'else', 'end', 'case', 'for' ...
    };
  end

  properties
    op_dir = [];
    id = '';
    signatures = util.Typewriter;
  end

  methods
    function obj = OpGenerator(op_dir)
      obj.op_dir = op_dir;
      obj.setupDestination();

      disp('Parsing registered operations ...');
      proto = tensorflow.Buffer(tensorflow_m_('TF_GetAllOpList'), true);
      op_list = util.protobuf.parser.pb_read_tensorflow__OpList(proto.data());
      disp(['Generating ' num2str(numel(op_list.op)) ' functions for operations ...']);
      obj.generateFunctions(op_list.op);

      obj.generateWrapper();
    end

    function generateFunctions(obj, oplist)
      nops = numel(oplist);
      for i = 1:1:nops
        if strcmp(oplist(i).name(1), '_')
          % skip functions whose name starts with an underscore
          obj.debugMsg('Skipping %4d/%4d: ''%s''\n', i, nops, oplist(i).name);
        else
          if any(strcmpi(oplist(i).name, obj.reserved_keywords))
            % modify name if blacklisted
            oplist(i).name = [ oplist(i).name '_' ];
          end
          obj.debugMsg('Generating %4d/%4d: ''%s''\n', i, nops, oplist(i).name);
          obj.generateFunction(oplist(i));
        end
      end
    end
  end

  methods (Access=private)
    function setupDestination(obj)
      obj.debugMsg('Setting up the destination folder ...\n');
      files = dir(obj.op_dir);
      for f = files'
        name = f.name;
        if numel(name) > 2
          if strcmp(name(end-1:end), '.m')
            delete(fullfile(obj.op_dir, name));
          end
        end
      end
    end

    function generateWrapper(obj)
      obj.debugMsg('Generating wrapper class ...\n');
      tw = util.Typewriter;
      tw <  'classdef Ops < util.mixin.Base';
      tw <  '  %OPS Wrapper class to hold generated graph operations.';
      tw <  '  %   This class definition is automatically generated when building tensorflow.m.';
      tw <= '  %   Do not edit this file.';
      tw <  '  methods (Access=public)';
      tw <  strcat({'    '}, obj.signatures.getText());
      tw <  '  end';
      tw < 'end';

      file = fullfile(obj.op_dir, 'Ops.m');
      fid = fopen(file, 'w');
      fprintf(fid, '%s\n', tw.getText{:});
      fclose(fid);
    end

    function generateFunction(obj, op_)
      op = obj.preprocess(op_);

      tw = util.Typewriter;
      tw <= obj.gen_INIT_(op);

      % generate input_arg
      for i = 1:numel(op.input_arg)
        tw <= obj.gen_input_arg_(op.input_arg(i));
      end

      % generate attributes
      for i = 1:numel(op.attr)
        tw < obj.gen_attr_(op.attr(i));
      end
      tw.addEmptyLine();

      tw < obj.gen_EXIT_();

      file = fullfile(obj.op_dir, [op.id '.m']);
      fid = fopen(file, 'w');
      fprintf(fid, '%s\n', tw.getText{:});
      fclose(fid);
    end

    function op = preprocess(obj, op_)
      % preprocessing op: name, inputs, outputs and attributes
      op = op_;
      op.id = lower(op.name);

      op.num.inputs = numel(op.input_arg);
      op.num.outputs = numel(op.output_arg);
      op.num.attrs = numel(op.attr);

      argstring = 'obj';
      if op.num.inputs > 0
        for i = 1:1:op.num.inputs
          if any(strcmpi(op.input_arg(i).name, obj.reserved_keywords))
            op.input_arg(i).name = [ op.input_arg(i).name '_' ]; % modify name if blacklisted
          end
        end

        argstring = [ argstring ', ' strjoin({ op.input_arg(:).name }, ', ')];

        % fetch all attributes that can be inferred from inputs
        input_attrs = unique({ op.input_arg(:).type_attr, ...
                               op.input_arg(:).number_attr, ...
                               op.input_arg(:).type_list_attr });
        input_attrs = input_attrs(~cellfun('isempty', input_attrs)); % remove empty entries
      end

      if op.num.outputs > 0
        for i = 1:1:op.num.outputs
          if any(strcmpi(op.output_arg(i).name, obj.reserved_keywords))
            op.output_arg(i).name = [ op.output_arg(i).name '_' ]; % modify name if blacklisted
          end
        end
        
        % fetch all attributes that are required by outputs
        output_attrs = unique({ op.output_arg(:).type_attr, ...
                                op.output_arg(:).number_attr, ...
                                op.output_arg(:).type_list_attr });
        output_attrs = output_attrs(~cellfun('isempty', output_attrs)); % remove empty entries
      end

      op.num.attrs_required = 0;
      op.num.attrs_optional = 0;
      for i = 1:1:op.num.attrs
        op.attr(i).is_required = true;
        op.attr(i).is_inferred = false;
        if any(strcmpi(op.attr(i).name, obj.reserved_keywords))
          % modify name if blacklisted
          op.attr(i).name = [ op.attr(i).name '_' ];
        end
        if op.num.inputs > 0 && any(strcmp(input_attrs, op.attr(i).name))
          % inferred
          op.attr(i).is_required = false;
          op.attr(i).is_inferred = true;
        elseif ~isempty(op.attr(i).default_value)
          % has default value - is optional
          op.attr(i).is_required = false;
          op.num.attrs_optional = op.num.attrs_optional + 1;
        else
          op.num.attrs_required = op.num.attrs_required + 1;
          % needs to be a function argument
          argstring = [ argstring ', ' op.attr(i).name ];
        end
      end

      % add varargin for name/value pairs of optional attributes and op name
      op.argstring = [ argstring ', varargin' ];
    end

    function txt = gen_INIT_(obj, op)
      tw = util.Typewriter;

      % signature
      sig = [ 'out = ' op.id '(' op.argstring ')' ];
      tw < [ 'function ' sig ];
      obj.signatures < sig; % store signature to later write into classdef file

      % summary + description
      tw < [ '%' upper(op.id) ' ' op.summary ];
      for line = strsplit(op.description, '\n')'
        tw < [ '%   ' line{:} ];
      end

      % information on function I/O
      % TODO more details on required/optional input arguments and outputs
      tw <    '%';
      tw <    '% Signature: ';
      tw <= [ '%   ' sig ];

      % Automatic generation notice
      tw <   '% <auto-generated>';
      tw <   '%   Generated by OpGenerator of tensorflow.m. DO NOT EDIT!';
      tw < [ '%   Source OpDef: ' op.name ];
      tw <=  '% </auto-generated>';

      % input arguments
      narg_min = 1 + op.num.inputs + op.num.attrs_required; % 1[graph] + number_of_inputs + number_of_required_attrs
      narg_max = 1 + narg_min + 2*(op.num.attrs_optional + 1); % 1[graph] + number_of_inputs + number_of_required_attrs + 2*(number_of_optional_attrs + 1[op_name])
      tw < [ '  assert(nargin >= ' num2str(narg_min) ', ''Not enough input arguments.'');' ];
      tw < [ '  assert(nargin <= ' num2str(narg_max) ', ''Too many input arguments.'');' ];
      tw <=  '  assert(isa(obj, ''tensorflow.Graph''), ''First input argument must be of class tensorflow.Graph.'');'; % asserting graph

      % process varargin
      tw < '  p = inputParser;';
      tw < '  addParameter(p, ''name'', '''', @ischar);'; % op name
      for i = 1:1:op.num.attrs
        if ~op.attr(i).is_required && ~op.attr(i).is_inferred
          tw < [ '  addParameter(p, ''' op.attr(i).name ''', []);' ];
        end
      end
      tw <= '  parse(p, varargin{:});';

      tw <   '  op_name = p.Results.name;';
      for i = 1:1:op.num.attrs
        if ~op.attr(i).is_required && ~op.attr(i).is_inferred
          tw < [ '  ' op.attr(i).name ' = p.Results.' op.attr(i).name ';' ];
        end
      end
      tw.addEmptyLine();

      % op name either supplied or randomized
      tw <   '  if isempty(op_name)';
      tw <   '    [~, randkey] = obj.hash_generator.sha1();';
      tw < [ '    op_name = [ ''' op.name '_''' ' randkey ];' ];
      tw <=  '  end';

      % op description
      tw < [ '  desc = obj.newOperation(''' op.name ''', op_name);' ];

      txt = tw.getText();
    end

    function txt = gen_input_arg_(obj, input_arg)
      tw = util.Typewriter;
      name = input_arg.name;
      tw < [ '  assert(~any(isempty(' name ')), ''All input values of ''''' name ''''' must be non-empty.'');' ];
      tw < [ '  assert(isa(' name ', ''tensorflow.Output''), ''Input values of ''''' name ''''' must be of class tensorflow.Output.'');' ]

      if ~isempty(input_arg.number_attr)
        tw < [ '  ' name ' = ' name '(:);' ];
        tw < [ '  desc.addInputList(' name ');' ];
      else
        tw < [ '  desc.addInput(' name ');' ];
      end

      txt = tw.getText();
    end

    function txt = gen_attr_(obj, attr)
      tw = util.Typewriter;
      % attributes can be ...
      % ... inferred: nothing to do
      if ~attr.is_inferred
        if attr.is_required
          % ... required: set attribute
          tw < strcat({'  '}, obj.set_attr_(attr));
        else
          % ... optional: if parsed from name/value pairs, set attribute
          tw < [ '  if ~isempty(' attr.name ')' ];
          tw < strcat({'    '}, obj.set_attr_(attr));
          tw < '  end';
        end
      end

      txt = tw.getText();
    end

    function txt = set_attr_(obj, attr)
      tw = util.Typewriter;
      fcn = 'setAttr';
      lmatch = regexp(attr.type, 'list\((.*)\)', 'tokens');
      if isempty(lmatch) % not a list
        fcn = [ fcn upper(attr.type(1)) attr.type(2:end) ];
      else % a list
        type = lmatch{1}{1};
        fcn = [ fcn upper(type(1)) type(2:end) 'List' ];
      end
      tw < [ 'desc.' fcn '(''' attr.name ''', ' attr.name ');' ];
      txt = tw.getText();
    end

    function txt = gen_EXIT_(obj)
      tw = util.Typewriter;
      tw < '  out = tensorflow.Output(desc.finishOperation());';
      tw < 'end' ;

      txt = tw.getText();
    end
  end
end
