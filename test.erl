-module(test).
-export([add/2
    ,hello/0
    ,greet/2
    ,head/1
    ,second/1
    ,third/1
    ,same/2
    ,old_enough/1
    ,oh_god/1
    ,help_me/1
    ,insert/2
    ,beach/1]).

-author("Me!").

add(A,B) ->
    A + B.

hello() ->
    io:format("Hello, world!\n").

greet(male, Name) ->
    io:format("Hello, Mr. ~s!\n", [Name]);
greet(female, Name) ->
    io:format("Hello, Mrs. ~s!\n", [Name]);
greet(_, Name) ->
    io:format("hello, ~s!\n", [Name]).


head([H|_]) -> H.

second([_,X|_]) -> X.

third([_,_,Y|_]) -> Y.


same(X,X) ->
    true;
same(_,_) ->
    false.


old_enough(X) when X >= 16, X =< 104 ->
    true;
old_enough(_) ->
    false.

oh_god(N) ->
    if N =:= 2 -> might_succeed;
        true -> always_does
    end.

help_me(Animal) ->
    Talk = if Animal == cat -> "Meow";
                Animal == dog -> "Woof";
                Animal == cow -> "Moo";
                true -> "fsgsefsdf"
            end,
        {Animal, "says " ++ Talk ++ "!"}.



insert(X,[]) ->
    [X];
insert(X,Set) ->
    case lists:member(X,Set) of 
        true -> Set;
        false -> [X|Set]
    end.



beach(Temp) ->
    case Temp of 
        {celsius, N} when N >= 20, N =< 45 ->
            'favorable';
        {kelvin, N} when N >= 293, N =< 318 ->
            'scientifically favorable';
        {fahrenheit, N} when N >= 68, N =< 113 ->
            'favorable in the US';
        _ ->
            'avoid beach'
    end.

