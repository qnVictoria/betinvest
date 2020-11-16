-module(bs04).
-export([decode/2]).

% Json = <<"
% {
%   'squadName': 'Super hero squad',
%   'homeTown': 'Metro City',
%   'formed': 2016,
%   'secretBase': 'Super tower',
%   'active': true,
%   'members': [
%     {
%       'name': 'Molecule Man',
%       'age': 29,
%       'secretIdentity': 'Dan Jukes',
%       'powers': [
%         'Radiation resistance',
%         'Turning tiny',
%         'Radiation blast'
%       ]
%     },
%     {
%       'name': 'Madame Uppercut',
%       'age': 39,
%       'secretIdentity': 'Jane Wilson',
%       'powers': [
%         'Million tonne punch',
%         'Damage resistance',
%         'Superhuman reflexes'
%       ]
%     },
%     {
%       'name': 'Eternal Flame',
%       'age': 1000000,
%       'secretIdentity': 'Unknown',
%       'powers': [
%         'Immortality',
%         'Heat Immunity',
%         'Inferno',
%         'Teleportation',
%         'Interdimensional travel'
%       ]
%     }
%   ]
%  }
%  ">>

decode(Json, proplist) ->
  to_proplist(json_trimmer(Json));
decode(Json, map) ->
  to_map(json_trimmer(Json));
decode(_, _) ->
  undefined.

json_trimmer(Json) ->
  json_trimmer(Json, outside, <<>>).

json_trimmer(<<>>, _, Acc) ->
  Acc;
json_trimmer(<<" ", Rest/binary>>, outside, Acc) ->
  json_trimmer(Rest, outside, Acc);
json_trimmer(<<"\n", Rest/binary>>, outside, Acc) ->
  json_trimmer(Rest, outside, Acc);
json_trimmer(<<"'", Rest/binary>>, outside, Acc) ->
  json_trimmer(Rest, inside, <<Acc/binary, "'">>);
json_trimmer(<<"'", Rest/binary>>, inside, Acc) ->
  json_trimmer(Rest, outside, <<Acc/binary, "'">>);
json_trimmer(<<X/utf8, Rest/binary>>, Value, Acc) ->
  json_trimmer(Rest, Value, <<Acc/binary, X/utf8>>).

to_proplist(Json) ->
  to_proplist(Json, [{<<>>, <<>>}]).

to_proplist(<<"}">>, [{Key, Value}|Tail]) ->
  lists:reverse([{bin_to_term(Key), bin_to_term(Value)}|Tail]);
to_proplist(<<"{", Rest/binary>>, [{<<>>, <<>>}] = Acc) ->
  to_proplist(Rest, Acc);
to_proplist(<<"'", Rest/binary>>, Acc) ->
  to_proplist(Rest, Acc);
to_proplist(<<",", Rest/binary>>, [{Key, Value}|Tail]) ->
  to_proplist(Rest, [{<<>>, <<>>}, {bin_to_term(Key), bin_to_term(Value)}|Tail]);
to_proplist(<<":", Rest/binary>>, [{<<>>, Value}|Tail]) ->
  to_proplist(Rest, [{Value, <<>>}|Tail]);
to_proplist(<<"{", Rest/binary>>, [{Key, _}|Tail]) ->
  {InnerJson, OuterText} = split_json(Rest, 1, <<>>),
	to_proplist(OuterText, [{Key, to_proplist(InnerJson, [{<<>>,<<>>}])}|Tail]);
to_proplist(<<"[", Rest/binary>>, [{Key, _}|Tail]) ->
	{InnerList, OuterText} = split_list(Rest, 1, <<>>, []),
	to_proplist(OuterText, [{Key, lists:reverse([to_proplist(X, [{<<>>,<<>>}]) || X <- InnerList])}|Tail]);
to_proplist(<<X/utf8, Rest/binary>>, [{Key, Value}|Tail]) ->
	to_proplist(Rest, [{Key, <<Value/binary, X/utf8>>}|Tail]);
to_proplist(<<>>, [{<<>>,Value}|_]) ->
  bin_to_term(Value).

to_map(Json) ->
  to_map(Json, {<<>>, <<>>}, #{}).

to_map(<<"}">>, {Key, Value}, Acc) ->
	maps:put(bin_to_term(Key), bin_to_term(Value), Acc);
to_map(<<"{", Rest/binary>>, {<<>>, <<>>}, #{}) ->
	to_map(Rest, {<<>>, <<>>}, #{});
to_map(<<"'", Rest/binary>>, Tuple, Acc) ->
  to_map(Rest, Tuple, Acc);
to_map(<<",", Rest/binary>>, {Key, Value}, Acc) ->
	to_map(Rest, {<<>>, <<>>}, maps:put(bin_to_term(Key), bin_to_term(Value), Acc));
to_map(<<":", Rest/binary>>, {<<>>, Value}, Acc) ->
	to_map(Rest, {Value, <<>>}, Acc);
to_map(<<"{", Rest/binary>>, {Key, _}, Acc) ->
	{InnerJson, OuterText} = split_json(Rest, 1, <<>>),
	to_map(OuterText, {Key, to_map(InnerJson, {<<>>, <<>>}, #{})}, Acc);
to_map(<<"[", Rest/binary>>, {Key, _}, Acc) ->
	{InnerList, OuterText} = split_list(Rest, 1, <<>>, []),
	to_map(OuterText, {Key, lists:reverse([to_map(X, {<<>>, <<>>}, #{}) || X <- InnerList])}, Acc);
to_map(<<X/utf8, RestText/binary>>, {Key, Value}, Acc) ->
	to_map(RestText, {Key, <<Value/binary, X/utf8>>}, Acc);
to_map(<<>>, {<<>>, Value}, #{}) ->
	bin_to_term(Value).

split_json(<<"}", Rest/binary>>, 1, Acc) ->
	{<<Acc/binary, "}">>, Rest};
split_json(<<"}", Rest/binary>>, Counter, Acc) ->
	split_json(Rest, Counter - 1, <<Acc/binary, "}">>);
split_json(<<"{", Rest/binary>>, Counter, Acc) ->
	split_json(Rest, Counter + 1, <<Acc/binary, "{">>);
split_json(<<X/utf8, Rest/binary>>, Counter, Acc) ->
	split_json(Rest, Counter, <<Acc/binary, X/utf8>>).

split_list(<<"]", Rest/binary>>, 1, AccElem, AccList) ->
	{[AccElem| AccList], Rest};
split_list(<<",", Rest/binary>>, 1, AccElem, AccList) ->
	split_list(Rest, 1, <<>>, [AccElem|AccList]);
split_list(<<"]", Rest/binary>>, Counter, AccElem, AccList) ->
	split_list(Rest, Counter - 1, <<AccElem/binary, "]">>, AccList);
split_list(<<"[", Rest/binary>>, Counter, AccElem, AccList) ->
	split_list(Rest, Counter + 1, <<AccElem/binary, "[">>, AccList);
split_list(<<"}", Rest/binary>>, Counter, AccElem, AccList) ->
	split_list(Rest, Counter - 1, <<AccElem/binary, "}">>, AccList);
split_list(<<"{", Rest/binary>>, Counter, AccElem, AccList) ->
	split_list(Rest, Counter + 1, <<AccElem/binary, "{">>, AccList);
split_list(<<X/utf8, Rest/binary>>, Counter, AccElem, AccList) ->
	split_list(Rest, Counter, <<AccElem/binary, X/utf8>>, AccList).

bin_to_term(<<"true">>) ->
  true;
bin_to_term(<<"false">>) ->
  false;
bin_to_term(Value) ->
  try
    binary_to_integer(Value)
	catch
		error: badarg ->
      Value
	end.
