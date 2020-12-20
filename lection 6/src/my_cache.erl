-module(my_cache).

-export([create/1, insert/4, lookup/2, lookup_by_date/3, delete_obsolete/1]).

create(TableName) ->
  case is_present(TableName) of
    true ->
      table_is_present;
    false ->
      ets:new(TableName, [public, named_table, set]),
      ok
  end.

insert(TableName, Key, Value, TTL) when is_integer(TTL) ->
  case is_present(TableName) of
    true ->
      ets:insert(TableName, {Key, Value, os:system_time(second) + TTL}),
      ok;
    false ->
      error
  end;

insert(TableName, Key, Value, TTL) ->
  error.

lookup(TableName, Key) ->
  case is_present(TableName) of
    true ->
      case ets:member(TableName, Key) of
        true ->
          [{Key, Value, EndTime}] = ets:lookup(TableName, Key),
          case EndTime > os:system_time(second) of
            true -> {ok, Value};
            false -> {error, not_found}
          end;
        false ->
          {error, not_found}
      end;
    false ->
      error
  end.

lookup_by_date(TableName, DateFrom, DateTo) ->
  case is_present(TableName) of
    true ->
      MatchSpec = [{{'$1','$2','$3'},[{'>','$3',universal_time_to_system(DateFrom)}, {'<','$3',universal_time_to_system(DateTo)}],[['$2']]}],
      lists:flatten(ets:select(TableName, MatchSpec));
    false ->
      error
  end.

get_value(TableName, Key) ->
  [{Key, Value, ExpirationTime}] = ets:lookup(TableName, Key),

  case os:system_time(second) =< ExpirationTime of
    true ->
      {ok, Value};
    false ->
      {ok, nil}
  end.

delete_obsolete(TableName) ->
  case is_present(TableName) of
    true ->
      ets:select_delete(TableName, [{{'$1','$2','$3'},[{'<','$3', os:system_time(second)}],[true]}]),
      ok;
    false ->
      error
  end.

is_present(TableName) ->
  lists:member(TableName, ets:all()).

universal_time_to_system(Time) ->
  calendar:datetime_to_gregorian_seconds(Time) - 719528 * 24 * 3600.
