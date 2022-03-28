{module, closure_test}.  %% version = 0

{exports, [{get_closure,2},{get_fun,2},{module_info,0},{module_info,1}]}.

{attributes, [{copyright,[{jzyx,'www.jzyx.com'}]},
              {author,[{fred,'wangxingfred@gmail.com'}]},
              {vsn,[1]}]}.

{labels, 15}.


{function, get_closure, 2, 2}.
  {label,1}.
    {line,[{location,"closure_test.erl",27}]}.
    {func_info,{atom,closure_test},{atom,get_closure},2}.
  {label,2}.
    {make_fun2,{f,14},0,0,2}.
    return.


{function, get_fun, 2, 4}.
  {label,3}.
    {line,[{location,"closure_test.erl",33}]}.
    {func_info,{atom,closure_test},{atom,get_fun},2}.
  {label,4}.
    {allocate,2,2}.
    {move,{x,1},{y,0}}.
    {move,{x,0},{y,1}}.
    {make_fun2,{f,12},0,0,0}.
    {test_heap,7,1}.
    {put_list,{y,0},{literal,"\n"},{x,1}}.
    {put_list,{y,1},{x,1},{x,1}}.
    {put_tuple2,{x,0},{list,[{x,0},{x,1}]}}.
    {deallocate,2}.
    return.


{function, add_, 4, 6}.
  {label,5}.
    {line,[{location,"closure_test.erl",37}]}.
    {func_info,{atom,closure_test},{atom,add_},4}.
  {label,6}.
    {line,[{location,"closure_test.erl",38}]}.
    {gc_bif,'+',{f,0},4,[{x,0},{x,1}],{x,0}}.
    {line,[{location,"closure_test.erl",38}]}.
    {gc_bif,'+',{f,0},4,[{x,0},{x,2}],{x,0}}.
    {line,[{location,"closure_test.erl",38}]}.
    {gc_bif,'+',{f,0},4,[{x,0},{x,3}],{x,0}}.
    return.


{function, module_info, 0, 8}.
  {label,7}.
    {line,[]}.
    {func_info,{atom,closure_test},{atom,module_info},0}.
  {label,8}.
    {move,{atom,closure_test},{x,0}}.
    {line,[]}.
    {call_ext_only,1,{extfunc,erlang,get_module_info,1}}.


{function, module_info, 1, 10}.
  {label,9}.
    {line,[]}.
    {func_info,{atom,closure_test},{atom,module_info},1}.
  {label,10}.
    {move,{x,0},{x,1}}.
    {move,{atom,closure_test},{x,0}}.
    {line,[]}.
    {call_ext_only,2,{extfunc,erlang,get_module_info,2}}.


{function, '-get_fun/2-fun-0-', 4, 12}.
  {label,11}.
    {line,[{location,"closure_test.erl",35}]}.
    {func_info,{atom,closure_test},{atom,'-get_fun/2-fun-0-'},4}.
  {label,12}.
    {call_only,4,{f,6}}.


{function, '-get_closure/2-fun-0-', 3, 14}.
  {label,13}.
    {line,[{location,"closure_test.erl",29}]}.
    {func_info,{atom,closure_test},{atom,'-get_closure/2-fun-0-'},3}.
  {label,14}.
    {line,[{location,"closure_test.erl",30}]}.
    {gc_bif,'+',{f,0},3,[{x,1},{x,2}],{x,1}}.
    {line,[{location,"closure_test.erl",30}]}.
    {gc_bif,'+',{f,0},2,[{x,1},{integer,10}],{x,1}}.
    {line,[{location,"closure_test.erl",30}]}.
    {gc_bif,'+',{f,0},2,[{x,1},{x,0}],{x,0}}.
    return.
