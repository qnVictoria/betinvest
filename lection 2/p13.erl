-module(p13).
-export([decode/1]).

decode(List) ->
  p05:reverse(decode(List, [])).

decode([], Acc) ->
  Acc;
decode([{1, H}|T], Acc) ->
  decode(T, [H|Acc]);
decode([{N, H}|T], Acc) ->
  decode([{N-1, H}|T], [H|Acc]).
