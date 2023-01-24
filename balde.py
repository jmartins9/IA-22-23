# Problema dos baldes
# dois baldes  a-> 4 litros e b -> 3 litros
# começar do estado (0,0)  e chegar a (2,0)
# estados possiveis-> tuplos com qualquer combinaçao (x,y) pertencendo  x e y {0,1,2,3,4}

# ações
# encher totalmente um balde
# esvaziar totalmente um balde
# despejar um balde no outro ate que o ultimo fique cheio
# despejar um balde no outro ate que o primeiro fique vazio


# Utilizar a classe grafo para resolver o problema
# Necessário modelar o problema como um grafo


from graph import Graph


class Balde():

    # start deve ser a capacidade dos dois baldes no inicio ex (0,0) "estado inicial"
    # goal deve ser o objectivo ex (2,0).  " estado final"
    # os estados são representados por "(x,y)" como string, em que x e y representam
    # as quantidades de agua nos jarros

    def __init__(self, start="(0,0)", goal="(2,0)", cap1=4, cap2=3):
        self.g = Graph(directed=True)
        self.start = start
        self.goal = goal
        self.balde1 = cap1  # capacidade do balde 1
        self.balde2 = cap2  # capacidade do balde 2

    # Partindo do estado inicial, utilizando as ações possíveis como transições
    # construir o grafo
    def cria_grafo(self):
        states = []
        states.append(self.start)
        visitados = []
        visitados.append(self.start)

        while len(states) > 0:
            state = states.pop()
            result_states = self.expande(state)

            for st in result_states:
                if st not in visitados:
                    states.append(st)
                    visitados.append(state)
                self.g.add_edge(state, st, 1)


    # Dado um estado, expande para outros mediante as açoes possiveis
    def expande(self, estado):
        states = []

        cap1 = int(estado[1])
        cap2 = int(estado[3])

        if cap1 > 0:
            states.append(self.esvazia1(estado))
        if cap2 > 0:
            states.append(self.esvazia2(estado))
        if cap1 < self.balde1:
            states.append(self.enche1(estado))
        if cap2 < self.balde2:
            states.append(self.enche2(estado))
        if cap1 < self.balde1 and cap2 > 0:
            states.append(self.despeja21(estado))
        if cap2 < self.balde2 and cap1 > 0:
            states.append(self.despeja12(estado))

        return states

    # Devolve o estado resultante de esvaziar o primeiro balde
    def esvazia1(self, nodo):
        return "(0," + nodo[3] + ")"

    # Devolve o estado resultante de esvaziar o segundo balde
    def esvazia2(self, nodo):
        return "(" + nodo[1] + ",0)"

    # Devolve o estado resultante de encher totalmente o primeiro balde da torneira
    def enche1(self, nodo):
        return "(" + str(self.balde1) + "," + nodo[3] + ")"

    # Devolve o estado resultante de encher totalmente o segundo balde da torneira
    def enche2(self, nodo):
        return "(" + nodo[1] + "," + str(self.balde2) + ")"

    # Devolve o estado resultante de despejar o balde 1 no balde 2
    def despeja12(self, nodo):
        cap1n = int(nodo[1])
        cap2n = int(nodo[3])

        if cap1n + cap2n <= self.balde2:
            return "(0," + str(cap1n + cap2n) + ")"
        else:
            ft = self.balde2 - cap2n
            return "(" + str(cap1n - ft) + "," + str(self.balde2) + ")"

    # Devolve o estado resultante de despejar o balde 2 no balde 1
    def despeja21(self, nodo):
        cap1n = int(nodo[1])
        cap2n = int(nodo[3])

        if cap1n + cap2n <= self.balde1:
            return "(" + str(cap1n + cap2n) + ",0)"
        else:
            ft = self.balde1 - cap1n
            return "(" + str(self.balde1) + "," + str(cap2n - ft) + ")"


    # Encontra a solução utilizando DFS (recorre à classe grafo e node implementada antes
    def solucaoDFS(self,start,goal):
        return self.g.search_dfs(start,goal)
        # To do...

    # Encontra a solução utilizando BFS (recorre à classe grafo e node implementada antes
    def solucaoBFS(self,start,goal):
        return self.g.search_bfs(start,goal)


    """
    # Greedy - necessita de heuristica
    def solucaoGreedy(self,start, goal):
        return self.g.greedy(start,goal)

    # A* - necessita de heuristica
    def solucaoAStar(self, start, goal):
        
        # To do...

    # Outra solução - procura caminho à medida que constrói o grafo
    def encontraDFS(self,start,end, visitados=[], caminho=[]):
        
        # To do...

    ##################################################################################
    # Dados dois estados e1 e e2, devolve a ação que origina a transição de e1 para e2
    ##################################################################################
    def mostraA(self,e1,e2):
        
        # To do...

    ########################################################
    # Imprimir sequência de ações para um caminho encontrado
    ########################################################
    def imprimeA(self,caminho):
        
        # To do...

"""
