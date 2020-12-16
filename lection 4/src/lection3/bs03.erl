-module(bs03).
-export([split/2]).

split(Text, Separator) ->
  BinarySeparator = list_to_binary(Separator),
  lists:reverse(split(Text, BinarySeparator, byte_size(BinarySeparator), [<<>>])).

split(<<>>, _, _, Acc) ->
  Acc;
split(Text, Separator, ByteSize, [H|T] = Acc) ->
  case Text of
    <<Separator:ByteSize/binary, Y/utf8, Rest/binary>> -> split(Rest, Separator, ByteSize, [<<Y/utf8>>|Acc]);
    <<X/utf8, Rest/binary>> -> split(Rest, Separator, ByteSize, [<<H/binary, X/utf8>>|T])
  end.
