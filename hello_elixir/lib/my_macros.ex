defmodule MyMacros.Conf do
    import Record
    
    alias :persistent_term, as: PersistentTerm
    
    defrecord(:conf, [:layer_list, :layer_map, :table_list, :table_map, :coll_list, :coll_map])
    
    @conf String.to_atom("#{__MODULE__}:my_conf")
    
    defmacro conf_set(conf) do
        quote do: PersistentTerm.put(unquote(@conf), unquote(conf))
    end
    
    defmacro conf_get(key \\ nil, conf \\ nil) do
        case key do
            nil -> quote do: PersistentTerm.get(unquote(@conf))
            _ when conf != nil -> quote do: conf(unquote(conf), unquote(key))
            _ -> quote do: conf(PersistentTerm.get(unquote(@conf)), unquote(key))
        end
    end
end

defmodule MyMacros do
    @moduledoc ~S"""
    Copyright <Woobest> 2020. All Rights Reserved.
      
    History:
        2020-10-30 14:20, fred 'wangxingfred@gmail.com', create module
    
    TODO 编写模块描述
    """
    import Record
    defrecord(:rec, [a: 1, b: 2, c: 3])
    
    @name :name

    defmacro rec_get(key \\ nil) do
        case key do
            nil ->
                quote do: rec()
            @name ->
                elem(rec(), 0)
            _ ->
                quote do
                    rec(rec(), unquote(key))
                end
        end
    end
    
    import MyMacros.Conf
    
    def test_set(conf), do: conf_set(conf)
    def test_get(), do: conf_get()
    def test_get(:layer_list), do: conf_get(:layer_list)
    def test_get(:layer_map), do: conf_get(:layer_map)
    def test_get(:table_list), do: conf_get(:table_list)
    def test_get(:table_map), do: conf_get(:table_map)
    
end
