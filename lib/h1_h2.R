#' Evol of wealth on networks
#' Scott Cohn
#' 2020-04-20
#' stdev of results

library('tidyverse')

# Import
g01p_std <- read_csv("output/g01p_std.csv")
g03p_std <- read_csv("output/g03p_std.csv")
g07p_std <- read_csv("output/g07p_std.csv")
g09p_std <- read_csv("output/g09p_std.csv")

g01_hc1p <- read_csv("output/g01_hc1p.csv")
g03_hc1p <- read_csv("output/g03_hc1p.csv")
g07_hc1p <- read_csv("output/g07_hc1p.csv")
g09_hc1p <- read_csv("output/g09_hc1p.csv")

g01_hc2p <- read_csv("output/g01_hc2p.csv")
g03_hc2p <- read_csv("output/g03_hc2p.csv")
g07_hc2p <- read_csv("output/g07_hc2p.csv")
g09_hc2p <- read_csv("output/g09_hc2p.csv")

g01_hc3p <- read_csv("output/g01_hc3p.csv")
g03_hc3p <- read_csv("output/g03_hc3p.csv")
g07_hc3p <- read_csv("output/g07_hc3p.csv")
g09_hc3p <- read_csv("output/g09_hc3p.csv")

# init empty tibble
df_master <- tibble(
  "treatment" = "",
  "mean" = NA,
  "stdev" = NA
)

# Func
end_distro <- function(df, df_master, tx){
  # Args: dataframe
  # Returns final round mean and stdev of assets
  
  # filter to only last round
  df <- df %>% filter(round == max(df$round)) 
  
  # return mean and stdev + add_row to master
  df_master <- df_master %>% 
    add_row(
      treatment = tx, 
      mean = mean(df[["assets"]]),
      stdev = sd(df[["assets"]])            
            )
  return(df_master)
}

df_master <- end_distro(g01p_std, df_master, "g01_std") 
df_master <- end_distro(g03p_std, df_master, "g03_std") 
df_master <- end_distro(g07p_std, df_master, "g07_std") 
df_master <- end_distro(g09p_std, df_master, "g09_std") 

df_master <- end_distro(g01_hc1p, df_master, "g01_hc1") 
df_master <- end_distro(g03_hc1p, df_master, "g03_hc1") 
df_master <- end_distro(g07_hc1p, df_master, "g07_hc1") 
df_master <- end_distro(g09_hc1p, df_master, "g09_hc1")

df_master <- end_distro(g01_hc2p, df_master, "g01_hc2") 
df_master <- end_distro(g03_hc2p, df_master, "g03_hc2") 
df_master <- end_distro(g07_hc2p, df_master, "g07_hc2") 
df_master <- end_distro(g09_hc2p, df_master, "g09_hc2") 

df_master <- end_distro(g01_hc3p, df_master, "g01_hc3") 
df_master <- end_distro(g03_hc3p, df_master, "g03_hc3") 
df_master <- end_distro(g07_hc3p, df_master, "g07_hc3") 
df_master <- end_distro(g09_hc3p, df_master, "g09_hc3") 

# remove blank row
df_master <- df_master[-1, ]

# write to csv
write_csv(df_master, path = 'output/fin_round_mean_stdv.csv')

df_master %>% ggplot(aes(x = stdev, y = mean, label = treatment)) + 
  geom_text(check_overlap = TRUE, size = 5, vjust = "inward", hjust = "inward") +
  ggsci::scale_color_d3() +
  theme_pubr(base_size = 14, legend = "bottom") +
  xlab("Standard Deviation") + 
  ylab("Mean") +
  grids(axis = "xy", linetype = "dotted", color = "#a9a9a9") +
  theme(text = element_text(family = "LM Roman 10", size = 19),
        axis.text = element_text(size = 16),
        axis.title = element_text(size = 19),
        panel.grid.minor = element_blank(),
        plot.margin = margin(5, 20, 5, 8))

# top 10 by stdev
df_master %>% 
  arrange(desc(stdev)) %>% 
  slice(1:10)

# top 10 by mean
df_master %>% 
  arrange(desc(mean)) %>% 
  slice(1:10)
