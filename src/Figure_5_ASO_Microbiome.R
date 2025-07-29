library(here)
library(ggplot2)
library(cowplot)
library(readr)

here::i_am("src/Figure_5_ASO_Microbiome.R")


### Read in files --- 

beta_diversity <- read_rds(here("results/ASO/figures/lumcol_beta_diversity.RDS"))
# beta_diversity <- ggdraw(add_sub(beta_diversity, 
#                      bquote(paste(~italic(R)^2,"=0.062 ", 
#                                   italic("P"),"<9.99 E-5"))))

beta_diversity <- beta_diversity + labs(subtitle = bquote(paste(~italic(R)^2,"=0.062 ", 
                                              italic("P"),"<9.99 E-5"))) + 
  theme(
    plot.subtitle = element_text(hjust = 0.5)
  )

rotarod_beta_diversity <- read_rds(here("results/ASO/figures/rotarod_beta_diversity.RDS"))
# rotarod_beta_diversity <- ggdraw(add_sub(rotarod_beta_diversity, 
#                                  bquote(paste(~italic(R)^2,"=0.044 ", 
#                                               italic("P"),"<9.99 E-5"))))

rotarod_beta_diversity <- rotarod_beta_diversity + labs(title = "ASO Colonic Lumen",
                                                        subtitle = bquote(paste(~italic(R)^2,"=0.044 ", 
                                                                italic("P"),"<9.99 E-5"))) + 
  theme(
    plot.subtitle = element_text(hjust = 0.5)
  )
dat <- read_rds(here("results/ASO/figures/lumcol_diff_taxa.RDS"))

dat <- dat + ggtitle("ASO Colonic Lumen")

corr_list <- read_rds(here("results/ASO/figures/lumcol_DAT_correlations.RDS"))

motor_pca <- read_rds(here("results/ASO/figures/motor_behavior_pca.RDS"))

### Assemble multi-panel figure ---

top <- plot_grid(beta_diversity,  dat, labels=c("A","B"), nrow=1,rel_widths = c(1,2))
bottom <- plot_grid(rotarod_beta_diversity, corr_list[[1]], corr_list[[2]], labels=c("C","D","E"),nrow=1)


dev.new(width=10,height=20)
plot_grid(top, bottom, nrow=2)
