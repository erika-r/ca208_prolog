compress([],[]).
compress([X],[X]).
compress([X,X|Xs],Zs):- !,
	compress([X|Xs],Zs).
compress([X,Y| Xs], [X|Zs]):-
	compress([Y|Xs],Zs).