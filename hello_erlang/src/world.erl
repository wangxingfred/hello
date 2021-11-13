%%%-------------------------------------------------------------------
%%% @author fred
%%% @copyright (C) 2021, <Woobest>
%%% @doc
%%%     Example of Compiler Pass
%%% @end
%%% Created : 29. Jun 2021 5:05 PM
%%%-------------------------------------------------------------------
-module(world).
-export([hello/0]).

-include("world.hrl").

hello() -> ?GREETING.

%% https://blog.stenmans.org/theBeamBook/#_compiler_pass_beam_code
%%
%% compile:options().
%%
%% c(world, ['P']).  ->  world.P
%%      -file("world.erl", 1).
%%      -module(world).
%%      -export([hello/0]).
%%      -file("world.hrl", 1).
%%      -file("world.erl", 4).
%%      hello() ->
%%          "hello world".
%%
%% c(world, ['E']).  ->  world.E
%%      -vsn("\002").
%%      -file("world.erl", 1).
%%      -file("world.hrl", 1).
%%      -file("world.erl", 5).
%%      hello() ->
%%          "hello world".
%%      module_info() ->
%%          erlang:get_module_info(world).
%%      module_info(X) ->
%%          erlang:get_module_info(world, X).
%%
%% c(world, ['S']).  ->  world.S
%%      {module, world}.  %% version = 0
%%      {exports, [{hello,0},{module_info,0},{module_info,1}]}.
%%      {attributes, []}.
%%      {labels, 7}.
%%      {function, hello, 0, 2}.
%%        {label,1}.
%%          {line,[{location,"world.erl",6}]}.
%%          {func_info,{atom,world},{atom,hello},0}.
%%        {label,2}.
%%          {move,{literal,"hello world"},{x,0}}.
%%          return.
%%      {function, module_info, 0, 4}.
%%        {label,3}.
%%          {line,[]}.
%%          {func_info,{atom,world},{atom,module_info},0}.
%%        {label,4}.
%%          {move,{atom,world},{x,0}}.
%%          {line,[]}.
%%          {call_ext_only,1,{extfunc,erlang,get_module_info,1}}.
%%      {function, module_info, 1, 6}.
%%        {label,5}.
%%          {line,[]}.
%%          {func_info,{atom,world},{atom,module_info},1}.
%%        {label,6}.
%%          {move,{x,0},{x,1}}.
%%          {move,{atom,world},{x,0}}.
%%          {line,[]}.
%%          {call_ext_only,2,{extfunc,erlang,get_module_info,2}}.
%%
%%  {ok, BEAM_Code} = file:consult("world.S").