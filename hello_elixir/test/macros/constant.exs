defmodule Constant do
    @moduledoc ~S"""
    Copyright <Woobest> 2020. All Rights Reserved.
      
    History:
        2020-03-19 13:14, fred 'wangxingfred@gmail.com', create module
    
    TODO 编写模块描述
    """
    
    defmacro __using__(_opts) do
        quote do
            import Constant
        end
    end

    @doc "Define a constant"
    defmacro constant(name, value) do
        quote do
            defmacro unquote(name), do: unquote(value)
        end
    end

    @doc "Define a constant. An alias for constant"
    defmacro define(name, value) do
        quote do
            constant unquote(name), unquote(value)
        end
    end
end


defmodule MyConst do
    import Constant
    
    define a, 1
    constant b, 2
end

defmodule MyTest do
    import MyConst
    
    def test() do
        IO.puts "a = #{inspect a()}"
        IO.puts "b = #{inspect b()}"
    end
end

MyTest.test()