{module, compiler_test}.  %% version = 0

{exports, [{a,0},
           {b,0},
           {case_,3},
           {empty_branch,4},
           {if_,3},
           {macro_ignore,2},
           {maybe2,2},
           {maybe2_identical,2},
           {maybe_expression,2},
           {module_info,0},
           {module_info,1},
           {reserve_list,1}]}.

{attributes, [{copyright,[{jzyx,'www.jzyx.com'}]},
              {author,[{fred,'wangxingfred@gmail.com'}]},
              {vsn,[1]}]}.

{labels, 53}.


{function, a, 0, 2}.
  {label,1}.
    {line,[{location,"compiler_test.erl",48}]}.
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
    {line,[{location,"compiler_test.erl",55}]}.
    {func_info,{atom,compiler_test},{atom,b},0}.
  {label,6}.
    {bif,self,{f,0},[],{x,1}}.
    {move,{atom,timeout},{x,2}}.
    {move,{integer,5000},{x,0}}.
    {line,[{location,"compiler_test.erl",56}]}.
    {call_ext_only,3,{extfunc,erlang,send_after,3}}.


{function, if_, 3, 8}.
  {label,7}.
    {line,[{location,"compiler_test.erl",58}]}.
    {func_info,{atom,compiler_test},{atom,if_},3}.
  {label,8}.
    {test,is_eq_exact,{f,9},[{x,0},{x,1}]}.
    {move,{x,2},{x,0}}.
    return.
  {label,9}.
    return.


{function, case_, 3, 11}.
  {label,10}.
    {line,[{location,"compiler_test.erl",63}]}.
    {func_info,{atom,compiler_test},{atom,case_},3}.
  {label,11}.
    {test,is_eq_exact,{f,12},[{x,0},{x,1}]}.
    {move,{x,2},{x,0}}.
    return.
  {label,12}.
    return.


{function, empty_branch, 4, 14}.
  {label,13}.
    {line,[{location,"compiler_test.erl",69}]}.
    {func_info,{atom,compiler_test},{atom,empty_branch},4}.
  {label,14}.
    {test,is_eq_exact,{f,15},[{x,0},{x,1}]}.
    {move,{atom,case1},{x,0}}.
    {line,[{location,"compiler_test.erl",72}]}.
    {call_ext_only,1,{extfunc,erlang,throw,1}}.
  {label,15}.
    {test,is_eq_exact,{f,16},[{x,0},{x,2}]}.
    {move,{atom,ok},{x,0}}.
    return.
  {label,16}.
    {move,{x,3},{x,0}}.
    {line,[{location,"compiler_test.erl",76}]}.
    {call_ext_only,1,{extfunc,erlang,throw,1}}.


{function, macro_ignore, 2, 18}.
  {label,17}.
    {line,[{location,"compiler_test.erl",80}]}.
    {func_info,{atom,compiler_test},{atom,macro_ignore},2}.
  {label,18}.
    {line,[{location,"compiler_test.erl",86}]}.
    {gc_bif,'+',{f,0},2,[{x,0},{x,1}],{x,0}}.
    return.


{function, reserve_list, 1, 20}.
  {label,19}.
    {line,[{location,"compiler_test.erl",88}]}.
    {func_info,{atom,compiler_test},{atom,reserve_list},1}.
  {label,20}.
    {allocate,1,1}.
    {move,{x,0},{y,0}}.
    {line,[{location,"compiler_test.erl",89}]}.
    {call_ext,1,{extfunc,lists,reverse,1}}.
    {move,nil,{x,1}}.
    {move,{y,0},{x,0}}.
    {line,[{location,"compiler_test.erl",90}]}.
    {call,2,{f,22}}. % reserve_list1/2
    {'%',{var_info,{x,0},[{type,{t_list,any,nil}}]}}.
    {move,nil,{x,1}}.
    {move,{y,0},{x,0}}.
    {call_last,2,{f,25},1}. % reserve_list2/2


{function, reserve_list1, 2, 22}.
  {label,21}.
    {line,[{location,"compiler_test.erl",93}]}.
    {func_info,{atom,compiler_test},{atom,reserve_list1},2}.
  {label,22}.
    {'%',{var_info,{x,1},[{type,{t_list,any,nil}}]}}.
    {test,is_nonempty_list,{f,23},[{x,0}]}.
    {test_heap,2,2}.
    {get_list,{x,0},{x,2},{x,0}}.
    {put_list,{x,2},{x,1},{x,1}}.
    {call_only,2,{f,22}}. % reserve_list1/2
  {label,23}.
    {test,is_nil,{f,21},[{x,0}]}.
    {move,{x,1},{x,0}}.
    return.


{function, reserve_list2, 2, 25}.
  {label,24}.
    {line,[{location,"compiler_test.erl",97}]}.
    {func_info,{atom,compiler_test},{atom,reserve_list2},2}.
  {label,25}.
    {'%',{var_info,{x,1},[{type,{t_list,any,nil}}]}}.
    {test,is_nonempty_list,{f,26},[{x,0}]}.
    {test_heap,2,2}.
    {get_list,{x,0},{x,2},{x,0}}.
    {put_list,{x,2},{x,1},{x,1}}.
    {call_only,2,{f,25}}. % reserve_list2/2
  {label,26}.
    {test,is_nil,{f,24},[{x,0}]}.
    {move,{x,1},{x,0}}.
    return.


{function, maybe_expression, 2, 28}.
  {label,27}.
    {line,[{location,"compiler_test.erl",102}]}.
    {func_info,{atom,compiler_test},{atom,maybe_expression},2}.
  {label,28}.
    {allocate,3,2}.
    {init_yregs,{list,[{y,0}]}}.
    {move,{x,1},{y,1}}.
    {move,{x,0},{y,2}}.
    {move,{atom,default},{x,2}}.
    {move,{atom,nil},{x,1}}.
    {line,[{location,"compiler_test.erl",104}]}.
    {call,3,{f,8}}. % if_/3
    {move,{x,0},{y,0}}.
    {test,is_eq_exact,{f,29},[{x,0},{atom,default}]}.
    {move,{atom,nil},{x,1}}.
    {move,{atom,default},{x,2}}.
    {move,{y,2},{x,0}}.
    {init_yregs,{list,[{y,0},{y,2}]}}.
    {line,[{location,"compiler_test.erl",105}]}.
    {call,3,{f,11}}. % case_/3
    {test,is_eq_exact,{f,30},[{x,0},{atom,default}]}.
    {move,{y,1},{x,0}}.
    {deallocate,3}.
    return.
  {label,29}.
    {move,{y,0},{x,0}}.
  {label,30}.
    {test,is_tuple,{f,33},[{x,0}]}.
    {test,test_arity,{f,33},[{x,0},2]}.
    {get_tuple_element,{x,0},0,{x,1}}.
    {select_val,{x,1},{f,33},{list,[{atom,error},{f,32},{atom,ok},{f,31}]}}.
  {label,31}.
    {move,{literal,{error,"unexpected wrapper"}},{x,0}}.
    {deallocate,3}.
    return.
  {label,32}.
    {move,{literal,{ok,"default"}},{x,0}}.
    {deallocate,3}.
    return.
  {label,33}.
    {test_heap,3,1}.
    {put_tuple2,{x,0},{list,[{literal,"else"},{x,0}]}}.
    {deallocate,3}.
    return.


{function, add_, 2, 35}.
  {label,34}.
    {line,[{location,"compiler_test.erl",117}]}.
    {func_info,{atom,compiler_test},{atom,add_},2}.
  {label,35}.
    {test,is_number,{f,36},[{x,0}]}.
    {test,is_number,{f,36},[{x,1}]}.
    {gc_bif,'+',{f,0},2,[{tr,{x,0},number},{tr,{x,1},number}],{x,0}}.
    {test_heap,3,1}.
    {put_tuple2,{x,0},{list,[{atom,ok},{x,0}]}}.
    return.
  {label,36}.
    {move,{atom,error},{x,0}}.
    return.


{function, sub_, 2, 38}.
  {label,37}.
    {line,[{location,"compiler_test.erl",120}]}.
    {func_info,{atom,compiler_test},{atom,sub_},2}.
  {label,38}.
    {test,is_ge,{f,39},[{x,0},{x,1}]}.
    {gc_bif,'-',{f,0},2,[{x,0},{x,1}],{x,0}}.
    {test_heap,3,1}.
    {put_tuple2,{x,0},{list,[{atom,ok},{x,0}]}}.
    return.
  {label,39}.
    {move,{atom,wrong},{x,0}}.
    return.


{function, maybe2, 2, 41}.
  {label,40}.
    {line,[{location,"compiler_test.erl",123}]}.
    {func_info,{atom,compiler_test},{atom,maybe2},2}.
  {label,41}.
    {allocate,3,2}.
    {init_yregs,{list,[{y,0}]}}.
    {move,{x,1},{y,1}}.
    {move,{x,0},{y,2}}.
    {line,[{location,"compiler_test.erl",125}]}.
    {call,2,{f,35}}. % add_/2
    {'%',
        {var_info,
            {x,0},
            [{type,
                 {t_union,
                     {t_atom,[error]},
                     none,none,
                     [{{2,{t_atom,[ok]}},
                       {t_tuple,2,true,#{1 => {t_atom,[ok]},2 => number}}}],
                     none}}]}}.
    {test,is_tuple,
          {f,42},
          [{tr,{x,0},
               {t_union,{t_atom,[error]},
                        none,none,
                        [{{2,{t_atom,[ok]}},
                          {t_tuple,2,true,#{1 => {t_atom,[ok]},2 => number}}}],
                        none}}]}.
    {get_tuple_element,{x,0},1,{y,0}}.
    {test,is_ge,{f,43},[{tr,{y,0},number},{integer,0}]}.
    {move,{y,1},{x,1}}.
    {move,{y,2},{x,0}}.
    {init_yregs,{list,[{y,1},{y,2}]}}.
    {line,[{location,"compiler_test.erl",127}]}.
    {call,2,{f,38}}. % sub_/2
    {'%',
        {var_info,
            {x,0},
            [{type,
                 {t_union,
                     {t_atom,[wrong]},
                     none,none,
                     [{{2,{t_atom,[ok]}},
                       {t_tuple,2,true,#{1 => {t_atom,[ok]},2 => number}}}],
                     none}}]}}.
    {test,is_tuple,
          {f,42},
          [{tr,{x,0},
               {t_union,{t_atom,[wrong]},
                        none,none,
                        [{{2,{t_atom,[ok]}},
                          {t_tuple,2,true,#{1 => {t_atom,[ok]},2 => number}}}],
                        none}}]}.
    {test_heap,3,1}.
    {get_tuple_element,{x,0},1,{x,0}}.
    {put_tuple2,{x,0},{list,[{y,0},{x,0}]}}.
    {deallocate,3}.
    return.
  {label,42}.
    {move,{atom,error},{x,0}}.
    {deallocate,3}.
    return.
  {label,43}.
    {line,[{location,"compiler_test.erl",126}]}.
    {badmatch,{atom,false}}.


{function, maybe2_identical, 2, 45}.
  {label,44}.
    {line,[{location,"compiler_test.erl",134}]}.
    {func_info,{atom,compiler_test},{atom,maybe2_identical},2}.
  {label,45}.
    {allocate,3,2}.
    {init_yregs,{list,[{y,0}]}}.
    {move,{x,1},{y,1}}.
    {move,{x,0},{y,2}}.
    {line,[{location,"compiler_test.erl",135}]}.
    {call,2,{f,35}}. % add_/2
    {'%',
        {var_info,
            {x,0},
            [{type,
                 {t_union,
                     {t_atom,[error]},
                     none,none,
                     [{{2,{t_atom,[ok]}},
                       {t_tuple,2,true,#{1 => {t_atom,[ok]},2 => number}}}],
                     none}}]}}.
    {test,is_tuple,
          {f,47},
          [{tr,{x,0},
               {t_union,{t_atom,[error]},
                        none,none,
                        [{{2,{t_atom,[ok]}},
                          {t_tuple,2,true,#{1 => {t_atom,[ok]},2 => number}}}],
                        none}}]}.
    {get_tuple_element,{x,0},1,{y,0}}.
    {test,is_ge,{f,48},[{tr,{y,0},number},{integer,0}]}.
    {move,{y,1},{x,1}}.
    {move,{y,2},{x,0}}.
    {init_yregs,{list,[{y,1},{y,2}]}}.
    {line,[{location,"compiler_test.erl",138}]}.
    {call,2,{f,38}}. % sub_/2
    {'%',
        {var_info,
            {x,0},
            [{type,
                 {t_union,
                     {t_atom,[wrong]},
                     none,none,
                     [{{2,{t_atom,[ok]}},
                       {t_tuple,2,true,#{1 => {t_atom,[ok]},2 => number}}}],
                     none}}]}}.
    {test,is_tuple,
          {f,46},
          [{tr,{x,0},
               {t_union,{t_atom,[wrong]},
                        none,none,
                        [{{2,{t_atom,[ok]}},
                          {t_tuple,2,true,#{1 => {t_atom,[ok]},2 => number}}}],
                        none}}]}.
    {test_heap,3,1}.
    {get_tuple_element,{x,0},1,{x,0}}.
    {put_tuple2,{x,0},{list,[{y,0},{x,0}]}}.
    {deallocate,3}.
    return.
  {label,46}.
    {move,{atom,wrong},{x,0}}.
    {deallocate,3}.
    return.
  {label,47}.
    {move,{atom,error},{x,0}}.
    {deallocate,3}.
    return.
  {label,48}.
    {line,[{location,"compiler_test.erl",137}]}.
    {badmatch,{atom,false}}.


{function, module_info, 0, 50}.
  {label,49}.
    {line,[]}.
    {func_info,{atom,compiler_test},{atom,module_info},0}.
  {label,50}.
    {move,{atom,compiler_test},{x,0}}.
    {call_ext_only,1,{extfunc,erlang,get_module_info,1}}.


{function, module_info, 1, 52}.
  {label,51}.
    {line,[]}.
    {func_info,{atom,compiler_test},{atom,module_info},1}.
  {label,52}.
    {move,{x,0},{x,1}}.
    {move,{atom,compiler_test},{x,0}}.
    {call_ext_only,2,{extfunc,erlang,get_module_info,2}}.
