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

top <- plot_grid(beta_diversity, rotarod_beta_diversity , labels=c("A","B"), nrow=1)
bottom <- plot_grid(corr_list[[1]], corr_list[[2]], labels=c("E","F"))
middle <- plot_grid(dat, labels="D")

dev.new(width=10,height=20)
plot_grid(top,middle, bottom, nrow=3,rel_heights = c(1,1.5,1))
