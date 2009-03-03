board(1,[ [0,0,0],
	[0,1,0],
    [0,0,1,1,1,0,0],
    [0,0,0,1,0,0,0],
    [0,0,0,1,0,0,0],
	[0,0,0],
	[0,0,0] ]).

board(2,[ [0,0,0],
	 [0,1,0],
     [0,0,0,1,0,0,0],
     [0,1,1,1,1,1,0],
     [0,0,0,1,0,0,0],
	 [0,1,0],
	 [0,0,0] ]).

%[] operator for lists
myselect(1,[Head|_],Head).
myselect(I,[_|Rest],Result) :-  I>1, J is I-1, myselect(J,Rest,Result).

%valid positions
pos(4,4).
pos(4,5).
pos(5,5).
pos(5,4).
pos(5,3).
pos(4,3).
pos(3,3).
pos(3,4).
pos(3,5).
pos(3,6).
pos(4,6).
pos(5,6).
pos(6,3).
pos(6,2).
pos(6,1).
pos(5,2).
pos(4,2).
pos(3,2).
pos(2,1).
pos(2,2).
pos(2,3).
pos(3,7).
pos(4,7).
pos(5,7).
pos(7,3).
pos(7,2).
pos(7,1).
pos(5,1).
pos(4,1).
pos(3,1).
pos(1,1).
pos(1,2).
pos(1,3).

%translates column position when moving from
%a large row to a small row and vise-versa
translate_column_up(Row,Column,NewColumn):-Row is 3,NewColumn is Column-2,!.
translate_column_up(Row,Column,NewColumn):-Row is 6,NewColumn is Column+2,!.
translate_column_up(_,Column,NewColumn):-NewColumn is Column.

translate_column_down(Row,Column,NewColumn):-Row is 2,NewColumn is Column+2,!.
translate_column_down(Row,Column,NewColumn):-Row is 5,NewColumn is Column-2,!.
translate_column_down(_,Column,NewColumn):-NewColumn is Column.

can_move_left((Row_Coord,Col_Coord),Board):-myselect(Row_Coord,Board,Row),myselect(Col_Coord,Row,E1),
	E1 is 1, N is Col_Coord-1, pos(Row_Coord,N),
	myselect(N,Row,E2),
	E2 is 1, M is Col_Coord-2, pos(Row_Coord,M),
	myselect(M,Row,E3),E3 is 0.

can_move_right((Row_Coord,Col_Coord),Board):-myselect(Row_Coord,Board,Row),myselect(Col_Coord,Row,E1),
	E1 is 1, N is Col_Coord+1, pos(Row_Coord,N),
	myselect(N,Row,E2),
	E2 is 1, M is Col_Coord+2, pos(Row_Coord,M),
	myselect(M,Row,E3),E3 is 0.

can_move_up((Row_Coord,Col_Coord),Board):-myselect(Row_Coord,Board,Row),myselect(Col_Coord,Row,E1),
	E1 is 1, N is Row_Coord-1, translate_column_up(Row_Coord,Col_Coord,Translated_Col_Coord), pos(N,Translated_Col_Coord),
	myselect(N,Board,Row2),
	myselect(Translated_Col_Coord,Row2,E2),
	E2 is 1, M is Row_Coord-2, translate_column_up(N,Translated_Col_Coord,Translated_Col_Coord2), pos(M,Translated_Col_Coord2),
	myselect(M,Board,Row3),
	myselect(Translated_Col_Coord2,Row3,E3),E3 is 0.

can_move_down((Row_Coord,Col_Coord),Board):-myselect(Row_Coord,Board,Row),myselect(Col_Coord,Row,E1),
	E1 is 1, N is Row_Coord+1, translate_column_down(Row_Coord,Col_Coord,Translated_Col_Coord), pos(N,Translated_Col_Coord),
	myselect(N,Board,Row2),
	myselect(Translated_Col_Coord,Row2,E2),
	E2 is 1, M is Row_Coord+2, translate_column_down(N,Translated_Col_Coord,Translated_Col_Coord2), pos(M,Translated_Col_Coord2),
	myselect(M,Board,Row3),
	myselect(Translated_Col_Coord2,Row3,E3),E3 is 0.

topfliprow(Left_Col_Coord,Right_Col_Coord,Row,FlippedRow):-Left_Bound is Left_Col_Coord-1, 
	Right_Bound is Right_Col_Coord+1, 
	fliprow(1,Left_Bound,Right_Bound,Row,FlippedRow).

%Base case.
fliprow(_,_,_,[],[]).
fliprow(I,Left_Col_Coord,Right_Col_Coord,[Head|Tail],[0|Rest]):- Left_Col_Coord<I, 
	I<Right_Col_Coord, 
	Head is 1, 
	M is I+1, 
	fliprow(M,Left_Col_Coord,Right_Col_Coord,Tail,Rest),!.
fliprow(I,Left_Col_Coord,Right_Col_Coord,[Head|Tail],[1|Rest]):- Left_Col_Coord<I, 
	I<Right_Col_Coord, 
	Head is 0, 
	M is I+1, 
	fliprow(M,Left_Col_Coord,Right_Col_Coord,Tail,Rest),!.
fliprow(I,Left_Col_Coord,Right_Col_Coord,[Head|Tail],[Head|Rest]):- M is I+1, 
	fliprow(M,Left_Col_Coord,Right_Col_Coord,Tail,Rest).

topflip((Row_Coord,Col_Coord),C1,Board,Result):-flip(1,Row_Coord,Col_Coord,C1,Board,Result).

%Base case.
flip(_,_,_,_,[],[]).
flip(I,Row_Coord,Col_Coord,C1,[BoardHead|BoardTail],[ResultHead|ResultTail]):-I is Row_Coord, 
	J is I+1, 
	topfliprow(Col_Coord,C1,BoardHead,ResultHead),
	flip(J,Row_Coord,Col_Coord,C1,BoardTail,ResultTail),!.
flip(I,Row_Coord,Col_Coord,C1,[BoardHead|BoardTail],[BoardHead|ResultTail]):-J is I+1,
	flip(J,Row_Coord,Col_Coord,C1,BoardTail,ResultTail).

move_left((Row_Coord,Col_Coord),Board,Result):-can_move_left((Row_Coord,Col_Coord),Board),C1 is Col_Coord-2, 
	topflip((Row_Coord,C1),
	Col_Coord,Board,Result).

move_right((Row_Coord,Col_Coord),Board,Result):-can_move_right((Row_Coord,Col_Coord),Board), 
	C1 is Col_Coord+2, 
	topflip((Row_Coord,Col_Coord),C1,Board,Result).

move_up((Row_Coord,Col_Coord),Board,Result):-can_move_up((Row_Coord,Col_Coord),Board),
	Row_Coord2 is Row_Coord-1,
	Row_Coord3 is Row_Coord-2,
	translate_column_up(Row_Coord,Col_Coord,Translated_Col_Coord),
	translate_column_up(Row_Coord2,Translated_Col_Coord,Translated_Col_Coord2),
	topflip((Row_Coord,Col_Coord),Col_Coord,Board,TempResult),
	topflip((Row_Coord2,Translated_Col_Coord),Translated_Col_Coord,TempResult,TempResult2),
	topflip((Row_Coord3,Translated_Col_Coord2),Translated_Col_Coord2,TempResult2,Result).

move_down((Row_Coord,Col_Coord),Board,Result):-can_move_down((Row_Coord,Col_Coord),Board),
	Row_Coord2 is Row_Coord+1,
	Row_Coord3 is Row_Coord+2,
	translate_column_down(Row_Coord,Col_Coord,Translated_Col_Coord),
	translate_column_down(Row_Coord2,Translated_Col_Coord,Translated_Col_Coord2),
	topflip((Row_Coord,Col_Coord),Col_Coord,Board,TempResult),
	topflip((Row_Coord2,Translated_Col_Coord),Translated_Col_Coord,TempResult,TempResult2),
	topflip((Row_Coord3,Translated_Col_Coord2),Translated_Col_Coord2,TempResult2,Result).

boardprint(Board):-write('      '),myselect(1,Board,R1),write(R1),nl,
	write('      '),myselect(2,Board,R2),write(R2),nl,
	myselect(3,Board,R3),write(R3),nl,
	myselect(4,Board,R4),write(R4),nl,
	myselect(5,Board,R5),write(R5),nl,
	write('      '),myselect(6,Board,R6),write(R6),nl,
	write('      '),myselect(7,Board,R7),write(R7),nl.