library(here)
library(tidyverse)
library(ggvenn)
library(ggplot2)
library(cowplot)

### Read in ASO results ---
ASO_lc_dat <-read.table(here("results/ASO/differential_taxa/L6_Luminal_Colon_Maaslin2_Sex_Site_Genotype/all_results.tsv"), header=TRUE)
ASO_lc_dat_het <- ASO_lc_dat %>% filter(value=="HET") %>% filter(qval<0.25) %>% pull(feature)
ASO_lc_dat_mut <- ASO_lc_dat %>% filter(value=="MUT") %>% filter(qval<0.25) %>% pull(feature)
combined_significant_features <- c(ASO_lc_dat_het, ASO_lc_dat_mut)
ASO_lc_dat <- ASO_lc_dat %>% filter(feature %in% combined_significant_features) %>% 
  filter(metadata =="Genotype")

ASO_lc_dat_filtered <- ASO_lc_dat %>%
  group_by(feature) %>%
  filter(all(c("HET", "MUT") %in% value)) %>%
  filter({
    het_coef <- coef[value == "HET"]
    mut_coef <- coef[value == "MUT"]
    length(het_coef) == 1 && length(mut_coef) == 1 &&
      ((het_coef > 0 & mut_coef > 0) | (het_coef < 0 & mut_coef < 0))
  }) %>%
  ungroup()

### Read in PFF results ---
PFF_lc_dat <-read.table(here("results/PFF/differential_taxa/L6_Luminal_Colon_Maaslin2_Sex_Study_Genotype_1-/all_results.tsv"), header=TRUE)
PFF_lc_dat_het <- PFF_lc_dat %>% filter(value=="HET") %>% filter(qval<0.25) %>% pull(feature)
PFF_lc_dat_mut <- PFF_lc_dat %>% filter(value=="MUT") %>% filter(qval<0.25) %>% pull(feature)

combined_significant_features <- c(PFF_lc_dat_het, PFF_lc_dat_mut)
PFF_lc_dat <- PFF_lc_dat %>% filter(feature %in% combined_significant_features) %>% 
  filter(metadata =="Genotype")

PFF_lc_dat_filtered <- PFF_lc_dat %>%
  group_by(feature) %>%
  filter(all(c("HET", "MUT") %in% value)) %>%
  filter({
    het_coef <- coef[value == "HET"]
    mut_coef <- coef[value == "MUT"]
    length(het_coef) == 1 && length(mut_coef) == 1 &&
      ((het_coef > 0 & mut_coef > 0) | (het_coef < 0 & mut_coef < 0))
  }) %>%
  ungroup()

### Read in spontaneous results ---
# Trios
Trios_lc_dat<-readr::read_delim(here("../slccolonpaper/slccolon/Trios/differential_taxa/L6_Luminal_Colon_L6_Maaslin2_Sequencing_Run_Site_Sex_Genotype_1-MouseID/all_results.tsv"))
Trios_lc_dat_het <- Trios_lc_dat %>% filter(value=="HET") %>% filter(qval<0.25) %>% pull(feature)
Trios_lc_dat_mut <- Trios_lc_dat %>% filter(value=="MUT") %>% filter(qval<0.25) %>% pull(feature)

combined_significant_features <- c(Trios_lc_dat_het, Trios_lc_dat_mut)
Trios_lc_dat <- Trios_lc_dat %>% filter(feature %in% combined_significant_features) %>% 
  filter(metadata =="Genotype")

Trios_lc_dat_filtered <- Trios_lc_dat %>%
  group_by(feature) %>%
  filter(all(c("HET", "MUT") %in% value)) %>%
  filter({
    het_coef <- coef[value == "HET"]
    mut_coef <- coef[value == "MUT"]
    length(het_coef) == 1 && length(mut_coef) == 1 &&
      ((het_coef > 0 & mut_coef > 0) | (het_coef < 0 & mut_coef < 0))
  }) %>%
  ungroup()

# Long Term 
LT_lc_dat <-readr::read_delim(here("../slccolonpaper/slccolon/Long_Term/differential_taxa/L6_Luminal_Colon_L6_Maaslin2_Site_Sex_Genotype_1-MouseID/all_results.tsv"))
LT_lc_dat_het <- LT_lc_dat %>% filter(value=="HET") %>% filter(qval<0.25) %>% pull(feature)
LT_lc_dat_mut <- LT_lc_dat %>% filter(value=="MUT") %>% filter(qval<0.25) %>% pull(feature)

combined_significant_features <- c(LT_lc_dat_het, LT_lc_dat_mut)
LT_lc_dat <- LT_lc_dat %>% filter(feature %in% combined_significant_features) %>% 
  filter(metadata =="Genotype")

LT_lc_dat_filtered <- LT_lc_dat %>%
  group_by(feature) %>%
  filter(all(c("HET", "MUT") %in% value)) %>%
  filter({
    het_coef <- coef[value == "HET"]
    mut_coef <- coef[value == "MUT"]
    length(het_coef) == 1 && length(mut_coef) == 1 &&
      ((het_coef > 0 & mut_coef > 0) | (het_coef < 0 & mut_coef < 0))
  }) %>%
  ungroup()

### Clean and compare the genera names ---
clean_genera_names <- function(dataframe) {
  
  data <- as.data.frame(dataframe)
  data$Taxon <- data$feature
  data$Phylum <- gsub(".*p__","",data$Taxon)
  data$Phylum <- gsub("\\..*","",data$Phylum)
  data$Class<- gsub(".*c__","",data$Taxon)
  data$Class <-  gsub("\\..*","",data$Class)
  data$Family<- gsub(".*f__","",data$Taxon)
  data$Family <-  gsub("\\..*","",data$Family)
  data$Order<- gsub(".*o__","",data$Taxon)
  data$Order <-  gsub("\\..*","",data$Order)
  data$Genus<- gsub(".*g__","",data$Taxon)
  
  data$annotation <- gsub("\\.E","E",data$Genus)
  data$annotation <- gsub("\\.","_",data$annotation)
  data$annotation <- gsub("__","_",data$annotation)
  #data$Genus <- gsub("\\..*","",data$Genus)
  data <- data %>% mutate(annotation = ifelse(data$Genus=="", paste0(data$Family," (f)"), data$annotation))
  data <- data %>% mutate(annotation = ifelse(data$Family=="", paste(data$Order,"(o)"), data$annotation))
  data <- data %>% mutate(annotation = ifelse(data$Order=="", paste(data$Class,"(c)"), data$annotation))
  
  return(data)
}
  
ASO_lc_dat_filtered <- clean_genera_names(ASO_lc_dat_filtered)
PFF_lc_dat_filtered <- clean_genera_names(PFF_lc_dat_filtered)
Trios_lc_dat_filtered <- clean_genera_names(Trios_lc_dat_filtered)
LT_lc_dat_filtered <- clean_genera_names(LT_lc_dat_filtered)

a <- intersect(LT_lc_dat_filtered$annotation, ASO_lc_dat_filtered$annotation)
b <- intersect(LT_lc_dat_filtered$annotation, PFF_lc_dat_filtered$annotation)
c <- intersect(ASO_lc_dat_filtered$annotation, PFF_lc_dat_filtered$annotation)

compare <- list(ASO = c(a,c), PFF= c(b,c), Mature = c(a,b))
full_compare <- list(ASO = ASO_lc_dat_filtered$annotation, PFF = PFF_lc_dat_filtered$annotation, Mature = LT_lc_dat_filtered$annotation)
ggvenn(compare, c("ASO", "PFF", "Mature"), show_elements = TRUE, label_sep = "\n", max_elements=2)
ggvenn(full_compare, c("ASO", "PFF", "Mature"), label_sep = "\n", max_elements=2)

### Make a full plot depicting relationships ---
ASO_intersect_mature <- ASO_lc_dat_filtered %>%
  filter(annotation %in% a) %>% 
  mutate(Model = "ASO")

Mature_intersect_ASO <- LT_lc_dat_filtered %>%
  filter(annotation %in% a) %>%
  mutate(Model= "Mature") %>% 
  full_join(ASO_intersect_mature) %>% 
  dplyr::select(annotation,coef,Model)



# Function to plot one feature
plot_feature <- function(feature_name, df) {
  
  sub <- df %>% filter(annotation == feature_name)
  
  p <- ggplot(sub, aes(x = Model, y = coef, fill = value)) +
    geom_col(position = position_dodge(width = 1)) +
    coord_flip() +
    labs(
      title = feature_name,
      x = "Genotype Comparison (HET or MUT vs WT)",
      y = "Coefficient"
    ) +
    theme_cowplot(12)+
    theme(legend.position = "top",legend.justification = "center") + 
    theme(plot.title = element_text(hjust = 0.5)) +
    scale_fill_manual(values= c("HET"="navy", "MUT" = "firebrick"))
  
  return(p)
}


# Apply function to all features
features <- unique(Mature_intersect_ASO$annotation)
comparison_plots <- list()
for(i in seq_along(features)){
  comparison_plots[[i]] <- plot_feature(features[i], Mature_intersect_ASO)
}

comparison_plots[[3]]


