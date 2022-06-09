defmodule HelloCowboy.Application do
    @moduledoc ~S"""
    Copyright localhost 2022. All Rights Reserved.
      
    History:
        2022-05-15 2:56, fred 'wangxingfred@gmail.com', create module
    
    TODO 编写模块描述
    """

    use Application

    def start(_type, _args) do
        HelloCowboy.start()
        SeatServer.start_link()
#        children = [
#            {SeatServer, []}
#        ]
#        opts = [strategy: :one_for_one, name: HelloCowboy.Supervisor]
#        Supervisor.start_link(children, opts)
    end
end