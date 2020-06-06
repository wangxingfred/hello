defmodule Macross do
    @moduledoc ~S"""
    Copyright <Woobest> 2020. All Rights Reserved.
      
    History:
        2020-03-19 11:05, fred 'wangxingfred@gmail.com', create module
    
    TODO 编写模块描述
    """
    
    @attr_xx "attr_xx"
    
    defmacro attr_xx, do: quote(do: @attr_xx)
    
    defmacro atom_aaa, do: quote(do: :aaa)
    defmacro atom_xx, do: :xx
    
    defmacro string_aaa, do: quote(do: "aaa")
    defmacro string_xx, do: "xx"
    
    def test1() do
        IO.puts "attr_xx() = #{inspect attr_xx()}"
        IO.puts "atom_aaa() = #{inspect atom_aaa()}"
        IO.puts "atom_xx() = #{inspect atom_xx()}"
        IO.puts "string_aaa() = #{inspect string_aaa()}"
        IO.puts "string_xx() = #{inspect string_xx()}"
    end
    
    defmacro prefix(list \\ []) do
        quote do
            ["prefix" | unquote(list)]
        end
    end
    
    def test2(list) do
        list = prefix(list)
        IO.puts "list = #{inspect list}"
    end
    
    defmacro rescue_expression(do: expression) do
        quote do
            try do
                unquote(expression)
            rescue
                error -> {:error, error}
            else
                {:ok, _} -> :ok
                {:error, _} = e -> e
                error -> {:error, error}
            end
        end
    end
    def test3(input) do
        rescue_expression do: IO.puts("input = #{input * 3}")
    end
end

IO.puts "Macross.test3(%{}) = #{inspect Macross.test3(1)}"

#IO.puts "Macross.test1() = #{inspect Macross.test1()}"
#IO.puts "Macross.test2([]) = #{inspect Macross.test2([])}"
#IO.puts "Macross.test2([2,3]) = #{inspect Macross.test2([2,3])}"
#IO.puts "Macross.test3() = #{inspect Macross.test3()}"