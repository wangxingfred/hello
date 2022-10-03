%%%-------------------------------------------------------------------
%%% @author fred
%%% @copyright (C) 2022, <Woobest>
%%% @doc
%%%     TODO 模块描述
%%% @end
%%% Created : 07. 4月 2022 14:46
%%%-------------------------------------------------------------------
-module(ets_test).

-copyright({jzyx, 'www.jzyx.com'}).
-author({fred, 'wangxingfred@gmail.com'}).
-vsn(1).

%% c(ets_test, ['P']).  ->  world.P
%% c(ets_test, ['E']).  ->  world.E
%% c(ets_test, ['S']).  ->  world.S

%%%===============================INCLUDE================================

%%%================================DEFINE================================
%% 不需要给其它模块用的宏定义可以写到这里，避免放到头文件中修改后增加编译时间

%%%================================EXPORT================================
-compile([export_all, nowarn_export_all]).

match(Ets) ->
    KeyPattern = {'_', '_'},
    ObjPattern = {KeyPattern, '$1', '_'},
    ets:match_object(Ets, ObjPattern).

match_object(Ets) ->
    KeyPattern = {'_', '_'},
    ObjPattern = {KeyPattern, '_', '_'},
    ets:match_object(Ets, ObjPattern).

match_delete(Ets, KeyPattern) ->
%%    KeyPattern = {'_', '_'},
    ObjPattern = {KeyPattern, '_', '_'},
    ets:match_delete(Ets, ObjPattern).

create_ets() ->
    Ets = ets:new(?MODULE, [named_table]),
    Objects = [
        {a, 0, 10},
        {{a, 1}, 1, 100},
        {{a, 2}, 2, 200},
        {{b, 11}, 11, 1100},
        {{b, 22, 22}, 22, 2200},
        {c, 11, 100}
    ],
    ets:insert(Ets, Objects),
    Ets.


select_by_element(Ets, Pos, Value) ->
    MatchHead = '_',
    MatchConditions = [{'=:=', {element, Pos, '$_'}, Value}],
    MatchBody = ['$_'],
    MatchSpec = [{MatchHead, MatchConditions, MatchBody}],
    ets:select(Ets, MatchSpec).

select_key_by_element(Ets, Pos, Value) ->
    KeyPos = ets:info(Ets, keypos),
    MatchHead = '_',
    MatchConditions = [{'=:=', {element, Pos, '$_'}, Value}],
    MatchBody = [{element, KeyPos, '$_'}],
    MatchSpec = [{MatchHead, MatchConditions, MatchBody}],
    ets:select(Ets, MatchSpec).



spec_compiled_example(Ets, Pos, Value) ->
    MatchHead = '_',
    MatchConditions = [{'=:=', {element, Pos, '$_'}, Value}],
    MatchBody = ['$_'],
    MatchSpec = [{MatchHead, MatchConditions, MatchBody}],

    Compiled = ets:match_spec_compile(MatchSpec),

    %% TODO delete
    io:format("~n------------------~p:~p-----------------~n", [?MODULE, ?LINE]),
    io:format("MatchSpec = ~p~n", [MatchSpec]),
    io:format("Compiled = ~p~n", [Compiled]),
    io:format("-----------------------------------------------------------------~n"),

    ets:match_spec_run(ets:tab2list(Ets), Compiled).

