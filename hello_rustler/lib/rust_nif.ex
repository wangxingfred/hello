defmodule RustNif do
    @moduledoc ~S"""
    Copyright <Woobest> 2021. All Rights Reserved.
      
    History:
        2021-01-06 10:01, fred 'wangxingfred@gmail.com', create module
    
    Rust编写的nif桥接模块
    """
    
    use Rustler, otp_app: :hello_rustler, crate: "rust_nif"
    
    # When your NIF is loaded, it will override this function.
    def add(_a, _b), do: :erlang.nif_error(:nif_not_loaded)
end
