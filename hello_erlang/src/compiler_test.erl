%%%-------------------------------------------------------------------
%%% @author fred
%%% @copyright (C) 2021, <Woobest>
%%% @doc
%%%     Compiler test cases
%%% @end
%%% Created : 29. Jun 2021 5:12 PM
%%%-------------------------------------------------------------------
-module(compiler_test).

-copyright({jzyx, 'www.jzyx.com'}).
-author({fred, 'wangxingfred@gmail.com'}).
-vsn(1).

%%%===============================INCLUDE================================

%%%================================DEFINE================================
%% 不需要给其它模块用的宏定义可以写到这里，避免放到头文件中修改后增加编译时间
-define(IGNORE(_), ignore).

%% c(compiler_test, ['P']).  ->  compiler_test.P
%% c(compiler_test, ['E']).  ->  compiler_test.E
%% c(compiler_test, ['S']).  ->  compiler_test.S

%%%================================EXPORT================================
-export([a/0, b/0]).
-export([if_/3, case_/3]).
-export([macro_ignore/2]).
-export([reserve_list/1]).

a() ->
    receive
        _ -> ok
    after 5000 ->
        timeout
    end.

b() ->
    erlang:send_after(5000, self(), timeout).

if_(Term, Nil, Default) ->
    if Term =:= Nil -> Default;
        true -> Term
    end.

case_(Term, Nil, Default) ->
    case Term of
        Nil -> Default;
        _ -> Term
    end.

macro_ignore(A, B) ->
    List = [
        {"A", A},
        {"B", B}
    ],
    ?IGNORE(List),
    A + B.

reserve_list(List) ->
    reserve_list1(List, []),
    reserve_list2(List, []).

reserve_list1([H|T], RL) ->
    reserve_list1(T, [H|RL]);
reserve_list1([], RL) -> RL.

reserve_list2([], RL) -> RL;
reserve_list2([H|T], RL) ->
    reserve_list2(T, [H|RL]).
