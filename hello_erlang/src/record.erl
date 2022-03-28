%%%-------------------------------------------------------------------
%%% @author fred
%%% @copyright (C) 2021, <Woobest>
%%% @doc
%%%     TODO 模块描述
%%% @end
%%% Created : 08. Sep 2021 3:01 PM
%%%-------------------------------------------------------------------
-module(record).

-copyright({jzyx, 'www.jzyx.com'}).
-author({fred, 'wangxingfred@gmail.com'}).
-vsn(1).

%% c(record, ['P']).  ->  record.P
%% c(record, ['E']).  ->  record.E
%% c(record, ['S']).  ->  record.S

%%%===============================INCLUDE================================

%%%================================DEFINE================================
%% 不需要给其它模块用的宏定义可以写到这里，避免放到头文件中修改后增加编译时间
-record(test, {
    a,
    b,
    c,
    d,
    e,
    f,
    g
}).

%%%================================EXPORT================================
-export([get_field_a/1, get_field_b/1, get_field_e/1]).
-export([guard_1/1, guard_2/1]).

get_field_a(Test) ->
    Test#test.a.

get_field_b(Test) ->
    element(#test.b, Test).

get_field_e(Test) ->
    Test#test.e.

guard_1(#test{} = Test) ->
    Test#test.a;
guard_1(Other) -> Other.

guard_2(Test) when is_record(Test, test) ->
    Test#test.a;
guard_2(Other) -> Other.
