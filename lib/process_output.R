#' Evol of wealth on networks
#' Scott Cohn
#' 2020-04-21
#' Process raw data to graph

library('tidyverse')

# Import 
gini_01 <- read.csv("g1.csv")
gini_03 <- read.csv("g3.csv")
gini_07 <- read.csv("g7.csv")
gini_09 <- read.csv("g9.csv")

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
g01p <- process.csv(gini_01)
write.csv(g01p, file = 'g01p.csv', row.names = TRUE)

g03p <- process.csv(gini_03)
write.csv(g03p, file = 'g03p.csv', row.names = TRUE)

g07p <- process.csv(gini_07)
write.csv(g07p, file = 'g07p.csv', row.names = TRUE)

g09p <- process.csv(gini_09)
write.csv(g09p, file = 'g09p.csv', row.names = TRUE)