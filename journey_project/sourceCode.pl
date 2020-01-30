
%!!facts
route(dublin, cork, 200, 'fct').
route(cork, dublin, 200, 'fct').
route(cork, corkAirport, 20, 'fc').
route(corkAirport, cork, 25, 'fc').
route(dublin, dublinAirport, 10, 'fc').
route(dublinAirport, dublin, 20, 'fc').
route(dublinAirport, corkAirport, 225, 'p').
route(corkAirport, dublinAirport, 225, 'p').
route(corkAirport,home,25,'f').
route(home,p1,100,'f').
route(p1,p2,100,'c').

%used to create list of all places passed till destination is reached
%if in list already, do not go through again
notElem(_,[]):- !.
notElem(X, [Head|Tail]) :- X \= Head, notElem(X, Tail).

%!!check if there is a way to destination
%!!calculate overall distance between src and dstn
%gets list of all places passed and total distance travelled

routeLst(X,Y,Lst,Visited,Dst):- X \= Y, route(X,Z,Distance,_),
	notElem(Z,Visited), append(Visited,[X],Lst1),
	routeLst(Z,Y,Lst,Lst1,Dst1), Dst is Distance + Dst1.

routeLst(X,Y,Lst,Visited,Dst):- X \= Y, route(X,Y,Distance,_),
	append(Visited,[X,Y],Lst), Dst is Distance,!.


%!!check for mode, atom_chars
%used to check if method of transport is in list given
%foot 5km/h
%car 80km/h
%train 100km/h
%plane 500km/h

%atom_chars turns strings into lists, Time in hours
foot(X,Y,Time):- route(X,Y,D,L1), atom_chars(L1,L2), member(f,L2), Time is D / 5.
car(X,Y,Time):- route(X,Y,D,L1),atom_chars(L1,L2), member(c,L2), Time is D / 80.
train(X,Y,Time):- route(X,Y,D,L1),atom_chars(L1,L2), member(t,L2), Time is D / 100.
plane(X,Y,Time):- route(X,Y,D,L1), atom_chars(L1,L2), member(p,L2), Time is D / 500.

totalTime(X,Y,Visited,Lst,Time,M):- X \= Y, route(X,Z,_,_), Z \= Y,
	(plane(X,Z,T),member(p,M); train(X,Z,T),member(t,M); car(X,Z,T),member(c,M); foot(X,Z,T),member(f,M)),
	notElem(Z,Visited),
	append(Visited,[X],Lst1),
	totalTime(Z,Y,Lst1,Lst,T2,M),
	routeLst(Z,Y,Lst,Lst1,_),
	Time is T2 + T.

totalTime(X,Y,Visited,Lst,Time,M):- X \= Y, route(X,Y,_,_),
	append(Visited,[X,Y],Lst),!,
	(plane(X,Y,T), member(p,M); train(X,Y,T), member(t,M); car(X,Y,T),member(c,M); foot(X,Y,T),member(f,M)),
	Time is T,!.


%list of all times for route
shortest(X,Y,M,T):- findall(Time, totalTime(X,Y,_,_,Time,M), Tlist), min_list(Tlist,T).

%!!func
%journey(Source,Destination,Mode).
%journey needs - source, destination, fastest route with only modes provided.

journey(X,Y,M):- atom_chars(M,M2), totalTime(X,Y,V,Lst,T,M2), shortest(X,Y,M2,T), routeLst(X,Y,Lst,V,Distance),
write('Source:'), write(X),nl,
write('Destination:'), write(Y),nl,
write('Distance:'), write(Distance), write('km'),nl,
write('Quickest Time:'), write(T),write('hrs'),nl,
write('Quickest Route:'), write(Lst),!.
