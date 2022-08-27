%%%-------------------------------------------------------------------
%%% @author fred
%%% @copyright (C) 2022, <Woobest>
%%% @doc
%%%     TODO 模块描述
%%% @end
%%% Created : 09. 6月 2022 14:50
%%%-------------------------------------------------------------------
-module(fun_test).

-copyright({jzyx, 'www.jzyx.com'}).
-author({fred, 'wangxingfred@gmail.com'}).
-vsn(1).

%% c(fun_test, ['P']).  ->  world.P
%% c(fun_test, ['E']).  ->  world.E
%% c(fun_test, ['S']).  ->  world.S

%%%===============================INCLUDE================================

%%%================================DEFINE================================
%% 不需要给其它模块用的宏定义可以写到这里，避免放到头文件中修改后增加编译时间

%%%================================EXPORT================================
-export([external_mf/0, local_fun1/0, local_fun2/0]).
-export([do_sth/0]).
-export([bind_not_exported/0]).

% erlang:fun_info(external_mf(), type) = {type,external}
external_mf() ->
    fun ?MODULE:do_sth/0.

% erlang:fun_info(local_fun1(), type) = {type,local}
local_fun1() ->
    fun do_sth/0.

% erlang:fun_info(local_fun2(), type) = {type,local}
local_fun2() ->
    fun () -> do_sth() end.


do_sth() ->
    io:format("~p:~p:~p ccc ~n", [?MODULE, ?FUNCTION_NAME, ?LINE]).

bind_not_exported() ->
    %% 此函数可以正常返回
    %% 但是：由于not_exported未导出，执行返回函数会报undefined function
    %% 如果在执行返回函数前，把not_exported导出，则可以正常执行
    %% 结论就是：下面这种形式，基本相当于{M,F,[]}，唯一的区别是限定了参数数量
    fun ?MODULE:not_exported/0.

not_exported() ->
    not_exported.
