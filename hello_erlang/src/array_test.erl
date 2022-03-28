%%%-------------------------------------------------------------------
%%% @author fred
%%% @copyright (C) 2022, <Woobest>
%%% @doc
%%%     TODO 模块描述
%%% @end
%%% Created : 19. 3月 2022 17:19
%%%-------------------------------------------------------------------
-module(array_test).

-copyright({jzyx, 'www.jzyx.com'}).
-author({fred, 'wangxingfred@gmail.com'}).
-vsn(1).

%%%===============================INCLUDE================================

%%%================================DEFINE================================
%% 不需要给其它模块用的宏定义可以写到这里，避免放到头文件中修改后增加编译时间

%%%================================EXPORT================================
-compile([export_all, nowarn_export_all]).

%% Create a fixed-size array with entries 0-9 set to 'undefined'
test() ->
    A0 = array:new(10),
    10 = array:size(A0).

test2() ->
    %% Create an extendible array and set entry 17 to 'true',
    %% causing the array to grow automatically
    A1 = array:set(17, true, array:new()),
    18 = array:size(A1),

    %% Read back a stored value
    true = array:get(17, A1),

    %% Accessing an unset entry returns the default value
    undefined = array:get(3, A1),

    %% Accessing an entry beyond the last set entry also returns the
    %% default value, if the array does not have fixed size
    undefined = array:get(18, A1),

    %% "sparse" functions ignore default-valued entries
    A2 = array:set(4, false, A1),
    [{4, false}, {17, true}] = array:sparse_to_orddict(A2),

    %% An extendible array can be made fixed-size later
    A3 = array:fix(A2),

    %% A fixed-size array does not grow automatically and does not
    %% allow accesses beyond the last set entry
    {'EXIT', {badarg, _}} = (catch array:set(18, true, A3)),
    {'EXIT', {badarg, _}} = (catch array:get(18, A3)).

