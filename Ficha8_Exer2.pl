%LICENCIATURA EM ENGENHARIA INFORMATICA
%MESTRADO integrado EM ENGENHARIA INFORMATICA

%Inteligencia Artificial
%2022/23

%Draft Ficha 8


%biblioteca(id, nome, localidade)

biblioteca(1, uminhogeral, braga).
biblioteca(2, luciocracveiro, braga).
biblioteca(3, municipal, porto).
biblioteca(4, publica, viana).
biblioteca(5, ajuda, lisboa).
biblioteca(6, cidade, coimbra).


%livros( id, nome, biblioteca)

livros(1, gameofthrones, 1). 
livros(2, codigodavinci, 2).
livros(3, setimoselo, 1).
livros(4, fireblood, 4).
livros(5, harrypotter, 6).
livros(6, senhoradosneis, 7).
livros(7, oalgoritmomestre, 9).

%leitores(id, nome, genero)

leitores(1, pedro, m).
leitores(2, joao, m).
leitores(3, lucia, f).
leitores(4, sofia, f).
leitores(5, patricia, f).
leitores(6, diana, f).


%requisicoes(id_requisicao,id_leitor, id_livro, data(A,M,D)

requisicoes(1,2,3,data(2022,5,17)).
requisicoes(2,1,2,data(2022,7,10)).
requisicoes(3,1,3,data(2021,11,2)).
requisicoes(4,1,4,data(2022,2,1)).
requisicoes(5,5,3,data(2022,4,23)).
requisicoes(6,4,2,data(2021,3,9)).
requisicoes(7,4,1,data(2022,5,5)).
requisicoes(8,2,6,data(2021,7,18)).
requisicoes(9,5,7,data(2022,4,12)).


%devolucoes(id_requisicao, data(A,M, D))


devolucoes(2, data(2022, 7,26)).
devolucoes(4, data(2022,2,4)).
devolucoes(5, data(2022, 6, 13)).
devolucoes(1, data(2022, 5, 23)).
devolucoes(6, data(2022, 4, 9)).

%ex1

numLeitoresFem(N) :- findall(ID, leitores(ID,_,f), L), length(L,N).

feminino(N) :- findall(ID, leitores(ID,_,f), L), length(L,N).

dois(L) :- findall((LV,LT), (requisicoes(_,IDLT,IDLV,_),  livros(IDLV,LV,IDB), biblioteca(IDB,_,braga), leitores(IDLT,LT,_)), L).

tres(L) :- findall(LV, (requisicoes(_,IDLT,IDLV,_), livros(IDLV,LV,IDB), not(biblioteca(IDB,_,_))) ,L). 


quatroAux(LV) :- livros(IDLV,LV,_), not(requisicoes(_,_,IDLV,_)).

quatro(L) :- findall(LV,quatroAux(LV),L).

cinco(L) :- findall((LV,data(ANO,MES,DIA)), (requisicoes(_,_,IDLV,data(ANO,MES,DIA)), livros(IDLV,LV,_), ANO == 2022 )  , L).


%ex2
%livroNaoAssociadoBibliotecaRequisitado
livroNABR(L) :- requisicoes(_,_,IDL,_), livros(IDL, L, IDB), not(biblioteca(IDB,_,_)).
livrosNABR(LS) :- findall(L, livroNABR(L), LS).


%ex3
%livroLeitorRequisitadosBraga
livroLeitorRB(L,LT) :- requisicoes(_,IDLT,IDL,_), leitores(IDLT,LT,_), livros(IDL,L,IDB), biblioteca(IDB,_,braga).
livrosLeitoresRB(LS) :- findall((L,LT), livroLeitorRB(L,LT), LS).

%ex4
naoRequisitado(L) :- livros(IDL,L,_), not(requisicoes(_,_,IDL,_)).
naoRequisitados(L) :- findall(LV, naoRequisitado(LV), L).

%ex5
livroDataReq(LV,ANO,data(ANO,M,D)) :- livros(IDL,LV,_), requisicoes(_,_,IDL,data(ANO,M,D)). 
livrosDatasReq(ANO,L) :- findall((LV,DR), livroDataReq(LV,ANO,DR), L).

%ex6
reqLeitVerao(LT) :- leitores(IDLT,LT,_), requisicoes(_,IDLT,_,data(A,M,D)), M>6, M<10. 
reqLeitsVerao(L) :- findall(LT, reqLeitVerao(LT), L).

%ex7
dataDevAtras(A,M,D,A1,M1,D1) :- A>A1, !.
dataDevAtras(A,M,D,A1,M1,D1) :- M>M1, !.
dataDevAtras(A,M,D,A1,M1,D1) :- D-D1>15.
leitorDevAtras(LT) :- devolucoes(IDR,data(A,M,D)), requisicoes(IDR,IDLT,_,data(A1,M1,D1)), leitores(IDLT,LT,_), dataDevAtras(A,M,D,A1,M1,D1).

leitoresDevAtras(L) :- findall(LT,leitorDevAtras(LT),L).

