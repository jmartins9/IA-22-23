########################################################
# Creation date: 20/10/2022                            #
# Author: Joao Martins                                 #
# Last update: 21/10/2022                              #
########################################################
from node import Node
import networkx as nx
import matplotlib.pyplot as plt


class Graph:
    def __init__(self, directed=False):
        self.nodes = set()
        self.graph = dict()
        self.heuristic = dict()
        self.directed = directed

    def __str__(self):
        out = ""
        for key in self.graph.keys():
            out = out + "node " + str(key) + ": " + str(self.graph[key]) + "\n"
        return out

    # Add an edge to the graph
    def add_edge(self, node1, node2, weight):
        n1 = Node(node1)
        n2 = Node(node2)

        if n1 not in self.nodes:
            self.nodes.add(n1)
            self.graph[node1] = set()

        if n2 not in self.nodes:
            self.nodes.add(n2)
            self.graph[node2] = set()

        self.graph[node1].add((node2, weight))

        if not self.directed:
            self.graph[node2].add((node1, weight))

    # Get the weight of an edge
    def get_arc_cost(self, node1, node2):
        for (adjacent, weight) in self.graph[node1]:
            if adjacent == node2:
                return weight
        return None  # Edge not exist

    # Get the cost (sum of the weights of the edges) of a path
    def calculate_cost(self, path):
        cost = 0
        tam = len(path)
        i = 1
        while i < tam:
            cost = cost + self.get_arc_cost(path[i - 1], path[i])
            i = i + 1
        return cost

    # BFS search, returns path and the path cost
    def search_bfs(self, start, end):
        path = []
        visited = set()
        queue = []
        parent = dict()

        visited.add(start)
        queue.append(start)
        parent[start] = None

        if start == end:
            return path, 0

        while len(queue) != 0:
            node = queue.pop(0)
            for (adjacent, weight) in self.graph[node]:

                if adjacent == end:
                    parent[adjacent] = node
                    aux = adjacent
                    while aux is not None:
                        path.append(aux)
                        aux = parent[aux]

                    path.reverse()
                    return path, self.calculate_cost(path)

                if adjacent not in visited:
                    visited.add(adjacent)
                    parent[adjacent] = node
                    queue.append(adjacent)

        return None

    def search_dfs(self, start, end, path=None, visited=None):
        if path is None:
            path = []
        if visited is None:
            visited = set()

        visited.add(start)
        path.append(start)

        if start == end:
            return path, self.calculate_cost(path)

        for (adjacent, weight) in self.graph[start]:
            if adjacent not in visited:
                result = self.search_dfs(adjacent, end, path, visited)
                if result is not None:
                    return result

        path.pop()
        return None

    # Add heuristic to a node
    def add_heuristic(self, node, heuristic):
        if Node(node) in self.nodes:
            self.heuristic[node] = heuristic
            return True
        return False

    # Graph search with the Greedy algorithm
    def search_greedy(self, start, end):
        open_list = set()
        open_list.add(start)
        closed_list = set()
        parent = dict()
        parent[start] = None

        while len(open_list) > 0:
            n1 = None
            for n2 in open_list:
                if (n1 is None) or (self.heuristic[n2] < self.heuristic[n1]):
                    n1 = n2

            if n1 == end:
                n_aux = end
                path = []

                while n_aux is not None:
                    path.append(n_aux)
                    n_aux = parent[n_aux]

                path.reverse()
                return path, self.calculate_cost(path)

            for (adjacent, weight) in self.graph[n1]:
                if adjacent not in open_list and adjacent not in closed_list:
                    open_list.add(adjacent)
                    parent[adjacent] = n1

            open_list.remove(n1)
            closed_list.add(n1)

        return None

    # Graph search with the A* algorithm
    def search_star_a(self, start, end):
        open_list = set()
        open_list.add(start)
        closed_list = set()
        parent = dict()
        parent[start] = None
        cost = dict()
        cost[start] = 0

        while len(open_list) > 0:
            n1 = None
            for n2 in open_list:
                if (n1 is None) or (self.heuristic[n2] + cost[n2]) < (self.heuristic[n1] + cost[n1]):
                    n1 = n2

            if n1 == end:
                n_aux = end
                path = []

                while n_aux is not None:
                    path.append(n_aux)
                    n_aux = parent[n_aux]

                path.reverse()
                return path, self.calculate_cost(path)

            for (adjacent, weight) in self.graph[n1]:
                if adjacent not in open_list and adjacent not in closed_list:
                    open_list.add(adjacent)
                    parent[adjacent] = n1
                    cost[adjacent] = cost[n1] + weight

            open_list.remove(n1)
            closed_list.add(n1)
        return None

    def desenha(self):
        lista_v = self.nodes
        g = nx.Graph()
        for nodo in lista_v:
            n = nodo.get_name()
            g.add_node(n)
            for (adjacent, peso) in self.graph[n]:
                g.add_edge(n, adjacent, weight=peso)

        pos = nx.spring_layout(g)
        nx.draw_networkx(g, pos, with_labels=True, font_weight='bold')
        labels = nx.get_edge_attributes(g, 'weight')
        nx.draw_networkx_edge_labels(g, pos, edge_labels=labels)

        plt.draw()
        plt.show()
