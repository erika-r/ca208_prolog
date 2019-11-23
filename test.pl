myElem(X,[X|_]).
myElem(X, [_|Tail]):-
	myElem(X,Tail).

myHead(X,[X|_]).

myLast(X, [X]).
myLast(X, [_|Tail]):-
	myLast(X,Tail).

myTail(X,[_|X]).
myTail(X, [_|Tail]):-
	myTail(X,Tail).

myAppend([],L2,L2).
myAppend([X|L1], L2, [X|L3]):-
	myAppend(L1,L2,L3).

myReverse(List,Revlist):-
	myReverse(List,[],Revlist).
myReverse([],Revlist,Revlist).
myReverse([X|Tail],Acc,Revlist):-
	myReverse(Tail,[X|Acc], Revlist).