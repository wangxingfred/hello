%%%-------------------------------------------------------------------
%%% @author fred
%%% @copyright (C) 2021, <Woobest>
%%% @doc
%%%     lists test cases
%%% @end
%%% Created : 04. Nov 2021 7:27 PM
%%%-------------------------------------------------------------------
-module(lists_test).

-copyright({jzyx, 'www.jzyx.com'}).
-author({fred, 'wangxingfred@gmail.com'}).
-vsn(1).

%%%===============================INCLUDE================================

%%%================================DEFINE================================
%% 不需要给其它模块用的宏定义可以写到这里，避免放到头文件中修改后增加编译时间

%% c(lists_test, ['S']).  ->  lists_test.S

%%%================================EXPORT================================
-export([bif_keyfind/2, foreach/2, push/2, push/3]).
-export([concat/2, subtract/2, concat_unique/2]).
-export([reverse1/2, reverse2/2]).

bif_keyfind(Key, List) ->
    lists:keyfind(Key, 1, List).

foreach(List, Func) ->
    [Func(X) || X <- List],
    no_return.

push(L1, V1) ->
    [{X, V1} || X <- L1].
push(L1, V1, L2) ->
    [{X, V1} || X <- L1] ++ L2.

concat(L1, L2) ->
    L1 ++ L2.

subtract(L1, L2) ->
    L1 -- L2.

concat_unique(L1, L2) ->
    L2 ++ (L1 -- L2).


reverse1(L1, L2) ->
    lists:reverse(L1) ++ L2.

reverse2(L1, L2) ->
    lists:reverse(L1, L2).