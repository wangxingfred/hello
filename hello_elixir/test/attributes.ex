defmodule Attributes do
    @moduledoc ~S"""
    Copyright <Woobest> 2020. All Rights Reserved.
      
    History:
        2020-02-27 17:40, fred 'wangxingfred@gmail.com', create module
    
    TODO 编写模块描述
    """
    
    defmacro __using__(_) do
        quote do
            @attr_a :a
            @attr_1 1
        end
    end
end
