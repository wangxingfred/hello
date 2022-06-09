-file("syntax_test.erl", 1).

-module(syntax_test).

-copyright({jzyx, 'www.jzyx.com'}).

-author({fred, 'wangxingfred@gmail.com'}).

-vsn(1).

-export([add/2,catch_add/2,try_after/2]).

add(A, B) ->
    A + B.

catch_add(A, B) ->
    catch A + B.

try_after(A, B) ->
    try A + B after io:format("A=~p,B=~p~n", [A, B]) end.



