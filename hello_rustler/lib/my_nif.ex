defmodule HelloRustler.MyNif do
    @moduledoc ~S"""
    History:
        2022-04-03 15:53, fred 'wangxingfred@gmail.com', create module
    
    TODO 编写模块描述
    """

    use Rustler,
        otp_app: :hello_rustler,
        crate: :my_nif

    # When loading a NIF module, dummy clauses for all NIF function are required.
    # NIF dummies usually just error out when called when the NIF is not loaded, as that should never normally happen.
    def add(_arg1, _arg2), do: :erlang.nif_error(:nif_not_loaded)

    def panic(), do: :erlang.nif_error(:nif_not_loaded)
    def crash(), do: :erlang.nif_error(:nif_not_loaded)
end
