-file("closure_test.erl", 1).

-module(closure_test).

-copyright({jzyx, 'www.jzyx.com'}).

-author({fred, 'wangxingfred@gmail.com'}).

-vsn(1).

-export([get_closure/2,get_fun/2]).

get_closure(A, B) ->
    C = 10,
    fun(D) ->
           A + B + C + D
    end.

get_fun(A, B) ->
    C = 10,
    {fun add_/4, [A, B, C]}.

add_(A, B, C, D) ->
    A + B + C + D.



