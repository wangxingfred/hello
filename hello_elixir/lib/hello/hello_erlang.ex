defmodule HelloErlang do
    @moduledoc ~S"""
    Copyright <Woobest> 2020. All Rights Reserved.
      
    History:
        2020-11-11 10:40, fred 'wangxingfred@gmail.com', create module
    
    TODO 编写模块描述
    """
    
    def fun_info_mfa1() do
        :erlang.fun_info_mfa(&fun_info_mfa1/0)
    end
    def fun_info_mfa2() do
        fun = fn -> :ok end
        :erlang.fun_info_mfa(fun)
    end
end
