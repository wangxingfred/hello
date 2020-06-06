defmodule Stacktrace do
    @moduledoc ~S"""
    Copyright <Woobest> 2020. All Rights Reserved.
      
    History:
        2020-03-18 14:25, fred 'wangxingfred@gmail.com', create module
    
    TODO 编写模块描述
    """
    
    def test(a) do
        try do
            error(a)
        catch e ->
            IO.puts "e = #{inspect e}"
            IO.puts "__STACKTRACE__ = #{inspect __STACKTRACE__}"
        end
    end
    
    defp error(a) do
        try do
            throw(a)
        catch
            type, reason ->
                IO.puts "{type, reason} = #{inspect {type, reason}}"
#            :error, reason ->
#                IO.puts "error => #{inspect reason}"
#            :throw, reason ->
#                IO.puts "throw => #{inspect reason}"
#        rescue e ->
#            IO.puts "a = #{inspect a}"
#            IO.puts "e = #{inspect e}"
#            raise e
        end
    end
end

Stacktrace.test(1)
