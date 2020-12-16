-module(p11_tests).
-include_lib("eunit/include/eunit.hrl").

encode_modified_test_() ->
  [
    ?_assertEqual(p11:encode_modified([a,a,a,a,b,c,c,a,a,d,e,e,e,e]), [{4,a},b,{2,c},{2,a},d,{4,e}]),
    ?_assertEqual(p11:encode_modified([]), [])
  ].
