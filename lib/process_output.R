#' Evol of wealth on networks
#' Scott Cohn
#' 2020-04-21
#' Process raw data to graph

library('tidyverse')

# Import 

# standard treatment --- uniform strat distro
gini_01_std <- read_csv("output/g1_std.csv")
gini_03_std <- read_csv("output/g3_std.csv")
gini_07_std <- read_csv("output/g7_std.csv")
gini_09_std <- read_csv("output/g9_std.csv")

# high coop 1 - 3
gini_01_hc1 <- read_csv("output/g1_hc1.csv")
gini_03_hc1 <- read_csv("output/g3_hc1.csv")
gini_07_hc1 <- read_csv("output/g7_hc1.csv")
gini_09_hc1 <- read_csv("output/g9_hc1.csv")

gini_01_hc2 <- read_csv("output/g1_hc2.csv")
gini_03_hc2 <- read_csv("output/g3_hc2.csv")
gini_07_hc2 <- read_csv("output/g7_hc2.csv")
gini_09_hc2 <- read_csv("output/g9_hc2.csv")

gini_01_hc3 <- read_csv("output/g1_hc3.csv")
gini_03_hc3 <- read_csv("output/g3_hc3.csv")
gini_07_hc3 <- read_csv("output/g7_hc3.csv")
gini_09_hc3 <- read_csv("output/g9_hc3.csv")

# Process func
process.csv <- function(df){
  # Gather
  df <- df %>%
    gather(key = "round", value = "assets", 3:28)
  
  # Change a_n to round n 
  df$round <- as.numeric(sapply(strsplit(df$round, "_"), "[[", 2))
  
  return(df)
}

# Process and write to csv
g01p_std <- process.csv(gini_01_std)
write_csv(g01p_std, path = 'output/g01p_std.csv')

g03p_std <- process.csv(gini_03_std)
write_csv(g03p_std, path = 'output/g03p_std.csv')

g07p_std <- process.csv(gini_07_std)
write_csv(g07p_std, path = 'output/g07p_std.csv')

g09p_std <- process.csv(gini_09_std)
write_csv(g09p_std, path = 'output/g09p_std.csv')
# 
g01_hc1p <- process.csv(gini_01_hc1)
write_csv(g01_hc1p, path = 'output/g01_hc1p.csv')

g03_hc1p <- process.csv(gini_03_hc1)
write_csv(g03_hc1p, path = 'output/g03_hc1p.csv')

g07_hc1p <- process.csv(gini_07_hc1)
write_csv(g07_hc1p, path = 'output/g07_hc1p.csv')

g09_hc1p <- process.csv(gini_09_hc1)
write_csv(g09_hc1p, path = 'output/g09_hc1p.csv')
#
g01_hc2p <- process.csv(gini_01_hc2)
write_csv(g01_hc2p, path = 'output/g01_hc2p.csv')

g03_hc2p <- process.csv(gini_03_hc2)
write_csv(g03_hc2p, path = 'output/g03_hc2p.csv')

g07_hc2p <- process.csv(gini_07_hc2)
write_csv(g07_hc2p, path = 'output/g07_hc2p.csv')

g09_hc2p <- process.csv(gini_09_hc2)
write_csv(g09_hc2p, path = 'output/g09_hc2p.csv')
#
g01_hc3p <- process.csv(gini_01_hc3)
write_csv(g01_hc3p, path = 'output/g01_hc3p.csv')

g03_hc3p <- process.csv(gini_03_hc3)
write_csv(g03_hc3p, path = 'output/g03_hc3p.csv')

g07_hc3p <- process.csv(gini_07_hc3)
write_csv(g07_hc3p, path = 'output/g07_hc3p.csv')

g09_hc3p <- process.csv(gini_09_hc3)
write_csv(g09_hc3p, path = 'output/g09_hc3p.csv')