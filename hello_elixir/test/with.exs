defmodule With do
    @moduledoc ~S"""
    Copyright <Woobest> 2020. All Rights Reserved.
      
    History:
        2020-03-13 15:46, fred 'wangxingfred@gmail.com', create module
    
    TODO 编写模块描述
    """
    
    def test(a, b) do
        with {:ok, a} <- a,
             {:ok, b} <- b do
            {a, b}
        end
    end

    def test1(a, b) do
        with ^a <- b do
            :equal
        else _ ->
            a
        end
    end
    
    def test2(a, b) do
        with true <- a === b do
            IO.puts "1111 = #{inspect 1111}"
        else _ ->
            IO.puts "22222 = #{inspect 22222}"
        end
    end
    
    def test3(a, b, c) do
        with :ok <- a do
            IO.puts "a = #{inspect a}"
            a
        else
            ^b ->
                IO.puts "b = #{inspect b}"
                b
        end
    end
end

#IO.puts "With.test(1,11) = #{inspect With.test(1, 11)}"
#IO.puts "With.test({:ok,2}, 22) = #{inspect With.test({:ok, 2}, 22)}"
#IO.puts "With.test({:ok,3}, {:ok,3}) = #{inspect With.test({:ok, 3}, {:ok, 3})}"

IO.puts "With.test1(:a, :a) = #{inspect With.test1(:a, :a)}"
IO.puts "With.test1(:a, :b) = #{inspect With.test1(:a, :b)}"

#IO.puts "With.test2(:a, :a) = #{inspect With.test2(:a, :a)}"
#IO.puts "With.test2(:a, :b) = #{inspect With.test2(:a, :b)}"

#IO.puts "With.test3(:ok, :b, :c) = #{inspect With.test3(:ok, :b, :c)}"
#IO.puts "With.test3(:a, :b, :c) = #{inspect With.test3(:a, :b, :c)}"