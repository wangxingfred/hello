defmodule MyPlug do
    @moduledoc false

    use Plug.Builder
    
    plug :set_header
    plug :send_ok
    
end
