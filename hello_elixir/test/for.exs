defmodule For do
    @moduledoc ~S"""
    Copyright <Woobest> 2020. All Rights Reserved.
      
    History:
        2020-03-12 16:56, fred 'wangxingfred@gmail.com', create module
    
    TODO 编写模块描述
    """
    
    def reduce(list) do
        for x <- list, reduce: [] do acc ->
            [x|acc]
        end
    end
end


IO.puts "For.reduce([1,2,3]) = #{inspect For.reduce([1,2,3])}"