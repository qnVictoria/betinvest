-module(p07_tests).
-include_lib("eunit/include/eunit.hrl").

flatten_test_() ->
  [
    ?_assertEqual(p07:flatten([a,[],[b,[c,d],e]]), [a,b,c,d,e]),
    ?_assertEqual(p07:flatten([]), [])
  ].
