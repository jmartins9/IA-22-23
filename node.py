########################################################
# Creation date: 20/10/2022                            #
# Author: Joao Martins                                 #
# Last update: 20/10/2022                              #
########################################################
class Node:

    def __init__(self, name):
        self.name = name

    def __str__(self):
        return "Node" + self.name

    def get_name(self):
        return self.name

    def __eq__(self, other):
        return self.name == other.name

    def __repr__(self):
        return "Node" + self.name

    def __hash__(self):
        return hash(self.name)

