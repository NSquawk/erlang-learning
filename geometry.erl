-module(geometry).
-export([test/0
	, area/1
	,peremiter/1]).


test() -> 
	12 = area({rectangle, 3, 4}),
	144 = area({square, 12}),
	tests_worked.

area({rectangle, Width, Height}) -> Width * Height;
area({square, Side}) -> Side * Side;
area({circle, Radius}) -> 3.14159 * Radius * Radius.


peremiter({circle, R}) -> 2 * math:pi() * R;
peremiter({square,S}) -> 4 * S;
peremiter({rectangle, W, H}) -> 2*W + 2*H.



