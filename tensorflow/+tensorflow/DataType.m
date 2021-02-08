classdef DataType < util.mixin.Enumeration & util.mixin.Vectorize
  properties (Constant, Access=private)
    % TYPEMAP collects three columns: TF type | enum value | Matlab class
    TYPEMAP = [ ...
      { 'TF_FLOAT',       1, 'single'  };
      { 'TF_DOUBLE',      2, 'double'  };
      { 'TF_INT32',       3, 'int32'   };
      { 'TF_UINT8',       4, 'uint8'   };
      { 'TF_INT16',       5, 'int16'   };
      { 'TF_INT8',        6, 'int8'    };
      { 'TF_STRING',      7, 'char'    };
      { 'TF_COMPLEX64',   8, 'complex' };
      { 'TF_COMPLEX',     8, 'complex' };
      { 'TF_INT64',       9, 'int64'   };
      { 'TF_BOOL',       10, 'logical' };
      { 'TF_QINT8',      11, ''        };
      { 'TF_QUINT8',     12, ''        };
      { 'TF_QINT32',     13, ''        };
      { 'TF_BFLOAT16',   14, ''        };
      { 'TF_QINT16',     15, ''        };
      { 'TF_QUINT16',    16, ''        };
      { 'TF_UINT16',     17, 'uint16'  };
      { 'TF_COMPLEX128', 18, ''        };
      { 'TF_HALF',       19, ''        };
      { 'TF_RESOURCE',   20, ''        };
      { 'TF_VARIANT',    21, ''        };
      { 'TF_UINT32',     22, 'uint32'  };
      { 'TF_UINT64',     23, 'uint64'  };
    ];
  end

  methods
    function obj = DataType(varargin)
      obj = vectorize_constructor_(obj, varargin{:});
      if numel(obj) == 1 && nargin ~= 0
        id = varargin{1};
        if isa(id, 'tensorflow.DataType')
          obj.set_value_(id.value_);
        else
          if ischar(id)
            % create from string
            val = tensorflow.DataType.lookup_fwd(id);
            if isempty(val)
              % try reverse lookup
              val = tensorflow.DataType.lookup_rev(id);
              warning('tensorflow:DataType:InputArguments', 'Creating tensorflow.DataType from Matlab data type - this is not encouraged.');
            end
            assert(~isempty(val), 'tensorflow:DataType:InputArguments', 'Cannot map given data type identifier to a known variant.');
          elseif tensorflow.DataType.is_int_robust_(id)
            % create from integer
            val = tensorflow.DataType.lookup_int(id);
            assert(~isempty(val), 'tensorflow:DataType:InputArguments', 'Cannot map given data type identifier to a known variant.');
          else
            error('tensorflow:DataType:InputArguments', 'Cannot create tensorflow.DataType from given argument.');
          end
          assert(size(val,1) <= 1, 'tensorflow:DataType:InputArguments', 'Given data type identifier maps to more than one variant.');
          obj.set_value_(val);
        end
      end
    end

    % TF_CAPI_EXPORT extern size_t TF_DataTypeSize(TF_DataType dt);
    function s = DataTypeSize(obj)
      s = double(tensorflow_m_('TF_DataTypeSize', uint32(obj)));
    end
  end

  methods (Static, Access=protected)
    function entry = lookup_fwd(str_tf)
      idx = strcmp(str_tf, tensorflow.DataType.TYPEMAP(:,1));
      entry = tensorflow.DataType.TYPEMAP(idx, :);
    end

    function entry = lookup_int(val_int)
      TYPEMAP = [ ...
        { 'TF_FLOAT',       1, 'single'  };
        { 'TF_DOUBLE',      2, 'double'  };
        { 'TF_INT32',       3, 'int32'   };
        { 'TF_UINT8',       4, 'uint8'   };
        { 'TF_INT16',       5, 'int16'   };
        { 'TF_INT8',        6, 'int8'    };
        { 'TF_STRING',      7, 'char'    };
        { 'TF_COMPLEX64',   8, 'complex' };
        { 'TF_COMPLEX',     8, 'complex' };
        { 'TF_INT64',       9, 'int64'   };
        { 'TF_BOOL',       10, 'logical' };
        { 'TF_QINT8',      11, ''        };
        { 'TF_QUINT8',     12, ''        };
        { 'TF_QINT32',     13, ''        };
        { 'TF_BFLOAT16',   14, ''        };
        { 'TF_QINT16',     15, ''        };
        { 'TF_QUINT16',    16, ''        };
        { 'TF_UINT16',     17, 'uint16'  };
        { 'TF_COMPLEX128', 18, ''        };
        { 'TF_HALF',       19, ''        };
        { 'TF_RESOURCE',   20, ''        };
        { 'TF_VARIANT',    21, ''        };
        { 'TF_UINT32',     22, 'uint32'  };
        { 'TF_UINT64',     23, 'uint64'  };
      ];
      idx = find([TYPEMAP{:,2}] == val_int);
      entry = TYPEMAP(idx, :);
    end

    function entry = lookup_rev(str_mat)
      TYPEMAP = [ ...
        { 'TF_FLOAT',       1, 'single'  };
        { 'TF_DOUBLE',      2, 'double'  };
        { 'TF_INT32',       3, 'int32'   };
        { 'TF_UINT8',       4, 'uint8'   };
        { 'TF_INT16',       5, 'int16'   };
        { 'TF_INT8',        6, 'int8'    };
        { 'TF_STRING',      7, 'char'    };
        { 'TF_COMPLEX64',   8, 'complex' };
        { 'TF_COMPLEX',     8, 'complex' };
        { 'TF_INT64',       9, 'int64'   };
        { 'TF_BOOL',       10, 'logical' };
        { 'TF_QINT8',      11, ''        };
        { 'TF_QUINT8',     12, ''        };
        { 'TF_QINT32',     13, ''        };
        { 'TF_BFLOAT16',   14, ''        };
        { 'TF_QINT16',     15, ''        };
        { 'TF_QUINT16',    16, ''        };
        { 'TF_UINT16',     17, 'uint16'  };
        { 'TF_COMPLEX128', 18, ''        };
        { 'TF_HALF',       19, ''        };
        { 'TF_RESOURCE',   20, ''        };
        { 'TF_VARIANT',    21, ''        };
        { 'TF_UINT32',     22, 'uint32'  };
        { 'TF_UINT64',     23, 'uint64'  };
      ];
      idx = strcmp(str_mat, TYPEMAP(:,3));
      entry = TYPEMAP(idx, :);
    end
  end

  methods (Static)
    function m = tf2m(tf_str)
      % convert a TF type to the corresponding Matlab class
      if isa(tf_str, 'tensorflow.DataType')
        tf_str = tf_str.value;
      end
      entry = tensorflow.DataType.lookup_fwd(tf_str);
      assert(~isempty(entry), 'tensorflow:DataType:tf2m:NotFound', ['Cannot interpret given TensorFlow data type ''' char(tf_str) '''.']);
      assert(~isempty(entry{1,3}), 'tensorflow:DataType:tf2m:NoEquivalent', ['No known Matlab equivalent for ''' char(tf_str) '''.']);
      m = entry{1,3};
    end

    function tf = m2tf(mat_class)
      % convert a Matlab class to the corresponding TF type
      if ~ischar(mat_class)
        mat_class = class(mat_class);
      end
      entry = tensorflow.DataType.lookup_rev(mat_class);
      assert(~isempty(entry), 'tensorflow:DataType:m2tf:NotFound', ['Cannot interpret given Matlab data type ''' char(mat_class) '''.']);
      assert(~isempty(entry{1,1}), 'tensorflow:DataType:m2tf:NoEquivalent', ['No known TensorFlow equivalent for ''' char(mat_class) '''.']);
      tf = entry{1,1};
    end

    function is = ismember(arg)
      if ischar(arg)
        is = ( ~isempty(tensorflow.DataType.lookup_fwd(arg)) || ~isempty(tensorflow.DataType.lookup_rev(arg)) );
      elseif isnumeric(arg)
        is = ~isempty(tensorflow.DataType.lookup_int(arg));
      else
        is = false;
      end
    end
  end
end
