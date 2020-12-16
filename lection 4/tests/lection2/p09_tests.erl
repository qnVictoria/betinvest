-module(p09_tests).
-include_lib("eunit/include/eunit.hrl").

pack_test_() ->
  [
    ?_assertEqual(p09:pack([a,a,a,a,b,c,c,a,a,d,e,e,e,e]), [[a,a,a,a],[b],[c,c],[a,a],[d],[e,e,e,e]]),
    ?_assertEqual(p09:pack([]), [])
  ].
