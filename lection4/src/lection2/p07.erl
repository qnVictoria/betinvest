-module(p07).
-export([flatten/1]).

flatten(List) ->
  flatten(List, []).

flatten([H|T], Acc) ->
  flatten(H, flatten(T, Acc));
flatten([], Acc) ->
  Acc;
flatten(X, Acc) ->
  [X|Acc].
