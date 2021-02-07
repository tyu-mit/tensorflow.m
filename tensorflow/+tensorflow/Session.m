classdef Session < util.mixin.Pointer
  %SESSION Summary of this class goes here
  %   Detailed explanation goes here

  properties (SetAccess=protected)
    status = [];
  end

  methods
    function obj = Session(varargin)
      if nargin == 1 && isa(varargin{1}, 'uint64')
        ref = varargin{1}; % create pointer from given reference
        owned = false;
        status = tensorflow.Status();
      else
        if nargin == 1
          graph = varargin{1};
          opts = tensorflow.SessionOptions();
        elseif nargin == 2
          graph = varargin{1};
          opts = varargin{2};
        else
          error('tensorflow:Session:InputArguments', 'Cannot create tensorflow.Session with given arguments.');
        end
        assert(isa(graph, 'tensorflow.Graph'), 'Provided graph must be of class tensorflow.Graph.');
        assert(isa(opts, 'tensorflow.SessionOptions'), 'Provided options must be of class tensorflow.SessionOptions.');

        status = tensorflow.Status();
        ref = tensorflow_m_('TF_NewSession', graph.ref, opts.ref, status.ref);
        status.maybe_raise();
        owned = true;
      end

      obj.set_reference_(ref, owned);
      obj.status = status;
    end

    % TF_CAPI_EXPORT extern void TF_CloseSession(TF_Session*, TF_Status* status);
    % TODO

    % TF_CAPI_EXPORT extern void TF_DeleteSession(TF_Session*, TF_Status* status);
    function deleteSession(obj)
      obj.delete();
    end

    % TF_CAPI_EXPORT extern void TF_SessionRun(TF_Session* session, const TF_Buffer* run_options, const TF_Output* inputs, TF_Tensor* const* input_values, int ninputs, const TF_Output* outputs, TF_Tensor** output_values, int noutputs, const TF_Operation* const* target_opers, int ntargets, TF_Buffer* run_metadata, TF_Status*);
    function res = run(obj, inputs, input_values, outputs, target_opers, run_options, run_metadata)
      if nargin < 4 || nargin > 8
        error('tensorflow:Session:run:InputArguments', 'Wrong number of input arguments provided.');
      end
      if numel(inputs) > 0
        if iscell(inputs)
          for idx = 1:numel(inputs)
            assert(isa(inputs{idx}, 'tensorflow.Output'), 'Provided inputs must be of class tensorflow.Output.');
            assert(isa(input_values{idx}, 'tensorflow.Tensor'), 'Provided input values must be of class tensorflow.Tensor.');
          end
        else
            assert(isa(inputs, 'tensorflow.Output'), 'Provided inputs must be of class tensorflow.Output.');
            assert(isa(input_values, 'tensorflow.Tensor'), 'Provided input values must be of class tensorflow.Tensor.');
        end
      end
      if numel(outputs) > 0
        if iscell(outputs)
          for idx = 1:numel(outputs)
            assert(isa(outputs{idx}, 'tensorflow.Output'), 'Provided outputs must be of class tensorflow.Output.');
          end
        else
            assert(isa(outputs, 'tensorflow.Output'), 'Provided outputs must be of class tensorflow.Output.');
        end
      end

      if nargin > 4
        assert(isa(target_opers, 'tensorflow.Operation'), 'Provided target operations must be of class tensorflow.Operation.');
      else
        target_opers = [];
      end

      % TODO additional arguments are not supported yet; consider this pseudo code
      run_options = [];
      if nargin > 5
        assert(isa(run_options, 'tensorflow.Buffer'), 'Provided run options must be of class tensorflow.Buffer.');
      end
      run_metadata = [];
      if nargin > 6
        assert(isa(run_metadata, 'tensorflow.Buffer'), 'Provided run metadata must be of class tensorflow.Buffer.');
      end

      ninputs = numel(inputs);
      inputs_ref = [];
      input_values_ref = [];
      if ninputs > 0
        assert(ninputs == numel(input_values), 'Number of provided inputs and input values must be equal.');
        if iscell(inputs)
          inputs_ref = zeros(1, ninputs);
          input_values_ref = zeros(1, ninputs);
          for idx = 1:ninputs
            inputs_ref(idx) = inputs{idx}.ref;
            input_values_ref(idx) = input_values{idx}.ref;
          end
        else
            inputs_ref = [inputs.ref];
            input_values_ref = [input_values.ref];
        end
      end

      noutputs = numel(outputs);
      outputs_ref = [];
      if noutputs > 0
          if iscell(outputs)
            outputs_ref = zeros(1, noutputs);
            for idx = 1:numel(outputs)
              outputs_ref(idx) = outputs{idx}.ref; 
            end
          else
            outputs_ref = [outputs.ref];
          end
      end

      ntargets = numel(target_opers);
      target_opers_ref = [];
      if ntargets > 0
        target_opers_ref = [target_opers.ref];
      end

      refs = tensorflow_m_('TF_SessionRun', obj.ref, run_options, ...
                           uint64(inputs_ref), uint64(input_values_ref), ...
                           int32(ninputs), uint64(outputs_ref), ...
                           int32(noutputs), target_opers_ref, ...
                           int32(ntargets), run_metadata, obj.status.ref);
      obj.status.maybe_raise();
      if ~isempty(refs)
        res = tensorflow.Tensor(refs, true);
      else
        res = [];
      end
    end

    % TF_CAPI_EXPORT extern void TF_SessionPRunSetup(TF_Session*, const TF_Output* inputs, int ninputs, const TF_Output* outputs, int noutputs, const TF_Operation* const* target_opers, int ntargets, const char** handle, TF_Status*);
    % TODO

    % TF_CAPI_EXPORT extern void TF_SessionPRun(TF_Session*, const char* handle, const TF_Output* inputs, TF_Tensor* const* input_values, int ninputs, const TF_Output* outputs, TF_Tensor** output_values, int noutputs, const TF_Operation* const* target_opers, int ntargets, TF_Status*);
    % TODO

    % TF_CAPI_EXPORT extern TF_DeviceList* TF_SessionListDevices(TF_Session* session, TF_Status* status);
    % TODO

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    function delete(obj)
      if obj.isdeletable()
        tensorflow_m_('TF_DeleteSession', obj.ref, obj.status.ref);
        obj.status.maybe_raise();
      end
      delete@util.mixin.Pointer(obj);
    end
  end
end
