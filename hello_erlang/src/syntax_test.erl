%%%-------------------------------------------------------------------
%%% @author fred
%%% @copyright (C) 2022, <Woobest>
%%% @doc
%%%     语法测试
%%% @end
%%% Created : 18. 4月 2022 20:33
%%%-------------------------------------------------------------------
-module(syntax_test).

-copyright({jzyx, 'www.jzyx.com'}).
-author({fred, 'wangxingfred@gmail.com'}).
-vsn(1).

%%%===============================INCLUDE================================

%%%================================DEFINE================================
%% 不需要给其它模块用的宏定义可以写到这里，避免放到头文件中修改后增加编译时间

%%%================================EXPORT================================
-export([add/2, catch_add/2, try_after/2]).

%% c(syntax_test, ['P']).  ->  world.P
%% c(syntax_test, ['E']).  ->  world.E
%% c(syntax_test, ['S']).  ->  world.S

add(A, B) ->
    A + B.

catch_add(A, B) ->
    catch A + B.

try_after(A, B) ->
    try
        A + B
    after
        io:format("A=~p,B=~p~n", [A, B])
    end.