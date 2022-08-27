{module, fun_test}.  %% version = 0

{exports, [{bind_not_exported,0},
           {do_sth,0},
           {external_mf,0},
           {local_fun1,0},
           {local_fun2,0},
           {module_info,0},
           {module_info,1}]}.

{attributes, [{copyright,[{jzyx,'www.jzyx.com'}]},
              {author,[{fred,'wangxingfred@gmail.com'}]},
              {vsn,[1]}]}.

{labels, 17}.


{function, external_mf, 0, 2}.
  {label,1}.
    {line,[{location,"fun_test.erl",30}]}.
    {func_info,{atom,fun_test},{atom,external_mf},0}.
  {label,2}.
    {move,{literal,fun fun_test:do_sth/0},{x,0}}.
    return.


{function, local_fun1, 0, 4}.
  {label,3}.
    {line,[{location,"fun_test.erl",34}]}.
    {func_info,{atom,fun_test},{atom,local_fun1},0}.
  {label,4}.
    {test_heap,{alloc,[{words,0},{floats,0},{funs,1}]},0}.
    {make_fun3,{f,8},0,0,{x,0},{list,[]}}.
    return.


{function, local_fun2, 0, 6}.
  {label,5}.
    {line,[{location,"fun_test.erl",38}]}.
    {func_info,{atom,fun_test},{atom,local_fun2},0}.
  {label,6}.
    {test_heap,{alloc,[{words,0},{floats,0},{funs,1}]},0}.
    {make_fun3,{f,16},0,0,{x,0},{list,[]}}.
    return.


{function, do_sth, 0, 8}.
  {label,7}.
    {line,[{location,"fun_test.erl",42}]}.
    {func_info,{atom,fun_test},{atom,do_sth},0}.
  {label,8}.
    {move,{literal,[fun_test,do_sth,43]},{x,1}}.
    {move,{literal,"~p:~p:~p ccc ~n"},{x,0}}.
    {line,[{location,"fun_test.erl",43}]}.
    {call_ext_only,2,{extfunc,io,format,2}}.


{function, bind_not_exported, 0, 10}.
  {label,9}.
    {line,[{location,"fun_test.erl",45}]}.
    {func_info,{atom,fun_test},{atom,bind_not_exported},0}.
  {label,10}.
    {move,{literal,fun fun_test:not_exported/1},{x,0}}.
    return.


{function, module_info, 0, 12}.
  {label,11}.
    {line,[]}.
    {func_info,{atom,fun_test},{atom,module_info},0}.
  {label,12}.
    {move,{atom,fun_test},{x,0}}.
    {call_ext_only,1,{extfunc,erlang,get_module_info,1}}.


{function, module_info, 1, 14}.
  {label,13}.
    {line,[]}.
    {func_info,{atom,fun_test},{atom,module_info},1}.
  {label,14}.
    {move,{x,0},{x,1}}.
    {move,{atom,fun_test},{x,0}}.
    {call_ext_only,2,{extfunc,erlang,get_module_info,2}}.


{function, '-local_fun2/0-fun-0-', 0, 16}.
  {label,15}.
    {line,[{location,"fun_test.erl",39}]}.
    {func_info,{atom,fun_test},{atom,'-local_fun2/0-fun-0-'},0}.
  {label,16}.
    {call_only,0,{f,8}}. % do_sth/0
