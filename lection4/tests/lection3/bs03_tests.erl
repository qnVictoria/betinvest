-module(bs03_tests).
-include_lib("eunit/include/eunit.hrl").

split_test_() ->
  [
    ?_assertEqual(bs03:split(<<"Col1-:-Col2-:-Col3-:-Col4-:-Col5">>, "-:-"), [<<"Col1">>, <<"Col2">>, <<"Col3">>, <<"Col4">>, <<"Col5">>]),
    ?_assertEqual(bs03:split(<<"Happy New Year">>, " "), [<<"Happy">>, <<"New">>, <<"Year">>]),
    ?_assertEqual(bs03:split(<<" ">>, "-:-"), [<<" ">>])
  ].
