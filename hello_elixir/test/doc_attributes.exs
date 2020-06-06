defmodule DocAttributes do
    @moduledoc ~S"""
    Copyright <Woobest> 2020. All Rights Reserved.
      
    History:
        2020-02-27 17:41, fred 'wangxingfred@gmail.com', create module
    
    TODO 编写模块描述
    """
    use Attributes

    def test() do
        IO.puts "@attr_a = #{inspect @attr_a}"
        IO.puts "@attr_1 = #{inspect @attr_1}"
    end
end

DocAttributes.test()