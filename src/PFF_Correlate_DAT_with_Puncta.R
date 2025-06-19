library(here)
library(tidyverse)
library(cowplot)
library(ggplot2)

### Establish location ---

here::i_am("src/PFF/PFF_Correlate_DAT_with _Rotarod.R")

### Read in input files ---

PFF_lum_col_counts <- read.delim(here("data/PFF/PFF_Microbiome/differential_taxa/collapsed_ASV_tables/PFF_L6_Subset_Luminal_Colon.tsv")) %>% 
  t() %>% as.data.frame()
PFF_lum_col_counts <-PFF_lum_col_counts / rowSums(PFF_lum_col_counts )
PFF_significant <- read_rds(here("results/PFF/differential_taxa/PFF_Combined_Significant_Genera.RDS"))
significant_feature <- PFF_significant$feature
metadata <- read.csv(here("data/PFF/PFF_Microbiome/starting_files/PFF_Mapping.csv"), header=TRUE)
metadata$SampleID <- gsub("-", ".", metadata$SampleID)

### Wrangle count data, append metadata and Rotarod data ---

PFF_lum_col_counts  <- PFF_lum_col_counts %>% rownames_to_column("SampleID")
names(PFF_lum_col_counts) <- gsub(";",".",names(PFF_lum_col_counts ))
names(PFF_lum_col_counts) <- gsub("\\ ",".",names(PFF_lum_col_counts ))
names(PFF_lum_col_counts) <- gsub("-",".",names(PFF_lum_col_counts ))
names(PFF_lum_col_counts) <- gsub("\\[",".",names(PFF_lum_col_counts ))
names(PFF_lum_col_counts) <- gsub("\\]",".",names(PFF_lum_col_counts ))
PFF_lum_col_counts  <- PFF_lum_col_counts %>% dplyr::select(c("SampleID",all_of(significant_feature)))

PFF_lum_col_counts<- merge(PFF_lum_col_counts, metadata, by="SampleID")
df_correlation <- PFF_lum_col_counts

### Produce scatterplots ---

# Get names of k_ columns
k_columns <- df_correlation %>% select(starts_with("k_")) %>% names()

# Initialize empty list to store plots
plot_list <- list()

# Initialize empty tibble to store correlation results
results <- tibble()

# Declare color vector 
genotype_cols <- c("WT"="black", "HET"="navy","MUT"="firebrick")


# Loop over k_ columns
for (k_col in k_columns) {
  
  # Spearman correlation test
  cor_test <- cor.test(df_correlation[[k_col]], df_correlation$Ipsilateral_Puncta, method = "spearman")
  
  # Create plot title 
  plt_title <- gsub(".*g__","",k_col)
  
  # Generate ggplot
  p <- ggplot(df_correlation, aes_string(x = k_col, y = "Ipsilateral_Puncta")) +
    geom_point(aes(fill=Genotype),shape = 21, color = "black", stroke = 0.5, alpha = 0.6) +
    geom_smooth(method = "lm", se = TRUE, color = "blue") +
    labs(
      title=plt_title,
      subtitle = paste("Spearman rho =", round(cor_test$estimate, 3), 
                       "| p =", signif(cor_test$p.value, 3)),
      x = gsub(".*o__","",k_col),
      y = "Ipsilateral Puncta"
    ) +
    theme_cowplot(10) +
    scale_fill_manual(values=genotype_cols) +
    theme(
      plot.title = element_text(hjust = 0.5),
      plot.subtitle = element_text(hjust = 0.5)
    )
  
  # Store plot in list with name
  plot_list[[k_col]] <- p
  
  # Append correlation result
  results <- bind_rows(results, tibble(
    feature = k_col,
    spearman_rho = cor_test$estimate,
    p_value = cor_test$p.value
  ))
}



# Adjust p-values using Benjamini-Hochberg to get q-values
results <- results %>%
  mutate(qval = p.adjust(p_value, method = "BH"))

# View correlation results
print(results)

# Filter features with q-value < 0.25
significant_features <- results %>%
  filter(qval < 0.25) %>%
  pull(feature)

# Subset the plot list
significant_plots <- plot_list[significant_features]

# Convert list to a plot grid using cowplot
if (length(significant_plots) > 0) {
  grid_plot <- plot_grid(plotlist = significant_plots, ncol = 2, align = "hv")
  print(grid_plot)
} else {
  message("No plots with qval < 0.25")
}

### Contralateral puncta ---

# Get names of k_ columns
k_columns <- df_correlation %>% select(starts_with("k_")) %>% names()

# Initialize empty list to store plots
plot_list <- list()

# Initialize empty tibble to store correlation results
results <- tibble()

# Declare color vector 
genotype_cols <- c("WT"="black", "HET"="navy","MUT"="firebrick")


# Loop over k_ columns
for (k_col in k_columns) {
  
  # Spearman correlation test
  cor_test <- cor.test(df_correlation[[k_col]], df_correlation$Contralateral_Puncta, method = "spearman")
  
  # Create plot title 
  plt_title <- gsub(".*g__","",k_col)
  
  # Generate ggplot
  p <- ggplot(df_correlation, aes_string(x = k_col, y = "Contralateral_Puncta")) +
    geom_point(aes(fill=Genotype),shape = 21, color = "black", stroke = 0.5, alpha = 0.6) +
    geom_smooth(method = "lm", se = TRUE, color = "blue") +
    labs(
      title=plt_title,
      subtitle = paste("Spearman rho =", round(cor_test$estimate, 3), 
                       "| p =", signif(cor_test$p.value, 3)),
      x = gsub(".*o__","",k_col),
      y = "Contralateral Puncta"
    ) +
    theme_cowplot(10) +
    scale_fill_manual(values=genotype_cols) +
    theme(
      plot.title = element_text(hjust = 0.5),
      plot.subtitle = element_text(hjust = 0.5)
    )
  
  # Store plot in list with name
  plot_list[[k_col]] <- p
  
  # Append correlation result
  results <- bind_rows(results, tibble(
    feature = k_col,
    spearman_rho = cor_test$estimate,
    p_value = cor_test$p.value
  ))
}



# Adjust p-values using Benjamini-Hochberg to get q-values
results <- results %>%
  mutate(qval = p.adjust(p_value, method = "BH"))

# View correlation results
print(results)

# Filter features with q-value < 0.25
significant_features <- results %>%
  filter(qval < 0.25) %>%
  pull(feature)

# Subset the plot list
significant_plots <- plot_list[significant_features]

# Convert list to a plot grid using cowplot
if (length(significant_plots) > 0) {
  grid_plot <- plot_grid(plotlist = significant_plots, ncol = 2, align = "hv")
  print(grid_plot)
} else {
  message("No plots with qval < 0.25")
}

# No significant correlations

### Ipsilateral TH  ---

# Get names of k_ columns
k_columns <- df_correlation %>% select(starts_with("k_")) %>% names()

# Initialize empty list to store plots
plot_list <- list()

# Initialize empty tibble to store correlation results
results <- tibble()

# Declare color vector 
genotype_cols <- c("WT"="black", "HET"="navy","MUT"="firebrick")


# Loop over k_ columns
for (k_col in k_columns) {
  
  # Spearman correlation test
  cor_test <- cor.test(df_correlation[[k_col]], df_correlation$Ipsilateral_TH, method = "spearman")
  
  # Create plot title 
  plt_title <- gsub(".*g__","",k_col)
  
  # Generate ggplot
  p <- ggplot(df_correlation, aes_string(x = k_col, y = "Ipsilateral_TH")) +
    geom_point(aes(fill=Genotype),shape = 21, color = "black", stroke = 0.5, alpha = 0.6) +
    geom_smooth(method = "lm", se = TRUE, color = "blue") +
    labs(
      title=plt_title,
      subtitle = paste("Spearman rho =", round(cor_test$estimate, 3), 
                       "| p =", signif(cor_test$p.value, 3)),
      x = gsub(".*o__","",k_col),
      y = "Ipsilateral_TH"
    ) +
    theme_cowplot(10) +
    scale_fill_manual(values=genotype_cols) +
    theme(
      plot.title = element_text(hjust = 0.5),
      plot.subtitle = element_text(hjust = 0.5)
    )
  
  # Store plot in list with name
  plot_list[[k_col]] <- p
  
  # Append correlation result
  results <- bind_rows(results, tibble(
    feature = k_col,
    spearman_rho = cor_test$estimate,
    p_value = cor_test$p.value
  ))
}



# Adjust p-values using Benjamini-Hochberg to get q-values
results <- results %>%
  mutate(qval = p.adjust(p_value, method = "BH"))

# View correlation results
print(results)

# Filter features with q-value < 0.25
significant_features <- results %>%
  filter(qval < 0.25) %>%
  pull(feature)

# Subset the plot list
significant_plots <- plot_list[significant_features]

# Convert list to a plot grid using cowplot
if (length(significant_plots) > 0) {
  grid_plot <- plot_grid(plotlist = significant_plots, ncol = 2, align = "hv")
  print(grid_plot)
} else {
  message("No plots with qval < 0.25")
}

### Contralateral TH  ---

# Get names of k_ columns
k_columns <- df_correlation %>% select(starts_with("k_")) %>% names()

# Initialize empty list to store plots
plot_list <- list()

# Initialize empty tibble to store correlation results
results <- tibble()

# Declare color vector 
genotype_cols <- c("WT"="black", "HET"="navy","MUT"="firebrick")


# Loop over k_ columns
for (k_col in k_columns) {
  
  # Spearman correlation test
  cor_test <- cor.test(df_correlation[[k_col]], df_correlation$Contralateral_TH, method = "spearman")
  
  # Create plot title 
  plt_title <- gsub(".*g__","",k_col)
  
  # Generate ggplot
  p <- ggplot(df_correlation, aes_string(x = k_col, y = "Contralateral_TH")) +
    geom_point(aes(fill=Genotype),shape = 21, color = "black", stroke = 0.5, alpha = 0.6) +
    geom_smooth(method = "lm", se = TRUE, color = "blue") +
    labs(
      title=plt_title,
      subtitle = paste("Spearman rho =", round(cor_test$estimate, 3), 
                       "| p =", signif(cor_test$p.value, 3)),
      x = gsub(".*o__","",k_col),
      y = "Contralateral_TH"
    ) +
    theme_cowplot(10) +
    scale_fill_manual(values=genotype_cols) +
    theme(
      plot.title = element_text(hjust = 0.5),
      plot.subtitle = element_text(hjust = 0.5)
    )
  
  # Store plot in list with name
  plot_list[[k_col]] <- p
  
  # Append correlation result
  results <- bind_rows(results, tibble(
    feature = k_col,
    spearman_rho = cor_test$estimate,
    p_value = cor_test$p.value
  ))
}



# Adjust p-values using Benjamini-Hochberg to get q-values
results <- results %>%
  mutate(qval = p.adjust(p_value, method = "BH"))

# View correlation results
print(results)

# Filter features with q-value < 0.25
significant_features <- results %>%
  filter(qval < 0.25) %>%
  pull(feature)

# Subset the plot list
significant_plots <- plot_list[significant_features]

# Convert list to a plot grid using cowplot
if (length(significant_plots) > 0) {
  grid_plot <- plot_grid(plotlist = significant_plots, ncol = 2, align = "hv")
  print(grid_plot)
} else {
  message("No plots with qval < 0.25")
}

