#' Evol of wealth on networks
#' Scott Cohn
#' 2020-04-20
#' Graph processed data

library('tidyverse')
library('ggsci')
library('extrafont')
library('ggpubr')

# run once at start
# font_import(pattern = "lmroman10-regular-webfont") 

# Import
g01p <- read_csv("output/g01p.csv")
g03p <- read_csv("output/g03p.csv")
g07p <- read_csv("output/g07p.csv")
g09p <- read_csv("output/g09p.csv")

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

# Func
asset.plot <- function(df){
    p <- df %>%
        group_by(strategies) %>%
        ggplot(aes(x = round, y = assets, color = strategies)) + 
        geom_point() + 
        ggsci::scale_color_d3() +
        theme_pubr(base_size = 14, legend = "right") +
        xlab("Round") + 
        ylab("Assets") +
        labs(color = "Strategies") +
        grids(axis = "xy", linetype = "dotted", color = "#a9a9a9") +
        theme(text = element_text(family = "LM Roman 10", size = 19),
              # text = element_text(size = 19),
              axis.text = element_text(size = 16),
              axis.title = element_text(size = 19),
              panel.grid.minor = element_blank(),
              plot.margin = margin(5, 20, 5, 8))
    
    return(p)
}

# Plot
p01 <- asset.plot(g01p)
p03 <- asset.plot(g03p)
p07 <- asset.plot(g07p)
p09 <- asset.plot(g09p)

p01_hc1 <- asset.plot(g01_hc1p)
p03_hc1 <- asset.plot(g03_hc1p)
p07_hc1 <- asset.plot(g07_hc1p)
p09_hc1 <- asset.plot(g09_hc1p)

p01_hc2 <- asset.plot(g01_hc2p)
p03_hc2 <- asset.plot(g03_hc2p)
p07_hc2 <- asset.plot(g07_hc2p)
p09_hc2 <- asset.plot(g09_hc2p)

p01_hc3 <- asset.plot(g01_hc3p)
p03_hc3 <- asset.plot(g03_hc3p)
p07_hc3 <- asset.plot(g07_hc3p)
p09_hc3 <- asset.plot(g09_hc3p)

#Save plot to PDF
ggsave(p01, filename = "figs/p01.pdf", 
       width = 9, height = 7, units = "in")

ggsave(p03, filename = "figs/p03.pdf", 
       width = 9, height = 7, units = "in")

ggsave(p07, filename = "figs/p07.pdf", 
       width = 9, height = 7, units = "in")

ggsave(p09, filename = "figs/p09.pdf", 
       width = 9, height = 7, units = "in")
#
ggsave(p01_hc1, filename = "figs/p01_hc1.pdf", 
       width = 9, height = 7, units = "in")

ggsave(p03_hc1, filename = "figs/p03_hc1.pdf", 
       width = 9, height = 7, units = "in")

ggsave(p07_hc1, filename = "figs/p07_hc1.pdf", 
       width = 9, height = 7, units = "in")

ggsave(p09_hc1, filename = "figs/p09_hc1.pdf", 
       width = 9, height = 7, units = "in")
#
ggsave(p01_hc2, filename = "figs/p01_hc2.pdf", 
       width = 9, height = 7, units = "in")

ggsave(p03_hc2, filename = "figs/p03_hc2.pdf", 
       width = 9, height = 7, units = "in")

ggsave(p07_hc2, filename = "figs/p07_hc2.pdf", 
       width = 9, height = 7, units = "in")

ggsave(p09_hc2, filename = "figs/p09_hc2.pdf", 
       width = 9, height = 7, units = "in")
#
ggsave(p01_hc3, filename = "figs/p01_hc3.pdf", 
       width = 9, height = 7, units = "in")

ggsave(p03_hc3, filename = "figs/p03_hc3.pdf", 
       width = 9, height = 7, units = "in")

ggsave(p07_hc3, filename = "figs/p07_hc3.pdf", 
       width = 9, height = 7, units = "in")

ggsave(p09_hc3, filename = "figs/p09_hc3.pdf", 
       width = 9, height = 7, units = "in")