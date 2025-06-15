library(here)
library(tidyverse)

here::i_am("src/PFF/PFF_Correlate_DAT_with _Rotarod.R")

### Read in input files ---

PFF_rotarod <- read.csv(here("data/PFF/PFF Rotarod - PFF_Rotarod_Analysis.csv"))
PFF_rotarod <- PFF_rotarod %>% filter(Day=="one") %>%
  dplyr::select(c("MouseID", "Average_Latency"))
# PFF_rotarod <- PFF_rotarod %>%
#   group_by(MouseID) %>%
#   mutate(Average_Latency = mean(Average_Latency, na.rm = TRUE)) %>%
#   ungroup() %>% 
#   dplyr::select(c("MouseID","Average_Latency")) %>% 
#   unique()
  
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
df_correlation <- merge(PFF_lum_col_counts, PFF_rotarod, by="MouseID")

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
  cor_test <- cor.test(df_correlation[[k_col]], df_correlation$Average_Latency, method = "spearman")
  
  # Generate ggplot
  p <- ggplot(df_correlation, aes_string(x = k_col, y = "Average_Latency",color="Genotype")) +
    geom_point(alpha = 0.6) +
    geom_smooth(method = "lm", se = TRUE, color = "blue") +
    labs(
      subtitle = paste("Spearman rho =", round(cor_test$estimate, 3), 
                    "| p =", signif(cor_test$p.value, 3)),
      x = k_col,
      y = "Average Latency"
    ) +
    theme_cowplot(12) +
    scale_color_manual(values=genotype_cols)
  
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

# Plot significant results 
eubacterium_siraeum <- plot_list[[6]]
eubacterium_siraeum
clostridium_sensu_stricto <- plot_list[[12]]
clostridium_sensu_stricto
bacteroides <- plot_list[[14]]
bacteroides
