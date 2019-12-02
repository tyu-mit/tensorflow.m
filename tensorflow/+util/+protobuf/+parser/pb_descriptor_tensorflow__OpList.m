function [descriptor] = pb_descriptor_tensorflow__OpList()
%pb_descriptor_tensorflow__OpList Returns the descriptor for message OpList.
%   function [descriptor] = pb_descriptor_tensorflow__OpList()
%
%   See also pb_read_tensorflow__OpList

  descriptor = struct( ...
    'name', 'OpList', ...
    'full_name', 'tensorflow.OpList', ...
    'filename', 'tensorflow/core/framework/op_def.proto', ...
    'containing_type', '', ...
    'fields', [ ...
      struct( ...
        'name', 'op', ...
        'full_name', 'tensorflow.OpList.op', ...
        'index', 1, ...
        'number', uint32(1), ...
        'type', uint32(11), ...
        'matlab_type', uint32(9), ...
        'wire_type', uint32(2), ...
        'label', uint32(3), ...
        'default_value', struct([]), ...
        'read_function', @(x) util.protobuf.parser.pb_read_tensorflow__OpDef(x{1}, x{2}, x{3}), ...
        'write_function', @(x) util.protobuf.lib.pblib_generic_serialize_to_string(x), ...
        'options', struct('packed', false) ...
      ) ...
    ], ...
    'extensions', [ ... % Not Implemented
    ], ...
    'nested_types', [ ... % Not implemented
    ], ...
    'enum_types', [ ... % Not Implemented
    ], ...
    'options', [ ... % Not Implemented
    ] ...
  );

  descriptor.field_indeces_by_number = javaObject('java.util.HashMap');
  javaMethod('put', descriptor.field_indeces_by_number, uint32(1), 1);