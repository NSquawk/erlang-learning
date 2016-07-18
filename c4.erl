-module(c4).
-export([my_tuple_to_list/1
	,t_to_list/1]).





my_tuple_to_list(T) ->
	[element(Pos, T) || Pos <- lists:seq(1,tuple_size(T))].


t_to_list(T) -> t_to_list(T, tuple_size(T), []).

t_to_list(T,0,L) -> L;
t_to_list(T, Size, L) ->
	t_to_list(T, Size - 1, [element(Size,T)|L]).
%t_to_list(T,0,L) -> Does not work because pattern is no mutually exclusive!!!!!
%       	lists:reverse(L).
