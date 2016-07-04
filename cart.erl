-module(cart).
-export([total/1
	,betterTotal/1
	,listTotal/1]).

-import(lists, [map/2, sum/1]).
-import(shop, [cost/1]).

total(T) -> total(T,0).

total([{What, N}|T], Total) -> total(T, cost(What) * N + Total);
total([],Total) -> Total.

betterTotal(L) ->
	sum(map(fun({What, N}) -> cost(What) * N end, L)).


listTotal(L) ->
	sum([cost(What) * N || {What, N} <- L]).

