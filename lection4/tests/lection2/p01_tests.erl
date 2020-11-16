-module(p01_tests).
-include_lib("eunit/include/eunit.hrl").

last_test_() ->
  [
    ?_assertEqual(p01:last([1,2,3]), 3),
    ?_assertEqual(p01:last([1]), 1),
    ?_assertError(function_clause, p01:last([]))
  ].
