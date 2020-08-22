defmodule HelloRedbugTest do
  use ExUnit.Case
  doctest HelloRedbug

  test "greets the world" do
    assert HelloRedbug.hello() == :world
  end
end
