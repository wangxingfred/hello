defmodule Conditional do
    @moduledoc ~S"""
    Copyright <Woobest> 2020. All Rights Reserved.
      
    History:
        2020-02-14 11:14, fred 'wangxingfred@gmail.com', create module
    
    TODO 编写模块描述
    """
    
    def case_1(a) do
        case a do
            true ->
                a = 1
            _ ->
                a = 0
        end
        IO.puts "------------#{__ENV__.file}:#{__ENV__.line}-----------"
        IO.puts "a = #{inspect a}"
        IO.puts "-----------------------------------------------------------~n"
        a
    end

end

Conditional.case_1(true)
Conditional.case_1(false)
