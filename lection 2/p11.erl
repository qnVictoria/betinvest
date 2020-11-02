-module (p11).
-export ([encode_modified/1]).

encode_modified(List) ->
  p05:reverse(encode_modified(List, [])).

encode_modified([], Acc) ->
  Acc;
encode_modified([H|T], [{N, H}|T2]) ->
  encode_modified(T, [{N +1, H}|T2]);
encode_modified([H|T], [H|T2]) ->
  encode_modified(T, [{2, H}|T2]);
encode_modified([H|T], Acc) ->
  encode_modified(T, [H|Acc]).
