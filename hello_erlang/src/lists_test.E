-file("lists_test.erl", 1).

-module(lists_test).

-copyright({jzyx, 'www.jzyx.com'}).

-author({fred, 'wangxingfred@gmail.com'}).

-vsn(1).

-export([bif_keyfind/2,foreach/2,push/2,push/3]).

-export([concat/2,subtract/2,concat_unique/2]).

bif_keyfind(Key, List) ->
    lists:keyfind(Key, 1, List).

foreach(List, Func) ->
    [ 
     (Func(X)) ||
         X <- List
    ],
    no_return.

push(L1, V1) ->
    [ 
     {X, V1} ||
         X <- L1
    ].

push(L1, V1, L2) ->
    [ 
     {X, V1} ||
         X <- L1
    ]
    ++
    L2.

concat(L1, L2) ->
    L1 ++ L2.

subtract(L1, L2) ->
    L1 -- L2.

concat_unique(L1, L2) ->
    L2 ++ L1 -- L2.



