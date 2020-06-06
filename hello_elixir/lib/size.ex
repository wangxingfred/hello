
defprotocol Size do
    @fallback_to_any true
    
    @doc "Calculate the size of a data structure"
    
    def size(data)

    def compare(data1, data2)
end

defimpl Size, for: BitString do
    def size(string), do: byte_size(string)
end

defimpl Size, for: Any do
    def size(_), do: 0
    def compare(data1, data2), do: data1 > data2
    end

defimpl Size, for: Map do
    def size(map), do: map_size(map)
end

defimpl Size, for: Tuple do
    def size(tuple), do: tuple_size(tuple)
end

defimpl Size, for: MapSet do
    def size(set) do
        MapSet.size(set)
    end
end

defmodule User do
    @derive [Size]
    defstruct [:name, :age]
    
    defimpl Size do
        defdelegate size(data), to: Size.Any
        defdelegate compare(data1, data2), to: Size.Any
#        def size(_), do: Size.Any.size(Any)
#        defp _size(), do: 2
    end
end

defmodule Test do
    defstruct [:test]
end

#IO.puts "%Test{} = #{inspect %Test{}}"

#IO.puts "Size.size(%User{}) = #{inspect Size.size(%User{})}"