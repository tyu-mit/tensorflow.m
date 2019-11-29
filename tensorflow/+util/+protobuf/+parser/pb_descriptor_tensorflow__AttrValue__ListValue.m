function [descriptor] = pb_descriptor_tensorflow__AttrValue__ListValue()
%pb_descriptor_tensorflow__AttrValue__ListValue Returns the descriptor for message ListValue.
%   function [descriptor] = pb_descriptor_tensorflow__AttrValue__ListValue()
%
%   See also pb_read_tensorflow__AttrValue__ListValue

  descriptor = struct( ...
    'name', 'ListValue', ...
    'full_name', 'tensorflow.AttrValue.ListValue', ...
    'filename', 'tensorflow/core/framework/attr_value.proto', ...
    'containing_type', 'tensorflow.AttrValue', ...
    'fields', [ ...
      struct( ...
        'name', 's', ...
        'full_name', 'tensorflow.AttrValue.ListValue.s', ...
        'index', 1, ...
        'number', uint32(2), ...
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
        'name', 'i', ...
        'full_name', 'tensorflow.AttrValue.ListValue.i', ...
        'index', 2, ...
        'number', uint32(3), ...
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
        'name', 'f', ...
        'full_name', 'tensorflow.AttrValue.ListValue.f', ...
        'index', 3, ...
        'number', uint32(4), ...
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
        'name', 'b', ...
        'full_name', 'tensorflow.AttrValue.ListValue.b', ...
        'index', 4, ...
        'number', uint32(5), ...
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
        'name', 'type', ...
        'full_name', 'tensorflow.AttrValue.ListValue.type', ...
        'index', 5, ...
        'number', uint32(6), ...
        'type', uint32(14), ...
        'matlab_type', uint32(10), ...
        'wire_type', uint32(0), ...
        'label', uint32(3), ...
        'default_value', int32([]), ...
        'read_function', @(x) util.protobuf.lib.pblib_helpers_first(typecast(x, 'int32')), ...
        'write_function', @(x) typecast(int32(x), 'uint32'), ...
        'options', struct('packed', true) ...
      ), ...
      struct( ...
        'name', 'shape', ...
        'full_name', 'tensorflow.AttrValue.ListValue.shape', ...
        'index', 6, ...
        'number', uint32(7), ...
        'type', uint32(11), ...
        'matlab_type', uint32(9), ...
        'wire_type', uint32(2), ...
        'label', uint32(3), ...
        'default_value', struct([]), ...
        'read_function', @(x) pb_read_tensorflow__TensorShapeProto(x{1}, x{2}, x{3}), ...
        'write_function', @(x) util.protobuf.lib.pblib_generic_serialize_to_string(x), ...
        'options', struct('packed', false) ...
      ), ...
      struct( ...
        'name', 'tensor', ...
        'full_name', 'tensorflow.AttrValue.ListValue.tensor', ...
        'index', 7, ...
        'number', uint32(8), ...
        'type', uint32(11), ...
        'matlab_type', uint32(9), ...
        'wire_type', uint32(2), ...
        'label', uint32(3), ...
        'default_value', struct([]), ...
        'read_function', @(x) pb_read_tensorflow__TensorProto(x{1}, x{2}, x{3}), ...
        'write_function', @(x) util.protobuf.lib.pblib_generic_serialize_to_string(x), ...
        'options', struct('packed', false) ...
      ), ...
      struct( ...
        'name', 'func', ...
        'full_name', 'tensorflow.AttrValue.ListValue.func', ...
        'index', 8, ...
        'number', uint32(9), ...
        'type', uint32(11), ...
        'matlab_type', uint32(9), ...
        'wire_type', uint32(2), ...
        'label', uint32(3), ...
        'default_value', struct([]), ...
        'read_function', @(x) pb_read_tensorflow__NameAttrList(x{1}, x{2}, x{3}), ...
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
  javaMethod('put', descriptor.field_indeces_by_number, uint32(2), 1);
  javaMethod('put', descriptor.field_indeces_by_number, uint32(3), 2);
  javaMethod('put', descriptor.field_indeces_by_number, uint32(4), 3);
  javaMethod('put', descriptor.field_indeces_by_number, uint32(5), 4);
  javaMethod('put', descriptor.field_indeces_by_number, uint32(6), 5);
  javaMethod('put', descriptor.field_indeces_by_number, uint32(7), 6);
  javaMethod('put', descriptor.field_indeces_by_number, uint32(8), 7);
  javaMethod('put', descriptor.field_indeces_by_number, uint32(9), 8);
