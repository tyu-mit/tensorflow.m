classdef ImportGraphDefResults < util.mixin.Pointer
  %IMPORTGRAPHDEFRESULTS Summary of this class goes here
  %   Detailed explanation goes here

  methods
    function obj = ImportGraphDefResults(ref)
      assert(isa(ref, 'uint64'));
      obj.set_reference_(ref, true);
    end

    % TF_CAPI_EXPORT extern void TF_ImportGraphDefResultsReturnOutputs(TF_ImportGraphDefResults* results, int* num_outputs, TF_Output** outputs);
    function outputs = returnOutputs(obj)
      refs = tensorflow_m_('TF_ImportGraphDefResultsReturnOutputs', obj.ref);
      outputs = tensorflow.Output(refs, false); % no ownership, according to comment in header file
    end

    % TF_CAPI_EXPORT extern void TF_ImportGraphDefResultsReturnOperations(TF_ImportGraphDefResults* results, int* num_opers, TF_Operation*** opers);
    function operations = returnOperations(obj)
      refs = tensorflow_m_('TF_ImportGraphDefResultsReturnOperations', obj.ref);
      operations = tensorflow.Operation(refs, false); % no ownership, according to comment in header file
    end

    % TF_CAPI_EXPORT extern void TF_ImportGraphDefResultsMissingUnusedInputMappings(TF_ImportGraphDefResults* results, int* num_missing_unused_input_mappings, const char*** src_names, int** src_indexes);
    % TODO

    % TF_CAPI_EXPORT extern void TF_DeleteImportGraphDefResults(TF_ImportGraphDefResults* results);
    function deleteImportGraphDefResults(obj)
      obj.delete();
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    function delete(obj)
      if obj.isdeletable()
        tensorflow_m_('TF_DeleteImportGraphDefResults', obj.ref);
      end
      delete@util.mixin.Pointer(obj);
    end

  end
end
