defmodule HelloXprofTest do
  use ExUnit.Case
  doctest HelloXprof

  test "greets the world" do
    assert HelloXprof.hello() == :world
  end
end
