
myElem(X,[X|_]).
myElem(X,[_|T]):-
	myElem(X,T).

myHead(X, [X|_]).

myLast(X,[X]).
myLast(X, [_|T]):-
	myLast(X,T).

myTail(X, [_|X]).
	myTail(X, [_|T]):-
	myTail(X,T).

myAppend([],L2,L2).
myAppend([X|L1], L2, [X|L3]) :-
	myAppend(L1,L2,L3).

myReverse(List,Revlist):-
	myReverse(List,[],Revlist).

myReverse([], Revlist, Revlist).

myReverse([X|Tail],Acc,Revlist):-
	myReverse(Tail,[X|Acc],Revlist).

myDelete(X, [X|L],L).
myDelete(X, [Y|Tail], [Y|Tail2]) :-
	myDelete(X,Tail,Tail2).
