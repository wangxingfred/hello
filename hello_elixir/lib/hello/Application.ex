defmodule Hello.Application do
    @moduledoc ~S"""
    Copyright <Woobest> 2020. All Rights Reserved.
      
    History:
        2020-10-30 15:25, fred 'wangxingfred@gmail.com', create module
    
    TODO 编写模块描述
    """
    
    use Application

    def start(_type, _args) do
        Supervisor.start_link([], [strategy: :one_for_one])
    end
end