library(here)
library(ggplot2)
library(cowplot)

here::i_am("src/Figure_5_ASO_Microbiome.R")


### Read in files --- 

beta_diversity <- read_rds(here("results/ASO/figures/lumcol_beta_diversity.RDS"))
rotarod_beta_diversity <- read_rds(here("results/ASO/figures/rotarod_beta_diversity.RDS"))
dat <- read_rds(here("results/ASO/figures/lumcol_diff_taxa.RDS"))

corr_list <- read_rds(here("results/ASO/figures/lumcol_DAT_correlations.RDS"))
motor_pca <- read_rds(here("results/ASO/figures/motor_behavior_pca.RDS"))

### Assemble multi-panel figure ---

top <- plot_grid(beta_diversity, rotarod_beta_diversity , motor_pca, labels=c("A","B","C"), nrow=1)
middle <- plot_grid(corr_list[[1]], corr_list[[2]], labels=c("D","E"))
bottom <- plot_grid(dat, labels="F")

dev.new(width=10,height=20)
plot_grid(top,middle, bottom, nrow=3)
