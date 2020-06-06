defmodule Protocols do
    @moduledoc ~S"""
    Copyright <Woobest> 2020. All Rights Reserved.
      
    History:
        2020-02-19 16:51, fred 'wangxingfred@gmail.com', create module
    
    TODO 编写模块描述
    """

end

defprotocol Utility do
    @fallback_to_any true
    @spec type(t) :: String.t()
    def type(value)
end


defimpl Utility, for: Any do
    def type(_), do: "unknown"
end

defimpl Utility, for: BitString do
    def type(_value), do: "string"
end

defimpl Utility, for: Integer do
    def type(_value), do: "integer"
end


IO.puts "Utility.type(\"foo\") = #{inspect Utility.type("foo")}"
IO.puts "Utility.type(123) = #{inspect Utility.type(123)}"
IO.puts "Utility.type([]) = #{inspect Utility.type([])}"


# Protocol Enumerable
Enum.map 1..3, &(&1 * 2)

# Protocol String.Chars
to_string :hello
age = 25
"age: #{age}"       # string interpolation calls to_string
tuple = {1,2,3}
#"tuple: #{tuple}" # error!! String.Chars not implemented for tuple

#Prococl Inspect
"tuple: #{inspect tuple}"