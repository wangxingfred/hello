defmodule HelloMacros do
    @moduledoc ~S"""
    Copyright <Woobest> 2020. All Rights Reserved.
      
    History:
        2020-11-25 13:41, fred 'wangxingfred@gmail.com', create module
    
    TODO 编写模块描述
    """
   
    defmacrop _map_get(map, key, default_expr) do
        quote do
            case unquote(map) do
                %{^unquote(key) => value} -> value
                _ -> unquote(default_expr)
            end
        end
    end

    defmacro error!(reason) do
        quote do: :erlang.error(unquote(reason))
    end
    
    
    def map_get!(map, key) do
        _map_get(map, key, error!(key))
    end
    
    
#    defp _bang!(error), do: :erlang.error(error)
end
