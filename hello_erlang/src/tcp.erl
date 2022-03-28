%%%-------------------------------------------------------------------
%%% @author fred
%%% @copyright (C) 2022, <Woobest>
%%% @doc
%%%     TODO 模块描述
%%% @end
%%% Created : 17. 3月 2022 19:41
%%%-------------------------------------------------------------------
-module(tcp).

-copyright({jzyx, 'www.jzyx.com'}).
-author({fred, 'wangxingfred@gmail.com'}).
-vsn(1).

%%%===============================INCLUDE================================

%%%================================DEFINE================================
%% 不需要给其它模块用的宏定义可以写到这里，避免放到头文件中修改后增加编译时间

%%%================================EXPORT================================
-export([accept/1]).

accept(Port) ->
    {ok, ListenSocket} = gen_tcp:listen(Port, []),

    {ok, Socket} = gen_tcp:accept(ListenSocket),

    {ok, IFs} = inet:getif(Socket),

    IFs.
