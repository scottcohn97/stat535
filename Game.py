#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Mar 27 14:16:02 2020

Classes that are useful for a simulation of the game

@author: liwenouyang
"""


import networkx as nx 
import random 

class Game:
    """A class representing a single state of the game we try to simulate"""
    def __init__(self,G):
        """Constructor
        
        Args: G, a preprocessed graph with node attributes set as player class defined below
              M, payoff matrix  class definded below
        """
        self.network = G
        self.players = nx.get_node_attributes(G,'player')
        
    def threshold(self, f = lambda x: sum(x)/len(x)):
        """calculate threshold for breaking ties based on the current state base on a function f, which is defaulted to be mean"""
        ass = [] # not intended, you know the hardest thing in programming is naming your variables :)
        for p in self.players.values():
            ass.append(p.asset)
        return f(ass)
    
    def succ(self):  #successor 
        """Given a current game state, return the game state of next round"""
                        
        for e in list(self.network.edges):
            a = self.players[e[0]]
            b = self.players[e[1]]
            M  = Matrix(a,b)
            P = M.payoff()
            a.asset += P[a.id]
            b.asset += P[b.id]
        
        def breakTie(a,b):
            """Given a,b as players, returns true if a want to break tie with b or the other way around"""
            return not(a.asset >= self.threshold() and b.asset >= self.threshold())
        
        
        for e in list(self.network.edges):
            a = self.players[e[0]]
            b = self.players[e[1]]
            if breakTie(a, b):
                self.network.remove_edge(e[0],e[1])
        
        return self
    
    def toImage(self):
        """plot the graph that represents the current state"""
        pass
    
    def assets(self):
        """return a dictionary that contains the assets every agent possess in the current state"""
        pass
    
    def distr(self):
        """plot the distribution of assets of the current state"""
        pass

class Player:
    """A player class that represents every single player with their strategy as str, current assets as int, and the actions taken as a list"""
    def __init__(self,ID,a = 0, s = 'random'):
        self.id = ID
        self.acts = {}
        self.asset = a
        self.strat = s
    #A note: if define constructor as init(self,ID, A=[],a=0,s = 'r'), p1 and p2 will be updated simultaneously when calling takeAct. 
    def takeAct(self,opponent,C = ('E', 'L')):
        """Given an opponent and two choices as C, get the action based on the strategy, and update Actions taken"""
        if self.strat == 'random':
            a = random.choice(C)
        if self.strat == 'coop':
            a = C[0]
        if self.strat == 'defect':
            a = C[1]
        # Only implemented 3 easy strategies thus far, will add more
        if opponent.id in self.acts:
            self.acts[opponent.id].append(a)
        else:
            self.acts[opponent.id] = [a]
        return a
    

class Matrix:
    """"A helper class that gives corresponding payoffs for two player"""
    def __init__(self,p1,p2,c1 = 'E',c2 = 'L'):
        self.player1 = p1
        self.player2 = p2
        self.c1 = c1
        self.c2 = c2
        
    def payoff(self):
        """returns a dict for payoffs based on the actions p1 and p2 take"""
        p1 = self.player1.id 
        p2 = self.player2.id 
        C = (self.c1,self.c2)
        a1 = self.player1.takeAct(self.player2,C)
        a2 = self.player2.takeAct(self.player1,C)
        if a1 == self.c1 and a2 ==self.c1:
            return {p1:4,p2:4}
        if a1 == self.c1 and a2 == self.c2:
            return {p1:0, p2: 6}
        if a1 == self.c2 and a2 == self.c1:
            return {p1:6, p2: 0}
        if a1 == self.c2 and a2 == self.c2:
            return {p1:2, p2: 2}
    
  


testNet = nx.Graph()
for i in [1,2,3]:
    testNet.add_node(i, player = Player(i))
testNet.add_edges_from([(1,2),(2,3),(1,3)])
g = Game(testNet)
g1 = g.succ().succ() #A test case for two rounds 
