-module(fib).
-export([fib/1]).

fib(N) ->
  round((math:pow(fi(), N) - math:pow(-fi(), -N))/(2 * fi() - 1)).

fi() ->
  (1 + math:sqrt(5))/2.
