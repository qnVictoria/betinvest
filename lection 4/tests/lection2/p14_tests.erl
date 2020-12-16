-module(p14_tests).
-include_lib("eunit/include/eunit.hrl").

duplicate_test_() ->
  [
    ?_assertEqual(p14:duplicate([a,b,c,d,e]), [a,a,b,b,c,c,d,d,e,e]),
    ?_assertEqual(p14:duplicate([a,a,b,c,c]), [a,a,a,a,b,b,c,c,c,c]),
    ?_assertEqual(p14:duplicate([]), [])
  ].
