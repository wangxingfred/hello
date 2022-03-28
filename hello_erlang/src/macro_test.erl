%%%-------------------------------------------------------------------
%%% @author fred
%%% @copyright (C) 2021, <Woobest>
%%% @doc
%%%     TODO 模块描述
%%% @end
%%% Created : 21. 12月 2021 19:37
%%%-------------------------------------------------------------------
-module(macro_test).

-copyright({jzyx, 'www.jzyx.com'}).
-author({fred, 'wangxingfred@gmail.com'}).
-vsn(1).

%%%===============================INCLUDE================================

%%%================================DEFINE================================
%% 不需要给其它模块用的宏定义可以写到这里，避免放到头文件中修改后增加编译时间

% 抛出错误信息
-record(throw_err, {
    id :: integer(), % 错误编号
    vars :: term(),  % 传给客户端的错误附加数据
    log :: tuple() % 附加到错误日志中的数据
}).

% 抛错
-define(THROW_ERR(Err), throw(Err)).
% 抛错，并且附带日志数据
-define(THROW_ERR(Err, Log), throw(setelement(#throw_err.log, Err, Log))).

-define(ASSERT(BoolExpr, Err), case (BoolExpr) of true -> ok; _ -> ?THROW_ERR(Err) end).
-define(ASSERT(BoolExpr, Err, Log), case (BoolExpr) of true -> ok; _ -> ?THROW_ERR(Err, Log) end).

%%%================================EXPORT================================
-export([assert/2]).

%% c(macro_test, ['P']).  ->  world.P
%% c(macro_test, ['E']).  ->  world.E
%% c(macro_test, ['S']).  ->  world.S

assert(A, B) ->
    ?ASSERT(A =:= B, #throw_err{id = 1}),

    ?ASSERT(A > B, #throw_err{id = 1}, {A, B}),

    ?ASSERT(A < B, #throw_err{id = 1}, [{"A", A}, {"B", B}]).
