-file("macro_test.erl", 1).

-module(macro_test).

-copyright({jzyx, 'www.jzyx.com'}).

-author({fred, 'wangxingfred@gmail.com'}).

-vsn(1).

-record(throw_err,{id :: integer(), vars :: term(), log :: tuple()}).

-export([assert/2,catch_throw/3]).

assert(A, B) ->
    case A =:= B of
        true ->
            ok;
        _ ->
            throw({throw_err, 1, undefined, undefined})
    end,
    case A > B of
        true ->
            ok;
        _ ->
            throw(setelement(4,
                             {throw_err, 1, undefined, undefined},
                             {A, B}))
    end,
    case A < B of
        true ->
            ok;
        _ ->
            throw(setelement(4,
                             {throw_err, 1, undefined, undefined},
                             [{"A", A}, {"B", B}]))
    end.

catch_throw(A, B, C) ->
    try
        begin
            begin
                A1 = A + B,
                A2 = A + C,
                assert(A, B),
                A1 + A2
            end
        end
    catch
        throw:{throw_err, _, _, _} = __Err__ ->
            __Err__
    end.



