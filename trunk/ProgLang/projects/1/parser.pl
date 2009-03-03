expected(X) :- append([],[non(e,_)],X).
consumed(X) :- append([],[],X).

sr([]).

sr(Input, RedSec) :-
	sr(Input, [], RedSec),!.

%Base case
sr(Input, Stack, RedSec) :- consumed(Input), expected(Stack).

sr(Input, Stack, RedSec) :-
	reduce(Stack, ReducedStack, RedSec, NewRedSec),
	write('RedSec: '),write(RedSec),nl,nl,
	write('Reduce: '), write(ReducedStack), nl,
	sr(Input, ReducedStack, NewRedSec).

sr(Input, Stack, RedSec) :-
	shift(Input, Stack, NewInput, NewStack),
	write('Shift: '), write(NewStack), nl,
	sr(NewInput, NewStack, RedSec).

shift([First | Rest], Stack, Rest, NewStack) :-
	append(Stack, [First], NewStack).

reduce(Stack, NewStack, RedSec, NewRedSec) :-
	match_term(Stack, NewStack, RedSec, NewRedSec).

reduce(Stack, NewStack, RedSec, NewRedSec) :-
	match_non(Stack,NewStack, RedSec, NewRedSec).

match_term(Stack, ReducedStack, RedSec, NewRedSec) :-
	append(Bottom, Term, Stack),
	term(Type, Term),
	append(Bottom, [term(Type,Term)], ReducedStack),
	append(RedSec, [term(Type,Term)], NewRedSec).

match_non(Stack, ReducedStack, RedSec, NewRedSec) :-
	non(Prod, Exp),
	append(Bottom, Exp, Stack),
	args(Prod,Exp,X),
	append(Bottom, [non(Prod,X)], ReducedStack),
	append(RedSec, [non(Prod,X)], NewRedSec).

%Gets the correct argument for the nonterminal
%--Addition
args(e,[non(e,[X|_]),term(add,_),non(t,[Y|_])],S) :- Temp is (X) + (Y), append([],[Temp],S).
%--Subtraction
args(e,[non(e,[X|_]),term(sub,_),non(t,[Y|_])],D) :- Temp is (X) - (Y), append([],[Temp],D).
%--Multiplication
args(t,[non(t,[X|_]),term(mult,_),non(f,[Y|_])],P) :- Temp is (X) * (Y), append([],[Temp],P).
%--Division
args(t,[non(t,[X|_]),term(div,_),non(f,[Y|_])],Q) :- Temp is (X) / (Y), append([],[Temp],Q).
%--Anything not involving arithmetic.
args(e,[non(t,Y)],Y).% :- X is Y.%append([],Y,X).
args(t,[non(f,Y)],Y).% :- X is Y.%append([],Y,X).
args(f,[term(int,Y)],Y).% :- X is Y.%append([],Y,X).
args(f,[term(lparen,_),non(e,Y),term(rparen,_)],Y).% :- X is Y.%append([],Y,X).

%Absolute value
absolute(X,Y) :- X > 0, Y = X, !.
absolute(X,Y) :- X < 0, Y is (X)*(-1), !.

%Definitions
natural(1).
natural(N) :- D is N-1, D > 0, natural(D).

%Terminals
%--Operators
term(add, [+]).
term(sub, [-]).
term(mult, [*]).
term(div, [/]).

%--Parens
term(lparen, ['(']).
term(rparen, [')']).

%--Integers
term(int,[X]) :- number(X), absolute(X,Y), natural(Y).

%Non-Terminals
%--E
non(e,[non(e,_),term(add,_),non(t,_)]).
non(e,[non(e,_),term(sub,_),non(t,_)]).
non(e,[non(t,_)]).
%--T
non(t,[non(t,_),term(mult,_),non(f,_)]).
non(t,[non(t,_),term(div,_),non(f,_)]).
non(t,[non(f,_)]).
%--F
non(f,[term(int,_)]).
non(f,[term(lparen,_),non(e,_),term(rparen,_)]).
