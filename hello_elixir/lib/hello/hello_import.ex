defmodule HelloImport do
    @moduledoc ~S"""
    Copyright <Woobest> 2020. All Rights Reserved.
      
    History:
        2020-11-14 10:55, fred 'wangxingfred@gmail.com', create module
    
    TODO 编写模块描述
    """

    # public函数可以被其他模块import
    def public_fn(), do: "public_fn"
    
    
    # private函数不能被其它模块import
    defp _private_fn(), do: "_private_fn"
    
end
