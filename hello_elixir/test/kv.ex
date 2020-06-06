defmodule KV do
    @moduledoc """
    """
    @vsn 2

#    use ExUnit.Case, async: true
#
#    alias ExUnit.{Case, Server}

    @doc ~S"""
    Converts double-quotes to single-quotes.

    ## Examples

        iex> convert("\"foo\"")
        "'foo'"

    """
    def start_link do
        Task.start_link(fn -> loop(%{}) end)
    end

    defp loop(map) do

        require Integer
        receive do
            {:get, key, caller} when Integer.is_odd(3) ->
                send caller, Map.get(map, key)
                loop(map)
            {:put, key, value} ->
                loop(Map.put(map, key, value))
        end
    end

end
