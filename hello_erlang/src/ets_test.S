{module, ets_test}.  %% version = 0

{exports, [{match_object,0},{module_info,0},{module_info,1}]}.

{attributes, [{copyright,[{jzyx,'www.jzyx.com'}]},
              {author,[{fred,'wangxingfred@gmail.com'}]},
              {vsn,[1]}]}.

{labels, 7}.


{function, match_object, 0, 2}.
  {label,1}.
    {line,[{location,"ets_test.erl",27}]}.
    {func_info,{atom,ets_test},{atom,match_object},0}.
  {label,2}.
    {allocate_zero,1,0}.
    {move,nil,{x,1}}.
    {move,{atom,ets_test},{x,0}}.
    {line,[{location,"ets_test.erl",28}]}.
    {call_ext,2,{extfunc,ets,new,2}}.
    {move,{x,0},{y,0}}.
    {move,{literal,{a,0,10}},{x,1}}.
    {line,[{location,"ets_test.erl",30}]}.
    {call_ext,2,{extfunc,ets,insert,2}}.
    {move,{literal,{{a,1},1,100}},{x,1}}.
    {move,{y,0},{x,0}}.
    {line,[{location,"ets_test.erl",31}]}.
    {call_ext,2,{extfunc,ets,insert,2}}.
    {move,{literal,{{a,2},2,200}},{x,1}}.
    {move,{y,0},{x,0}}.
    {line,[{location,"ets_test.erl",32}]}.
    {call_ext,2,{extfunc,ets,insert,2}}.
    {move,{literal,{{b,11},11,1100}},{x,1}}.
    {move,{y,0},{x,0}}.
    {line,[{location,"ets_test.erl",33}]}.
    {call_ext,2,{extfunc,ets,insert,2}}.
    {move,{literal,{{b,22,22},22,2200}},{x,1}}.
    {move,{y,0},{x,0}}.
    {line,[{location,"ets_test.erl",34}]}.
    {call_ext,2,{extfunc,ets,insert,2}}.
    {move,{literal,{{'_','_'},'_','_'}},{x,1}}.
    {move,{y,0},{x,0}}.
    {line,[{location,"ets_test.erl",36}]}.
    {call_ext_last,2,{extfunc,ets,match_object,2},1}.


{function, module_info, 0, 4}.
  {label,3}.
    {line,[]}.
    {func_info,{atom,ets_test},{atom,module_info},0}.
  {label,4}.
    {move,{atom,ets_test},{x,0}}.
    {line,[]}.
    {call_ext_only,1,{extfunc,erlang,get_module_info,1}}.


{function, module_info, 1, 6}.
  {label,5}.
    {line,[]}.
    {func_info,{atom,ets_test},{atom,module_info},1}.
  {label,6}.
    {move,{x,0},{x,1}}.
    {move,{atom,ets_test},{x,0}}.
    {line,[]}.
    {call_ext_only,2,{extfunc,erlang,get_module_info,2}}.
