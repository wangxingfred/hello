-file("compiler_test.erl", 1).

-module(compiler_test).

-copyright({jzyx, 'www.jzyx.com'}).

-author({fred, 'wangxingfred@gmail.com'}).

-vsn(1).

-import(lists, [reverse/1]).

-export([a/0,b/0]).

-export([if_/3,case_/3]).

-export([macro_ignore/2]).

-export([reserve_list/1]).

-export([maybe_expression/2]).

a() ->
    receive
        _ ->
            ok
    after
        5000 -> {error, timeout}
    end.

b() ->
    erlang:send_after(5000, self(), timeout).

if_(Term, Nil, Default) ->
    if
        Term =:= Nil ->
            Default;
        true ->
            Term
    end.

case_(Term, Nil, Default) ->
    case Term of
        Nil ->
            Default;
        _ ->
            Term
    end.

macro_ignore(A, B) ->
    List = [{"A", A}, {"B", B}],
    ignore,
    A + B.

reserve_list(List) ->
    lists:reverse(List),
    reserve_list1(List, []),
    reserve_list2(List, []).

reserve_list1([H | T], RL) ->
    reserve_list1(T, [H | RL]);
reserve_list1([], RL) ->
    RL.

reserve_list2([], RL) ->
    RL;
reserve_list2([H | T], RL) ->
    reserve_list2(T, [H | RL]).

maybe_expression(Term, Default) ->
    maybe
        default ?= if_(Term, nil, default),
        default ?= case_(Term, nil, default),
        Default
    else
        {error, Y} ->
            {ok, "default"};
        {ok, _Term} ->
            {error, "unexpected wrapper"};
        Else ->
            {"else", Else}
    end.


