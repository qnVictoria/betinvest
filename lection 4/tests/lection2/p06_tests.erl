-module(p06_tests).
-include_lib("eunit/include/eunit.hrl").

is_palindrome_test_() ->
  [
    ?_assertEqual(p06:is_palindrome([1,2,3,2,1]), true),
    ?_assertEqual(p06:is_palindrome([1,2,3,4,5]), false),
    ?_assertEqual(p06:is_palindrome([1]), true),
    ?_assertEqual(p06:is_palindrome([]), true)
  ].
