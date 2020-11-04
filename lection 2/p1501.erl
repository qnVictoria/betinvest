-module (p15).
-export ([replicate/2]).

replicate(List, N) ->
    Res = p05:reverse(replicate(List, N, [])),
    p13:decode(Res).

replicate([], _, Acc) ->
  Acc;
replicate([H|T], N, Acc) ->
  replicate(T, N, [{N, H}|Acc]).
