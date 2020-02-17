function [descriptor] = pb_descriptor_tensorflow__TensorProto()
%pb_descriptor_tensorflow__TensorProto Returns the descriptor for message TensorProto.
%   function [descriptor] = pb_descriptor_tensorflow__TensorProto()
%
%   See also pb_read_tensorflow__TensorProto

  descriptor = struct( ...
    'name', 'TensorProto', ...
    'full_name', 'tensorflow.TensorProto', ...
    'filename', 'tensorflow/core/framework/tensor.proto', ...
    'containing_type', '', ...
    'fields', [ ...
      struct( ...
        'name', 'dtype', ...
        'full_name', 'tensorflow.TensorProto.dtype', ...
        'index', 1, ...
        'number', uint32(1), ...
        'type', uint32(14), ...
        'matlab_type', uint32(10), ...
        'wire_type', uint32(0), ...
        'label', uint32(1), ...
        'default_value', int32(0), ...
        'read_function', @(x) util.protobuf.lib.pblib_helpers_first(typecast(x, 'int32')), ...
        'write_function', @(x) typecast(int32(x), 'uint32'), ...
        'options', struct('packed', false) ...
      ), ...
      struct( ...
        'name', 'tensor_shape', ...
        'full_name', 'tensorflow.TensorProto.tensor_shape', ...
        'index', 2, ...
        'number', uint32(2), ...
        'type', uint32(11), ...
        'matlab_type', uint32(9), ...
        'wire_type', uint32(2), ...
        'label', uint32(1), ...
        'default_value', struct([]), ...
        'read_function', @(x) util.protobuf.parser.pb_read_tensorflow__TensorShapeProto(x{1}, x{2}, x{3}), ...
        'write_function', @(x) util.protobuf.lib.pblib_generic_serialize_to_string(x), ...
        'options', struct('packed', false) ...
      ), ...
      struct( ...
        'name', 'version_number', ...
        'full_name', 'tensorflow.TensorProto.version_number', ...
        'index', 3, ...
        'number', uint32(3), ...
        'type', uint32(5), ...
        'matlab_type', uint32(1), ...
        'wire_type', uint32(0), ...
        'label', uint32(1), ...
        'default_value', int32(0), ...
        'read_function', @(x) util.protobuf.lib.pblib_helpers_first(typecast(x, 'int32')), ...
        'write_function', @(x) typecast(int32(x), 'uint32'), ...
        'options', struct('packed', false) ...
      ), ...
      struct( ...
        'name', 'tensor_content', ...
        'full_name', 'tensorflow.TensorProto.tensor_content', ...
        'index', 4, ...
        'number', uint32(4), ...
        'type', uint32(12), ...
        'matlab_type', uint32(8), ...
        'wire_type', uint32(2), ...
        'label', uint32(1), ...
        'default_value', uint8(''), ...
        'read_function', @(x) uint8(x{1}(x{2} : x{3})), ...
        'write_function', @uint8, ...
        'options', struct('packed', false) ...
      ), ...
      struct( ...
        'name', 'float_val', ...
        'full_name', 'tensorflow.TensorProto.float_val', ...
        'index', 5, ...
        'number', uint32(5), ...
        'type', uint32(2), ...
        'matlab_type', uint32(6), ...
        'wire_type', uint32(5), ...
        'label', uint32(3), ...
        'default_value', single([]), ...
        'read_function', @(x) typecast(x, 'single'), ...
        'write_function', @(x) typecast(single(x), 'uint8'), ...
        'options', struct('packed', true) ...
      ), ...
      struct( ...
        'name', 'double_val', ...
        'full_name', 'tensorflow.TensorProto.double_val', ...
        'index', 6, ...
        'number', uint32(6), ...
        'type', uint32(1), ...
        'matlab_type', uint32(5), ...
        'wire_type', uint32(1), ...
        'label', uint32(3), ...
        'default_value', double([]), ...
        'read_function', @(x) typecast(x, 'double'), ...
        'write_function', @(x) typecast(double(x), 'uint8'), ...
        'options', struct('packed', true) ...
      ), ...
      struct( ...
        'name', 'int_val', ...
        'full_name', 'tensorflow.TensorProto.int_val', ...
        'index', 7, ...
        'number', uint32(7), ...
        'type', uint32(5), ...
        'matlab_type', uint32(1), ...
        'wire_type', uint32(0), ...
        'label', uint32(3), ...
        'default_value', int32([]), ...
        'read_function', @(x) util.protobuf.lib.pblib_helpers_first(typecast(x, 'int32')), ...
        'write_function', @(x) typecast(int32(x), 'uint32'), ...
        'options', struct('packed', true) ...
      ), ...
      struct( ...
        'name', 'string_val', ...
        'full_name', 'tensorflow.TensorProto.string_val', ...
        'index', 8, ...
        'number', uint32(8), ...
        'type', uint32(12), ...
        'matlab_type', uint32(8), ...
        'wire_type', uint32(2), ...
        'label', uint32(3), ...
        'default_value', uint8([]), ...
        'read_function', @(x) uint8(x{1}(x{2} : x{3})), ...
        'write_function', @uint8, ...
        'options', struct('packed', false) ...
      ), ...
      struct( ...
        'name', 'scomplex_val', ...
        'full_name', 'tensorflow.TensorProto.scomplex_val', ...
        'index', 9, ...
        'number', uint32(9), ...
        'type', uint32(2), ...
        'matlab_type', uint32(6), ...
        'wire_type', uint32(5), ...
        'label', uint32(3), ...
        'default_value', single([]), ...
        'read_function', @(x) typecast(x, 'single'), ...
        'write_function', @(x) typecast(single(x), 'uint8'), ...
        'options', struct('packed', true) ...
      ), ...
      struct( ...
        'name', 'int64_val', ...
        'full_name', 'tensorflow.TensorProto.int64_val', ...
        'index', 10, ...
        'number', uint32(10), ...
        'type', uint32(3), ...
        'matlab_type', uint32(2), ...
        'wire_type', uint32(0), ...
        'label', uint32(3), ...
        'default_value', int64([]), ...
        'read_function', @(x) typecast(x, 'int64'), ...
        'write_function', @(x) typecast(int64(x), 'uint64'), ...
        'options', struct('packed', true) ...
      ), ...
      struct( ...
        'name', 'bool_val', ...
        'full_name', 'tensorflow.TensorProto.bool_val', ...
        'index', 11, ...
        'number', uint32(11), ...
        'type', uint32(8), ...
        'matlab_type', uint32(3), ...
        'wire_type', uint32(0), ...
        'label', uint32(3), ...
        'default_value', uint32([]), ...
        'read_function', @(x) util.protobuf.lib.pblib_helpers_first(typecast(x, 'uint32')), ...
        'write_function', @(x) typecast(uint32(x), 'uint32'), ...
        'options', struct('packed', true) ...
      ), ...
      struct( ...
        'name', 'dcomplex_val', ...
        'full_name', 'tensorflow.TensorProto.dcomplex_val', ...
        'index', 12, ...
        'number', uint32(12), ...
        'type', uint32(1), ...
        'matlab_type', uint32(5), ...
        'wire_type', uint32(1), ...
        'label', uint32(3), ...
        'default_value', double([]), ...
        'read_function', @(x) typecast(x, 'double'), ...
        'write_function', @(x) typecast(double(x), 'uint8'), ...
        'options', struct('packed', true) ...
      ), ...
      struct( ...
        'name', 'half_val', ...
        'full_name', 'tensorflow.TensorProto.half_val', ...
        'index', 13, ...
        'number', uint32(13), ...
        'type', uint32(5), ...
        'matlab_type', uint32(1), ...
        'wire_type', uint32(0), ...
        'label', uint32(3), ...
        'default_value', int32([]), ...
        'read_function', @(x) util.protobuf.lib.pblib_helpers_first(typecast(x, 'int32')), ...
        'write_function', @(x) typecast(int32(x), 'uint32'), ...
        'options', struct('packed', true) ...
      ), ...
      struct( ...
        'name', 'resource_handle_val', ...
        'full_name', 'tensorflow.TensorProto.resource_handle_val', ...
        'index', 14, ...
        'number', uint32(14), ...
        'type', uint32(11), ...
        'matlab_type', uint32(9), ...
        'wire_type', uint32(2), ...
        'label', uint32(3), ...
        'default_value', struct([]), ...
        'read_function', @(x) util.protobuf.parser.pb_read_tensorflow__ResourceHandleProto(x{1}, x{2}, x{3}), ...
        'write_function', @(x) util.protobuf.lib.pblib_generic_serialize_to_string(x), ...
        'options', struct('packed', false) ...
      ), ...
      struct( ...
        'name', 'variant_val', ...
        'full_name', 'tensorflow.TensorProto.variant_val', ...
        'index', 15, ...
        'number', uint32(15), ...
        'type', uint32(11), ...
        'matlab_type', uint32(9), ...
        'wire_type', uint32(2), ...
        'label', uint32(3), ...
        'default_value', struct([]), ...
        'read_function', @(x) util.protobuf.parser.pb_read_tensorflow__VariantTensorDataProto(x{1}, x{2}, x{3}), ...
        'write_function', @(x) util.protobuf.lib.pblib_generic_serialize_to_string(x), ...
        'options', struct('packed', false) ...
      ), ...
      struct( ...
        'name', 'uint32_val', ...
        'full_name', 'tensorflow.TensorProto.uint32_val', ...
        'index', 16, ...
        'number', uint32(16), ...
        'type', uint32(13), ...
        'matlab_type', uint32(3), ...
        'wire_type', uint32(0), ...
        'label', uint32(3), ...
        'default_value', uint32([]), ...
        'read_function', @(x) util.protobuf.lib.pblib_helpers_first(typecast(x, 'uint32')), ...
        'write_function', @(x) typecast(uint32(x), 'uint32'), ...
        'options', struct('packed', true) ...
      ), ...
      struct( ...
        'name', 'uint64_val', ...
        'full_name', 'tensorflow.TensorProto.uint64_val', ...
        'index', 17, ...
        'number', uint32(17), ...
        'type', uint32(4), ...
        'matlab_type', uint32(4), ...
        'wire_type', uint32(0), ...
        'label', uint32(3), ...
        'default_value', uint64([]), ...
        'read_function', @(x) typecast(x, 'uint64'), ...
        'write_function', @(x) typecast(uint64(x), 'uint64'), ...
        'options', struct('packed', true) ...
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
  javaMethod('put', descriptor.field_indeces_by_number, uint32(2), 2);
  javaMethod('put', descriptor.field_indeces_by_number, uint32(3), 3);
  javaMethod('put', descriptor.field_indeces_by_number, uint32(4), 4);
  javaMethod('put', descriptor.field_indeces_by_number, uint32(5), 5);
  javaMethod('put', descriptor.field_indeces_by_number, uint32(6), 6);
  javaMethod('put', descriptor.field_indeces_by_number, uint32(7), 7);
  javaMethod('put', descriptor.field_indeces_by_number, uint32(8), 8);
  javaMethod('put', descriptor.field_indeces_by_number, uint32(9), 9);
  javaMethod('put', descriptor.field_indeces_by_number, uint32(10), 10);
  javaMethod('put', descriptor.field_indeces_by_number, uint32(11), 11);
  javaMethod('put', descriptor.field_indeces_by_number, uint32(12), 12);
  javaMethod('put', descriptor.field_indeces_by_number, uint32(13), 13);
  javaMethod('put', descriptor.field_indeces_by_number, uint32(14), 14);
  javaMethod('put', descriptor.field_indeces_by_number, uint32(15), 15);
  javaMethod('put', descriptor.field_indeces_by_number, uint32(16), 16);
  javaMethod('put', descriptor.field_indeces_by_number, uint32(17), 17);