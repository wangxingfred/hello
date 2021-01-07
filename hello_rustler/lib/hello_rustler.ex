defmodule HelloRustler do
    @moduledoc """
    Documentation for `HelloRustler`.
    """
    
    @doc """
    Hello world.
    
    ## Examples
    
        iex> HelloRustler.hello()
        :world
    
    """
    def hello do
        :world
    end
    
    def add(a, b), do: a + b
    
    def hashmap(count) when count > 0 do
        :erlang.put(count, count)
        hashmap(count - 1)
    end
    def hashmap(_), do: :no_return
end
