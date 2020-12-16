-module(bs01).
-export([first_word/1]).

first_word(X) ->
  first_word(X, <<>>).

first_word(<<" ", _/binary>>, Acc) ->
  Acc;
first_word(<<X/utf8, Rest/binary>>, Acc) ->
  first_word(Rest, <<Acc/binary, X/utf8>>).
