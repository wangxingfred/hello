defmodule TryRescueThrowCatchAfter do
    @moduledoc ~S"""
    Copyright <Woobest> 2020. All Rights Reserved.
      
    History:
        2020-02-20 09:48, fred 'wangxingfred@gmail.com', create module
    
    TODO 编写模块描述
    """
    
    defmodule MyError do
        defexception message: "default message"
    end
    
    def try_rescue(error) do
        try do
            if is_function(error), do: error.()
            
            if error !== nil and error !== :ok, do: raise error
            
            error
        rescue
            RuntimeError -> "RuntimeError!"
            MyError -> "MyError!"
            e in ErlangError -> e.original
            e -> e
        else
            :ok -> "OK~"
            _ -> "NoError~"
        end
    end
    
    def try_throw_catch(term) do
        try do
            if term !== nil and term !== :ok do
                throw term
            end
            term
        catch
            e -> "Catch #{inspect e}"
        else
            :ok -> ":ok~"
            e -> "No throw: #{inspect e}~"
        end
    end
    
    def try_after(message) do
        try do
            if is_function(message), do: message.(), else: raise message
        after
            IO.puts "after: message = #{inspect message}"
        end
    end
    
    def do_after(message) do
        raise "oops"
    after
        IO.puts "after: message = #{inspect message}"
    end
    
    def try_rescue_catch_else(action) do
        a = 1
        try do
            a = 2
            if is_function(action), do: action.(), else: raise action
        rescue e -> {:rescue, e}
        catch e -> {:catch, e}
        else _ -> {:else, "a = #{a}"}
        after
            #            IO.puts ":after => #{inspect action}"
        end
    end
    
    def try_ets(tab, key, index) do
        try do
            :ets.lookup_element(tab, key, index)
#        rescue e -> {:rescue, e}
#        catch e -> {:catch, e}
        catch :error, _ -> {:catch, :error}
        end
    end
end

alias TryRescueThrowCatchAfter.MyError

#error_type = TryRescueThrowCatchAfter.try_rescue(MyError) # "MyError!"
#IO.puts "try_rescue(MyError) => #{inspect error_type}"
#error_type = TryRescueThrowCatchAfter.try_rescue("oops") # "RuntimeError!"
#IO.puts "try_rescue(\"oops\") => #{inspect error_type}"
#error_type = TryRescueThrowCatchAfter.try_rescue(:ok) # "OK~"
#IO.puts "try_rescue(:ok) => #{inspect error_type}"
#error_type = TryRescueThrowCatchAfter.try_rescue(nil) # "NoError~"
#IO.puts "try_rescue(nil) => #{inspect error_type}"
##error_type = TryRescueThrowCatchAfter.try_rescue(fn -> 1 / 0 end) # %ArithmeticError
##IO.puts "try_rescue(fn -> 1 / 0 end) => #{inspect error_type}"
#error_type = TryRescueThrowCatchAfter.try_rescue(fn -> :erlang.error({:bad,"reason"}) end) # %ArithmeticError
#IO.puts "try_rescue(fn -> :erlang.error({:bad,\"reason\"}) end) => #{inspect error_type}"
##error_type = TryRescueThrowCatchAfter.try_rescue({:bad,"reason"}) # %ArgumentError
##IO.puts "try_rescue({:bad,\"reason\"}) => #{inspect error_type}"


#IO.puts "TryRescueThrowCatchAfter.try_throw_catch(11) => #{inspect TryRescueThrowCatchAfter.try_throw_catch(11)}"
#IO.puts "TryRescueThrowCatchAfter.try_throw_catch(:ok) => #{inspect TryRescueThrowCatchAfter.try_throw_catch(:ok)}"
#IO.puts "TryRescueThrowCatchAfter.try_throw_catch(nil) => #{inspect TryRescueThrowCatchAfter.try_throw_catch(nil)}"
#
#IO.puts "TryRescueThrowCatchAfter.try_after(22) = #{inspect TryRescueThrowCatchAfter.try_after(22)}"
#IO.puts "TryRescueThrowCatchAfter.do_after(22) = #{inspect TryRescueThrowCatchAfter.do_after(33)}"
IO.puts "try_after(fn -> :xxx end) = #{inspect TryRescueThrowCatchAfter.try_after(fn -> :xxx end)}"
IO.puts "try_after(fn -> 1/0 end) = #{inspect TryRescueThrowCatchAfter.try_after(fn -> 1 / 0 end)}"

#IO.puts "try_rescue_catch_else(fn -> :xxx end) = #{
#    inspect TryRescueThrowCatchAfter.try_rescue_catch_else(fn -> :xxx end)
#}"
#IO.puts "try_rescue_catch_else(fn -> throw :xxx end) = #{
#    inspect TryRescueThrowCatchAfter.try_rescue_catch_else(fn -> throw :xxx end)
#}"
#IO.puts "try_rescue_catch_else(fn -> raise :xxx end) = #{
#    inspect TryRescueThrowCatchAfter.try_rescue_catch_else(fn -> raise :xxx end)
#}"

#IO.puts "try_ets(:xx, 1,2) = #{inspect TryRescueThrowCatchAfter.try_ets(:xx, 1, 2)}"