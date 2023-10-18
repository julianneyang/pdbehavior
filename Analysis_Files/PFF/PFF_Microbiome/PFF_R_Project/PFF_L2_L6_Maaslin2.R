library(Maaslin2)
library(funrar)
library(dplyr)
library(ggplot2)
library(cowplot)
library(plyr)
setwd("C:/Users/Jacobs Laboratory/Documents/JCYang/SLC_GitHub/slcproject/PFF_Microbiome/")

### Note: First remove "#Constructed from biom file row"
### Fraction ASV table into respective subsets ---

## L2 level ---
input_data <- read.delim("differential_taxa/collapsed_ASV_tables/export_L2_min10000_no_tax_PFF_ASV_table/feature-table.tsv", header=TRUE, row.names=1) # choose filtered non rarefied csv file

df_input_data <- as.data.frame(input_data)
df_input_data <- select(df_input_data, -c("taxonomy"))

input_metadata <-read.delim("starting_files/PFF_Mapping.tsv",sep="\t",header=TRUE, row.names=1)
input_metadata$SampleID <- row.names(input_metadata)

jejunum <- input_metadata %>% filter(Study =="PFF_Jejunum", SampleID %in% names(df_input_data)) %>% pull(SampleID)
female_jejunum <- input_metadata %>% filter(Study =="PFF_Jejunum", Sex=="F", SampleID %in% names(df_input_data)) %>% pull(SampleID)

jej_data <- df_input_data[, jejunum]
write.table(jej_data,"differential_taxa/collapsed_ASV_tables/L2_PFF_Jejunum.tsv", sep="\t")

fjej_data <- df_input_data[, female_jejunum]
write.table(fjej_data,"differential_taxa/collapsed_ASV_tables/L2_females_PFF_Jejunum.tsv", sep="\t")

## L6 level ---
input_data <- read.delim("differential_taxa/collapsed_ASV_tables/export_L6_min10000_no_tax_PFF_ASV_table/feature-table.tsv", header=TRUE, row.names=1) # choose filtered non rarefied csv file
df_input_data <- as.data.frame(input_data)
df_input_data <- select(df_input_data, -c("taxonomy"))

input_metadata <-read.delim("starting_files/PFF_Mapping.tsv",sep="\t",header=TRUE, row.names=1)
input_metadata$SampleID <- row.names(input_metadata)

jejunum <- input_metadata %>% filter(Study =="PFF_Jejunum", SampleID %in% names(df_input_data)) %>% pull(SampleID)
female_jejunum <- input_metadata %>% filter(Study =="PFF_Jejunum", Sex=="F", SampleID %in% names(df_input_data)) %>% pull(SampleID)

jej_data <- df_input_data[, jejunum]
write.table(jej_data,"differential_taxa/collapsed_ASV_tables/L6_PFF_Jejunum.tsv", sep="\t")

fjej_data <- df_input_data[, female_jejunum]
write.table(fjej_data,"differential_taxa/collapsed_ASV_tables/L6_females_PFF_Jejunum.tsv", sep="\t")


## Use the Maaslin 2 function ---
run_Maaslin2_genotype <- function(counts_filepath, metadata_filepath, subset_string) {
  #input_data <- read.delim("export_s3_min10000_PFF_Baseline_min10000_no_tax_PFF_ASV_table/feature-table.tsv", header=TRUE, row.names=1) # choose filtered non rarefied csv file
  input_data <- read.delim(counts_filepath, header=TRUE, row.names=1) # choose filtered non rarefied csv file
  
  
  df_input_data <- as.data.frame(input_data)
  #df_input_data <- select(df_input_data, -c("taxonomy"))
  
  transposed_input_data <- t(df_input_data)
  transposed_input_data <- as.matrix(transposed_input_data) #taxa are now columns, samples are rows. 
  df_relative_ASV <- make_relative(transposed_input_data)
  df_relative_ASV <- as.data.frame(df_relative_ASV)
  Relative_Abundance <- summarize_all(df_relative_ASV, mean)
  Relative_Abundance <- as.data.frame(t(Relative_Abundance))
  
  #readr::write_rds(Relative_Abundance,paste0("Relative_Abundance_",subset_string,"_ASV.RDS"))
  
  input_metadata <-read.delim(metadata_filepath,sep="\t",header=TRUE, row.names=1)
  #input_metadata <-read.delim("../starting_files/PFF_Mapping.tsv",sep="\t",header=TRUE, row.names=1)
  
  
  target <- colnames(df_input_data)
  input_metadata = input_metadata[match(target, row.names(input_metadata)),]
  target == row.names(input_metadata)
  
  df_input_metadata<-input_metadata
  df_input_metadata$MouseID <- factor(df_input_metadata$MouseID)
  df_input_metadata$Genotype <- factor(df_input_metadata$Genotype, levels=c("WT","HET", "MUT"))
  df_input_metadata$Sex <- factor(df_input_metadata$Sex)
  sapply(df_input_metadata,levels)
  
  ?Maaslin2
  
  fit_data = Maaslin2(input_data=df_input_data, 
                      input_metadata=df_input_metadata, 
                      output = paste0(subset_string,"_Maaslin2_Genotype"), 
                      fixed_effects = c("Genotype"),normalization="TSS", 
                      min_prevalence = 0.15,
                      transform ="log",plot_heatmap = FALSE,plot_scatter = FALSE)
  
  
}

run_Maaslin2_genotype("differential_taxa/collapsed_ASV_tables/L2_females_PFF_Jejunum.tsv",
                      "starting_files/PFF_Mapping.tsv",
                      "L2_female_Jejunum")

run_Maaslin2_genotype("differential_taxa/collapsed_ASV_tables/L6_females_PFF_Jejunum.tsv",
                      "starting_files/PFF_Mapping.tsv",
                      "L6_female_Jejunum")
## Visualization ---
# Jejunum
data<-read.table("L2_Jejunum_Maaslin2_Sex_Genotype/significant_results.tsv", header=TRUE)
data <- data %>% filter(qval <0.05)
data <- data %>% filter(metadata=="Genotype")

data<-read.table("L2_female_Jejunum_Maaslin2_Genotype/significant_results.tsv", header=TRUE)
data <- data %>% filter(qval <0.05)
data <- data %>% filter(metadata=="Genotype")

data<-read.table("L6_female_Jejunum_Maaslin2_Genotype/significant_results.tsv", header=TRUE)
data <- data %>% filter(qval <0.05)
data <- data %>% filter(metadata=="Genotype")

## Visualization ---
# Jejunum
data<-read.table("differential_taxa/L6_Jejunum_Maaslin2_Sex_Genotype/significant_results.tsv", header=TRUE)
data <- data %>% filter(qval <0.05)
data <- data %>% filter(metadata=="Genotype")
