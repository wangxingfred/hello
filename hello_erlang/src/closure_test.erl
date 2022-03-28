%%%-------------------------------------------------------------------
%%% @author fred
%%% @copyright (C) 2021, <Woobest>
%%% @doc
%%%     TODO 模块描述
%%% @end
%%% Created : 27. 12月 2021 10:42
%%%-------------------------------------------------------------------
-module(closure_test).

-copyright({jzyx, 'www.jzyx.com'}).
-author({fred, 'wangxingfred@gmail.com'}).
-vsn(1).

%% c(closure_test, ['P']).  ->  world.P
%% c(closure_test, ['E']).  ->  world.E
%% c(closure_test, ['S']).  ->  world.S

%%%===============================INCLUDE================================

%%%================================DEFINE================================
%% 不需要给其它模块用的宏定义可以写到这里，避免放到头文件中修改后增加编译时间

%%%================================EXPORT================================
-export([get_closure/2, get_fun/2]).

get_closure(A, B) ->
    C = 10,
    fun (D) ->
           A + B + C + D
    end.

get_fun(A, B) ->
    C = 10,
    {fun add_/4, [A, B,C]}.

add_(A, B, C, D) ->
    A + B + C + D.