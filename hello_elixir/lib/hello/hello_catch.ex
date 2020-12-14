defmodule HelloCatch do
    @moduledoc ~S"""
    Copyright <Woobest> 2020. All Rights Reserved.
      
    History:
        2020-11-11 09:20, fred 'wangxingfred@gmail.com', create module
    
    TODO 编写模块描述
    """
    
    def try_catch_else1(term, kind \\ "throw") do
        try do
            if term !== nil and term !== :ok do
                _exception!(kind, term)
            end
            term
        catch
            e -> "Catch #{inspect e}"
        else
            :ok -> "else :ok"
            e -> "else e -> #{inspect e}~"
        end
    end

    def try_catch_else2(term, kind \\ "throw") do
        try do
            if term !== nil and term !== :ok do
                _exception!(kind, term)
            end
            term
        catch
            kind, reason -> "Catch #{inspect {kind, reason}}"
        else
            :ok -> "else :ok"
            e -> "else e -> #{inspect e}~"
        end
    end

    def try_after(message, kind) do
        try do
            if is_function(message), do: message.(), else: _exception!(kind, message)
        after
            IO.puts "after: message = #{inspect message}"
        end
    end

    def try_after!(message, kind) do
        try do
            if is_function(message), do: message.(), else: _exception!(kind, message)
        after
            _exception!(kind, "after!")
        end
    end

    def do_after(message) do
        raise "oops"
    after
        IO.puts "after: message = #{inspect message}"
    end
    
    defp _exception!("throw", message), do: throw message
    defp _exception!("raise", message), do: raise message
    defp _exception!("error", message), do: :erlang.error(message)
end
