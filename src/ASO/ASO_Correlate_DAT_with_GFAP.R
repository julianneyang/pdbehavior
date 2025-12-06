library(here)
library(tidyverse)
library(cowplot)
library(ggplot2)

### Establish location ---

here::i_am("src/ASO/ASO_Correlate_DAT_with_GFAP.R")

### Read in input files ---

ASO_lum_col_counts <- read.delim(here("data/ASO/Microbiome/differential_taxa/ASO_L6_Subset_Luminal_Colon.tsv")) %>% 
  t() %>% as.data.frame()
df_tss <-ASO_lum_col_counts / rowSums(ASO_lum_col_counts )

## ASO GFAP Cell Count-- 
data <- readr::read_csv(here("data/ASO/Analysis_GFAP.csv"))
data$Genotype<-factor(data$Genotype,levels=c("WT","HET","MUT", "Tg_Neg"))
data <- data %>% filter(Genotype!="Tg_Neg")
names(data)
striatum <- data %>% filter(Particle_Size=="3.5-10") %>%
  drop_na(Count)
summary(striatum$Count)

df <- striatum %>%
  group_by(MouseID) %>%
  summarise(Average_GFAP = mean(Count)) %>%
  ungroup()

subset <- unique(striatum %>% select("MouseID","Genotype", "Sex"))
gfap_meta <- merge(df, subset, by= "MouseID")

sex <- read.csv(here("data/ASO/Fig_S5B.csv")) %>%
  unique()
gfap_meta <- gfap_meta %>% 
  select(!c("Sex")) %>%
  inner_join(sex %>% dplyr::select("MouseID","Sex"), by="MouseID") %>%
  unique()
gfap_meta <- gfap_meta %>% 
  mutate(MouseID = replace(MouseID, MouseID == "43/899", "899")) %>%
  mutate(MouseID = replace(MouseID, MouseID == "44/891", "891")) %>%
  mutate(MouseID = replace(MouseID, MouseID == "35", "923")) 

write.csv(gfap_meta, here("data/ASO/GFAP_meta.csv"))


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
ASO_lum_col_counts$MouseID <- as.character(ASO_lum_col_counts$MouseID)

df_correlation <- merge(ASO_lum_col_counts, gfap_meta, by=c("MouseID","Genotype"))


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
# lm_results <- tibble()

# # Loop over k_columns and fit a linear model
# for (k_col in k_columns) {
#   
#   # Fit linear model
#   lmod <- lm(df_correlation[[k_col]] ~ Average_Latency + Sex + Site , data=df_correlation)
#   
#   # Shapiro Test
#   norm <- shapiro.test(df_correlation[[k_col]])$p.value
#   
#   # Extract model summary
#   lmod_summary <- summary(lmod)
#   
#   # Extract p-values for each coefficient
#   p_vals <- coef(lmod_summary)["Average_Latency", "Pr(>|t|)"]
#   
#   # Create a tibble with results for this k_col
#   temp_df <- tibble(
#     k_col = k_col,
#     p_value = p_vals,
#     shapiro_p = norm
#   )
#   
#   # Bind to results
#   lm_results <- bind_rows(lm_results, temp_df)
# }
# 
# # Apply BH correction across taxa (17 tests)
# lm_results <- lm_results %>%
#   mutate(p_adj = p.adjust(p_value, method = "BH"))

# # Save dataframes for SDV file required by JCI
# fig5D <- df_correlation %>% 
#   dplyr::select(MouseID,
#                 SampleID,
#                 Genotype,Sex,Site, 
#                 k__Bacteria.p__Bacillota.c__Bacilli.o__Lactobacillales.f__Lactobacillaceae.g__Lactobacillus,
#                 Average_Latency)
# fig5E <- df_correlation %>% 
#   dplyr::select(MouseID,
#                 SampleID,
#                 Genotype,Sex,Site, 
#                 k__Bacteria.p__Bacillota.c__Bacilli.o__Lactobacillales.f__Lactobacillaceae.g__HT002,
#                 Average_Latency)
# 
# write.csv(fig5D, here("results/ASO/figures/fig_5D.csv"))
# write.csv(fig5D, here("results/ASO/figures/fig_5E.csv"))

# Loop over k_ columns and perform Spearman Correlations
for (k_col in k_columns) {
  
  # Spearman correlation test
  cor_test <- cor.test(df_correlation[[k_col]], df_correlation$Average_GFAP, method = "spearman")
  
  # Create plot title 
  plt_title <- gsub(".*g__","",k_col)
  
  # Generate ggplot
  p <- ggplot(df_correlation, aes_string(x = k_col, y = "Average_GFAP")) +
    geom_point(aes(fill=Genotype),shape = 21, color = "black", stroke = 0.5, alpha = 0.6) +
    geom_smooth(method = "lm", se = TRUE, color = "blue") +
    labs(
      title=plt_title,
      subtitle = paste("Spearman rho =", round(cor_test$estimate, 3), 
                       "| p =", signif(cor_test$p.value, 3)),
      x = gsub(".*o__","",k_col),
      y = "Average GFAP"
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

write_rds(significant_plots, here("results/ASO/figures/lumcol_DAT_correlations_with_GFAP.rds"))

