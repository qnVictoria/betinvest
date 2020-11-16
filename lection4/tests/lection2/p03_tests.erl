-module(p03_tests).
-include_lib("eunit/include/eunit.hrl").

element_at_test_() ->
  [
    ?_assertEqual(p03:element_at([1,2,3,4,5], 4), 4),
    ?_assertEqual(p03:element_at([1], 1), 1),
    ?_assertEqual(p03:element_at([1,2,3,4,5], 10), undefined)
  ].
