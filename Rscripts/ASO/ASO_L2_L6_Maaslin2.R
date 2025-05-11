library(Maaslin2)
library(funrar)
library(dplyr)
library(ggplot2)
library(cowplot)
library(here)
library(glue)

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
  df_relative_ASV <- make_relative(transposed_input_data)
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
# Jejunum
data<-read.table(here("Analysis_Files/ASO/Microbiome/differential_taxa/L6_Luminal_Colon_Maaslin2_Sex_Genotype/significant_results.tsv"), header=TRUE)
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
