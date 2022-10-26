%%%-------------------------------------------------------------------
%%% @author fred
%%% @copyright (C) 2021, <Woobest>
%%% @doc
%%%     Compiler test cases
%%% @end
%%% Created : 29. Jun 2021 5:12 PM
%%%-------------------------------------------------------------------
-module(compiler_test).

-feature(maybe_expr, enable).

-copyright({jzyx, 'www.jzyx.com'}).
-author({fred, 'wangxingfred@gmail.com'}).
-vsn(1).

%%%===============================INCLUDE================================

%%%================================DEFINE================================
%% 不需要给其它模块用的宏定义可以写到这里，避免放到头文件中修改后增加编译时间
-define(IGNORE(_), ignore).

%%-define(MAYBE, maybe).
%%-define(ELSE, else).
%%-define(END, end).
%%-define(MATCH(Left, Right), Left ?= Right).
%%-define(MAYBE_ELSE(Maybe, Else), maybe Maybe else Else end).
%%
%%-define(MAYBE_BEGIN(Left, Right), maybe Left ?= Right).
%%-define(MAYBE_MATCH(Left, Right), Left ?= Right).
%%-define(MAYBE_RETURN(Expr), Expr).
%%-define(MAYBE_ELSE_END(Expr), else Expr end).

%% c(compiler_test, ['P']).  ->  compiler_test.P
%% c(compiler_test, ['E']).  ->  compiler_test.E
%% c(compiler_test, ['S']).  ->  compiler_test.S
%% c(compiler_core, [time, 'to_core']).  ->  compiler_core.core

-import(lists, [reverse/1]).

%%%================================EXPORT================================
-export([a/0, b/0]).
-export([if_/3, case_/3, empty_branch/4]).
-export([macro_ignore/2]).
-export([reserve_list/1]).
-export([maybe_expression/2, maybe2/2, maybe2_identical/2]).

a() ->
    receive
        _ -> ok
    after 5000 ->
        {error, timeout}
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

empty_branch(Term, Case1, Case2, Default) ->
    case Term of
        Case1 ->
            throw(case1);
        Case2 ->
            empty;
        _  ->
            throw(Default)
    end,
    ok.

macro_ignore(A, B) ->
    List = [
        {"A", A},
        {"B", B}
    ],
    ?IGNORE(List),
    A + B.

reserve_list(List) ->
    reverse(List),
    reserve_list1(List, []),
    reserve_list2(List, []).

reserve_list1([H|T], RL) ->
    reserve_list1(T, [H|RL]);
reserve_list1([], RL) -> RL.

reserve_list2([], RL) -> RL;
reserve_list2([H|T], RL) ->
    reserve_list2(T, [H|RL]).


maybe_expression(Term, Default) ->
    maybe
        default ?= if_(Term, nil, default),
        default ?= case_(Term, nil, default),
        Default
    else
        {error, _Y} ->
            {ok, "default"};
        {ok, _Term} ->
            {error, "unexpected wrapper"};
        Else ->
            {"else", Else}
    end.


add_(A, B) when is_number(A), is_number(B) -> {ok, A + B};
add_(_A, _B) -> error.

sub_(A, B) when A >= B -> {ok, A - B};
sub_(_A, _B) -> wrong.

maybe2(A, B) ->
    maybe
        {ok, Sum} ?= add_(A, B),
        true = Sum >= 0,
        {ok, Sub} ?= sub_(A, B),
        {Sum, Sub}
    else
        error -> error;
        wrong -> error
    end.

maybe2_identical(A, B) ->
    case add_(A, B) of
        {ok, Sum} ->
            true = Sum >= 0,
            case sub_(A, B) of
                {ok, Sub} ->
                    {Sum, Sub};
                wrong -> wrong
            end;
        error -> error
    end.


%%maybe_expr(Term, Default) ->
%%    ?MAYBE_BEGIN(default, if_(Term, nil, default)),
%%    ?MAYBE_MATCH(default, case_(Term, nil, default)),
%%    ?MAYBE_MATCH(default, case_(Term, nil, default)),
%%    ?MAYBE_ELSE_END({error, Y} -> {ok, "default"}; {ok, _Term} -> {error, "unexpected wrapper"}; Else -> {"else", Else}).