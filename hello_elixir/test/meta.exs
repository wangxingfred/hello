defmodule Meta do
    @moduledoc ~S"""
    Copyright <Woobest> 2020. All Rights Reserved.
      
    History:
        2020-02-19 16:13, fred 'wangxingfred@gmail.com', create module
    
    TODO 编写模块描述
    """
    
end

# require for macros
require Integer

IO.puts "Integer.is_odd(3) = #{inspect Integer.is_odd(3)}"


# import for public functions and macros
# import >= require
import List, only: [duplicate: 2]

IO.puts "duplicate(:ok, 3) = #{inspect duplicate(:ok, 3)}"


# use use to inject code
# https://elixir-lang.org/getting-started/alias-require-and-import.html#use