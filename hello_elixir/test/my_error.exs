defmodule MyError do
    @moduledoc false

    defexception message: "my error default message"
end

try do
    raise MyError
rescue
    e in MyError -> e
end