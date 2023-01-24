soma(X, Y, Z, R) :- R is X+Y+Z.

soma([], 0).
soma([H|T], R) :- soma(T, R1), R is R1+H.

max(X, Y, X) :- X>Y, !.
max(X, Y, Y).

max([X], X).
max([H|T], X) :- max(T, X1), max(H, X1, X).

tamL([], 0).
tamL([_|T], C) :- tamL(T, C1), C is C1+1. 

media(L, M) :- soma(L, R), tamL(L, C), M is R/C.

par(X) :- X1 is X mod 2, X1 == 0.

insereOrdL(X, [], [X]).
insereOrdL(X, [H|T], [X,H|T]) :- X<H, !.
insereOrdL(X, [H|R], [H|R1]) :- insereOrdL(X,R,R1).

ordenaL([],[]).  
ordenaL([H|T], L2) :- ordenaL(T,L1), insereOrdL(H, L1, L2).

pertenceL(X,[X|T]).
pertenceL(X,[H|T]) :- pertenceL(X,T).

diferentesL([],0).
diferentesL([X],1).
diferentesL([H|T],N) :- diferentesL(T,N1), not(pertenceL(H,T)), N is N1+1.
diferentesL([H|T],N) :- diferentesL(T,N), pertenceL(H,T).

apagaPrimOcorrL(_,[],[]).
apagaPrimOcorrL(X,[X|T],T).
apagaPrimOcorrL(X,[H|T],[H|L]) :- apagaPrimOcorrL(X,T,L).

apagaTodasOcorrL(_,[],[]).
apagaTodasOcorrL(X,[X|T],L) :- apagaTodasOcorrL(X,T,L).
apagaTodasOcorrL(X,[H|T],[H|L]) :- apagaTodasOcorrL(X,T,L).

insereElemSemRepL(X,[],[X]).
insereElemSemRepL(X,[X|T],[X|T]).
insereElemSemRepL(X,[H|T],[H|L]) :-  insereElemSemRepL(X,T,L).

concatenarL(L,[],L).
concatenarL([],L,L).
concatenarL([H|T],L,[H|L1]) :- concatenarL(T,L,L1).

insereElemFimL(X,[],[X]).
insereElemFimL(X,[H|T],[H|L]) :- insereElemFimL(X,T,L).

inverterL([],[]).
inverterL([X],[X]).
inverterL([H|T],L1) :- inverterL(T,L), insereElemFimL(H,L,L1).

subL(X,[X]).
subL(X,[X|T]).
subL(X,[H|T]) :- subL(X,T).








