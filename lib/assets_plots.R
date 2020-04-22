#' Evol of wealth on networks
#' Scott Cohn
#' 2020-04-20

library('tidyverse')
library('ggsci')

g01p <- read.csv("g01p.csv")
g03p <- read.csv("g03p.csv")
g07p <- read.csv("g07p.csv")
g09p <- read.csv("g09p.csv")

asset.plot <- function(df){
    p <- df %>%
        group_by(strategies) %>%
        ggplot(aes(x = round, y = assets, color = strategies)) + 
        geom_point() + 
        ggsci::scale_color_d3() +
        theme_bw() + 
        xlab("Round") + 
        ylab("Assets") +
        labs(color = "Strategies") +
        theme(text = element_text(size = 19),
              axis.text = element_text(size = 16),
              axis.title = element_text(size = 19),
              panel.grid.minor = element_blank(),
              plot.margin = margin(5, 20, 5, 8))
    
    return(p)
}

p01 <- asset.plot(g01p)
p03 <- asset.plot(g03p)
p07 <- asset.plot(g07p)
p09 <- asset.plot(g09p)

#Save plot to PDF
ggsave(p01, filename = "p01.pdf", 
       width = 9, height = 7, units = "in")

ggsave(p03, filename = "p03.pdf", 
       width = 9, height = 7, units = "in")

ggsave(p07, filename = "p07.pdf", 
       width = 9, height = 7, units = "in")

ggsave(p09, filename = "p09.pdf", 
       width = 9, height = 7, units = "in")