{module, syntax_test}.  %% version = 0

{exports, [{add,2},
           {catch_add,2},
           {module_info,0},
           {module_info,1},
           {try_after,2}]}.

{attributes, [{copyright,[{jzyx,'www.jzyx.com'}]},
              {author,[{fred,'wangxingfred@gmail.com'}]},
              {vsn,[1]}]}.

{labels, 15}.


{function, add, 2, 2}.
  {label,1}.
    {line,[{location,"syntax_test.erl",27}]}.
    {func_info,{atom,syntax_test},{atom,add},2}.
  {label,2}.
    {line,[{location,"syntax_test.erl",28}]}.
    {gc_bif,'+',{f,0},2,[{x,0},{x,1}],{x,0}}.
    return.


{function, catch_add, 2, 4}.
  {label,3}.
    {line,[{location,"syntax_test.erl",30}]}.
    {func_info,{atom,syntax_test},{atom,catch_add},2}.
  {label,4}.
    {allocate,1,2}.
    {'catch',{y,0},{f,5}}.
    {line,[{location,"syntax_test.erl",31}]}.
    {gc_bif,'+',{f,0},2,[{x,0},{x,1}],{x,0}}.
  {label,5}.
    {catch_end,{y,0}}.
    {deallocate,1}.
    return.


{function, try_after, 2, 7}.
  {label,6}.
    {line,[{location,"syntax_test.erl",33}]}.
    {func_info,{atom,syntax_test},{atom,try_after},2}.
  {label,7}.
    {allocate,5,2}.
    {init,{y,0}}.
    {init,{y,1}}.
    {move,{x,1},{y,2}}.
    {move,{x,0},{y,3}}.
    {'try',{y,4},{f,8}}.
    {line,[{location,"syntax_test.erl",35}]}.
    {gc_bif,'+',{f,0},2,[{x,0},{x,1}],{y,1}}.
    {try_end,{y,4}}.
    {line,[{location,"syntax_test.erl",34}]}.
    {call,2,{f,14}}.
    {move,{y,1},{x,0}}.
    {deallocate,5}.
    return.
  {label,8}.
    {try_case,{y,4}}.
    {move,{x,2},{y,0}}.
    {move,{x,1},{y,1}}.
    {move,{y,2},{x,1}}.
    {move,{y,3},{x,0}}.
    {kill,{y,2}}.
    {kill,{y,3}}.
    {line,[{location,"syntax_test.erl",34}]}.
    {call,2,{f,14}}.
    {bif,raise,{f,0},[{y,0},{y,1}],{x,0}}.


{function, module_info, 0, 10}.
  {label,9}.
    {line,[]}.
    {func_info,{atom,syntax_test},{atom,module_info},0}.
  {label,10}.
    {move,{atom,syntax_test},{x,0}}.
    {line,[]}.
    {call_ext_only,1,{extfunc,erlang,get_module_info,1}}.


{function, module_info, 1, 12}.
  {label,11}.
    {line,[]}.
    {func_info,{atom,syntax_test},{atom,module_info},1}.
  {label,12}.
    {move,{x,0},{x,1}}.
    {move,{atom,syntax_test},{x,0}}.
    {line,[]}.
    {call_ext_only,2,{extfunc,erlang,get_module_info,2}}.


{function, '-try_after/2-after$^0/0-0-', 2, 14}.
  {label,13}.
    {line,[{location,"syntax_test.erl",34}]}.
    {func_info,{atom,syntax_test},{atom,'-try_after/2-after$^0/0-0-'},2}.
  {label,14}.
    {test_heap,4,2}.
    {put_list,{x,1},nil,{x,1}}.
    {put_list,{x,0},{x,1},{x,1}}.
    {move,{literal,"A=~p,B=~p~n"},{x,0}}.
    {line,[{location,"syntax_test.erl",37}]}.
    {call_ext_only,2,{extfunc,io,format,2}}.
