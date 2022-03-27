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

%%%================================EXPORT================================
-compile([export_all, nowarn_export_all]).

flatmap() ->
    maps:from_keys([a,b,c], 1).

flatmap_keys(Map) when is_map(Map) ->
    erts_internal:map_to_tuple_keys(Map).

is_flatmap(Map) ->
    erts_internal:term_type(Map) =:= flatmap.
