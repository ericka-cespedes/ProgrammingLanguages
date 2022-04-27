% Student exercise profile
:- set_prolog_flag(occurs_check, error).        % disallow cyclic terms
:- set_prolog_stack(global, limit(8 000 000)).  % limit term space (8Mb)
:- set_prolog_stack(local,  limit(2 000 000)).  % limit environment space

% Your program goes here
% Reglas
deriva(U+V,X,DU+DV):- deriva(U,X,DU), deriva(V,X,DV).
deriva(U-V,X,DU-DV):- deriva(U,X,DU), deriva(V,X,DV).
deriva(U*V,X,DU*V+U*DV):- deriva(U,X,DU), deriva(V,X,DV).
deriva(U/V,X,(DU*V+U*DV)/V^2):- deriva(U,X,DU), deriva(V,X,DV).

%Regla del polinomio
deriva(U^N,X,N*U^(N-1)*DU):-
				integer(N), atomic(N), N\==X,
				deriva(U,X,DU).

deriva(-V,X,-DV):- deriva(V,X,DV).

%Reglas exponencial y logaritmica
deriva(exp(V),X,exp(V)*DV):- deriva(V,X,DV).
deriva(ln(V),X,DV/V):- deriva(V,X,DV).
deriva(A^V,X,(A^V)*ln(A)*DV):-
			integer(A), atomic(A), A\==X,
			deriva(V,X,DV).

%Reglas trigonometricas
deriva(sin(W),X,Z*cos(W)):- deriva(W,X,Z).
deriva(cos(W),X,-Z*sin(W)):- deriva(W,X,Z).
deriva(tg(W),X,Z*sec(W)^2):- deriva(W,X,Z).
deriva(cotg(W),X,-Z*csc(W)^2):- deriva(W,X,Z).
deriva(sec(W),X,Z*sec(W)*tg(W)):- deriva(W,X,Z).
deriva(csc(W),X,-Z*csc(W)*cotg(W)):- deriva(W,X,Z).

deriva(arcsin(V),X,(1-V^2)^(-1/2)*DV):- deriva(V,X,DV).
deriva(arccos(V),X,-(1-V^2)^(-1/2)*DV):- deriva(V,X,DV).
deriva(arctg(V),X,(1+V^2)^(-1)*DV):- deriva(V,X,DV).
deriva(arccotg(V),X,-(1+V^2)^(-1)*DV):- deriva(V,X,DV).
deriva(arcsec(V),X,(V^2-1)^(-1/2)*DV):- deriva(V,X,DV).
deriva(arccsc(V),X,-(V^2-1)^(-1/2)*DV):- deriva(V,X,DV).

%Reglas hiperbolicas
deriva(sinh(W),X,Z*cosh(W)):- deriva(W,X,Z).
deriva(cosh(W),X,-Z*sinh(W)):- deriva(W,X,Z).
deriva(tgh(W),X,Z*sech(W)^2):- deriva(W,X,Z).
deriva(cotgh(W),X,-Z*csch(W)^2):- deriva(W,X,Z).
deriva(sech(W),X,Z*sech(W)*tgh(W)):- deriva(W,X,Z).
deriva(csch(W),X,-Z*csch(W)*cotgh(W)):- deriva(W,X,Z).

deriva(arcsinh(V),X,DV/(V^2+1)^(1/2)):- deriva(V,X,DV).
deriva(arccosh(V),X,DV/(V^2-1)^(1/2)):- deriva(V,X,DV).
deriva(arctgh(V),X,DV/(1-V^2)):- deriva(V,X,DV).
deriva(arccotgh(V),X,DV/(1+V^2)):- deriva(V,X,DV).
deriva(arcsech(V),X,-DV/((DV)*(-V^2+1)^(1/2))):- deriva(V,X,DV).
deriva(arccsch(V),X,-DV/((DV)*(V^2+1)^(1/2))):- deriva(V,X,DV).

%Reglas simples
deriva(X,X,1).
deriva(C,X,0):- atomic(C), C\==X.

%Funciones para simplificar

simplify(X+0,X).
simplify(1*X,X).
%simplify(X*0, 0).
%simplify(0*X,0).
simplify(X^1,X).
simplify(X^0,X/X).
simplify(X^A*X^B,X^C):- C is A+B.
simplify(X^A/X^B,X^C):- C is A-B.
simplify(X*(A+B),X*C):- C is A+B.
simplify(X*(A-B),X*C):- C is A-B.
simplify(A*(B*X),C*X):- C is A*B.
simplify(C, C) :- atom(C) ; number(C).
simplify((X),X).
simplify(X+Y, X1+Y1) :- simplify(X, X1), simplify(Y, Y1).
simplify(X*Y, X1*Y1) :- simplify(X, X1), simplify(Y, Y1).
simplify(X/Y, X1/Y1) :- simplify(X, X1), simplify(Y, Y1).
simplify(X-Y, X1-Y1) :- simplify(X, X1), simplify(Y, Y1).
simplify(X+Y, C) :- number(X), number(Y), C is X+Y.
simplify(X-Y, C) :- number(X), number(Y), C is X-Y.
simplify(X*Y, C) :- number(X), number(Y), C is X*Y.
simplify(X^Y, C) :- number(X), number(Y), C is X^Y.
simplify(X/Y, C) :- number(X), number(Y), C is X/Y.

derive(Expression,X,Result):- deriva =..[Expression,X,Result], call(simplify(deriva)).

/** <examples> Your example queries go here, e.g.
?- member(X, [cat, mouse]).
?- derive(sin(3*x^2+2),x,Result).
Result = 6*cos(3*x^2+2)*x
more solutions?
?- derive(x^3+2y-4,y,Result).
Result = 2
more solutions? No
?- _
*/
