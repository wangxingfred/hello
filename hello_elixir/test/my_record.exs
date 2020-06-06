defmodule MyRecord do
    @moduledoc false
    
    require Record
    
    Record.defrecord(:user, name: "Join", age: 25)
    
#    @type user :: record(:usr_record, name:String.t(), age:integer)
    
    def test do
        IO.puts "111111 = #{inspect 111111}"
        try do
            user = 2
            IO.puts "user() = #{inspect user()}"
            IO.puts "user(:name) = #{inspect user(:name)}"
            
            user = user(name: 11, age: 111)
            IO.puts "user = #{inspect user}"
            IO.puts "user(user, :name) = #{inspect user(user, :name)}"
            user(name: name, age: age) = user
            IO.puts "{name, age} = #{inspect {name, age}}"
            IO.puts "user(user, :name) = #{inspect user(user, :name)}"
            
            IO.puts "user(user, age: 1111) = #{inspect user(user, age: 1111)}"
            
            user2 = user(name: 2, age: 22)
            users = [user, user2]
            IO.puts "users = #{inspect users}"
            for user(name: name, age: age) <- users, do: IO.puts "{name, age} = #{inspect {name, age}}"
            [user(age: age) = user1|tail] = users
            IO.puts "user1 = #{inspect user1}"
            IO.puts "users = #{inspect users}"
            
            IO.puts "List.keytake(users, 22, user(:age)) = #{inspect List.keytake(users, 22, user(:age))}"
            
            IO.puts "user(user1) = #{inspect user(user1)}"  # to keyword list
            IO.puts "Keyword.keys(user(user())) = #{inspect Keyword.keys(user(user()))}"

            IO.puts "(user(name: 2) = user2) = #{inspect (user(name: 2) = user2)}"  # match specified field
        catch
            :error, e ->
                IO.puts "e = #{inspect e}"
        end
    end
end

MyRecord.test()