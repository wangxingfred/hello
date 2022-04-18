%%%-------------------------------------------------------------------
%%% @author fred
%%% @copyright (C) 2022, <Woobest>
%%% @doc
%%%     TODO 模块描述
%%% @end
%%% Created : 19. 3月 2022 17:34
%%%-------------------------------------------------------------------
-module(map_test).

-copyright({jzyx, 'www.jzyx.com'}).
-author({fred, 'wangxingfred@gmail.com'}).
-vsn(1).

%% c(map_test, ['P']).
%% c(map_test, ['E']).
%% c(map_test, ['S']).

%%%===============================INCLUDE================================

%%%================================DEFINE================================
%% 不需要给其它模块用的宏定义可以写到这里，避免放到头文件中修改后增加编译时间
-define(SMALL_MAP_LIMIT, 32).

-define(MAP_1, #{a => 1, b => 2}).
-define(MAP_2, ?MAP_1#{c => 3}).

-define(MAP_3, #{
    node => node(), pid => self(),
    mfa => {?MODULE, ?FUNCTION_NAME, ?FUNCTION_ARITY},
    time => now_millisecond()
}).
-define(MAP_4, ?MAP_3#{line => ?LINE}).

-define(MAP_5,
    begin
        Node = node(),
        Pid = self(),
        MFA = {?MODULE, ?FUNCTION_NAME, ?FUNCTION_ARITY},
        Time = now_millisecond(),
        #{node => Node, pid => Pid ,mfa => MFA, time => Time}
    end).
-define(MAP_6,
    begin
        Line = ?LINE,
        ?MAP_5#{line => Line}
    end).

-define(MAP_7, #{
    node => node, pid => pid,
    mfa => {?MODULE, ?FUNCTION_NAME, ?FUNCTION_ARITY}, time => 0}#{
    node := node(), pid := self(), time := now_millisecond()
}).
-define(MAP_8, ?MAP_7#{line => ?LINE}).

%%%================================EXPORT================================
-compile([export_all, nowarn_export_all]).

flatmap() ->
    maps:from_keys([a,b,c], 1).

flatmap_keys(Map) when is_map(Map) ->
    erts_internal:map_to_tuple_keys(Map).

is_flatmap(Map) ->
    erts_internal:term_type(Map) =:= flatmap.



get_value_1(Map, Key) ->
    #{Key := Value} = Map,
    Value.

get_value_2(Map, Key) ->
    maps:get(Key, Map).

get_value_3(Map, Key) ->
    map_get(Key, Map).

map1() -> ?MAP_1.
map2() -> ?MAP_2.
map3() -> ?MAP_3.
map4() -> ?MAP_4.
map5() -> ?MAP_5.
map6() -> ?MAP_6.
map7() -> ?MAP_7.
map8() -> ?MAP_8.

now_millisecond() ->
    os:system_time(millisecond).
