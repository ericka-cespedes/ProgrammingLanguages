% Student exercise profile
:- set_prolog_flag(occurs_check, error).        % disallow cyclic terms
:- set_prolog_stack(global, limit(8 000 000)).  % limit term space (8Mb)
:- set_prolog_stack(local,  limit(2 000 000)).  % limit environment space
% Your program goes here
% Reglas
derive(U+V,X,DU+DV):- derive(U,X,DU), derive(V,X,DV).
derive(U-V,X,DU-DV):- derive(U,X,DU), derive(V,X,DV).
derive(U*V,X,DU*V+U*DV):- derive(U,X,DU), derive(V,X,DV).
derive(U/V,X,(DU*V+U*DV)/V^2):- derive(U,X,DU), derive(V,X,DV).

%Regla del polinomio
derive(U^N,X,N*U^(N-1)*DU):-
                integer(N), atomic(N), N\==X,
                derive(U,X,DU).

derive(-V,X,-DV):- derive(V,X,DV).

%Reglas exponencial y logaritmica
derive(exp(V),X,exp(V)*DV):- derive(V,X,DV).
derive(ln(V),X,DV/V):- derive(V,X,DV).
derive(A^V,X,(A^V)*ln(A)*DV):-
            integer(A), atomic(A), A\==X,
            derive(V,X,DV).

%Reglas trigonometricas
derive(sin(W),X,Z*cos(W)):- derive(W,X,Z).
derive(cos(W),X,-Z*sin(W)):- derive(W,X,Z).
derive(tg(W),X,Z*sec(W)^2):- derive(W,X,Z).
derive(cotg(W),X,-Z*csc(W)^2):- derive(W,X,Z).
derive(sec(W),X,Z*sec(W)*tg(W)):- derive(W,X,Z).
derive(csc(W),X,-Z*csc(W)*cotg(W)):- derive(W,X,Z).

derive(arcsin(V),X,(1-V^2)^(-1/2)*DV):- derive(V,X,DV).
derive(arccos(V),X,-(1-V^2)^(-1/2)*DV):- derive(V,X,DV).
derive(arctg(V),X,(1+V^2)^(-1)*DV):- derive(V,X,DV).
derive(arccotg(V),X,-(1+V^2)^(-1)*DV):- derive(V,X,DV).
derive(arcsec(V),X,(V^2-1)^(-1/2)*DV):- derive(V,X,DV).
derive(arccsc(V),X,-(V^2-1)^(-1/2)*DV):- derive(V,X,DV).

%Reglas hiperbolicas
derive(sinh(W),X,Z*cosh(W)):- derive(W,X,Z).
derive(cosh(W),X,-Z*sinh(W)):- derive(W,X,Z).
derive(tgh(W),X,Z*sech(W)^2):- derive(W,X,Z).
derive(cotgh(W),X,-Z*csch(W)^2):- derive(W,X,Z).
derive(sech(W),X,Z*sech(W)*tgh(W)):- derive(W,X,Z).
derive(csch(W),X,-Z*csch(W)*cotgh(W)):- derive(W,X,Z).

derive(arcsinh(V),X,DV/(V^2+1)^(1/2)):- derive(V,X,DV).
derive(arccosh(V),X,DV/(V^2-1)^(1/2)):- derive(V,X,DV).
derive(arctgh(V),X,DV/(1-V^2)):- derive(V,X,DV).
derive(arccotgh(V),X,DV/(1+V^2)):- derive(V,X,DV).
derive(arcsech(V),X,-DV/((DV)*(-V^2+1)^(1/2))):- derive(V,X,DV).
derive(arccsch(V),X,-DV/((DV)*(V^2+1)^(1/2))):- derive(V,X,DV).

%Reglas simples
derive(X,X,1).
derive(C,X,0):- atomic(C), C\==X.

%Funciones para simplificar

simplify(X+0,X).
simplify(1*X,X).
simplify(X^1,X).
simplify(X^0,X/X).
simplify(X^A*X^B,X^C):- C is A+B.
simplify(X^A/X^B,X^C):- C is A-B.
simplify(X*(A+B),X*C):- C is A+B.
simplify(X*(A-B),X*C):- C is A-B.

/** <examples> Your example queries go here, e.g.
?- member(X, [cat, mouse]).
?- derive(sin(3*x^2+2,x,Result).
Result = 6*cos(3*x^2+2)*x
more solutions?
?- derive(x^3+2y-4,y,Result).
Result = 2
more solutions? No
?- _
*/