library(Rtsne)
library(here)
library(dplyr)
library(ggplot2)
library(cowplot)

### Compiling PFF data into one single sheet

## Rotarod -- 
data <- readr::read_csv(here("data", "PFF","PFF Rotarod - PFF_Rotarod_Analysis.csv"))
summary_rotarod <- data %>%
  group_by(MouseID) %>%
  summarise(mean_latency = mean(Average_Latency))

## Wire Hang --
wire_hang <- readr::read_csv(here("data", "PFF", "PFF_Wire_Hang - Wire_Hang.csv"))
wire_hang <- wire_hang %>% filter(DPI==150)

## Pole Test --
grip <- readr::read_csv(here("data", "PFF","PFF_Forelimb_Grip_Strength.csv"))


## Ensure that MouseIDs are found in all datasets --
list1 <- unique(intersect(wire_hang$MouseID, summary_rotarod$MouseID))
list2 <- unique(intersect(grip$MouseID, list1))
setdiff(list1,list2)

## Merge values for dim reduction --
df_1 <- merge(wire_hang, grip, by="MouseID")
df_2 <- merge(df_1, summary_rotarod, by="MouseID")
df_motor <- df_2 %>% select(c("MouseID","Total_Hang_Time","Average", "mean_latency"))

# Define the columns to normalize
cols_to_normalize <- (c("Total_Hang_Time","Average", "mean_latency"))

# Apply min-max normalization to the selected columns
df_normalized <- df_motor %>%
  mutate(across(all_of(cols_to_normalize), ~ (.-min(.))/(max(.)-min(.)), .names = "norm_{.col}"))

# Select the columns for PCA
pca_data <- df_normalized %>%
  select(norm_Total_Hang_Time, norm_Average, norm_mean_latency)

## Perform PCA --
pca_result <- prcomp(pca_data, scale. = FALSE)  # Set scale. to TRUE if you want to scale the variables

# Extract the results
pca_summary <- summary(pca_result)
pca_variance <- pca_summary$sdev^2  # Variance explained by each principal component
pve <- pca_variance/sum(pca_variance) #compute the proportion of variance explained
pve 
pca_loadings <- pca_result$rotation  # Loadings (coefficients) of each variable on each PC

# You can also access the scores of each observation on each PC
pca_scores_df <- data.frame(MouseID = df_normalized$MouseID, pca_result$x)

# Merge the PCA scores with the original DataFrame based on "MouseID"
subset <- wire_hang %>% select(c("SLC_Genotype","MouseID","Sex"))
merged_df <- merge(subset,pca_scores_df,by="MouseID")
merged_df$Genotype <- merged_df$SLC_Genotype

# Visualize the PCA scores
cols <- c("WT"="black", "HET"="navy", "MUT"="firebrick")
pff_behavior_pca <- ggplot(merged_df, aes(x = PC1, y = PC2, color =Genotype)) +
  geom_point(size=3) +
  labs(title = "PFF Motor Phenotypes",
       x = paste0("PC1 (", signif(pve[1]*100, digits=2),"%)"), 
       y = paste0("PC2 (", signif(pve[2]*100,digits=2), "%)")) +
  theme_cowplot(12) +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(legend.position = "top", legend.justification = "center" )+
  scale_color_manual(values=cols, name="Genotype")

pff_behavior_pca 
write_rds(pff_behavior_pca, here("results/PFF/figures/motor_behavior_pca.RDS"))

# ## Perform tSNE
# # Select the columns for t-SNE
# tsne_data <- df_normalized %>%
#   select(norm_Total_Hang_Time, norm_Average, norm_mean_latency)
# 
# # Perform t-SNE
# tsne_result <- Rtsne(tsne_data, dims = 2, perplexity =6, verbose = TRUE)  # You can adjust perplexity as needed
# 
# # Extract the t-SNE coordinates
# tsne_coordinates <- tsne_result$Y
# tsne_df <- data.frame(MouseID = df_normalized$MouseID, tsne_coordinates)
# merged_df <- merge(subset,tsne_df,by="MouseID")
# 
# ggplot(merged_df, aes(x = X1, y = X2, color=Genotype)) +
#   geom_point() +
#   labs(title = "t-SNE Visualization", x = "t-SNE Dimension 1", y = "t-SNE Dimension 2")

