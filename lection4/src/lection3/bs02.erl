-module(bs02).
-export([words/1]).

words(X) ->
  lists:reverse(words(X, [<<>>])).

words(<<>>, Acc) ->
  Acc;
words(<<" ", Y/utf8, Rest/binary>>, Acc) ->
  words(Rest, [<<Y/utf8>>|Acc]);
words(<<X/utf8, Rest/binary>>, [H|T]) ->
  words(Rest, [<<H/binary, X/utf8>>|T]).
