-module(p15).
-export([replicate/2]).

replicate(List, Num) ->
  p05:reverse(replicate(List, Num, Num, [])).

replicate([_|T], Num, 0, Acc) ->
  replicate(T, Num, Num, Acc);
replicate([H|T], Num, N, Acc) ->
  replicate([H|T], Num, N-1, [H|Acc]);
replicate([], _, _, Acc) ->
  Acc.
