library(Maaslin2)
library(funrar)
library(dplyr)
library(ggplot2)
library(cowplot)
library(here)
library(glue)
library(tidyverse)

here::i_am("src/PFF/PFF_L2_L6_Maaslin2.R")

### Note: First remove "#Constructed from biom file row"
### Fraction ASV table into respective subsets ---

# Load metadata once
metadata <- read.csv(here("data/PFF/PFF_Microbiome/starting_files/PFF_Mapping.csv"), header=TRUE)
metadata$SampleID <- gsub("-", ".", metadata$SampleID)

# Define function to filter and write data
filter_and_save <- function(level, filter_column, filter_value) {
  data_path <- here(glue("data/PFF/PFF_Microbiome/differential_taxa/collapsed_ASV_tables/export_{level}_min10000_no_tax_PFF_ASV_table/feature-table.tsv"))
  input_data <- read.delim(data_path, sep="\t", header=TRUE, row.names = 1)
  
  input_data <- as.data.frame(input_data)
  input_data <- select(input_data, -taxonomy)
  
  # Filter metadata
  samples_to_keep <- metadata %>%
    filter(!!sym(filter_column) == filter_value, SampleID %in% colnames(input_data)) %>%
    pull(SampleID)
  
  # Subset data
  filtered_data <- input_data[, samples_to_keep, drop=FALSE]
  
  # Generate output file name
  output_file <- here(glue("data/PFF/PFF_Microbiome/differential_taxa/collapsed_ASV_tables/PFF_{level}_{filter_column}_{filter_value}.tsv"))
  write.table(filtered_data, file=output_file, sep="\t", row.names = TRUE)
}


# Loop through multiple Site values
site_values <- c("PFF_Baseline", "PFF_Cecum", "PFF_Colon", "PFF_Jejunum")
for (site in site_values) {
  filter_and_save("L2", "Study", site)
  filter_and_save("L6", "Study", site)
}

# Single call for a Subset value
filter_and_save("L2", "Subset", "Luminal_Colon")
filter_and_save("L6", "Subset", "Luminal_Colon")


run_Maaslin2_genotype <- function(counts_filepath, metadata_filepath, subset_string, fixed_effects = c("Genotype"), random_effects=NULL) {
  # Read input table
  input_data <- read.delim(counts_filepath, header = TRUE, row.names = 1)
  df_input_data <- as.data.frame(input_data)
  
  # Convert to relative abundance
  transposed_input_data <- t(df_input_data)
  transposed_input_data <- as.matrix(transposed_input_data)
  df_relative_ASV <- funrar::make_relative(transposed_input_data)
  df_relative_ASV <- as.data.frame(df_relative_ASV)
  
  Relative_Abundance <- summarize_all(df_relative_ASV, mean)
  Relative_Abundance <- as.data.frame(t(Relative_Abundance))
  readr::write_rds(Relative_Abundance, paste0(here("results/PFF/differential_taxa/"),"Relative_Abundance_", subset_string, ".RDS"))
  
  # Load and match metadata
  metadata <- read.csv(metadata_filepath, header = TRUE)
  metadata$SampleID <- gsub("-", ".", metadata$SampleID)
  
  target <- colnames(df_input_data)
  input_metadata <- metadata[match(target, metadata$SampleID), ]
  rownames(input_metadata) <- input_metadata$SampleID
  
  if (!all(target == rownames(input_metadata))) {
    stop("Sample IDs in counts and metadata do not match.")
  }
  
  # Format metadata factors
  df_input_metadata <- input_metadata
  df_input_metadata$MouseID <- factor(df_input_metadata$MouseID)
  df_input_metadata$Genotype <- factor(df_input_metadata$Genotype, levels = c("WT", "HET", "MUT"))
  df_input_metadata$Sex <- factor(df_input_metadata$Sex)
  
  # Sanitize fixed effects for use in filenames
  fixed_effects_label <- paste(fixed_effects, collapse = "_")
  fixed_effects_label <- gsub("[^A-Za-z0-9_]", "", fixed_effects_label)  # Remove problematic characters
  
  output_dir <- paste0(here("results/PFF/differential_taxa/"),subset_string, "_Maaslin2_", fixed_effects_label,"_1-",random_effects)
  
  # Run Maaslin2
  fit_data <- Maaslin2(
    input_data = df_input_data,
    input_metadata = df_input_metadata,
    output = output_dir,
    fixed_effects = fixed_effects,
    random_effects = random_effects,
    normalization = "TSS",
    min_prevalence = 0.15,
    transform = "log",
    plot_heatmap = FALSE,
    plot_scatter = FALSE
  )
}




counts_filepaths <- c(
  here("data/PFF/PFF_Microbiome/differential_taxa/collapsed_ASV_tables/PFF_L6_Study_PFF_Baseline.tsv"),
  here("data/PFF/PFF_Microbiome/differential_taxa/collapsed_ASV_tables/PFF_L6_Study_PFF_Jejunum.tsv"),
  here("data/PFF/PFF_Microbiome/differential_taxa/collapsed_ASV_tables/PFF_L6_Study_PFF_Cecum.tsv"),
  here("data/PFF/PFF_Microbiome/differential_taxa/collapsed_ASV_tables/PFF_L6_Study_PFF_Colon.tsv"),
  here("data/PFF/PFF_Microbiome/differential_taxa/collapsed_ASV_tables/PFF_L6_Subset_Luminal_Colon.tsv")
)

subset_strings <- c("L6_Baseline", "L6_Jejunum", "L6_Cecum",
                    "L6_Colon", "L6_Luminal_Colon")
metadata_filepath <- here("data/PFF/PFF_Microbiome/starting_files/PFF_Mapping.csv")

purrr::pwalk(
  list(counts_filepaths, subset_strings),
  ~ run_Maaslin2_genotype(
    counts_filepath = ..1,
    metadata_filepath = metadata_filepath,
    subset_string = ..2,
    fixed_effects = "Genotype"
  )
)

purrr::pwalk(
  list(counts_filepaths, subset_strings),
  ~ run_Maaslin2_genotype(
    counts_filepath = ..1,
    metadata_filepath = metadata_filepath,
    subset_string = ..2,
    fixed_effects = c("Sex","Genotype")
  )
)



counts_filepaths <- c(
  here("data/PFF/PFF_Microbiome/differential_taxa/collapsed_ASV_tables/PFF_L6_Subset_Luminal_Colon.tsv")
)

subset_strings <- c("L6_Luminal_Colon")

purrr::pwalk(
  list(counts_filepaths, subset_strings),
  ~ run_Maaslin2_genotype(
    counts_filepath = ..1,
    metadata_filepath = metadata_filepath,
    subset_string = ..2,
    fixed_effects = c("Sex","Study", "Genotype")
  )
)

purrr::pwalk(
  list(counts_filepaths, subset_strings),
  ~ run_Maaslin2_genotype(
    counts_filepath = ..1,
    metadata_filepath = metadata_filepath,
    subset_string = ..2,
    fixed_effects = c("Sex","Genotype"),
    random_effects = "MouseID"
  )
)

## Visualization ---
genus_colors <- viridis::plasma(n=8)

# Jejunum : 1 significant taxa at q  < 0.25
jej_dat <-read.table(here("Analysis_Files/PFF/PFF_Microbiome/differential_taxa/collapsed_ASV_tables/L6_Jejunum_Maaslin2_Sex_Genotype/significant_results.tsv"), header=TRUE)
jej_dat_het <- jej_dat %>% filter(value=="HET") # 1 significant taxa at q < 0.25
jej_diff_taxa_het <- make_genus_level_taxa_dotplot(ASV_significant_results_dataset = colon_dat_het,
                                                     Relative_Abundance_filepath_rds = "Analysis_Files/PFF/PFF_Microbiome/differential_taxa/collapsed_ASV_tables/Relative_Abundance_L6_Colon.RDS",
                                                     titlestring = "PFF Jej (HET vs WT) (Genus ~ Sex + Genotype)",
                                                     genus_colors, qvalue = 0.25)
jej_diff_taxa_het

# Colon : 
colon_dat <-read.table(here("Analysis_Files/PFF/PFF_Microbiome/differential_taxa/collapsed_ASV_tables/L6_Colon_Maaslin2_Sex_Genotype/significant_results.tsv"), header=TRUE)
colon_dat_het <- colon_dat %>% filter(value=="HET") # 1 significant taxa at q < 0.25
colon_dat_mut <- colon_dat %>% filter(value=="MUT") # 0 significant taxa at q < 0.25
colon_diff_taxa_het <- make_genus_level_taxa_dotplot(ASV_significant_results_dataset = colon_dat_het,
                                                     Relative_Abundance_filepath_rds = "Analysis_Files/PFF/PFF_Microbiome/differential_taxa/collapsed_ASV_tables/Relative_Abundance_L6_Colon.RDS",
                                                     titlestring = "PFF Colon (HET vs WT) (Genus ~ Sex + Genotype)",
                                                     genus_colors, qvalue = 0.25)
colon_diff_taxa_het


# Cecum : 
cecum_dat <-read.table(here("Analysis_Files/PFF/PFF_Microbiome/differential_taxa/collapsed_ASV_tables/L6_Cecum_Maaslin2_Sex_Genotype/significant_results.tsv"), header=TRUE)
cecum_dat_het <- cecum_dat %>% filter(value=="HET") # 0 significant taxa at q < 0.25 
cecum_dat_mut <- cecum_dat %>% filter(value=="MUT") # 0 significant taxa at q < 0.25

# Colonic Lumen 

lc_dat <-read.table(here("results/PFF/differential_taxa/L6_Luminal_Colon_Maaslin2_Sex_Study_Genotype_1-/all_results.tsv"), header=TRUE)
lc_dat_het <- lc_dat %>% filter(value=="HET") %>% filter(qval<0.25) %>% pull(feature)
lc_dat_mut <- lc_dat %>% filter(value=="MUT") %>% filter(qval<0.25) %>% pull(feature)

combined_significant_features <- c(lc_dat_het, lc_dat_mut)
lc_dat <- lc_dat %>% filter(feature %in% combined_significant_features) %>% 
  filter(metadata =="Genotype")


lc_diff_taxa<- make_combined_genus_level_taxa_dotplot(ASV_significant_results_dataset = lc_dat,
                                                      Relative_Abundance_filepath_rds = "results/PFF/differential_taxa/Relative_Abundance_L6_Luminal_Colon.RDS",
                                                      titlestring = "PFF Colonic Lumen (HET or MUT vs WT) ",
                                                      genotype_colors, qvalue = 1)
lc_diff_taxa + labs(subtitle = "Genus ~ Sex + Site + Genotype")



# Restrict visualization just to features agreeing in direction in both HET and MUT 

lc_dat_filtered <- lc_dat %>%
  group_by(feature) %>%
  filter(all(c("HET", "MUT") %in% value)) %>%
  filter({
    het_coef <- coef[value == "HET"]
    mut_coef <- coef[value == "MUT"]
    length(het_coef) == 1 && length(mut_coef) == 1 &&
      ((het_coef > 0 & mut_coef > 0) | (het_coef < 0 & mut_coef < 0))
  }) %>%
  ungroup()

lc_diff_taxa<- make_combined_genus_level_taxa_dotplot(ASV_significant_results_dataset = lc_dat_filtered,
                                                      Relative_Abundance_filepath_rds = "results/PFF/differential_taxa/Relative_Abundance_L6_Luminal_Colon.RDS",
                                                      titlestring = "PFF Colonic Lumen (HET or MUT vs WT) ",
                                                      genotype_colors, qvalue = 1)
lc_diff_taxa <- lc_diff_taxa + labs(subtitle = "Genus ~ Sex + Site + Genotype")

write_rds(lc_diff_taxa, here("results/PFF/figures/lumcol_diff_taxa.RDS"))
write_rds(lc_dat_filtered, here("results/PFF/differential_taxa/PFF_Combined_Significant_Genera.RDS"))

# Plot grid 
cowplot::plot_grid(jej_diff_taxa_het,colon_diff_taxa_het,lc_diff_taxa_het, lc_diff_taxa_mut)
# Colonic Lumen with MouseID as random

lc_dat <-read.table(here("Analysis_Files/PFF/PFF_Microbiome/differential_taxa/collapsed_ASV_tables/L6_Luminal_Colon_Maaslin2_Sex_Genotype_1-MouseID/all_results.tsv"), header=TRUE)
# 0 significant taxa