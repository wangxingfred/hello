defmodule HelloRecord do
    @moduledoc ~S"""
    Copyright <Woobest> 2020. All Rights Reserved.
      
    History:
        2020-11-09 20:22, fred 'wangxingfred@gmail.com', create module
    
    TODO 编写模块描述
    """
    
    import Record
    
    defrecord(:a, [a: nil])
    defrecord(:b, [a: nil, b: nil])
    defrecord(:c, [:c, b: nil, a: nil])
    defrecord(:d, [:c, :d, :b, :a])
    
    defmacrop indexes, do: [a(:a), b(:b), c(:c), d(:d)]

    def get_indexes(), do: indexes()
end
