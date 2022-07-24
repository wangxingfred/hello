%%%-------------------------------------------------------------------
%%% @author fred
%%% @copyright (C) 2022, <Woobest>
%%% @doc
%%%     compiler pass : c
%%% @end
%%% Created : 24. Jul 2022 11:49 AM
%%%-------------------------------------------------------------------
-module(compiler_core).

%%-copyright({jzyx, 'www.jzyx.com'}).
%%-author({fred, 'wangxingfred@gmail.com'}).
%%-vsn(1).

%%%===============================INCLUDE================================

%%%================================DEFINE================================
%% 不需要给其它模块用的宏定义可以写到这里，避免放到头文件中修改后增加编译时间

%% erlc +time +to_core core_example.erl
%% c(compiler_core, [time, 'to_core']).  ->  compiler_core.core

% https://www.erlang.org/blog/core-erlang-by-example/

%%%================================EXPORT================================
-export([]).


simplest() -> 'ok'.

id(I) -> I.

a(42) -> ok;
a(_) -> error.
% The Core Erlang code will be essentially the same as the Core Erlang code for a/1:
b(N) ->
    case N of
        42 -> ok;
        _ -> error
    end.

c(inc, Base, N) ->
    Base+N;
c(_, Base, _) ->
    Base.

% if 完全由 when 实现
d(A, B) ->
    if
        A > B ->
            greater;
        true ->
            not_greater
    end.

cmp(Same, Same) -> same;
cmp(_, _) -> different.


e(42) -> ok.
f(N) ->
    case N of
        42 -> ok
    end.
g(N) ->
    42 = N,
    ok.

h(A) ->
    I = id(A),
    I + A.

i(E) ->
    case E of
        a ->
            X = 1,
            Y = 10;
        b ->
            X = 23,
            Y = 17
    end,
    {X,Y}.