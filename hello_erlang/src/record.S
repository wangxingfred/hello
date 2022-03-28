{module, record}.  %% version = 0

{exports, [{get_field_a,1},
           {get_field_b,1},
           {get_field_e,1},
           {guard_1,1},
           {guard_2,1},
           {module_info,0},
           {module_info,1}]}.

{attributes, [{copyright,[{jzyx,'www.jzyx.com'}]},
              {author,[{fred,'wangxingfred@gmail.com'}]},
              {vsn,[1]}]}.

{labels, 19}.


{function, get_field_a, 1, 2}.
  {label,1}.
    {line,[{location,"record.erl",37}]}.
    {func_info,{atom,record},{atom,get_field_a},1}.
  {label,2}.
    {test,is_tagged_tuple,{f,3},[{x,0},8,{atom,test}]}.
    {get_tuple_element,{x,0},1,{x,0}}.
    return.
  {label,3}.
    {move,{literal,{badrecord,test}},{x,0}}.
    {line,[{location,"record.erl",38}]}.
    {call_ext,1,{extfunc,erlang,error,1}}.


{function, get_field_b, 1, 5}.
  {label,4}.
    {line,[{location,"record.erl",40}]}.
    {func_info,{atom,record},{atom,get_field_b},1}.
  {label,5}.
    {line,[{location,"record.erl",41}]}.
    {bif,element,{f,0},[{integer,3},{x,0}],{x,0}}.
    return.


{function, get_field_e, 1, 7}.
  {label,6}.
    {line,[{location,"record.erl",43}]}.
    {func_info,{atom,record},{atom,get_field_e},1}.
  {label,7}.
    {test,is_tagged_tuple,{f,8},[{x,0},8,{atom,test}]}.
    {get_tuple_element,{x,0},5,{x,0}}.
    return.
  {label,8}.
    {move,{literal,{badrecord,test}},{x,0}}.
    {line,[{location,"record.erl",44}]}.
    {call_ext,1,{extfunc,erlang,error,1}}.


{function, guard_1, 1, 10}.
  {label,9}.
    {line,[{location,"record.erl",46}]}.
    {func_info,{atom,record},{atom,guard_1},1}.
  {label,10}.
    {test,is_tagged_tuple,{f,11},[{x,0},8,{atom,test}]}.
    {get_tuple_element,{x,0},1,{x,0}}.
    return.
  {label,11}.
    return.


{function, guard_2, 1, 13}.
  {label,12}.
    {line,[{location,"record.erl",50}]}.
    {func_info,{atom,record},{atom,guard_2},1}.
  {label,13}.
    {test,is_tagged_tuple,{f,14},[{x,0},8,{atom,test}]}.
    {get_tuple_element,{x,0},1,{x,0}}.
    return.
  {label,14}.
    return.


{function, module_info, 0, 16}.
  {label,15}.
    {line,[]}.
    {func_info,{atom,record},{atom,module_info},0}.
  {label,16}.
    {move,{atom,record},{x,0}}.
    {line,[]}.
    {call_ext_only,1,{extfunc,erlang,get_module_info,1}}.


{function, module_info, 1, 18}.
  {label,17}.
    {line,[]}.
    {func_info,{atom,record},{atom,module_info},1}.
  {label,18}.
    {move,{x,0},{x,1}}.
    {move,{atom,record},{x,0}}.
    {line,[]}.
    {call_ext_only,2,{extfunc,erlang,get_module_info,2}}.
