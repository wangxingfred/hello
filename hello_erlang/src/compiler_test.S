{module, compiler_test}.  %% version = 0

{exports, [{a,0},{b,0},{module_info,0},{module_info,1}]}.

{attributes, [{copyright,[{jzyx,'www.jzyx.com'}]},
              {author,[{fred,'wangxingfred@gmail.com'}]},
              {vsn,[1]}]}.

{labels, 11}.


{function, a, 0, 2}.
  {label,1}.
    {line,[{location,"compiler_test.erl",23}]}.
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
    {line,[{location,"compiler_test.erl",30}]}.
    {func_info,{atom,compiler_test},{atom,b},0}.
  {label,6}.
    {bif,self,{f,0},[],{x,1}}.
    {move,{atom,timeout},{x,2}}.
    {move,{integer,5000},{x,0}}.
    {line,[{location,"compiler_test.erl",31}]}.
    {call_ext_only,3,{extfunc,erlang,send_after,3}}.


{function, module_info, 0, 8}.
  {label,7}.
    {line,[]}.
    {func_info,{atom,compiler_test},{atom,module_info},0}.
  {label,8}.
    {move,{atom,compiler_test},{x,0}}.
    {call_ext_only,1,{extfunc,erlang,get_module_info,1}}.


{function, module_info, 1, 10}.
  {label,9}.
    {line,[]}.
    {func_info,{atom,compiler_test},{atom,module_info},1}.
  {label,10}.
    {move,{x,0},{x,1}}.
    {move,{atom,compiler_test},{x,0}}.
    {call_ext_only,2,{extfunc,erlang,get_module_info,2}}.
