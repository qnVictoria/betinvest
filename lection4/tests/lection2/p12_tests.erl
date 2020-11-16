-module(p12_tests).
-include_lib("eunit/include/eunit.hrl").

decode_modified_test_() ->
  [
    ?_assertEqual(p12:decode_modified([{4,a},b,{2,c},{2,a},d,{4,e}]), [a,a,a,a,b,c,c,a,a,d,e,e,e,e]), 
    ?_assertEqual(p12:decode_modified([]), [])
  ].
