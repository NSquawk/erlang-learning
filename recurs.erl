-module(recurs).
-export([fac/1
    ,bfac/1
    ,len/1
    ,tail_fac/1
    ,tail_len/1
    ,tail_sum/1]).

fac(N) when N == 0 -> 1;
fac(N) when N > 0 -> N*fac(N-1).

bfac(0) -> 1;
bfac(N) when N > 0 -> N*bfac(N-1).

len([]) -> 0;
len([_|T]) -> 1 + len(T).

tail_fac(N) -> tail_fac(N,1).
tail_fac(0,Acc) -> Acc;
tail_fac(N,Acc) when N > 0 -> tail_fac(N-1, N*Acc).



tail_len(X) -> tail_len(X,0).

tail_len([], Acc) -> Acc;
tail_len([_|T], Acc) -> tail_len(T, Acc+1).



tail_sum(X) -> tail_sum(X,0).

tail_sum([],Acc) -> Acc;
tail_sum([H|T], Acc) -> tail_sum(T,Acc + H).


