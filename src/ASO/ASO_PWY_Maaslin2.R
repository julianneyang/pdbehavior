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
filter_and_save <- function(filter_column, filter_value) {
  data_path <- here(glue("Analysis_Files/ASO/Microbiome/picrust2_output/export_pathway_abundance/feature-table.tsv"))
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
  output_file <- here(glue("Analysis_Files/ASO/Microbiome/differential_pathway/ASO_PWY_{filter_column}_{filter_value}.tsv"))
  write.table(filtered_data, file=output_file, sep="\t", row.names = TRUE)
}


# Loop through multiple Site values
site_values <- c("JEJ", "CEC", "COL")
for (site in site_values) {
  filter_and_save("Site", site)
  filter_and_save("Site", site)
}

# Single call for a Subset value
filter_and_save("Subset", "Luminal_Colon")


run_Maaslin2_genotype <- function(counts_filepath, metadata_filepath, subset_string, fixed_effects = c("Genotype")) {
  # Read input table
  input_data <- read.delim(counts_filepath, header = TRUE, row.names = 1)
  df_input_data <- as.data.frame(input_data)
  
  # Convert to relative abundance
  # transposed_input_data <- t(df_input_data)
  # transposed_input_data <- as.matrix(transposed_input_data)
  # df_relative_ASV <- funrar::make_relative(transposed_input_data)
  # df_relative_ASV <- as.data.frame(df_relative_ASV)
  # 
  # Relative_Abundance <- summarize_all(df_relative_ASV, mean)
  # Relative_Abundance <- as.data.frame(t(Relative_Abundance))
  # readr::write_rds(Relative_Abundance, paste0(here("Analysis_Files/ASO/Microbiome/differential_pathway/"),"Relative_Abundance_", subset_string, "_ASV.RDS"))
  
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
  
  output_dir <- paste0(here("Analysis_Files/ASO/Microbiome/differential_pathway/"),subset_string, "_Maaslin2_", fixed_effects_label)
  
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


run_Maaslin2_genotype(counts_filepath =   here("Analysis_Files/ASO/Microbiome/differential_pathway/ASO_PWY_Subset_Luminal_Colon.tsv"),
                      metadata_filepath = here("Analysis_Files/ASO/Microbiome/ASO_Metadata_2025.csv"),
                      subset_string = "PWY_Luminal_Colon",
                      fixed_effects = c("Sex","Site","Genotype"))

counts_filepaths <- c(
  here("Analysis_Files/ASO/Microbiome/differential_pathway/ASO_PWY_Site_CEC.tsv"),
  here("Analysis_Files/ASO/Microbiome/differential_pathway/ASO_PWY_Site_COL.tsv"),
  here("Analysis_Files/ASO/Microbiome/differential_pathway/ASO_PWY_Site_JEJ.tsv")
 )

subset_strings <- c("PWY_Cecum", "PWY_Colon",
                    "PWY_Jejunum")
metadata_filepath <- here("Analysis_Files/ASO/Microbiome/ASO_Metadata_2025.csv")

# purrr::pwalk(
#   list(counts_filepaths, subset_strings),
#   ~ run_Maaslin2_genotype(
#     counts_filepath = ..1,
#     metadata_filepath = metadata_filepath,
#     subset_string = ..2,
#     fixed_effects = "Genotype"
#   )
# )

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

# Jejunum : 0 significant pathways at q  < 0.25
jej_pwy <-read.table(here("Analysis_Files/ASO/Microbiome/differential_pathway/PWY_Jejunum_Maaslin2_Sex_Genotype/significant_results.tsv"), header=TRUE)


# Colon : 0 significant pathways at q < 0.25
colon_pwy  <-read.table(here("Analysis_Files/ASO/Microbiome/differential_pathway/PWY_Colon_Maaslin2_Sex_Genotype/significant_results.tsv"), header=TRUE)


# Cecum : 
# Read in data
cecum_pwy <- read.table(here("Analysis_Files/ASO/Microbiome/differential_pathway/PWY_Cecum_Maaslin2_Sex_Genotype/significant_results.tsv"), header = TRUE)

# Read and clean annotation
annotation <- read.delim(here("Analysis_Files/ASO/Microbiome/picrust2_output/export_pathway_abundance/annotated_pwy.tsv"), row.names = 1) %>%
  tibble::rownames_to_column("feature") %>%
  mutate(feature = gsub("-", ".", feature)) %>%
  select(feature, description)

# Merge annotation into main table
cecum_pwy <- left_join(cecum_pwy, annotation, by = "feature")

# Define a plotting function
plot_pwy <- function(df, genotype_label,title) {
  df %>%
    filter(value == genotype_label) %>%
    mutate(Genotype = ifelse(coef < 0, "WT", value)) %>%
    ggplot(aes(x = coef, y = reorder(description, coef), fill = Genotype)) +
    geom_col() +
    labs(
      x = "Coefficient",
      y = "Description",
      title = paste(title, genotype_label, "~Sex + Genotype")
    ) +
    theme_cowplot(12) +
    theme(axis.text.y = element_text(size = 10))
}

# Generate plots
plot_pwy(cecum_pwy, "HET", "ASO Cecum:")
plot_pwy(cecum_pwy, "MUT", "ASO Cecum:")

# Colonic Lumen 
# Read in data
lc_pwy <- read.delim(here("results/ASO/differential_pathway/PWY_Luminal_Colon_Maaslin2_Sex_Site_Genotype/all_results.tsv"), header = TRUE)
lc_pwy_het <- lc_pwy %>% filter(value=="HET") %>% filter(qval<0.25) %>% pull(feature)
lc_pwy_mut <- lc_pwy%>% filter(value=="MUT") %>% filter(qval<0.25) %>% pull(feature)
combined_significant_features <- c(lc_pwy_het, lc_pwy_mut)
lc_pwy <- lc_pwy %>% filter(feature %in% combined_significant_features) %>% 
  filter(metadata =="Genotype")

# Restrict visualization just to features agreeing in direction in both HET and MUT 
lc_pwy_filtered <- lc_pwy %>%
  group_by(feature) %>%
  filter(all(c("HET", "MUT") %in% value)) %>%
  filter({
    het_coef <- coef[value == "HET"]
    mut_coef <- coef[value == "MUT"]
    length(het_coef) == 1 && length(mut_coef) == 1 &&
      ((het_coef > 0 & mut_coef > 0) | (het_coef < 0 & mut_coef < 0))
  }) %>%
  ungroup() 

write_rds(lc_pwy_filtered, here("results/ASO/differential_pathway/ASO_Combined_Significant_PWY.RDS"))

# Read and clean annotation
annotation <- read.delim(here("data/ASO/Microbiome/picrust2_output/export_pathway_abundance/annotated_pwy.tsv"), row.names = 1) %>%
  tibble::rownames_to_column("feature") %>%
  mutate(feature = gsub("-", ".", feature)) %>%
  select(feature, description)

# Merge annotation into main table
lc_pwy <- inner_join(lc_pwy_filtered, annotation, by = "feature")

# Add higher-order annotations
higher_classification <- read.delim(here("data/Huttenhower_MetaCyc_Hierarchy.txt"),header=TRUE)
df <- higher_classification
df_split <- strsplit(df$annotation, "\\|")
df_new <- data.frame(do.call(rbind, df_split))
df_new$feature <- higher_classification$feature
df_new$feature <- gsub("-",".",df_new$feature)

data <- merge(lc_pwy,df_new, by="feature")
# data <- data %>% mutate(coef_abs = abs(coef))

plot <- data %>% 
  filter(coef< -0.5) %>% 
  select(c("description", "X2")) %>%
  unique()

plot$description <- str_wrap(plot$description, width=50)

mat <- plot
circos.clear()
dev.new(width=10,height=10)
chordDiagram(mat,annotationTrack = "grid",preAllocateTracks = list(track.height = max(strwidth(unlist(dimnames(mat))))))
obj <- circos.track(track.index = 1, panel.fun = function(x, y) {
  circos.text(CELL_META$xcenter, CELL_META$ylim[1], CELL_META$sector.index, 
              facing = "clockwise", niceFacing = TRUE, adj = 0.4,
              cex=1)
}, bg.border = NA) 


plot <- data %>% 
  filter(coef> 0.5) %>% 
  select(c("description", "X2")) %>%
  unique()

plot$description <- str_wrap(plot$description, width=50)

mat <- plot
circos.clear()
dev.new(width=10,height=10)
chordDiagram(mat,annotationTrack = "grid",preAllocateTracks = list(track.height = max(strwidth(unlist(dimnames(mat))))))
obj <- circos.track(track.index = 1, panel.fun = function(x, y) {
  circos.text(CELL_META$xcenter, CELL_META$ylim[1], CELL_META$sector.index, 
              facing = "clockwise", niceFacing = TRUE, adj = 0.4,
              cex=1)
}, bg.border = NA) 



