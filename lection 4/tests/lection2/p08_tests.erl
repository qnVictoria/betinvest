-module(p08_tests).
-include_lib("eunit/include/eunit.hrl").

compress_test_() ->
  [
    ?_assertEqual(p08:compress([a,a,a,a,b,c,c,a,a,d,e,e,e,e]), [a,b,c,a,d,e]),
    ?_assertEqual(p08:compress([]), [])
  ].
