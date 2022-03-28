{module, lists_test}.  %% version = 0

{exports, [{bif_keyfind,2},
           {concat,2},
           {concat_unique,2},
           {foreach,2},
           {module_info,0},
           {module_info,1},
           {push,2},
           {push,3},
           {reverse1,2},
           {reverse2,2},
           {subtract,2}]}.

{attributes, [{copyright,[{jzyx,'www.jzyx.com'}]},
              {author,[{fred,'wangxingfred@gmail.com'}]},
              {vsn,[1]}]}.

{labels, 35}.


{function, bif_keyfind, 2, 2}.
  {label,1}.
    {line,[{location,"lists_test.erl",27}]}.
    {func_info,{atom,lists_test},{atom,bif_keyfind},2}.
  {label,2}.
    {move,{x,1},{x,2}}.
    {move,{integer,1},{x,1}}.
    {line,[{location,"lists_test.erl",28}]}.
    {call_ext_only,3,{extfunc,lists,keyfind,3}}.


{function, foreach, 2, 4}.
  {label,3}.
    {line,[{location,"lists_test.erl",30}]}.
    {func_info,{atom,lists_test},{atom,foreach},2}.
  {label,4}.
    {allocate,0,2}.
    {line,[{location,"lists_test.erl",31}]}.
    {call,2,{f,32}}.
    {move,{atom,no_return},{x,0}}.
    {deallocate,0}.
    return.


{function, push, 2, 6}.
  {label,5}.
    {line,[{location,"lists_test.erl",34}]}.
    {func_info,{atom,lists_test},{atom,push},2}.
  {label,6}.
    {call_only,2,{f,28}}.


{function, push, 3, 8}.
  {label,7}.
    {line,[{location,"lists_test.erl",36}]}.
    {func_info,{atom,lists_test},{atom,push},3}.
  {label,8}.
    {call_only,3,{f,24}}.


{function, concat, 2, 10}.
  {label,9}.
    {line,[{location,"lists_test.erl",39}]}.
    {func_info,{atom,lists_test},{atom,concat},2}.
  {label,10}.
    {line,[{location,"lists_test.erl",40}]}.
    {call_ext_only,2,{extfunc,erlang,'++',2}}.


{function, subtract, 2, 12}.
  {label,11}.
    {line,[{location,"lists_test.erl",42}]}.
    {func_info,{atom,lists_test},{atom,subtract},2}.
  {label,12}.
    {line,[{location,"lists_test.erl",43}]}.
    {call_ext_only,2,{extfunc,erlang,'--',2}}.


{function, concat_unique, 2, 14}.
  {label,13}.
    {line,[{location,"lists_test.erl",45}]}.
    {func_info,{atom,lists_test},{atom,concat_unique},2}.
  {label,14}.
    {allocate,1,2}.
    {move,{x,1},{y,0}}.
    {line,[{location,"lists_test.erl",46}]}.
    {call_ext,2,{extfunc,erlang,'--',2}}.
    {move,{x,0},{x,1}}.
    {move,{y,0},{x,0}}.
    {line,[{location,"lists_test.erl",46}]}.
    {call_ext_last,2,{extfunc,erlang,'++',2},1}.


{function, reverse1, 2, 16}.
  {label,15}.
    {line,[{location,"lists_test.erl",49}]}.
    {func_info,{atom,lists_test},{atom,reverse1},2}.
  {label,16}.
    {allocate,1,2}.
    {move,{x,1},{y,0}}.
    {line,[{location,"lists_test.erl",50}]}.
    {call_ext,1,{extfunc,lists,reverse,1}}.
    {move,{y,0},{x,1}}.
    {line,[{location,"lists_test.erl",50}]}.
    {call_ext_last,2,{extfunc,erlang,'++',2},1}.


{function, reverse2, 2, 18}.
  {label,17}.
    {line,[{location,"lists_test.erl",52}]}.
    {func_info,{atom,lists_test},{atom,reverse2},2}.
  {label,18}.
    {line,[{location,"lists_test.erl",53}]}.
    {call_ext_only,2,{extfunc,lists,reverse,2}}.


{function, module_info, 0, 20}.
  {label,19}.
    {line,[]}.
    {func_info,{atom,lists_test},{atom,module_info},0}.
  {label,20}.
    {move,{atom,lists_test},{x,0}}.
    {line,[]}.
    {call_ext_only,1,{extfunc,erlang,get_module_info,1}}.


{function, module_info, 1, 22}.
  {label,21}.
    {line,[]}.
    {func_info,{atom,lists_test},{atom,module_info},1}.
  {label,22}.
    {move,{x,0},{x,1}}.
    {move,{atom,lists_test},{x,0}}.
    {line,[]}.
    {call_ext_only,2,{extfunc,erlang,get_module_info,2}}.


{function, '-push/3-lc$^0/1-0-', 3, 24}.
  {label,23}.
    {line,[{location,"lists_test.erl",37}]}.
    {func_info,{atom,lists_test},{atom,'-push/3-lc$^0/1-0-'},3}.
  {label,24}.
    {test,is_nonempty_list,{f,25},[{x,0}]}.
    {allocate,2,3}.
    {move,{x,1},{y,1}}.
    {get_list,{x,0},{y,0},{x,0}}.
    {line,[{location,"lists_test.erl",37}]}.
    {call,3,{f,24}}.
    {test_heap,5,1}.
    {put_tuple2,{x,1},{list,[{y,0},{y,1}]}}.
    {put_list,{x,1},{x,0},{x,0}}.
    {deallocate,2}.
    return.
  {label,25}.
    {test,is_nil,{f,26},[{x,0}]}.
    {move,{x,2},{x,0}}.
    return.
  {label,26}.
    {test_heap,2,1}.
    {put_list,{x,0},nil,{x,1}}.
    {move,{atom,function_clause},{x,0}}.
    {line,[{location,"lists_test.erl",37}]}.
    {call_ext,2,{extfunc,erlang,error,2}}.


{function, '-push/2-lc$^0/1-0-', 2, 28}.
  {label,27}.
    {line,[{location,"lists_test.erl",35}]}.
    {func_info,{atom,lists_test},{atom,'-push/2-lc$^0/1-0-'},2}.
  {label,28}.
    {test,is_nonempty_list,{f,29},[{x,0}]}.
    {allocate,2,2}.
    {move,{x,1},{y,1}}.
    {get_list,{x,0},{y,0},{x,0}}.
    {line,[{location,"lists_test.erl",35}]}.
    {call,2,{f,28}}.
    {'%',{type_info,{x,0},list}}.
    {test_heap,5,1}.
    {put_tuple2,{x,1},{list,[{y,0},{y,1}]}}.
    {put_list,{x,1},{x,0},{x,0}}.
    {deallocate,2}.
    return.
  {label,29}.
    {test,is_nil,{f,30},[{x,0}]}.
    return.
  {label,30}.
    {test_heap,2,1}.
    {put_list,{x,0},nil,{x,1}}.
    {move,{atom,function_clause},{x,0}}.
    {line,[{location,"lists_test.erl",35}]}.
    {call_ext,2,{extfunc,erlang,error,2}}.


{function, '-foreach/2-lc$^0/1-0-', 2, 32}.
  {label,31}.
    {line,[{location,"lists_test.erl",31}]}.
    {func_info,{atom,lists_test},{atom,'-foreach/2-lc$^0/1-0-'},2}.
  {label,32}.
    {test,is_nonempty_list,{f,33},[{x,0}]}.
    {allocate,2,2}.
    {move,{x,1},{y,1}}.
    {get_list,{x,0},{x,0},{y,0}}.
    {move,{y,1},{x,1}}.
    {line,[{location,"lists_test.erl",31}]}.
    {call_fun,1}.
    {move,{y,1},{x,1}}.
    {move,{y,0},{x,0}}.
    {call_last,2,{f,32},2}.
  {label,33}.
    {test,is_nil,{f,34},[{x,0}]}.
    return.
  {label,34}.
    {test_heap,2,1}.
    {put_list,{x,0},nil,{x,1}}.
    {move,{atom,function_clause},{x,0}}.
    {line,[{location,"lists_test.erl",31}]}.
    {call_ext,2,{extfunc,erlang,error,2}}.
