-module(bs02_tests).
-include_lib("eunit/include/eunit.hrl").

words_test_() ->
  [
    ?_assertEqual(bs02:words(<<"Hello my dear friends">>), [<<"Hello">>, <<"my">>, <<"dear">>, <<"friends">>]),
    ?_assertEqual(bs02:words(<<" ">>), [<<" ">>])
  ].
