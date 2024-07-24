defmodule CompilerTest do
  @moduledoc ~S"""
  Copyright <JZYX> 2024. All Rights Reserved.
    
  History:
  2024-07-24 9:37, 汪兴 cd_wangx@jzyx.com, create module

  测试compiler选项、结果

  iex> {:ok, code} = BeamFile.elixir_code(CompilerTest, docs: true)
  iex> IO.puts(code)

  iex> {:ok, code} = BeamFile.erl_code(CompilerTest)
  iex> IO.puts(code)

  iex> {:ok, code} = BeamFile.byte_code(CompilerTest)
  iex> IO.puts(code)
  """

  def try_catch_recursion do
    try do
      _recursion1([1, 2, 3], 1, 2, 3, 4, %{})
    catch
      {:error, {:reason1, term}} -> {:error, {:known_error, {:reason1, term}}}
      {:error, {:reason2, term}} -> {:error, {:known_error, {:reason2, term}}}
      {:error, term} -> {:error, {:unknown_error, term}}
    end
  end



  @doc """
  获取元组指定位置的元素，索引从1开始
  """
  defmacro element(tuple, index) do
    quote do: :erlang.element(unquote(index), unquote(tuple))
  end

  defmacro map_get(map, key, default \\ nil) do
    quote do
      case unquote(map) do
        %{^unquote(key) => value} -> value
        _ -> unquote(default)
      end
    end
  end

  defmacro map_get_element(map, key, pos, default \\ nil) do
    quote do
      case unquote(map) do
        %{^unquote(key) => value} -> element(value, unquote(pos))
        _ -> unquote(default)
      end
    end
  end

  defmacro map_put(map, key, value) do
    quote do: :maps.put(unquote(key), unquote(value), unquote(map))
  end

  defmacro map_keys(map) do
    quote do: :maps.keys(unquote(map))
  end

  defmacro map_values(map) do
    quote do: :maps.values(unquote(map))
  end

  defp _recursion1([x | t], a, b, c, d, results) do
    values = map_get(x, results, [])
    value = x + a + b + c + d
    values = [value | values]
    map_put(results, x, values)
    _recursion1(t, a, b, c, d, results)
  end

  defp _recursion1([], _a, _b, _c, _d, results) do
    results
  end

  defp _recursion2([x | t], a, b, c, d, results) do
    values = map_get_element(x, results, 2, [])
    value = x + a + b + c + d
    values = [value | values]
    map_put(results, x, {x, values})
    _recursion2(t, a, b, c, d, results)
  end

  defp _recursion2([], _a, _b, _c, _d, results) do
    map_values(results)
  end
end
