{module, compiler_test}.  %% version = 0

{exports, [{a,0},
           {b,0},
           {case_,3},
           {if_,3},
           {macro_ignore,2},
           {module_info,0},
           {module_info,1},
           {reserve_list,1}]}.

{attributes, [{copyright,[{jzyx,'www.jzyx.com'}]},
              {author,[{fred,'wangxingfred@gmail.com'}]},
              {vsn,[1]}]}.

{labels, 27}.


{function, a, 0, 2}.
  {label,1}.
    {line,[{location,"compiler_test.erl",31}]}.
    {func_info,{atom,compiler_test},{atom,a},0}.
  {label,2}.
    {allocate,0,0}.
  {label,3}.
    {loop_rec,{f,4},{x,0}}.
    remove_message.
    {move,{atom,ok},{x,0}}.
    {deallocate,0}.
    return.
  {label,4}.
    {wait_timeout,{f,3},{integer,5000}}.
    timeout.
    {move,{atom,timeout},{x,0}}.
    {deallocate,0}.
    return.


{function, b, 0, 6}.
  {label,5}.
    {line,[{location,"compiler_test.erl",38}]}.
    {func_info,{atom,compiler_test},{atom,b},0}.
  {label,6}.
    {bif,self,{f,0},[],{x,1}}.
    {move,{atom,timeout},{x,2}}.
    {move,{integer,5000},{x,0}}.
    {line,[{location,"compiler_test.erl",39}]}.
    {call_ext_only,3,{extfunc,erlang,send_after,3}}.


{function, if_, 3, 8}.
  {label,7}.
    {line,[{location,"compiler_test.erl",41}]}.
    {func_info,{atom,compiler_test},{atom,if_},3}.
  {label,8}.
    {test,is_eq_exact,{f,9},[{x,0},{x,1}]}.
    {move,{x,2},{x,0}}.
    return.
  {label,9}.
    return.


{function, case_, 3, 11}.
  {label,10}.
    {line,[{location,"compiler_test.erl",46}]}.
    {func_info,{atom,compiler_test},{atom,case_},3}.
  {label,11}.
    {test,is_eq_exact,{f,12},[{x,0},{x,1}]}.
    {move,{x,2},{x,0}}.
    return.
  {label,12}.
    return.


{function, macro_ignore, 2, 14}.
  {label,13}.
    {line,[{location,"compiler_test.erl",52}]}.
    {func_info,{atom,compiler_test},{atom,macro_ignore},2}.
  {label,14}.
    {line,[{location,"compiler_test.erl",58}]}.
    {gc_bif,'+',{f,0},2,[{x,0},{x,1}],{x,0}}.
    return.


{function, reserve_list, 1, 16}.
  {label,15}.
    {line,[{location,"compiler_test.erl",60}]}.
    {func_info,{atom,compiler_test},{atom,reserve_list},1}.
  {label,16}.
    {allocate,1,1}.
    {move,{x,0},{y,0}}.
    {move,nil,{x,1}}.
    {line,[{location,"compiler_test.erl",61}]}.
    {call,2,{f,18}}.
    {'%',{type_info,{x,0},list}}.
    {move,nil,{x,1}}.
    {move,{y,0},{x,0}}.
    {call_last,2,{f,21},1}.


{function, reserve_list1, 2, 18}.
  {label,17}.
    {line,[{location,"compiler_test.erl",64}]}.
    {func_info,{atom,compiler_test},{atom,reserve_list1},2}.
  {label,18}.
    {'%',{type_info,{x,1},list}}.
    {test,is_nonempty_list,{f,19},[{x,0}]}.
    {test_heap,2,2}.
    {get_list,{x,0},{x,2},{x,0}}.
    {put_list,{x,2},{x,1},{x,1}}.
    {call_only,2,{f,18}}.
  {label,19}.
    {test,is_nil,{f,17},[{x,0}]}.
    {move,{x,1},{x,0}}.
    return.


{function, reserve_list2, 2, 21}.
  {label,20}.
    {line,[{location,"compiler_test.erl",68}]}.
    {func_info,{atom,compiler_test},{atom,reserve_list2},2}.
  {label,21}.
    {'%',{type_info,{x,1},list}}.
    {test,is_nonempty_list,{f,22},[{x,0}]}.
    {test_heap,2,2}.
    {get_list,{x,0},{x,2},{x,0}}.
    {put_list,{x,2},{x,1},{x,1}}.
    {call_only,2,{f,21}}.
  {label,22}.
    {test,is_nil,{f,20},[{x,0}]}.
    {move,{x,1},{x,0}}.
    return.


{function, module_info, 0, 24}.
  {label,23}.
    {line,[]}.
    {func_info,{atom,compiler_test},{atom,module_info},0}.
  {label,24}.
    {move,{atom,compiler_test},{x,0}}.
    {line,[]}.
    {call_ext_only,1,{extfunc,erlang,get_module_info,1}}.


{function, module_info, 1, 26}.
  {label,25}.
    {line,[]}.
    {func_info,{atom,compiler_test},{atom,module_info},1}.
  {label,26}.
    {move,{x,0},{x,1}}.
    {move,{atom,compiler_test},{x,0}}.
    {line,[]}.
    {call_ext_only,2,{extfunc,erlang,get_module_info,2}}.
