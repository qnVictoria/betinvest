-module(p10_tests).
-include_lib("eunit/include/eunit.hrl").

encode_test_() ->
  [
    ?_assertEqual(p10:encode([a,a,a,a,b,c,c,a,a,d,e,e,e,e]), [{4,a},{1,b},{2,c},{2,a},{1,d},{4,e}]),
    ?_assertEqual(p10:encode([]), [])
  ].
