library(here)
library(tidyverse)
library(cowplot)
library(ggplot2)

### Establish location ---

here::i_am("src/ASO/ASO_Correlate_DAT_with_Rotarod.R")

### Read in input files ---

ASO_rotarod <- read.csv(here("data/ASO/ASO Rotarod - Rotarod.csv"))
ASO_rotarod <- ASO_rotarod %>% filter(Day=="One") %>%
  filter(ASO_Tg=="Positive") %>%
  dplyr::select(c("MouseID", "Average_Latency"))

msid_conversion <- read.csv(here("data/ASO/ASO_From_Rotarod_To_Counts_MouseID.csv"))
msid_conversion$MouseID <- msid_conversion$From
ASO_rotarod <- ASO_rotarod %>%
  left_join(msid_conversion,by="MouseID") %>%
  mutate(MouseID=ifelse(is.na(From),MouseID,To)) %>% 
  dplyr::select(c("MouseID", "Average_Latency")) %>%
  unique()
# ASO_rotarod <- ASO_rotarod %>%
#   group_by(MouseID) %>%
#   mutate(Average_Latency = mean(Average_Latency, na.rm = TRUE)) %>%
#   ungroup() %>% 
#   dplyr::select(c("MouseID","Average_Latency")) %>% 
#   unique()

### Read in microbiome counts and do relative abundance followed by log normalization
ASO_lum_col_counts <- read.delim(here("data/ASO/Microbiome/differential_taxa/ASO_L6_Subset_Luminal_Colon.tsv")) %>% 
  t() %>% as.data.frame()
df_tss <-ASO_lum_col_counts / rowSums(ASO_lum_col_counts )
df_tss <- df_tss %>%
  select(where(~ any(. != 0)))

normality_results <- df_tss %>%
  summarise(across(everything(), ~ {
    if (length(na.omit(.x)) < 3) {
      return(NA)  # Shapiro-Wilk requires at least 3 values
    } else {
      shapiro.test(.x)$p.value
    }
  }))

# Transpose to get results in long format
normality_long <- normality_results %>%
  pivot_longer(everything(), names_to = "Feature", values_to = "Shapiro_P")

# Add a column to flag features that are normally distributed (e.g., p > 0.05)
normality_long <- normality_long %>%
  mutate(Normal = Shapiro_P > 0.05)

# # Compute feature-wise pseudocounts
# # Extract column-wise (feature-wise) minimum non-zero values and divide by 2
# pseudocounts <- df_tss %>%
#   summarise(across(everything(), ~ {
#     nz <- .x[.x > 0]
#     if (length(nz) == 0) 0 else min(nz) / 2
#   }))
# 
# # Replace zeros with pseudocounts using mutate + ifelse
# df_tss_pseudo <- df_tss %>%
#   rownames_to_column(var = "SampleID") %>%
#   mutate(across(-SampleID, ~ ifelse(.x == 0, pseudocounts[[cur_column()]], .x)))
# 
# #  Re-normalize so rows sum to 1 again
# df_tss_final <- df_tss_pseudo %>%
#   rowwise() %>%
#   mutate(across(-SampleID, ~ .x / sum(c_across(-SampleID), na.rm = TRUE))) %>%
#   ungroup()
# 
# # log-normalize (log base 2 same as in Maaslin2)
# df_log_normalized <- df_tss_final %>%
#   mutate(across(-SampleID, log2)) %>%
#   column_to_rownames("SampleID")

### Pull out significant DAT
ASO_significant <- read_rds(here("results/ASO/differential_taxa/ASO_Combined_Significant_Genera.RDS"))
significant_feature <- ASO_significant$feature
metadata <- read.csv(here("data/ASO/Microbiome/ASO_Metadata_2025.csv"), header=TRUE)
metadata$SampleID <- gsub("-", ".", metadata$SampleID)

### Wrangle count data, append metadata and Rotarod data ---

ASO_lum_col_counts  <- df_tss %>% rownames_to_column("SampleID")
names(ASO_lum_col_counts) <- gsub(";",".",names(ASO_lum_col_counts ))
names(ASO_lum_col_counts) <- gsub("\\ ",".",names(ASO_lum_col_counts ))
names(ASO_lum_col_counts) <- gsub("-",".",names(ASO_lum_col_counts ))
names(ASO_lum_col_counts) <- gsub("\\[",".",names(ASO_lum_col_counts ))
names(ASO_lum_col_counts) <- gsub("\\]",".",names(ASO_lum_col_counts ))
ASO_lum_col_counts  <- ASO_lum_col_counts %>% dplyr::select(c("SampleID",all_of(significant_feature)))

ASO_lum_col_counts<- merge(ASO_lum_col_counts, metadata, by="SampleID")
df_correlation <- merge(ASO_lum_col_counts, ASO_rotarod, by="MouseID")

### Produce scatterplots ---

# Declare Genotype as factor 
df_correlation$Genotype <- factor(df_correlation$Genotype, levels=c("WT", "HET", "MUT"))

# Get names of k_ columns
k_columns <- df_correlation %>% select(starts_with("k_")) %>% names()

# Initialize empty list to store plots
plot_list <- list()

# Initialize empty tibble to store correlation results
results <- tibble()

# Declare color vector 
genotype_cols <- c("WT"="black", "HET"="navy","MUT"="firebrick")

# Initialize empty tibble to store correlation results
lm_results <- tibble()

# Loop over k_columns and fit a linear model
for (k_col in k_columns) {
  
  # Fit linear model
  lmod <- lm(df_correlation[[k_col]] ~ Average_Latency + Sex + Site , data=df_correlation)
  
  # Shapiro Test
  norm <- shapiro.test(df_correlation[[k_col]])$p.value
  
  # Extract model summary
  lmod_summary <- summary(lmod)
  
  # Extract p-values for each coefficient
  p_vals <- coef(lmod_summary)["Average_Latency", "Pr(>|t|)"]
  
  # Create a tibble with results for this k_col
  temp_df <- tibble(
    k_col = k_col,
    p_value = p_vals,
    shapiro_p = norm
  )
  
  # Bind to results
  lm_results <- bind_rows(lm_results, temp_df)
}

# Apply BH correction across taxa (17 tests)
lm_results <- lm_results %>%
  mutate(p_adj = p.adjust(p_value, method = "BH"))

# Loop over k_ columns and perform Spearman Correlations
for (k_col in k_columns) {
  
  # Spearman correlation test
  cor_test <- cor.test(df_correlation[[k_col]], df_correlation$Average_Latency, method = "spearman")
  
  # Create plot title 
  plt_title <- gsub(".*g__","",k_col)
  
  # Generate ggplot
  p <- ggplot(df_correlation, aes_string(x = k_col, y = "Average_Latency")) +
    geom_point(aes(fill=Genotype),shape = 21, color = "black", stroke = 0.5, alpha = 0.6) +
    geom_smooth(method = "lm", se = TRUE, color = "blue") +
    labs(
      title=plt_title,
      subtitle = paste("Spearman rho =", round(cor_test$estimate, 3), 
                       "| p =", signif(cor_test$p.value, 3)),
      x = gsub(".*o__","",k_col),
      y = "Average Latency Day One"
    ) +
    theme_cowplot(10) +
    theme(legend.position = "top")+
    scale_fill_manual(values=genotype_cols) +
    xlab("") + 
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

write_rds(significant_plots, here("results/ASO/figures/lumcol_DAT_correlations.RDS"))
