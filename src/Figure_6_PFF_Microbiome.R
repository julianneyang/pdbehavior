library(here)
library(ggplot2)
library(cowplot)

here::i_am("src/Figure_5_ASO_Microbiome.R")


### Read in files --- 

pff_beta_diversity <- readRDS(here("results/PFF/figures/lumcol_beta_diversity.RDS"))
pff_beta_diversity <- pff_beta_diversity + labs(subtitle = bquote(paste(~italic(R)^2,"=0.062 ", 
                                                                italic("P"),"<9.99 E-5"))) + 
  theme(
    plot.subtitle = element_text(hjust = 0.5)
  )
pff_rotarod_beta_diversity <- readRDS(here("results/PFF/figures/rotarod_beta_diversity.RDS"))
pff_rotarod_beta_diversity <- pff_rotarod_beta_diversity + labs(subtitle = bquote(paste(~italic(R)^2,"=0.030 ", 
                                                                                italic("P"),"<9.99 E-5"))) + 
  theme(
    plot.subtitle = element_text(hjust = 0.5)
  )
pff_dat <- readRDS(here("results/PFF/figures/lumcol_diff_taxa.RDS"))

pff_corr_list <- readRDS(here("results/PFF/figures/lumcol_DAT_correlations.rds"))
pff_motor_pca <- readRDS(here("results/PFF/figures/motor_behavior_pca.RDS"))
pff_corr_puncta <- readRDS(here("results/PFF/figures/lumcol_DAT_correlations_with_Puncta.rds"))

### Make cosmetic changes to each figure ---
pff_beta_diversity <- pff_beta_diversity + ggtitle("PFF Colonic Lumen")
pff_dat <- pff_dat + ggtitle("PFF Colonic Lumen",
                             subtitle ="")
pff_rotarod_beta_diversity <- pff_rotarod_beta_diversity + ggtitle("PFF Colonic Lumen")

### Assemble multi-panel figure ---


top <- plot_grid(pff_beta_diversity, pff_dat , labels=c("A","B"),rel_widths = c(1,2), nrow=1)
bottom <- plot_grid(pff_corr_puncta[[1]], pff_corr_puncta[[2]], labels=c("F","G"))
middle <- plot_grid(pff_rotarod_beta_diversity, pff_corr_list[[1]], pff_corr_list[[6]], labels=c("C","D","E"),rel_widths = c(1,1,1), nrow=1)

dev.new(width=10,height=20)
plot_grid(top,middle, bottom, nrow=3)
