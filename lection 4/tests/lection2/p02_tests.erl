-module(p02_tests).
-include_lib("eunit/include/eunit.hrl").

but_last_test_() ->
  [
    ?_assertEqual(p02:but_last([1,2,3,4]), [3,4]),
    ?_assertEqual(p02:but_last([1,2]), [1,2]),
    ?_assertError(function_clause, p02:but_last([1])),
    ?_assertError(function_clause, p02:but_last([]))
  ].
