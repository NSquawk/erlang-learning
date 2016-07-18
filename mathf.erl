-module(mathf).
-export([even/1
	 ,odd/1
	 ,filter2/2]).


even(X) -> X rem 2 =:= 0.
odd(X) -> X rem 2 =:= 1.


filter(F,[H|T]) -> filter(F(H), H, F, T).

filter(true,H,F,T) -> [H | filter(F,T)];
filter(false,H,F,T) -> [filter(F,T)].


filter2(F,L) -> filter2(F,L,[]).


filter2(F,[H|T],Acc) ->
	case F(H) of %revisit if guard. was getting illegal guard expression error on compile
	   true	-> filter2(F,T,[H|Acc]);
	   false -> filter2(F,T,Acc)
	end;
filter2(F,[],Acc) -> lists:reverse(Acc).
