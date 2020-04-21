#' Evol of wealth on networks
#' Scott Cohn
#' 2020-04-20

library('tidyverse')

gini_01  <- read.csv("output/g1.csv")
# gini_02  <- read.csv("output/g1.csv")
# gini_07  <- read.csv("output/g7.csv")
# gini_09  <- read.csv("output/g9.csv")

gini_01 %>%
    unnest(assets = str_split(assets, ",")) %>%
    group_by(strategies) %>%
    ggplot()


# How to unpack np array in df ?
