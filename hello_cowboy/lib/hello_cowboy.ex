defmodule HelloCowboy do
    @moduledoc """
    Documentation for `HelloCowboy`.
    """

    @doc """
    Hello world.

    ## Examples

        iex> HelloCowboy.hello()
        :world

    """

    defmodule HelloCowboy.HandleSeat do
        def init(req0, state) do
            IO.puts "req0 = #{inspect req0}"

            response_text = try do

                qs = :cowboy_req.match_qs([{:name, :nonempty}, {:seat, :int}], req0)
                IO.puts "qs = #{inspect qs}"

                %{name: name, seat: seat} = qs
                case SeatServer.take_seat(name, seat) do
                    {:ok, map} ->
                        {:ok, text} = Jason.encode(map)
                        text
                    :already_seated -> "error_already_seated"
                    :seat_taked -> "error_seat_taked"
                end
            catch
                error, reason ->
                    IO.puts "error = #{inspect error}"
                    IO.puts "reason = #{inspect reason}"
                    IO.puts "stack = #{inspect __STACKTRACE__}"
                    "error"
            end

            req = :cowboy_req.reply(
                200,
                %{"content-type" => "text/plain"},
                response_text,
                req0
            )
            {:ok, req, state}
        end
    end

    defmodule HelloCowboy.HandlePull do
        def init(req0, state) do
            {:ok, map} = SeatServer.pull_data()
            {:ok, response_text} = Jason.encode(map)

            req = :cowboy_req.reply(
                200,
                %{"content-type" => "text/plain"},
                response_text,
                req0
            )
            {:ok, req, state}
        end
    end

    def start do
        dispatch = :cowboy_router.compile(
            [
                {
                    :_,
                    [
                        {"/take_seat", HelloCowboy.HandleSeat, []},
                        {"/pull_data", HelloCowboy.HandlePull, []},
                        #                        {"/static/[...]", :cowboy_static, {:priv_dir, :hello_cowboy, "static_files"}},
                        #{"/assets/[...]", :cowboy_static, {:priv_dir, :my_app, "static/assets"}},
                        {"/web-mobile/[...]", :cowboy_static, {:priv_dir, :hello_cowboy, "web-mobile"}}
                    ]
                }
            ]
        )


        {:ok, _} = :cowboy.start_clear(
            :my_http_listener,
            [{:port, 8080}],
            %{
                env: %{
                    dispatch: dispatch
                }
            }
        )

    end

    #    def stop do
    #        :cowboy.sto
    #    end
end
