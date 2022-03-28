{module, map_test}.  %% version = 0

{exports, [{flatmap,0},{flatmap_keys,1},{module_info,0},{module_info,1}]}.

{attributes, [{copyright,[{jzyx,'www.jzyx.com'}]},
              {author,[{fred,'wangxingfred@gmail.com'}]},
              {vsn,[1]}]}.

{labels, 9}.


{function, flatmap, 0, 2}.
  {label,1}.
    {line,[{location,"map_test.erl",28}]}.
    {func_info,{atom,map_test},{atom,flatmap},0}.
  {label,2}.
    {move,{integer,1},{x,1}}.
    {move,{literal,[a,b,c]},{x,0}}.
    {line,[{location,"map_test.erl",29}]}.
    {call_ext_only,2,{extfunc,maps,from_keys,2}}.


{function, flatmap_keys, 1, 4}.
  {label,3}.
    {line,[{location,"map_test.erl",31}]}.
    {func_info,{atom,map_test},{atom,flatmap_keys},1}.
  {label,4}.
    {test,is_map,{f,3},[{x,0}]}.
    {line,[{location,"map_test.erl",32}]}.
    {call_ext_only,1,{extfunc,erts_internal,map_to_tuple_keys,1}}.


{function, module_info, 0, 6}.
  {label,5}.
    {line,[]}.
    {func_info,{atom,map_test},{atom,module_info},0}.
  {label,6}.
    {move,{atom,map_test},{x,0}}.
    {call_ext_only,1,{extfunc,erlang,get_module_info,1}}.


{function, module_info, 1, 8}.
  {label,7}.
    {line,[]}.
    {func_info,{atom,map_test},{atom,module_info},1}.
  {label,8}.
    {move,{x,0},{x,1}}.
    {move,{atom,map_test},{x,0}}.
    {call_ext_only,2,{extfunc,erlang,get_module_info,2}}.
