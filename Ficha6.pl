filho( joao, jose).
filho( jose, manuel).
filho( carlos, jose).
pai( paulo, filipe).
pai( paulo, maria).
avo( antonio, nadia).
neto( nuno, ana).
sexo( joao, masculino).
sexo( jose, maculino).
sexo( maria, feminino).
sexo( joana, feminino).

% -------------- Regras ------------------
pai( P, F) :- filho( F, P).

avo( A, N) :- filho( N, X), pai( A, X).

neto( N, A) :- avo(A, N).

descendente( X, Y) :- filho( X, Y).
descendente( X, Y) :- filho( X, N), descendente( N, Y).
				
grau(X, Y, 1) :- filho( X, Y).
grau(X, Y, Z) :- filho( X, N), grau( N, Y, G), Z is G+1.

avo( A, N) :- grau( N, A, 2).

bisavo( X, Y) :- grau(Y, X, 3).

trisavo( X, Y) :- grau( Y, X, 4).

tetraneto( X, Y) :- grau(X, Y, 4).


