{module, macro_test}.  %% version = 0

{exports, [{assert,2},{catch_throw,3},{module_info,0},{module_info,1}]}.

{attributes, [{copyright,[{jzyx,'www.jzyx.com'}]},
              {author,[{fred,'wangxingfred@gmail.com'}]},
              {vsn,[1]}]}.

{labels, 14}.


{function, assert, 2, 2}.
  {label,1}.
    {line,[{location,"macro_test.erl",56}]}.
    {func_info,{atom,macro_test},{atom,assert},2}.
  {label,2}.
    {test,is_eq_exact,{f,5},[{x,0},{x,1}]}.
    {test,is_lt,{f,4},[{x,1},{x,0}]}.
    {test,is_lt,{f,3},[{x,0},{x,1}]}.
    {move,{atom,ok},{x,0}}.
    return.
  {label,3}.
    {test_heap,15,2}.
    {put_tuple2,{x,1},{list,[{literal,"B"},{x,1}]}}.
    {put_list,{x,1},nil,{x,1}}.
    {put_tuple2,{x,0},{list,[{literal,"A"},{x,0}]}}.
    {put_list,{x,0},{x,1},{x,0}}.
    {put_tuple2,{x,0},
                {list,[{atom,throw_err},{integer,1},{atom,undefined},{x,0}]}}.
    {line,[{location,"macro_test.erl",61}]}.
    {call_ext_only,1,{extfunc,erlang,throw,1}}.
  {label,4}.
    {test_heap,8,2}.
    {put_tuple2,{x,0},{list,[{x,0},{x,1}]}}.
    {put_tuple2,{x,0},
                {list,[{atom,throw_err},{integer,1},{atom,undefined},{x,0}]}}.
    {line,[{location,"macro_test.erl",59}]}.
    {call_ext_only,1,{extfunc,erlang,throw,1}}.
  {label,5}.
    {move,{literal,{throw_err,1,undefined,undefined}},{x,0}}.
    {line,[{location,"macro_test.erl",57}]}.
    {call_ext_only,1,{extfunc,erlang,throw,1}}.


{function, catch_throw, 3, 7}.
  {label,6}.
    {line,[{location,"macro_test.erl",63}]}.
    {func_info,{atom,macro_test},{atom,catch_throw},3}.
  {label,7}.
    {allocate,3,3}.
    {init_yregs,{list,[{y,0},{y,1}]}}.
    {'try',{y,2},{f,8}}.
    {line,[{location,"macro_test.erl",66}]}.
    {gc_bif,'+',{f,0},3,[{x,0},{x,1}],{y,1}}.
    {line,[{location,"macro_test.erl",67}]}.
    {gc_bif,'+',{f,0},3,[{tr,{x,0},number},{x,2}],{y,0}}.
    {line,[{location,"macro_test.erl",68}]}.
    {call,2,{f,2}}. % assert/2
    {'%',{var_info,{x,0},[{type,{t_atom,[ok]}}]}}.
    {line,[{location,"macro_test.erl",69}]}.
    {gc_bif,'+',{f,0},0,[{tr,{y,1},number},{tr,{y,0},number}],{x,0}}.
    {try_end,{y,2}}.
    {deallocate,3}.
    return.
  {label,8}.
    {try_case,{y,2}}.
    {test,is_eq_exact,
          {f,9},
          [{tr,{x,0},{t_atom,[error,exit,throw]}},{atom,throw}]}.
    {test,is_tagged_tuple,{f,9},[{x,1},4,{atom,throw_err}]}.
    {move,{x,1},{x,0}}.
    {deallocate,3}.
    return.
  {label,9}.
    {bif,raise,{f,0},[{x,2},{x,1}],{x,0}}.


{function, module_info, 0, 11}.
  {label,10}.
    {line,[]}.
    {func_info,{atom,macro_test},{atom,module_info},0}.
  {label,11}.
    {move,{atom,macro_test},{x,0}}.
    {call_ext_only,1,{extfunc,erlang,get_module_info,1}}.


{function, module_info, 1, 13}.
  {label,12}.
    {line,[]}.
    {func_info,{atom,macro_test},{atom,module_info},1}.
  {label,13}.
    {move,{x,0},{x,1}}.
    {move,{atom,macro_test},{x,0}}.
    {call_ext_only,2,{extfunc,erlang,get_module_info,2}}.
