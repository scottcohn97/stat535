#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Mar 27 14:16:02 2020

Classes that are useful for a simulation of the game

@author: liwenouyang
"""

from scipy import special
import networkx as nx 
import random 
import numpy as np


def naive(a,b,w):
        """A naive way to calculate the probability of breaking ties given two players's gain a, b and average global gain:
            If both above average, the pobability of breaking tie is low: 0.1
            If both below average, a high probability of breaking tie: 0.9
            Otherwise 50/50 chance 
            """
        if a >= w and b >= w:
            return 0.01
        elif a < w and b < w:
            return 0.99
        else:
            return 0.5
            

def deterministic(a,b,w):
        """deterministic tie breaking
            """
        if a >= w and b >= w:
            return 0
        else:
            return 1
    

class Game:
    """A class representing a single state of the game we try to simulate"""
    def __init__(self,numAgent,Gini,para = 10,prob =[0.25,0.25,0.25,0.25],distr = 'lognormal'):
        """Constructor
        
        Args: 
        numAgent: the number of agents 
        Gini: the initial gini coefficient
        para: parameter depending on distribution chosen for initial wealth distribution. 
                 If lognormal, para = mu. If expontential, para = lambda. If uniform, para= a.
        prob: the probability of an agent getting certain strategy, defaulted to be equally likely
        distr: lognormal, exp, uni
        """
        assert distr in ['lognormal','exp','uni'], "invalid distribution"
        assert numAgent >= 1
        wealth = []
        if distr == 'lognormal':
            sig = special.erfinv(Gini) * 2
            for i in range(numAgent):
                wealth.append(int(random.lognormvariate(para, sig)))
        if distr == 'exp':
            for i in range(numAgent):
                wealth.append(int(random.expovariate(para)))
        if distr == 'uni':
            b = (3*Gini+1)/(1 - 3*Gini)
            for i in range(numAgent):
                wealth.append(int(random.uniform(para, b)))
        g = nx.complete_graph(numAgent)
        for i in range(numAgent):
            strats = ['coop','defect','random','tft']
            g.nodes[i]['player'] = Player(i,a = [wealth[i]],s = np.random.choice(strats,p = prob))
        self.network = g
        self.players = nx.get_node_attributes(g,'player')
        
    def wealth_distr(self,numRound,strat = ''):
        """return the wealth of agents as a list for given round and agent population"""
        assert numRound < len(self.players[0].asset), 'invalid round number'
        wealth = []
        if strat == '':
            for p in self.players.values():
                wealth.append(p.asset[numRound])
        else:
            for p in self.players.values():
                if p.strat == strat:
                    wealth.append(p.asset[numRound])
        return wealth 
    
        
    def individualWealth(self,id):
        """return the asset of an individual agent"""
        return self.players[id].asset
        
    def gini(self,numRound,strat =''):
        "calculate the current gini using the method provided by literature provided in the report"
        y = self.wealth_distr(numRound,strat)
        D = 0
        n = len(y)
        for i in range(n-1):
            for j in range(i+1,n):
                D += abs(y[i] - y[j])
        return D* n/(n*(n-1)*sum(y))
    
    
    def succ(self,f = naive):  #successor  
        """Given a current game state and a function f , return the game state of next round 
        Args:
            f(a,b,w): a function that takes in three numbers and returns a number in [0,1] as the probability of breaking tie.
            where a is the gain of player A, and b is the gain of player B. w is the average gain of this round. 
        """
        totalgain = 0
        
        for e in list(self.network.edges):
            a = self.players[e[0]]
            b = self.players[e[1]]
            M  = Matrix(a,b)
            P = M.payoff()
            a.gain += P[a.id]
            b.gain += P[b.id]
        
        for a in self.players.values():
            a.asset.append(a.asset[-1]+a.gain)
            totalgain += a.gain

        
        
        avg = totalgain/ len(self.players)
        for e in list(self.network.edges):
            a = self.players[e[0]]
            b = self.players[e[1]]
            pob = f(a.gain,b.gain,avg)
            choice = np.random.choice(['b','m'],p = [pob, 1-pob])
            if choice == 'b':
                self.network.remove_edge(e[0], e[1])
       
        for n in self.players.values():
            n.gain = 0
            # Reset gain for next round 
        
        return self
    
    def sim(self,numRounds,breakTie = naive):
        """run simulation a given number of rounds with a given tie breaking mechanism"""
        for i in range(numRounds):
            self.succ(breakTie)
        return self 
    
    def toImage(self):
        """plot the connected graph that represents the current state
        red: coop
        blue: defect
        yellow: random
        green: tft
        The size of a node corresponds to realtive wealth of the agent in the connected component
        """
        label = []
        color =['r','b','y','g']
        s =['coop','defect','random','tft']
        size = []
        np = len(self.players)
        nlist = list(max(nx.connected_components(self.network), key=len))
        for i in nlist:
            label.append(color[s.index(self.players[i].strat)])
            size.append(self.wealth_distr(-1)[i])
        a = max(size)
        size = list(map(lambda x: x/a*280,self.wealth_distr(-1)))
        nx.draw(self.network,nodelist = nlist,node_size =size,node_color = label,width=1 - len(nlist)/np+0.1)
    
    



class Player:
    """A player class that represents every single player with their strategy as str, current assets as int, and the actions taken as a list"""
    def __init__(self,ID,a =[], s = 'random'):
        self.id = ID
        self.acts = {}
        self.asset = a #change this to list to record the history of wealth
        self.strat = s
        self.gain = 0
        
    def takeAct(self,opponent,C = ('E', 'L')):
        """Given an opponent and two choices as C, get the action based on the strategy, and update Actions taken"""
        if self.strat == 'random':
            a = random.choice(C)
        if self.strat == 'coop':
            a = C[0]
        if self.strat == 'defect':
            a = C[1]
        if self.strat =='tft':
            if opponent.id not in self.acts:
                a = C[0]
            else:
                a = opponent.acts[self.id][-1]
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
  

        