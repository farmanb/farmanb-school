% Shift reduce
%?- shift_reduce([the, waiter, brought, the, meal], [s]).
% yes
% ?- shift_reduce([the, waiter, brought, the, meal], [np, vp]).
% yes

shift_reduce(Sentence, Category) :-
	shift_reduce(Sentence, [], Category).

shift_reduce([], Category, Category).
shift_reduce(Sentence, Stack, Category) :-
	reduce(Stack, ReducedStack),
	write('Reduce: '), write(ReducedStack), nl,
	shift_reduce(Sentence, ReducedStack, Category).
shift_reduce(Sentence, Stack, Category) :-
	shift(Sentence, Stack, NewSentence, NewStack),
	write('Shift: '), write(NewStack), nl,
	shift_reduce(NewSentence, NewStack, Category).

shift([First | Rest], Stack, Rest, NewStack) :-
	append(Stack, [First], NewStack).

reduce(Stack, NewStack) :-
	match_rule(Stack, NewStack).
reduce(Stack, NewStack) :-
	match_word(Stack, NewStack).

match_rule(Stack, ReducedStack) :-
	rule(Head, Expansion),
	append(AssEnd, Expansion, Stack),
	append(AssEnd, [Head], ReducedStack).

match_word(Stack, NewStack) :-
	append(StackBottom, Word, Stack),
	word(POS, Word),
	append(StackBottom, [POS], NewStack).

rule(s, [np, vp]).
rule(np, [d, n]).
rule(vp, [v]).
rule(vp, [v, np]).

word(d, [the]).
word(n, [waiter]).
word(n, [meal]).
word(n, [cat]).
word(v, [brought]).
word(v, [slept]).


