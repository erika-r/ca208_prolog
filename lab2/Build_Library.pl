book(illiad, homer, study, 500).
book(c, richie, study, 150).
book(nt_bible, sams, reference, 480).
book(monty_python, cleese, comedy, 300).
book(a,b, drama, 69).
book(c,d,drama,69).
book(e,f,fiction,69).

buildLibrary(Lib) :- 
	findall(book(Title, Author, Genre, Size), book(Title, Author,
	Genre, Size), Lib). 

/* findall(template, goal, bag), temp = what you want the item to look like, goal == if true,
bag == name of returned list */

revision(X) :-
	book(X,_,Y,Z),
	(Y == study ; Y == reference),
	Z > 300.

holidays(X) :-
	book(X,_,Z,Y), 
	Z \= study,
	Z \= reference,
	Y < 400.

literary(X) :-
	book(X,_,G,_),
	G == drama.

leisure(X) :-
	book(X,_,G,_),
	(G == comedy ; G == fiction).