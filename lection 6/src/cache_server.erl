-module(cache_server).
-behaviour(gen_server).

%% API.
-export([start_link/2]).
-export([stop/0]).
-export([insert/3]).
-export([lookup/1]).
-export([lookup_by_date/2]).

%% gen_server.
-export([init/1]).
-export([handle_call/3]).
-export([handle_cast/2]).
-export([handle_info/2]).
-export([terminate/2]).

%% API.

-spec start_link(atom(), list()) -> {ok, pid()}.
start_link(TableName, [{drop_interval, Interval}]) ->
  gen_server:start_link({local, ?MODULE}, ?MODULE, [TableName, Interval*1000], []).

-spec stop() -> stopped.
stop() ->
	gen_server:call(?MODULE, stop).

-spec insert(term(), term(), integer()) -> ok.
insert(Key, Value, TTL) ->
  gen_server:cast(?MODULE, {insert, Key, Value, TTL}).

-spec lookup(term()) -> {ok, term()}.
lookup(Key) ->
  gen_server:call(?MODULE, {lookup, Key}).

-spec lookup_by_date(tuple(), tuple()) -> {ok, list()}.
lookup_by_date(DateFrom, DateTo) ->
  gen_server:call(?MODULE, {lookup_by_date, DateFrom, DateTo}).

%% gen_server.

init([TableName, Interval]) ->
  my_cache:create(TableName),
  erlang:send_after(Interval, self(), delete_obsolete),
  {ok, {TableName, Interval}}.

handle_info(delete_obsolete, {TableName, Interval} = State) ->
  my_cache:delete_obsolete(TableName),
  erlang:send_after(Interval, self(), delete_obsolete),
  {noreply, State};
handle_info(_Info, State) ->
	{noreply, State}.

terminate(_Reason, _State) ->
	ok.

handle_cast({insert, Key, Value, TTL}, {TableName, _} = State) ->
  my_cache:insert(TableName, Key, Value, TTL),
  {noreply, State}.

handle_call({lookup, Key}, _From, {TableName, _} = State) ->
  Result = my_cache:lookup(TableName, Key),
  {reply, Result, State};
handle_call({lookup_by_date, DateFrom, DateTo}, _From, {TableName, _} = State) ->
  Values = my_cache:lookup_by_date(TableName, DateFrom, DateTo),
  {reply, {ok, Values}, State};
handle_call(stop, _From, State) ->
	{stop, normal, stopped, State};
handle_call(_Request, _From, State) ->
	{reply, ignored, State}.
