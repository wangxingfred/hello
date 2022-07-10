{module, compiler_test}.  %% version = 0

{exports, [{a,0},
           {b,0},
           {case_,3},
           {if_,3},
           {macro_ignore,2},
           {maybe_expression,2},
           {module_info,0},
           {module_info,1},
           {reserve_list,1}]}.

{attributes, [{copyright,[{jzyx,'www.jzyx.com'}]},
              {author,[{fred,'wangxingfred@gmail.com'}]},
              {vsn,[1]}]}.

{labels, 34}.


{function, a, 0, 2}.
  {label,1}.
    {line,[{location,"compiler_test.erl",36}]}.
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
    {move,{literal,{error,timeout}},{x,0}}.
    {deallocate,0}.
    return.


{function, b, 0, 6}.
  {label,5}.
    {line,[{location,"compiler_test.erl",43}]}.
    {func_info,{atom,compiler_test},{atom,b},0}.
  {label,6}.
    {bif,self,{f,0},[],{x,1}}.
    {move,{atom,timeout},{x,2}}.
    {move,{integer,5000},{x,0}}.
    {line,[{location,"compiler_test.erl",44}]}.
    {call_ext_only,3,{extfunc,erlang,send_after,3}}.


{function, if_, 3, 8}.
  {label,7}.
    {line,[{location,"compiler_test.erl",46}]}.
    {func_info,{atom,compiler_test},{atom,if_},3}.
  {label,8}.
    {test,is_eq_exact,{f,9},[{x,0},{x,1}]}.
    {move,{x,2},{x,0}}.
    return.
  {label,9}.
    return.


{function, case_, 3, 11}.
  {label,10}.
    {line,[{location,"compiler_test.erl",51}]}.
    {func_info,{atom,compiler_test},{atom,case_},3}.
  {label,11}.
    {test,is_eq_exact,{f,12},[{x,0},{x,1}]}.
    {move,{x,2},{x,0}}.
    return.
  {label,12}.
    return.


{function, macro_ignore, 2, 14}.
  {label,13}.
    {line,[{location,"compiler_test.erl",57}]}.
    {func_info,{atom,compiler_test},{atom,macro_ignore},2}.
  {label,14}.
    {line,[{location,"compiler_test.erl",63}]}.
    {gc_bif,'+',{f,0},2,[{x,0},{x,1}],{x,0}}.
    return.


{function, reserve_list, 1, 16}.
  {label,15}.
    {line,[{location,"compiler_test.erl",65}]}.
    {func_info,{atom,compiler_test},{atom,reserve_list},1}.
  {label,16}.
    {allocate,1,1}.
    {move,{x,0},{y,0}}.
    {line,[{location,"compiler_test.erl",66}]}.
    {call_ext,1,{extfunc,lists,reverse,1}}.
    {move,nil,{x,1}}.
    {move,{y,0},{x,0}}.
    {line,[{location,"compiler_test.erl",67}]}.
    {call,2,{f,18}}. % reserve_list1/2
    {'%',{var_info,{x,0},[{type,{t_list,any,nil}}]}}.
    {move,nil,{x,1}}.
    {move,{y,0},{x,0}}.
    {call_last,2,{f,21},1}. % reserve_list2/2


{function, reserve_list1, 2, 18}.
  {label,17}.
    {line,[{location,"compiler_test.erl",70}]}.
    {func_info,{atom,compiler_test},{atom,reserve_list1},2}.
  {label,18}.
    {'%',{var_info,{x,1},[{type,{t_list,any,nil}}]}}.
    {test,is_nonempty_list,{f,19},[{x,0}]}.
    {test_heap,2,2}.
    {get_list,{x,0},{x,2},{x,0}}.
    {put_list,{x,2},{x,1},{x,1}}.
    {call_only,2,{f,18}}. % reserve_list1/2
  {label,19}.
    {test,is_nil,{f,17},[{x,0}]}.
    {move,{x,1},{x,0}}.
    return.


{function, reserve_list2, 2, 21}.
  {label,20}.
    {line,[{location,"compiler_test.erl",74}]}.
    {func_info,{atom,compiler_test},{atom,reserve_list2},2}.
  {label,21}.
    {'%',{var_info,{x,1},[{type,{t_list,any,nil}}]}}.
    {test,is_nonempty_list,{f,22},[{x,0}]}.
    {test_heap,2,2}.
    {get_list,{x,0},{x,2},{x,0}}.
    {put_list,{x,2},{x,1},{x,1}}.
    {call_only,2,{f,21}}. % reserve_list2/2
  {label,22}.
    {test,is_nil,{f,20},[{x,0}]}.
    {move,{x,1},{x,0}}.
    return.


{function, maybe_expression, 2, 24}.
  {label,23}.
    {line,[{location,"compiler_test.erl",79}]}.
    {func_info,{atom,compiler_test},{atom,maybe_expression},2}.
  {label,24}.
    {allocate,3,2}.
    {init_yregs,{list,[{y,0}]}}.
    {move,{x,1},{y,1}}.
    {move,{x,0},{y,2}}.
    {move,{atom,default},{x,2}}.
    {move,{atom,nil},{x,1}}.
    {line,[{location,"compiler_test.erl",81}]}.
    {call,3,{f,8}}. % if_/3
    {move,{x,0},{y,0}}.
    {test,is_eq_exact,{f,25},[{x,0},{atom,default}]}.
    {move,{atom,nil},{x,1}}.
    {move,{atom,default},{x,2}}.
    {move,{y,2},{x,0}}.
    {init_yregs,{list,[{y,0},{y,2}]}}.
    {line,[{location,"compiler_test.erl",82}]}.
    {call,3,{f,11}}. % case_/3
    {test,is_eq_exact,{f,26},[{x,0},{atom,default}]}.
    {move,{y,1},{x,0}}.
    {deallocate,3}.
    return.
  {label,25}.
    {move,{y,0},{x,0}}.
  {label,26}.
    {test,is_tuple,{f,29},[{x,0}]}.
    {test,test_arity,{f,29},[{x,0},2]}.
    {get_tuple_element,{x,0},0,{x,1}}.
    {select_val,{x,1},{f,29},{list,[{atom,error},{f,28},{atom,ok},{f,27}]}}.
  {label,27}.
    {move,{literal,{error,"unexpected wrapper"}},{x,0}}.
    {deallocate,3}.
    return.
  {label,28}.
    {move,{literal,{ok,"default"}},{x,0}}.
    {deallocate,3}.
    return.
  {label,29}.
    {test_heap,3,1}.
    {put_tuple2,{x,0},{list,[{literal,"else"},{x,0}]}}.
    {deallocate,3}.
    return.


{function, module_info, 0, 31}.
  {label,30}.
    {line,[]}.
    {func_info,{atom,compiler_test},{atom,module_info},0}.
  {label,31}.
    {move,{atom,compiler_test},{x,0}}.
    {call_ext_only,1,{extfunc,erlang,get_module_info,1}}.


{function, module_info, 1, 33}.
  {label,32}.
    {line,[]}.
    {func_info,{atom,compiler_test},{atom,module_info},1}.
  {label,33}.
    {move,{x,0},{x,1}}.
    {move,{atom,compiler_test},{x,0}}.
    {call_ext_only,2,{extfunc,erlang,get_module_info,2}}.
