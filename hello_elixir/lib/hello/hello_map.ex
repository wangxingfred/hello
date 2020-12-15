defmodule HelloMap do
    @moduledoc ~S"""
    Copyright <Woobest> 2020. All Rights Reserved.
      
    History:
        2020-11-05 15:45, fred 'wangxingfred@gmail.com', create module
    
    TODO 编写模块描述
    """
    
    #    def map_match({k, v}, %{^k => ^v}), do: {:match, k, v}
    #    def map_match({k, v}, %{^k => v2}), do: {:key_match, k, v, v2}
    #    def map_match({k, v}, _), do: {:badmatch, k, v}
    
    def map_match({k, v}, map) do
        case map do
            %{^k => ^v} -> {:match, k, v}
            %{^k => v2} -> {:key_match, k, v, v2}
            _ -> {:badmatch, k, v}
        end
    end


end
