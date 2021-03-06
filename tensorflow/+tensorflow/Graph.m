classdef Graph < util.mixin.Pointer & tensorflow.Ops
  %GRAPH Summary of this class goes here
  %   Detailed explanation goes here

  properties (SetAccess=protected)
    status = [];
  end

  methods
    % TF_CAPI_EXPORT extern TF_Graph* TF_NewGraph(void);
    function obj = Graph()
      ref = tensorflow_m_('TF_NewGraph');
      obj.set_reference_(ref, true);
      obj.status = tensorflow.Status();
    end

    % TF_CAPI_EXPORT extern void TF_DeleteGraph(TF_Graph*);
    function deleteGraph(obj)
      obj.delete();
    end

    % TF_CAPI_EXPORT extern void TF_GraphSetTensorShape(TF_Graph* graph, TF_Output output, const int64_t* dims, const int num_dims, TF_Status* status);
    function setTensorShape(obj, output, dims)
      tensorflow_m_('TF_GraphSetTensorShape', obj.ref, output.ref, int64(dims), int32(numel(dims)), obj.status.ref);
      obj.status.maybe_raise();
    end

    % TF_CAPI_EXPORT extern int TF_GraphGetTensorNumDims(TF_Graph* graph, TF_Output output, TF_Status* status);
    function dims = getTensorNumDims(obj, output)
      assert(isa(output, 'tensorflow.Output'), 'Provided output must be of class tensorflow.Output.');
      dims = double(tensorflow_m_('TF_GraphGetTensorNumDims', obj.ref, output.ref, obj.status.ref));
      obj.status.maybe_raise();
    end

    % TF_CAPI_EXPORT extern void TF_GraphGetTensorShape(TF_Graph* graph, TF_Output output, int64_t* dims, int num_dims, TF_Status* status);
    function dims = getTensorShape(obj, output)
      assert(isa(output, 'tensorflow.Output'), 'Provided output must be of class tensorflow.Output.');
      dims = double(tensorflow_m_('TF_GraphGetTensorShape', obj.ref, output.ref, obj.status.ref));
      obj.status.maybe_raise();
    end

    % TF_CAPI_EXPORT extern TF_OperationDescription* TF_NewOperation(TF_Graph* graph, const char* op_type, const char* oper_name);
    function desc = newOperation(obj, op_type, op_name)
      desc = tensorflow.OperationDescription(obj, op_type, op_name);
    end

    % TF_CAPI_EXPORT extern TF_Operation* TF_GraphOperationByName(TF_Graph* graph, const char* oper_name);
    function oper = operationByName(obj, oper_name)
      assert(ischar(oper_name), 'Provided operation name must be a string.');
      ref = tensorflow_m_('TF_GraphOperationByName', obj.ref, oper_name);
      assert(ref ~= 0, ['Couldn''t find operation by name ''' oper_name '''.']);
      oper = tensorflow.Operation(ref, false);
    end

    % TF_CAPI_EXPORT extern TF_Operation* TF_GraphNextOperation(TF_Graph* graph, size_t* pos);
    function oper = nextOperation(obj, pos)
      assert(isnumeric(pos) && isscalar(pos), 'Provided position must be numeric and scalar.');
      ref = tensorflow_m_('TF_GraphNextOperation', obj.ref, pos);
      oper = tensorflow.Operation(ref, false);
    end

    % TF_CAPI_EXPORT extern void TF_GraphToGraphDef(TF_Graph* graph, TF_Buffer* output_graph_def, TF_Status* status);
    % TODO

    % TF_CAPI_EXPORT extern void TF_GraphGetOpDef(TF_Graph* graph, const char* op_name, TF_Buffer* output_op_def, TF_Status* status);
    % TODO

    % TF_CAPI_EXPORT extern void TF_GraphVersions(TF_Graph* graph, TF_Buffer* output_version_def, TF_Status* status);
    % TODO

    % TF_CAPI_EXPORT extern TF_ImportGraphDefResults* TF_GraphImportGraphDefWithResults(TF_Graph* graph, const TF_Buffer* graph_def, const TF_ImportGraphDefOptions* options, TF_Status* status);
    function res = importGraphDefWithResults(obj, buffer, options)
      assert(isa(buffer, 'tensorflow.Buffer'), 'Provided graph definition must be of class tensorflow.Buffer.');
      assert(isa(options, 'tensorflow.ImportGraphDefOptions'), 'Provided options must be of class tensorflow.ImportGraphDefOptions.');
      res_ref = tensorflow_m_('TF_GraphImportGraphDefWithResults', obj.ref, buffer.ref, options.ref, obj.status.ref);
      obj.status.maybe_raise();
      res = tensorflow.ImportGraphDefResults(res_ref);
    end

    % TF_CAPI_EXPORT extern void TF_GraphImportGraphDefWithReturnOutputs(TF_Graph* graph, const TF_Buffer* graph_def, const TF_ImportGraphDefOptions* options, TF_Output* return_outputs, int num_return_outputs, TF_Status* status);
    % TODO

    % TF_CAPI_EXPORT extern void TF_GraphImportGraphDef(TF_Graph* graph, const TF_Buffer* graph_def, const TF_ImportGraphDefOptions* options, TF_Status* status);
    function importGraphDef(obj, buffer, options)
      assert(isa(buffer, 'tensorflow.Buffer'), 'Provided graph definition must be of class tensorflow.Buffer.');
      assert(isa(options, 'tensorflow.ImportGraphDefOptions'), 'Provided options must be of class tensorflow.ImportGraphDefOptions.');
      tensorflow_m_('TF_GraphImportGraphDef', obj.ref, buffer.ref, options.ref, obj.status.ref);
      obj.status.maybe_raise();
    end

    % TF_CAPI_EXPORT extern void TF_GraphCopyFunction(TF_Graph* g, const TF_Function* func, const TF_Function* grad, TF_Status* status);
    % TODO

    % TF_CAPI_EXPORT extern int TF_GraphNumFunctions(TF_Graph* g);
    % TODO

    % TF_CAPI_EXPORT extern int TF_GraphGetFunctions(TF_Graph* g, TF_Function** funcs, int max_func, TF_Status* status);
    % TODO

    % TF_CAPI_EXPORT extern TF_WhileParams TF_NewWhile(TF_Graph* g, TF_Output* inputs, int ninputs, TF_Status* status);
    % TODO
    % function wparams = newWhile(obj, inputs)
    %   % ref = tensorflow_m_('TF_NewWhile', obj.ref, inputs.ref, numel(inputs));
    %   % wparams = tensorflow.WhileParams(ref);
    % end

    % TF_CAPI_EXPORT void TF_AddGradients(TF_Graph* g, TF_Output* y, int ny, TF_Output* x, int nx, TF_Output* dx, TF_Status* status, TF_Output* dy);
    function dy = addGradients(obj, y, x)
      %TODO bug for numel(x) > 1
      assert(numel(x) == 1, 'addGradients currently only supports one denominating variable.');

      assert(isa(x, 'tensorflow.Output') && isa(y, 'tensorflow.Output'), 'Provided inputs must be of class tensorflow.Output.');
      ref = tensorflow_m_('TF_AddGradients', obj.ref, [y.ref], int32(numel(y)), [x.ref], int32(numel(x)), [], obj.status.ref);
      obj.status.maybe_raise();
      dy = tensorflow.Output(ref, true);
    end

    % TF_CAPI_EXPORT void TF_AddGradientsWithPrefix(TF_Graph* g, const char* prefix, TF_Output* y, int ny, TF_Output* x, int nx, TF_Output* dx, TF_Status* status, TF_Output* dy);
    % TODO

    % TF_CAPI_EXPORT extern TF_Function* TF_GraphToFunction(const TF_Graph* fn_body, const char* fn_name, unsigned char append_hash_to_fn_name, int num_opers, const TF_Operation* const* opers, int ninputs, const TF_Output* inputs, int noutputs, const TF_Output* outputs, const char* const* output_names, const TF_FunctionOptions* opts, const char* description, TF_Status* status);
    % TODO

    % TF_CAPI_EXPORT extern TF_Function* TF_GraphToFunctionWithControlOutputs(const TF_Graph* fn_body, const char* fn_name, unsigned char append_hash_to_fn_name, int num_opers, const TF_Operation* const* opers, int ninputs, const TF_Output* inputs, int noutputs, const TF_Output* outputs, const char* const* output_names, int ncontrol_outputs, const TF_Operation* const* control_outputs, const char* const* control_output_names, const TF_FunctionOptions* opts, const char* description, TF_Status* status);
    % TODO

    % TF_CAPI_EXPORT extern unsigned char TF_TryEvaluateConstant(TF_Graph* graph, TF_Output output, TF_Tensor** result, TF_Status* status);
    % TODO

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    function output = constant(obj, data, varargin)
      t = tensorflow.Tensor(data);
      output = obj.const(t, t.type, varargin{:});
    end

    function delete(obj)
      if obj.isdeletable()
        tensorflow_m_('TF_DeleteGraph', obj.ref);
      end
      delete@util.mixin.Pointer(obj);
    end
  end
end
