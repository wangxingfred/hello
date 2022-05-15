defmodule SeatServer do
    @moduledoc ~S"""
    Copyright localhost 2022. All Rights Reserved.
      
    History:
        2022-05-15 2:46, fred 'wangxingfred@gmail.com', create module
    
    TODO 编写模块描述
    """

    use GenServer

    def start_link() do
        init_arg = []
        opts = [name: __MODULE__]
        GenServer.start_link(__MODULE__, init_arg, opts)
    end

    def take_seat(name, seat) when is_integer(seat) do
        GenServer.call(__MODULE__, {:take_seat, name, seat})
    end
    def pull_data() do
        GenServer.call(__MODULE__, :pull_data)
    end

    @impl true
    def init(_init_arg) do
        file_path = 'seats.dets'
        {:ok, dets} = :dets.open_file(__MODULE__, [{:file, file_path}, {:keypos, 2}])

        kv_list = _select_dets(dets)
        map = :maps.from_list(kv_list)

        IO.puts "------------#{__ENV__.file}:#{__ENV__.line}-----------"
        IO.puts "map = #{inspect map}"
        IO.puts "-----------------------------------------------------------~n"

        {:ok, %{dets: dets, map: map}}
    end

    @impl true
    def handle_call({:take_seat, name, seat}, _from, state) do
        %{dets: dets, map: map} = state
        case :dets.lookup(dets, name) do
            [] ->
                case map do
                    %{^seat => _} ->
                        {:reply, :seat_taked, state}
                    _ ->
                        :dets.insert_new(dets, {seat, name})
                        map2 = :maps.put(seat, name, map)
#                        IO.puts "------------#{__ENV__.file}:#{__ENV__.line}-----------"
#                        IO.puts "map = #{inspect map}"
#                        IO.puts "map2 = #{inspect map2}"
#                        IO.puts "_select_dets(dets) = #{inspect _select_dets(dets)}"
#                        IO.puts "-----------------------------------------------------------~n"
                        state2 = :maps.put(:map, map2, state)
                        {:reply, {:ok, map2}, state2}
                end
            _ ->
                {:reply, :already_seated, state}
        end
    end
    def handle_call(:pull_data, _from, %{map: map} = state) do
        {:reply, {:ok, map}, state}
    end
    def handle_call(_message, _from, state) do
        {:reply, :ok, state}
    end

    @impl true
    def handle_cast(_msg, state) do
        {:noreply, state}
    end

    defp _select_dets(dets) do
        :dets.select(dets, [{:_, [], [:"$_"]}])
    end
end