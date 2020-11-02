-module (p14).
-export ([duplicate/1]).

duplicate(List) ->
  Res = duplicate(List, []),
  p05:reverse(Res).

duplicate([], Acc) ->
  Acc;
duplicate([H|T], Acc) ->
  duplicate(T, [H, H|Acc]).
