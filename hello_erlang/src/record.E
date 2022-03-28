-file("record.erl", 1).

-module(record).

-copyright({jzyx, 'www.jzyx.com'}).

-author({fred, 'wangxingfred@gmail.com'}).

-vsn(1).

-record(test,{a, b, c, d, e, f, g}).

-export([get_field_a/1,get_field_b/1,get_field_e/1]).

-export([guard_1/1,guard_2/1]).

get_field_a(Test) ->
    case Test of
        {test, rec0, _, _, _, _, _, _} ->
            rec0;
        _ ->
            error({badrecord, test})
    end.

get_field_b(Test) ->
    element(3, Test).

get_field_e(Test) ->
    case Test of
        {test, _, _, _, _, rec1, _, _} ->
            rec1;
        _ ->
            error({badrecord, test})
    end.

guard_1({test, _, _, _, _, _, _, _} = Test) ->
    case Test of
        {test, rec2, _, _, _, _, _, _} ->
            rec2;
        _ ->
            error({badrecord, test})
    end;
guard_1(Other) ->
    Other.

guard_2({test, _, _, _, _, _, _, _} = Test) when true ->
    case Test of
        {test, rec3, _, _, _, _, _, _} ->
            rec3;
        _ ->
            error({badrecord, test})
    end;
guard_2(Other) ->
    Other.



