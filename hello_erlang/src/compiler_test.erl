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

%%%================================EXPORT================================
-export([a/0, b/0]).

a() ->
    receive
        _ -> ok
    after 5000 ->
        timeout
    end.

b() ->
    erlang:send_after(5000, self(), timeout).
