%%%-------------------------------------------------------------------
%%% @author fred
%%% @copyright (C) 2022, localhost
%%% @doc
%%%     TODO 模块描述
%%% @end
%%% Created : 08. 7月 2022 22:47
%%%-------------------------------------------------------------------
-module(mnesia_test).
-copyright({jzyx, 'www.jzyx.com'}).
-author({fred, 'wangxingfred@gmail.com'}).
-vsn(1).

-include_lib("eunit/include/eunit.hrl").

-include_lib("stdlib/include/qlc.hrl").

-record(shop, {item, quantity, cost}).
-record(cost, {name, price}).
-record(design, {id, plan}).

-compile([export_all, nowarn_export_all]).


simple_test() ->
    ?assert(true).

do_this_once() ->
    {
        application:ensure_all_started(mnesia),
        mnesia:create_schema([node()]),
        mnesia:start(),
        mnesia:create_table(shop, [
            {disc_copies, [node()]},
%%            {record_name, element(1, #shop{})}, record_name默认为table的Name，可以不填
            {attributes, record_info(fields, shop)}
        ]),
        mnesia:create_table(cost, [
            {disc_copies, [node()]},
            {attributes, record_info(fields, cost)}
        ]),
        mnesia:create_table(design, [
            {disc_copies, [node()]},
            {attributes, record_info(fields, design)}
        ]),
        mnesia:create_table(my_design, [
            {disc_copies, [node()]},
            {record_name, design},
            {attributes, record_info(fields, design)}
        ]),
        mnesia:create_table(your_design, [
            {disc_copies, [node()]},
            {record_name, design},
            {attributes, record_info(fields, design)}
        ]),
        mnesia:wait_for_tables([shop, cost, design, my_design, your_design], 5000)
%%        mnesia:stop()
    }.

start() ->
    mnesia:start(),
    mnesia:wait_for_tables([shop, cost, design, my_design, your_design], 20000).

dirty_ops() ->
    {
        mnesia:dirty_write(my_design, #design{id = 1}),
        mnesia:dirty_write(your_design, #design{id = 1}),

        mnesia:dirty_delete(your_design, 1),
        mnesia:dirty_delete(your_design, 2),


        mnesia:dirty_read(my_design, 1),
        mnesia:dirty_read(your_design, 1),

        mnesia:dirty_all_keys(my_design),
        mnesia:dirty_select(my_design, [{'$1', [], ['$1']}])
    }.

reset_tables() ->
    mnesia:clear_table(shop),
    mnesia:clear_table(cost),

    mnesia:transaction(
        fun() ->
            lists:foreach(fun mnesia:write/1, example_tables())
        end).

demo(select_shop) ->
    do(qlc:q([X || X <- mnesia:table(shop)]));
demo(select_some) ->
    do(qlc:q([{X#shop.item, X#shop.quantity} || X <- mnesia:table(shop)]));
demo(reorder) ->
    do(qlc:q([X#shop.item || X <- mnesia:table(shop), X#shop.quantity < 250]));
demo(join) ->
    do(qlc:q([X#shop.item || X <- mnesia:table(shop), X#shop.quantity < 250,
        Y <- mnesia:table(cost), X#shop.item =:= Y#cost.name, Y#cost.price < 2]));
demo(_) ->
    error.

add_shop_item(Name, Quantity, Cost) ->
    Row = #shop{item = Name, quantity = Quantity, cost = Cost},
    mnesia:transaction(
        fun() ->
            mnesia:write(Row)
        end
    ).

remove_shop_item(Item) ->
    Oid = {shop, Item},
    mnesia:transaction(fun() ->
        mnesia:delete(Oid)
                       end).

do(Q) ->
    F = fun() -> qlc:e(Q) end,
    {atomic, Val} = mnesia:transaction(F),
    Val.



example_tables() ->
    [%% The shop table
        {shop, apple, 20, 2.3},
        {shop, orange, 100, 3.8},
        {shop, pear, 200, 3.6},
        {shop, banana, 420, 4.5},
        {shop, potato, 2456, 1.2},
        %% The cost table
        {cost, apple, 1.5},
        {cost, orange, 2.4},
        {cost, pear, 2.2},
        {cost, banana, 1.5},
        {cost, potato, 0.6}
    ].

record_info() ->
    %% TODO delete
    io:format("record_info(fields, shop) = ~p~n", [record_info(fields, shop)]),
    io:format("record_info(size, shop) = ~p~n", [record_info(size, shop)]).
