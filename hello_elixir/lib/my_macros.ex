defmodule MyMacros do
    @moduledoc ~S"""
    Copyright <Woobest> 2020. All Rights Reserved.
      
    History:
        2020-10-30 14:20, fred 'wangxingfred@gmail.com', create module
    
    TODO 编写模块描述
    """
    import Record

    defrecord(:rec, [a: 1, b: 2, c: 3])



    defmacro rec_get(key \\ nil) do
        case key do
            nil -> quote do: rec()
            _ ->
                quote do
                    rec(rec(), unquote(key))
                end
        end
    end

end
