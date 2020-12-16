-module(bs01_tests).
-include_lib("eunit/include/eunit.hrl").

first_word_test_() ->
  [
    ?_assertEqual(bs01:first_word(<<"Hello world">>), <<"Hello">>),
    ?_assertEqual(bs01:first_word(<<" ">>), <<>>)
  ].
