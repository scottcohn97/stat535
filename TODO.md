# Theory

### Initial Conditions / Framework

- Choose network topologies (small-world, fully-connected, random connections)
- Choose number of agents
- Choose number of rounds in each interaction
- Finalize payoff matrix

### Range / Granularity

- Choose starting distribution of wealth (via Gini), including Gini = 0 and Gini = 1
- How many MC Sims do we do?

### [Micro] Dynamics

- Choose list of strategies attributed to players
- Choose threshold for breaking a tie
- How do we connect starting wealth to threshold and tie maintanence behavior?

### Figures

- Show starting networks with associated gini
- Show ending networks with associated gini

### Interpreting Results

A `segregated group` is one that is connected and separated from another group.

- Initally, there is only 1 group 
    + when do we stop running? 
    + What does convergence look like?
    
- Is segregation behavior different for different levels of wealth inequality?
- How about levels of cooperative behavior?
- For the above, how do we measure this? 

# Wed Apr 1

### general

- visualization
- starting gini
    - and how to distribute wealth
    - constructor: given gini coeff -> construct pop with wealth distro
    - how to assign strategies (randomly)
    - maybe look at extreme cases
    - Scott find paper with most common "real" strategies

- network starts as complete graph
- threshold to break/maintain is average of proportional change in wealth ??
- strategies
    - random
    - always coop
    - always defect
    - add more later 
    
### What to measure

- how to analyze subgraphs
- gini of whole pop and connected components
    - what differentiates subgraphs ?

### file org

- game.py is source file
- separate files of indiv sim go in a new file / sub dir

