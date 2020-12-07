-module(my_cache).

-export([create/1, insert/4, lookup/2, delete_obsolete/1]).

create(TableName) ->
  ets:new(TableName, [public, named_table, set]),
  ok.

insert(TableName, Key, Value, TTL) when is_integer(TTL) ->
  ets:insert(TableName, {Key, Value, os:system_time(second) + TTL}),
  ok;

insert(TableName, Key, Value, TTL) ->
  error.

lookup(TableName, Key) ->
  [{Key, Value, EndTime}] = ets:lookup(TableName, Key),
  case EndTime > os:system_time(second) of
    true -> {ok, Value};
    false -> error
  end.

delete_obsolete(TableName) ->
  ets:select_delete(TableName, [{{'$1','$2','$3'},[{'<','$3', os:system_time(second)}],[true]}]),
  ok.
