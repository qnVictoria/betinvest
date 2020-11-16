-module(p05_tests).
-include_lib("eunit/include/eunit.hrl").

reverse_test_() ->
  [
    ?_assertEqual(p05:reverse([1,2,3]), [3,2,1]),
    ?_assertEqual(p05:reverse([1]),[1]),
    ?_assertEqual(p05:reverse([]), [])
  ].
