-module(p10).
-export([encode/1]).

encode(List) ->
  p05:reverse(encode(List, [])).

encode([], Acc) ->
  Acc;
encode([H|T], [{N, H}|T2]) ->
  encode(T, [{N + 1, H}|T2]);
encode([H|T], Acc) ->
  encode(T, [{1, H}|Acc]).
