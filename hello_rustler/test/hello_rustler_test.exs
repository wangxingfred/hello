defmodule HelloRustlerTest do
  use ExUnit.Case
  doctest HelloRustler

  test "greets the world" do
    assert HelloRustler.hello() == :world
  end
end
