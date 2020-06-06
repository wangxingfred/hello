defmodule Enumerate do
    @moduledoc ~S"""
    Copyright <Woobest> 2020. All Rights Reserved.
      
    History:
        2020-03-19 13:43, fred 'wangxingfred@gmail.com', create module
    
    TODO 编写模块描述
    """
    
    def reduce_test(batch) do
        list = [1, 2, 3, 4, 5, 6, 7, 8]
        acc = 0
        fun = fn (_x, i) ->
            i = i + 1
            
            if i === batch do
                {:suspend, 0}
            else
                {:cont, i}
            end
        end
        Enumerable.reduce(list, {:cont, acc}, fun)
    end

    def reduce_while(batch) do
        list = [10, 20, 30, 40, 50, 60, 70, 80]
        acc = 0

        fun = fn (x, i) ->
            i = i + 1
            
            IO.puts "x = #{inspect x}"
    
            if i === batch do
                {:halt, x}
            else
                {:cont, i}
            end
        end
        Enum.reduce_while(list, acc, fun)
    end
end

#IO.puts "Enumerate.reduce_test(2) = #{inspect Enumerate.reduce_test(2)}"
#IO.puts "Enumerate.reduce_test(3) = #{inspect Enumerate.reduce_test(3)}"

IO.puts "Enumerate.reduce_while(3) = #{inspect Enumerate.reduce_while(3)}"
IO.puts "Enumerate.reduce_while(1) = #{inspect Enumerate.reduce_while(1)}"