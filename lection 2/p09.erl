-module (p09).
-export ([pack/1]).

pack(List) ->
  p05:reverse(pack(List, [])).

pack([], Acc) ->
  Acc;
pack([H|T], [[H|T2]|T3]) ->
  pack(T, [[H, H|T2]|T3]);
pack([H|T], Acc) ->
  pack(T, [[H]|Acc]).
