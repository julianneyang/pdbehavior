library(Maaslin2)
library(funrar)
library(dplyr)
library(ggplot2)
library(cowplot)
library(here)
library(glue)
library(tidyverse)

here::i_am("Rscripts/ASO/ASO_L2_L6_Maaslin2.R")

### Note: First remove "#Constructed from biom file row"
### Fraction ASV table into respective subsets ---

# Load metadata once
metadata <- read.csv(here("Analysis_Files/ASO/Microbiome/ASO_Metadata_2025.csv"), header=TRUE)
metadata$SampleID <- gsub("-", ".", metadata$SampleID)

# Define function to filter and write data
filter_and_save <- function(level, filter_column, filter_value) {
  data_path <- here(glue("Analysis_Files/ASO/Microbiome/differential_taxa/export_{level}_min_6935_ASO_ASV_table/feature-table.tsv"))
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
  output_file <- here(glue("Analysis_Files/ASO/Microbiome/differential_taxa/ASO_{level}_{filter_column}_{filter_value}.tsv"))
  write.table(filtered_data, file=output_file, sep="\t", row.names = TRUE)
}


# Loop through multiple Site values
site_values <- c("JEJ", "CEC", "COL")
for (site in site_values) {
  filter_and_save("L2", "Site", site)
  filter_and_save("L6", "Site", site)
}

# Single call for a Subset value
filter_and_save("L2", "Subset", "Luminal_Colon")
filter_and_save("L6", "Subset", "Luminal_Colon")


run_Maaslin2_genotype <- function(counts_filepath, metadata_filepath, subset_string, fixed_effects = c("Genotype")) {
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
  readr::write_rds(Relative_Abundance, paste0(here("Analysis_Files/ASO/Microbiome/differential_taxa/"),"Relative_Abundance_", subset_string, "_ASV.RDS"))
  
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
  
  output_dir <- paste0(here("Analysis_Files/ASO/Microbiome/differential_taxa/"),subset_string, "_Maaslin2_", fixed_effects_label)
  
  # Run Maaslin2
  fit_data <- Maaslin2(
    input_data = df_input_data,
    input_metadata = df_input_metadata,
    output = output_dir,
    fixed_effects = fixed_effects,
    normalization = "TSS",
    min_prevalence = 0.15,
    transform = "log",
    plot_heatmap = FALSE,
    plot_scatter = FALSE
  )
}


run_Maaslin2_genotype(counts_filepath =   here("Analysis_Files/ASO/Microbiome/differential_taxa/ASO_L6_Subset_Luminal_Colon.tsv"),
                      metadata_filepath = here("Analysis_Files/ASO/Microbiome/ASO_Metadata_2025.csv"),
                      subset_string = "L6_Luminal_Colon",
                      fixed_effects = c("Sex","Site","Genotype"))

counts_filepaths <- c(
  here("Analysis_Files/ASO/Microbiome/differential_taxa/ASO_L2_Site_JEJ.tsv"),
  here("Analysis_Files/ASO/Microbiome/differential_taxa/ASO_L2_Site_CEC.tsv"),
  here("Analysis_Files/ASO/Microbiome/differential_taxa/ASO_L2_Site_COL.tsv"),
  here("Analysis_Files/ASO/Microbiome/differential_taxa/ASO_L6_Site_JEJ.tsv"),
  here("Analysis_Files/ASO/Microbiome/differential_taxa/ASO_L6_Site_CEC.tsv"),
  here("Analysis_Files/ASO/Microbiome/differential_taxa/ASO_L6_Site_COL.tsv"),
  here("Analysis_Files/ASO/Microbiome/differential_taxa/ASO_L2_Subset_Luminal_Colon.tsv"),
  here("Analysis_Files/ASO/Microbiome/differential_taxa/ASO_L6_Subset_Luminal_Colon.tsv")
)

subset_strings <- c("L2_Jejunum", "L2_Cecum", "L2_Colon",
                    "L6_Jejunum", "L6_Cecum", "L6_Colon",
                    "L2_Luminal_Colon", "L6_Luminal_Colon")
metadata_filepath <- here("Analysis_Files/ASO/Microbiome/ASO_Metadata_2025.csv")

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

## Visualization ---
genus_colors <- viridis::plasma(n=8)

# Jejunum : 0 significant taxa at q  < 0.25

# Colon : 
colon_dat <-read.table(here("Analysis_Files/ASO/Microbiome/differential_taxa/L6_Colon_Maaslin2_Sex_Genotype/significant_results.tsv"), header=TRUE)
colon_dat_het <- colon_dat %>% filter(value=="HET")
colon_dat_mut <- colon_dat %>% filter(value=="MUT")
colon_diff_taxa_het <- make_genus_level_taxa_dotplot(ASV_significant_results_dataset = colon_dat_het,
                                               Relative_Abundance_filepath_rds = "Analysis_Files/ASO/Microbiome/differential_taxa/Relative_Abundance_L6_Colon_ASV.RDS",
                                               titlestring = "ASO Colon (HET vs WT) (Genus ~ Sex + Genotype)",
                                               genus_colors, qvalue = 0.25)
colon_diff_taxa_het

colon_diff_taxa_mut <- make_genus_level_taxa_dotplot(ASV_significant_results_dataset = colon_dat_mut,
                                                     Relative_Abundance_filepath_rds = "Analysis_Files/ASO/Microbiome/differential_taxa/Relative_Abundance_L6_Colon_ASV.RDS",
                                                     titlestring = "ASO Colon (MUT vs WT) (Genus ~ Sex + Genotype)",
                                                     genus_colors, qvalue = 0.25)

colon_diff_taxa_mut


# Cecum : 
cecum_dat <-read.table(here("Analysis_Files/ASO/Microbiome/differential_taxa/L6_Cecum_Maaslin2_Sex_Genotype/significant_results.tsv"), header=TRUE)
cecum_dat_het <- cecum_dat %>% filter(value=="HET")
cecum_dat_mut <- cecum_dat %>% filter(value=="MUT")
cecum_diff_taxa_het <- make_genus_level_taxa_dotplot(ASV_significant_results_dataset = cecum_dat_het,
                                                 Relative_Abundance_filepath_rds = "Analysis_Files/ASO/Microbiome/differential_taxa/Relative_Abundance_L6_Cecum_ASV.RDS",
                                                 titlestring = "ASO Cecum (HET vs WT) (Genus ~ Sex + Genotype)",
                                                 genus_colors, qvalue = 0.25)
cecum_diff_taxa_het

cecum_diff_taxa_mut <- make_genus_level_taxa_dotplot(ASV_significant_results_dataset = cecum_dat_mut,
                                                 Relative_Abundance_filepath_rds = "Analysis_Files/ASO/Microbiome/differential_taxa/Relative_Abundance_L6_Cecum_ASV.RDS",
                                                 titlestring = "ASO Cecum (MUT vs WT) (Genus ~ Sex + Genotype)",
                                                 genus_colors, qvalue = 0.25)
cecum_diff_taxa_mut

# Colonic Lumen 

lc_dat <-read.table(here("Analysis_Files/ASO/Microbiome/differential_taxa/L6_Luminal_Colon_Maaslin2_Sex_Genotype/significant_results.tsv"), header=TRUE)
lc_dat_het <- lc_dat %>% filter(value=="HET")
lc_dat_mut <- lc_dat %>% filter(value=="MUT")
lc_diff_taxa_het <- make_genus_level_taxa_dotplot(ASV_significant_results_dataset = lc_dat_het,
                                                     Relative_Abundance_filepath_rds = "Analysis_Files/ASO/Microbiome/differential_taxa/Relative_Abundance_L6_Luminal_Colon_ASV.RDS",
                                                     titlestring = "ASO Colonic Lumen (HET vs WT) (Genus ~ Sex + Genotype)",
                                                     genus_colors, qvalue = 0.25)
lc_diff_taxa_het

lc_diff_taxa_mut <- make_genus_level_taxa_dotplot(ASV_significant_results_dataset = lc_dat_mut,
                                                     Relative_Abundance_filepath_rds = "Analysis_Files/ASO/Microbiome/differential_taxa/Relative_Abundance_L6_Luminal_Colon_ASV.RDS",
                                                     titlestring = "ASO Colonic Lumen (MUT vs WT) (Genus ~ Sex + Genotype)",
                                                     genus_colors, qvalue = 0.25)
lc_diff_taxa_mut


lc_dat <-read.table(here("Analysis_Files/ASO/Microbiome/differential_taxa/L6_Luminal_Colon_Maaslin2_Sex_Site_Genotype/significant_results.tsv"), header=TRUE)
lc_dat_het <- lc_dat %>% filter(value=="HET")
lc_dat_mut <- lc_dat %>% filter(value=="MUT")
lc_diff_taxa_het <- make_genus_level_taxa_dotplot(ASV_significant_results_dataset = lc_dat_het,
                                                  Relative_Abundance_filepath_rds = "Analysis_Files/ASO/Microbiome/differential_taxa/Relative_Abundance_L6_Luminal_Colon_ASV.RDS",
                                                  titlestring = "ASO Colonic Lumen (HET vs WT) (Genus ~ Sex + Site + Genotype)",
                                                  genus_colors, qvalue = 0.25)
lc_diff_taxa_het

lc_diff_taxa_mut <- make_genus_level_taxa_dotplot(ASV_significant_results_dataset = lc_dat_mut,
                                                  Relative_Abundance_filepath_rds = "Analysis_Files/ASO/Microbiome/differential_taxa/Relative_Abundance_L6_Luminal_Colon_ASV.RDS",
                                                  titlestring = "ASO Colonic Lumen (MUT vs WT) (Genus ~ Sex + Site + Genotype)",
                                                  genus_colors, qvalue = 0.25)
lc_diff_taxa_mut
