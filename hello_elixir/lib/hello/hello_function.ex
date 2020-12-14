defmodule HelloFunction do
    @moduledoc ~S"""
    Copyright <Woobest> 2020. All Rights Reserved.
      
    History:
        2020-11-17 09:40, fred 'wangxingfred@gmail.com', create module
    
    TODO 编写模块描述
    """
    
    def outer() do
        IO.puts "outer function"
        
        # 嵌套定义编译不过
#        defp _inner() do
#            IO.puts "inner function"
#        end
#
#        _inner()
    end

    def fn_with_default1(a, b, c \\ :c) do
        {a, b, c}
    end
    def fn_with_default2(a, b, c \\ _new_default(:c)) do
        {a,b,c}
    end
    
    # 错误
#    def fn_with_default3(a, b, c \\ _new_default(a)) do
#        {a,b,c}
#    end
    
    defp _new_default(name) do
        IO.puts "_new_default : #{name}"
        {:default, name}
    end
    
    
    def print(a, b \\ "b") do
        IO.puts "a=#{a}, b=#{b}"
    end
end
