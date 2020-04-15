#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on 2020-04-15 18:39

Some misc. functions for exploring the simulation

@author: Scott Cohn
"""

import matplotlib.pyplot as plt
import pandas as pd

from Game import *

def strat_distribution(g, numAgents):
    """
    Plot strategy distribution for a game instance
    """
    strat_distro = {"coop" : 0, "defect" : 0, "random" : 0} # [coop, defect, random]

    for i in range(numAgents):
        if g.players[i].strat == "coop":
            strat_distro["coop"] += 1
        elif g.players[i].strat == "defect":
            strat_distro["defect"] += 1
        else:
            strat_distro["random"] += 1

    print(f"Cooperate: {strat_distro.get('coop')} Defect: {strat_distro.get('defect')} Random: {strat_distro.get('random')}")

    x = strat_distro.keys()
    y = strat_distro.values()

    return(plt.bar(x, y))

def game_df(g, numAgents):
    """
    Takes a game instance and creates a pandas df of id, strat, assets
    """
    id = []
    strat = []
    assets = []

    for i in range(numAgents):
        id.append(g.players[i].id)
        strat.append(g.players[i].strat)
        assets.append(g.players[i].asset)

    df = pd.DataFrame({"id" : id, "strategies" : strat, "assets" : assets})

    return df

def strat_plot(g, numAgents):
    df = game_df(g, numAgents)

    groups = df.groupby("id")
    for strategies, assets in groups:
        plt.plot(df["strategies"], df["assets"], marker="o", color = 'g', linestyle="", label=id)

def sim(g, N):
    """
    Runs simulation N times
    N is num sims
    g is game
    """
    for _ in range(N):
        g = g.succ()
   
    return g