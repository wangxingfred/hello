defmodule Recursion do
  @moduledoc false

  def printn(msg, n) when n <= 1 do
    IO.puts msg
  end

  def printn(msg, n) do
    IO.puts msg
    printn(msg, n - 1)
  end

  a = Stream.map()
end

Recursion.printn("Hello ", 3)

