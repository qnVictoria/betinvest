-module(p04_tests).
-include_lib("eunit/include/eunit.hrl").

len_test_() ->
  [
    ?_assertEqual(p04:len([1,2,3,4]), 4),
    ?_assertEqual(p04:len([1]), 1),
    ?_assertEqual(p04:len([]), 0)
  ].
