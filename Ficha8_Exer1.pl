
aluno(1,joao,m).
aluno(2,antonio,m).
aluno(3,carlos,m).
aluno(4,luisa,f).
aluno(5,maria,f).
aluno(6,isabel,f).

curso(1,lei).
curso(2,miei).
curso(3,lcc).

%disciplina(cod,sigla,ano,curso)
disciplina(1,ed,2,1).
disciplina(2,ia,3,1).
disciplina(3,fp,1,2).

%inscrito(aluno,disciplina)
inscrito(1,1).
inscrito(1,2).
inscrito(5,3).
inscrito(5,5).
inscrito(2,5).

%nota(aluno,disciplina,nota)
nota(1,1,15).
nota(1,2,16).
nota(1,5,20).
nota(2,5,10).
nota(3,5,8).

%copia
copia(1,2).
copia(2,3).
copia(3,4).

%ex1
naoInscrito(NOME) :- aluno(ID,NOME,_), not(inscrito(ID,_)). 
naoInscritos(L) :-  findall(A, naoInscrito(A), L).

%ex2
naoInscrito2(N) :- aluno(ID,N,_) , (not(inscrito(ID,_)) ;(inscrito(ID,D), not(disciplina(D,_,_,_)))).
naoInscritos2(L) :- findall(A, naoInscrito2(A), L).

%ex3
notaAluno(A,N) :- aluno(ID,A,_), nota(ID,_,N).
media(A,M) :- findall(N, notaAluno(A,N), L), length(L,C), sum_list(L,S), M is S/C. 

%ex4
mediaGlobal(M) :- findall(N, nota(_,_,N), L), length(L,C), sum_list(L,S), M is S/C.
alunoAcimaMedia(A) :- notaAluno(A,_), mediaGlobal(M), media(A,N), N>M.
alunosAcimaMedia(L) :- setof(A, alunoAcimaMedia(A), L).


%ex5
alunosCopiaram(L) :- findall(A, (aluno(ID,A,_), copia(ID,_)) ,L).


%ex6
copiouIndiretamente(A) :- aluno(ID,A,_), copia(ID,ID2), aluno(ID2,A2,_), copia(ID2,_).
copiouIndiretamente(A) :- aluno(ID,A,_), copia(ID,ID2), aluno(ID2,A2,_), copiouIndiretamente(A2).

alunosCopiaram2(L) :- alunosCopiaram(L1), findall(A, copiouIndiretamente(A), L2), union(L1,L2,L3), list_to_set(L3,L). 

copiou(A1,A2) :- aluno(ID1,A1,_), aluno(ID2,A2,_), copia(ID1,ID2).
copiou(A1,A2) :- aluno(ID1,A1,_), copia(ID1,ID), aluno(ID,A,_), copiou(A,A2).

alunosCopiaramPorAluno(A,L) :- findall(AL, copiou(AL,A),L).


%ex7
mapToNome([],[]).
mapToNome([H|T],L) :- mapToNome(T,L), not(aluno(H,_,_)).
mapToNome([H|T],[A|L1]) :- mapToNome(T,L1), aluno(H,A,_).  



mapToNome1([],[]).
mapToNome1([H|T],L) :- not(aluno(H,A,_)), mapToNome1(T,L).
mapToNome1([H|T],[A|L]) :- aluno(H,A,_), mapToNome1(T,L).



