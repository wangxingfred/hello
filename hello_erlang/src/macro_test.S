{module, macro_test}.  %% version = 0

{exports, [{assert,2},{module_info,0},{module_info,1}]}.

{attributes, [{copyright,[{jzyx,'www.jzyx.com'}]},
              {author,[{fred,'wangxingfred@gmail.com'}]},
              {vsn,[1]}]}.

{labels, 10}.


{function, assert, 2, 2}.
  {label,1}.
    {line,[{location,"macro_test.erl",42}]}.
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
    {line,[{location,"macro_test.erl",47}]}.
    {call_ext,1,{extfunc,erlang,throw,1}}.
  {label,4}.
    {test_heap,8,2}.
    {put_tuple2,{x,0},{list,[{x,0},{x,1}]}}.
    {put_tuple2,{x,0},
                {list,[{atom,throw_err},{integer,1},{atom,undefined},{x,0}]}}.
    {line,[{location,"macro_test.erl",45}]}.
    {call_ext,1,{extfunc,erlang,throw,1}}.
  {label,5}.
    {move,{literal,{throw_err,1,undefined,undefined}},{x,0}}.
    {line,[{location,"macro_test.erl",43}]}.
    {call_ext,1,{extfunc,erlang,throw,1}}.


{function, module_info, 0, 7}.
  {label,6}.
    {line,[]}.
    {func_info,{atom,macro_test},{atom,module_info},0}.
  {label,7}.
    {move,{atom,macro_test},{x,0}}.
    {line,[]}.
    {call_ext_only,1,{extfunc,erlang,get_module_info,1}}.


{function, module_info, 1, 9}.
  {label,8}.
    {line,[]}.
    {func_info,{atom,macro_test},{atom,module_info},1}.
  {label,9}.
    {move,{x,0},{x,1}}.
    {move,{atom,macro_test},{x,0}}.
    {line,[]}.
    {call_ext_only,2,{extfunc,erlang,get_module_info,2}}.
