library(Maaslin2)
library(funrar)
library(dplyr)
library(ggplot2)
library(cowplot)
library(here)
library(glue)
library(tidyverse)

here::i_am("src/ASO/ASO_L2_L6_Maaslin2.R")

### Note: First remove "#Constructed from biom file row"
### Fraction ASV table into respective subsets ---

# Load metadata once
metadata <- read.csv(here("data/ASO/Microbiome/ASO_Metadata_2025.csv"), header=TRUE)
metadata$SampleID <- gsub("-", ".", metadata$SampleID)
metadata <- metadata %>% filter(Omit=="No")

# Define function to filter and write data
filter_and_save <- function(level, filter_column, filter_value) {
  data_path <- here(glue("data/ASO/Microbiome/differential_taxa/export_{level}_min_6935_ASO_ASV_table/feature-table.tsv"))
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
  output_file <- here(glue("data/ASO/Microbiome/differential_taxa/ASO_{level}_{filter_column}_{filter_value}.tsv"))
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
  readr::write_rds(Relative_Abundance, paste0(here("results/ASO/differential_taxa/"),"Relative_Abundance_", subset_string, "_ASV.RDS"))
  
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
  
  output_dir <- paste0(here("results/ASO/differential_taxa/"),subset_string, "_Maaslin2_", fixed_effects_label)
  
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


run_Maaslin2_genotype(counts_filepath =   here("data/ASO/Microbiome/differential_taxa/ASO_L6_Subset_Luminal_Colon.tsv"),
                      metadata_filepath = here("data/ASO/Microbiome/ASO_Metadata_2025.csv"),
                      subset_string = "L6_Luminal_Colon",
                      fixed_effects = c("Sex","Site","Genotype"))

counts_filepaths <- c(
  here("data/ASO/Microbiome/differential_taxa/ASO_L2_Site_JEJ.tsv"),
  here("data/ASO/Microbiome/differential_taxa/ASO_L2_Site_CEC.tsv"),
  here("data/ASO/Microbiome/differential_taxa/ASO_L2_Site_COL.tsv"),
  here("data/ASO/Microbiome/differential_taxa/ASO_L6_Site_JEJ.tsv"),
  here("data/ASO/Microbiome/differential_taxa/ASO_L6_Site_CEC.tsv"),
  here("data/ASO/Microbiome/differential_taxa/ASO_L6_Site_COL.tsv"),
  here("data/ASO/Microbiome/differential_taxa/ASO_L2_Subset_Luminal_Colon.tsv"),
  here("data/ASO/Microbiome/differential_taxa/ASO_L6_Subset_Luminal_Colon.tsv")
)

subset_strings <- c("L2_Jejunum", "L2_Cecum", "L2_Colon",
                    "L6_Jejunum", "L6_Cecum", "L6_Colon",
                    "L2_Luminal_Colon", "L6_Luminal_Colon")
metadata_filepath <- here("data/ASO/Microbiome/ASO_Metadata_2025.csv")


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
jejunum_dat <-read.table(here("results/ASO/differential_taxa/L6_Jejunum_Maaslin2_Sex_Genotype/significant_results.tsv"), header=TRUE)


# Colon : 
colon_dat <-read.table(here("results/ASO/differential_taxa/L6_Colon_Maaslin2_Sex_Genotype/significant_results.tsv"), header=TRUE)
colon_dat_het <- colon_dat %>% filter(value=="HET") # 1 result
colon_dat_mut <- colon_dat %>% filter(value=="MUT") # 0 results
colon_diff_taxa_het <- make_genus_level_taxa_dotplot(ASV_significant_results_dataset = colon_dat_het,
                                               Relative_Abundance_filepath_rds = "results/ASO/differential_taxa/Relative_Abundance_L6_Colon_ASV.RDS",
                                               titlestring = "ASO Colon (HET vs WT) (Genus ~ Sex + Genotype)",
                                               genus_colors, qvalue = 0.25)
colon_diff_taxa_het

significant_feature <- colon_dat %>% filter(value=="HET") %>% 
  pull(feature)

metadata <- read.csv(here("data/ASO/Microbiome/ASO_Metadata_2025.csv")) %>% filter(Omit=="No")
metadata$SampleID <- gsub("-",".", metadata$SampleID)

ASO_counts_colon <- read.delim(here("data/ASO/Microbiome/differential_taxa/ASO_L6_Site_COL.tsv")) %>% 
  t() %>% as.data.frame()

# Step 1: Compute total sum scaling 
ASO_counts_colon_tss <- ASO_counts_colon/ rowSums(ASO_counts_colon)

# Step 2: Compute pseudocounts (half of feature-wise min non-zero values) - this is what's done in Maaslin2
pseudocounts <- apply(ASO_counts_colon_tss, 2, function(col) {
  non_zero_vals <- col[col > 0]
  if (length(non_zero_vals) == 0) return(0)
  min(non_zero_vals) / 2
})

# Step 3: Replace zeros with feature-specific pseudocounts
ASO_counts_colon <- ASO_counts_colon_tss
for (j in seq_along(pseudocounts)) {
  zero_idx <- ASO_counts_colon_tss[, j] == 0
  ASO_counts_colon[zero_idx, j] <- pseudocounts[j]
}

#ASO_counts_colon <- ASO_counts_colon / rowSums(ASO_counts_colon)
ASO_counts_colon <- ASO_counts_colon%>% rownames_to_column("SampleID")


names(ASO_counts_colon) <- gsub(";",".",names(ASO_counts_colon))

ASO_counts_colon <- ASO_counts_colon %>% dplyr::select(c("SampleID",all_of(significant_feature)))
ASO_counts_colon<- merge(ASO_counts_colon, metadata, by="SampleID")
ASO_counts_colon$Genotype <- factor(ASO_counts_colon$Genotype, levels=c("WT", "HET", "MUT"))

ASO_counts_colon <- ASO_counts_colon %>% 
  mutate(Log_transformed_feature = log(!!sym(significant_feature)))

colon_boxplot <-  ASO_counts_colon %>%
  ggplot(aes(x=Genotype,y=!!sym(significant_feature),fill=Genotype)) + 
  geom_boxplot(alpha=0.3) +
  #geom_point(size=3, alpha = 0.7) +
  geom_jitter(width=0.2, size=2) + 
  theme_cowplot(12) +
  theme(legend.position = "none") 

colon_boxplot <- colon_boxplot + scale_y_log10() + ylab("Relative Abundance, log-scaled visually") + 
  ggtitle("ASO Colon: Colidextribacter") + 
  theme(plot.title = element_text(hjust = 0.5))

colon_boxplot

# Cecum : 0 significant DAT 
cecum_dat <-read.table(here("results/ASO/differential_taxa/L6_Cecum_Maaslin2_Sex_Genotype/significant_results.tsv"), header=TRUE)
cecum_dat_het <- cecum_dat %>% filter(value=="HET")
cecum_dat_mut <- cecum_dat %>% filter(value=="MUT")
# cecum_diff_taxa_het <- make_genus_level_taxa_dotplot(ASV_significant_results_dataset = cecum_dat_het,
#                                                  Relative_Abundance_filepath_rds = "Analysis_Files/ASO/Microbiome/differential_taxa/Relative_Abundance_L6_Cecum_ASV.RDS",
#                                                  titlestring = "ASO Cecum (HET vs WT) (Genus ~ Sex + Genotype)",
#                                                  genus_colors, qvalue = 0.25)
# cecum_diff_taxa_het
# 
# cecum_diff_taxa_mut <- make_genus_level_taxa_dotplot(ASV_significant_results_dataset = cecum_dat_mut,
#                                                  Relative_Abundance_filepath_rds = "Analysis_Files/ASO/Microbiome/differential_taxa/Relative_Abundance_L6_Cecum_ASV.RDS",
#                                                  titlestring = "ASO Cecum (MUT vs WT) (Genus ~ Sex + Genotype)",
#                                                  genus_colors, qvalue = 0.25)
# cecum_diff_taxa_mut

# Colonic Lumen 
genotype_colors <- c("HET"="navy", "MUT" = "firebrick")
lc_dat <-read.table(here("results/ASO/differential_taxa/L6_Luminal_Colon_Maaslin2_Sex_Site_Genotype/all_results.tsv"), header=TRUE)
lc_dat_het <- lc_dat %>% filter(value=="HET") %>% filter(qval<0.25) %>% pull(feature)
lc_dat_mut <- lc_dat %>% filter(value=="MUT") %>% filter(qval<0.25) %>% pull(feature)
combined_significant_features <- c(lc_dat_het, lc_dat_mut)
lc_dat <- lc_dat %>% filter(feature %in% combined_significant_features) %>% 
  filter(metadata =="Genotype")

lc_diff_taxa<- make_combined_genus_level_taxa_dotplot(ASV_significant_results_dataset = lc_dat,
                                                     Relative_Abundance_filepath_rds = "results/ASO/differential_taxa/Relative_Abundance_L6_Luminal_Colon_ASV.RDS",
                                                     titlestring = "ASO Colonic Lumen (HET or MUT vs WT) ",
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
                                                      Relative_Abundance_filepath_rds = "results/ASO/differential_taxa/Relative_Abundance_L6_Luminal_Colon_ASV.RDS",
                                                      titlestring = "ASO Colonic Lumen (HET or MUT vs WT) ",
                                                      genotype_colors, qvalue = 1)
lc_diff_taxa + labs(subtitle = "Genus ~ Sex + Site + Genotype")



