defmodule Math do
    @moduledoc """
    Provides math-related functions.
    
    ## Examples
    
      iex> Math.sum(1, 2)
      3
    
      哈哈哈
    """
    
    Module.register_attribute __MODULE__, :param, accumulate: true
    @param :foo
    @param :bar
    
    @service Application.get_env(:my_app, :email_service)
    @message Application.get_env(:my_app, :welcome_email)
    
    @initial_state %{host: "127.0.0.1", port: 3456}
    IO.inspect @initial_state
    
    @doc """
    Calculate
    """
    def sum(a, b), do: a + b

    @doc """
    Judge whether an integer is '0'
    """
    def zero?(0), do: true
    def zero?(x) when is_integer(x), do: false

    defstruct [name: "John", age: 2]
end
