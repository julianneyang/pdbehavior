library(here)
library(tidyr)
library(dplyr)
library(ggplot2)
library(cowplot)
library(nlme)
library(ggpubr)

setwd("/Users/rochellelai/Documents/JacobsGit/slcproject/PFF_Microbiome/alpha_diversity/")
# here::i_am("PFF_Microbiome_RProj/Alpha_Diversity.R")

### Read data frames
# Choose one type of data set below

# JEJUNUM
tissue <- "Jejunum"
otus <- readr::read_delim("/Users/rochellelai/Documents/JacobsGit/slcproject/PFF_Microbiome/alpha_diversity/Jejunum/alpha_min_6000_PFF_Jejunum_PFF_ASV_table/otus_dir/alpha-diversity.tsv")
shannon <- readr::read_delim("/Users/rochellelai/Documents/JacobsGit/slcproject/PFF_Microbiome/alpha_diversity/Jejunum/alpha_min_6000_PFF_Jejunum_PFF_ASV_table/shannon_dir/alpha-diversity.tsv")

# COLON
tissue <- "Colon"
otus <- readr::read_delim("/Users/rochellelai/Documents/JacobsGit/slcproject/PFF_Microbiome/alpha_diversity/Colon/alpha_min_6000_PFF_Colon_PFF_ASV_table/otus_dir/alpha-diversity.tsv")
shannon <- readr::read_delim("/Users/rochellelai/Documents/JacobsGit/slcproject/PFF_Microbiome/alpha_diversity/Colon/alpha_min_6000_PFF_Colon_PFF_ASV_table/shannon_dir/alpha-diversity.tsv")

# CECUM
tissue <- "Cecum"
otus <- readr::read_delim("/Users/rochellelai/Documents/JacobsGit/slcproject/PFF_Microbiome/alpha_diversity/Cecum/alpha_min_6000_PFF_Cecum_PFF_ASV_table/otus_dir/alpha-diversity.tsv")
shannon <- readr::read_delim("/Users/rochellelai/Documents/JacobsGit/slcproject/PFF_Microbiome/alpha_diversity/Cecum/alpha_min_6000_PFF_Cecum_PFF_ASV_table/shannon_dir/alpha-diversity.tsv")

# BASELINE
tissue <- "Baseline"
otus <- readr::read_delim("/Users/rochellelai/Documents/JacobsGit/slcproject/PFF_Microbiome/alpha_diversity/Baseline/alpha_min_6000_PFF_Baseline_PFF_ASV_table/otus_dir/alpha-diversity.tsv")
shannon <- readr::read_delim("/Users/rochellelai/Documents/JacobsGit/slcproject/PFF_Microbiome/alpha_diversity/Baseline/alpha_min_6000_PFF_Baseline_PFF_ASV_table/shannon_dir/alpha-diversity.tsv")

### Format data
row.names(otus) <- otus$...1
row.names(shannon) <- shannon$...1

data<- merge(otus, shannon, by = "...1")
data$SampleID <- data$...1

metadata <- readr::read_delim("/Users/rochellelai/Documents/JacobsGit/slcproject/PFF_Microbiome/alpha_diversity/PFF_Mapping.tsv")
data_meta <- merge(data, metadata, by ="SampleID")

### Function for plotting alpha diversity
generate_PFF_adiv_plots <- function(input_data, X, Y, min, max) {
  
  # read in files
  data <- as.data.frame(input_data)
  
  # declare order of variables
  # data$Genotype <- factor(data$Genotype, levels = c("WT", "HET", "MUT"))
  # data$Sex <- factor(data$Sex, levels = c("M", "F"))
  # data$Genotype_Sex <- factor(data$Genotype_Sex, levels = c("WT_M", "WT_F", "HET_M", "HET_F", "MUT_M", "MUT_F"))
  
  # graph plot
  ggplot(data=data, aes(x={{X}}, y={{Y}}, fill = Genotype)) +
    geom_violin(alpha=0.25,position=position_dodge(width=.75), linewidth = 1,color = "black",draw_quantiles = c(0.5))+
    scale_fill_viridis_d() +
    # geom_line(aes(group = MouseID,color=Genotype),size=1)+
    geom_point(size=2,position=position_jitter(width=0.25),alpha=1) +
    theme_cowplot(12) +
    ylim(min,max) +
    theme(legend.position = "none")
}

# compare <- c("WT","HET", "MUT")

### Make and save plots
pff_shannon <- generate_PFF_adiv_plots(data_meta, Genotype, shannon_entropy, 0, 8) #+ stat_compare_means(comparisons = compare, method ="wilcox", vjust=0.3, label="p.signif", step.increase = 0.05)
pff_otus <- generate_PFF_adiv_plots(data_meta, Genotype, observed_features, 0, 400)

### Save plots
ggsave(paste(tissue, "PFF_shannon_violin_plot.png", sep = ("_")), pff_shannon, width = 9, height = 12.6)
ggsave(paste(tissue, "PFF_otus_violin_plot.png", sep = ("_")), pff_otus, width = 9, height = 12.6)

### Alpha Diversity Stats
sink(paste(tissue, "PFF_alpha_diversity_statistics.txt", sep = ("_")))

data_meta$Genotype <-factor(data_meta$Genotype, levels=c("WT", "HET", "MUT"))
output <- lme(fixed = shannon_entropy ~ Genotype, random = ~1|MouseID, data=data_meta)
summary(output)
output <- lme(fixed = observed_features ~ Genotype, random = ~1|MouseID, data=data_meta)
summary(output)

data_meta1 <- data.frame(data_meta)
data_meta2 <- data.frame(data_meta)
data_meta3 <- data.frame(data_meta)

# WT vs MUT
WTvsMUT <- data_meta1$Genotype <-factor(data_meta$Genotype, levels=c("WT", "MUT"))
wilcox.test(shannon_entropy ~ Genotype, data_meta1)
wilcox.test(observed_features ~ Genotype, data_meta1)
t.test(shannon_entropy ~ Genotype, data_meta1)
t.test(observed_features ~ Genotype, data_meta1)

# WT vs HET
WTvsHET <- data_meta2$Genotype <-factor(data_meta$Genotype, levels=c("WT", "HET"))
wilcox.test(shannon_entropy ~ Genotype, data_meta2)
wilcox.test(observed_features ~ Genotype,data_meta2)
t.test(shannon_entropy ~ Genotype, data_meta2)
t.test(observed_features ~ Genotype, data_meta2)

# HET vs MUT
HETvsMUT <- data_meta3$Genotype <-factor(data_meta$Genotype, levels=c("HET", "MUT"))
wilcox.test(shannon_entropy ~ Genotype, data_meta3)
wilcox.test(observed_features ~ Genotype,data_meta3)
t.test(shannon_entropy ~ Genotype, data_meta3)
t.test(observed_features ~ Genotype, data_meta3)

sink()
