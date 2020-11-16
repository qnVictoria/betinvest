-module(p15_tests).
-include_lib("eunit/include/eunit.hrl").

replicate_test_() ->
  [
    ?_assertEqual(p15:replicate([a,b,c], 3), [a,a,a,b,b,b,c,c,c]),
    ?_assertEqual(p15:replicate([a], 4), [a,a,a,a]),
    ?_assertEqual(p15:replicate([], 1), [])
  ].
