-module(fib_tests).
-include_lib("eunit/include/eunit.hrl").

fib_test_() ->
  [
    ?_assertEqual(fib:fib(10), 55),
    ?_assertEqual(fib:fib(-3), 2),
    ?_assertEqual(fib:fib(1), 1),
    ?_assertEqual(fib:fib(0), 0)
  ].
