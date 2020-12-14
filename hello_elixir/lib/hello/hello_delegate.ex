defmodule HelloDelegate do
    @moduledoc ~S"""
    Copyright <Woobest> 2020. All Rights Reserved.
      
    History:
        2020-11-25 10:34, fred 'wangxingfred@gmail.com', create module
    
    TODO 编写模块描述
    """
    
    defdelegate print(a), to: HelloFunction
    defdelegate print(a, b), to: HelloFunction
end
