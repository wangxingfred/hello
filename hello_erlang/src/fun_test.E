-file("fun_test.erl", 1).

-module(fun_test).

-copyright({jzyx, 'www.jzyx.com'}).

-author({fred, 'wangxingfred@gmail.com'}).

-vsn(1).

-export([external_mf/0,local_fun1/0,local_fun2/0]).

-export([do_sth/0]).

-export([bind_not_exported/0]).

external_mf() ->
    fun fun_test:do_sth/0.

local_fun1() ->
    fun do_sth/0.

local_fun2() ->
    fun() ->
           do_sth()
    end.

do_sth() ->
    io:format("~p:~p:~p ccc ~n", [fun_test, do_sth, 43]).

bind_not_exported() ->
    fun fun_test:not_exported/0.

not_exported() ->
    not_exported.



