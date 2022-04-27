/* derivador */
d(X,X,1) :- !.
d(Y,_,0) :- atom(Y).
d(N,_,0) :- number(N).
d(A+B, X, DA+DB) :-
  d(A,X,DA),
  d(B,X,DB).

d(A*B, X, DA*B+ DB*A) :-
  d(A,X,DA),
  d(B,X,DB).

d(A/B,X, (DA*B - DB*A)/(B*B)) :-
  d(A,X,DA),
  d(B,X,DB).

d(sin(A), X, cos(A)*DA) :-
  d(A,X,DA).

d(cos(A), X, -sin(A)*DA) :-
  d(A,X,DA).
