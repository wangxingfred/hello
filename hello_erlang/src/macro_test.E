-file("macro_test.erl", 1).

-module(macro_test).

-copyright({jzyx, 'www.jzyx.com'}).

-author({fred, 'wangxingfred@gmail.com'}).

-vsn(1).

-record(throw_err,{id :: integer(), vars :: term(), log :: tuple()}).

-export([assert/2]).

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



