library(here)
library(ggplot2)
library(cowplot)

here::i_am("src/Figure_5_ASO_Microbiome.R")


### Read in files --- 

pff_beta_diversity <- read_rds(here("results/PFF/figures/lumcol_beta_diversity.RDS"))
pff_rotarod_beta_diversity <- read_rds(here("results/PFF/figures/rotarod_beta_diversity.RDS"))
pff_dat <- read_rds(here("results/PFF/figures/lumcol_diff_taxa.RDS"))

pff_corr_list <- read_rds(here("results/PFF/figures/lumcol_DAT_correlations.rds"))
pff_motor_pca <- read_rds(here("results/PFF/figures/motor_behavior_pca.RDS"))
pff_corr_puncta <- read_rds(here("results/PFF/figures/lumcol_DAT_correlations_with_Puncta.rds"))

### Assemble multi-panel figure ---

corr_list[[1]]

top <- plot_grid(pff_beta_diversity, pff_dat , labels=c("A","B"),rel_widths = c(1,2), nrow=1)
bottom <- plot_grid(pff_corr_puncta[[1]], pff_corr_puncta[[2]], labels=c("F","G"))
middle <- plot_grid(rotarod_beta_diversity, pff_corr_list[[1]], pff_corr_list[[6]], labels=c("C","D","E"),rel_widths = c(1,1,1), rows=1)

dev.new(width=10,height=20)
plot_grid(top,middle, bottom, nrow=3)
