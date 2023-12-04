library(Rtsne)
library(here)
library(dplyr)
library(ggplot2)
library(cowplot)

### Compiling ASO data into one single sheet

## Rotarod -- 
data <- readr::read_csv(here("Analysis_Files", "ASO","ASO Rotarod - Rotarod.csv"))
subset <- data %>% select(c("MouseID","ASO_Tg"))
summary_rotarod <- data %>%
  group_by(MouseID) %>%
  summarise(mean_latency = mean(Average_Latency))
summary_rotarod <- unique(merge(summary_rotarod, subset, by="MouseID"))

## Wire Hang --
df <- readr::read_csv(here("Analysis_Files", "ASO","ASO Wire Hang - Wire_Hang.csv"))
df$SLC_Genotype <- factor(df$SLC_Genotype, levels= c("WT","HET", "MUT"))

df <- df %>%
  group_by(MouseID) %>%
  mutate(Exclusion = ifelse(all(Sincerity_Score_Relaxed == "Insincere"), "Yes", "No")) 
v1 <- unique(df$MouseID)

# Remove rows with Exclusion = "Yes"
df_excluded <- df %>% 
  filter(Exclusion =="Yes")
df_filtered <- df %>%
  filter(Exclusion != "Yes")

# Filter for mice with one Insincere trial and one Sincere trial, retain Sincere trial
df_filtered_2 <- df_filtered %>%
  group_by(MouseID) %>%
  filter(n_distinct(Sincerity_Score_Relaxed) > 1) %>%
  filter(Sincerity_Score_Relaxed == "Sincere")

# For mice with two Sincere trials, retain trial with greater Time value
df_filtered_greater<- df_filtered %>%
  group_by(MouseID) %>%
  filter(n_distinct(Sincerity_Score_Relaxed) == 1) %>%
  filter(n_distinct(Trial) == 2) %>%
  mutate(max_time = max(Time)) %>%
  filter(Time == max_time) %>%
  select(-max_time)

# For mice with one trials, retain trial 
df_one_trial<- df_filtered %>%
  group_by(MouseID) %>%
  filter(n_distinct(Trial) == 1)

# Combine with mice having only one Sincere trial
wire_hang <- rbind(df_filtered_2, df_filtered_greater) 
wire_hang <- rbind(wire_hang,df_one_trial)

# Double check that each mouse is represented at least once in the dataframe
v2<- unique(wire_hang$MouseID)
v3 <-unique(df_excluded$MouseID)
vfinal <- union(v2,v3)
setdiff(v1, vfinal)

## Pole Test --
data<- readr::read_csv(here("Analysis_Files", "ASO","ASO Pole Test - All_Cohorts_Assign_Maximum_Time.csv"))
data <- data %>%
  rowwise() %>%
  mutate(Average_Tturn = mean(c(Trial_1_Tturn, Trial_2_Tturn, Trial_3_Tturn, Trial_4_Tturn, Trial_5_Tturn), na.rm = TRUE)) %>%
  mutate(Fastest_Tturn = pmin(Trial_1_Tturn, Trial_2_Tturn, Trial_3_Tturn, Trial_4_Tturn, Trial_5_Tturn, na.rm = TRUE))

data <- data %>%
  rowwise() %>%
  mutate(Average_Ttotal = mean(c(Trial_1_Ttotal, Trial_2_Ttotal, Trial_3_Ttotal, Trial_4_Ttotal, Trial_5_Ttotal), na.rm = TRUE)) %>%
  mutate(Fastest_Ttotal = pmin(Trial_1_Ttotal, Trial_2_Ttotal, Trial_3_Ttotal, Trial_4_Ttotal, Trial_5_Ttotal, na.rm = TRUE))

pole_data <- data %>%
  mutate(Best_Performance = case_when(
    any(Trial_1_Mode == "C" | Trial_2_Mode == "C" | Trial_3_Mode == "C" | Trial_4_Mode == "C" | Trial_5_Mode == "C") ~ "C",
    any(Trial_1_Mode == "S" | Trial_2_Mode == "S" | Trial_3_Mode == "S" | Trial_4_Mode == "S" | Trial_5_Mode == "S") ~ "S",
    TRUE ~ "S"
  ))

## Food Pellet --

food<-readr::read_csv(here("Analysis_Files", "ASO","ASO Food Pellet - Buried_Food_Pellet.csv"))
food$SLC_Genotype <- factor(food$SLC_Genotype, levels=c("WT", "HET", "MUT"))
food$MouseID <- food$`Mouse ID`

## Fecal Pellet --
poop <- readr::read_csv(here("Analysis_Files","ASO","ASO GI Motility - ASO_FP_Output.csv"))

poop <- poop %>% select(c("MouseID","60_min", "ASO_Tg"))

## Hindlimb Clasp -- 
clasp <-readr::read_csv(here("Analysis_Files", "ASO", "ASO_Hindlimb_Clasping .csv"))
clasp$MouseID <- clasp$`Mouse ID`
clasp <- clasp %>% select(c("MouseID", "Score","ASO_Tg"))

## Ensure that MouseIDs are found in all datasets --
list1 <- unique(intersect(wire_hang$MouseID, summary_rotarod$MouseID))
list2 <- unique(intersect(pole_data$MouseID, list1))
list3 <- unique(intersect(pole_data$MouseID, summary_rotarod$MouseID))
setdiff(list1, list2)
list4 <- unique(intersect(list1,food$MouseID))
list5 <- intersect(poop$MouseID, list1)
setdiff(list1,list4)
setdiff(list1,list5)
list6 <- intersect(clasp$MouseID, list1)
setdiff(list1, list6)

## Restrict to ASO_Tg positive --
wire_hang <- wire_hang %>% filter(ASO_Tg=="Positive")
pole_data <- pole_data %>% filter(ASO_Tg=="Positive") 
summary_rotarod <- summary_rotarod %>% filter(ASO_Tg =="Positive")
food <- food %>% filter(ASO_Tg=="Positive") 
poop<- poop %>% filter(ASO_Tg=="Positive") 
clasp<- clasp %>% filter(ASO_Tg=="Positive") 

## Run what values you want to perform dim red on --


## Merge values for dim reduction --
df_1 <- merge(wire_hang, pole_data, by="MouseID")
df_2 <- merge(df_1, summary_rotarod, by="MouseID")
df_3 <- merge(df_2, food, by= "MouseID")
df_4 <- merge(df_3, poop, by= "MouseID")
df_5 <- merge(df_4, clasp, by= "MouseID")
df_motor <- df_5 %>% select(c("MouseID","Time", "Average_Tturn", "Average_Ttotal", "mean_latency", "Best_Performance", "Total_Time", "60_min", "Score"))

# Define the columns to normalize
cols_to_normalize <- c("Time", "Average_Tturn", "Average_Ttotal", "mean_latency", "Score", "Total_Time", "60_min")

# Apply min-max normalization to the selected columns
df_normalized <- df_motor %>%
  mutate(across(all_of(cols_to_normalize), ~ (.-min(.))/(max(.)-min(.)), .names = "norm_{.col}"))

# Select the columns for PCA
pca_data <- df_normalized %>%
  select(norm_Time, norm_Average_Tturn, norm_Average_Ttotal, norm_mean_latency, norm_Score,norm_Total_Time, norm_60_min)
pca_data <- df_normalized %>%
  select(norm_Time, norm_Average_Tturn, norm_Average_Ttotal, norm_mean_latency, norm_Score,norm_Total_Time)
pca_data <- df_normalized %>%
  select(norm_Time, norm_Average_Tturn, norm_Average_Ttotal, norm_mean_latency, norm_Score)
pca_data <- df_normalized %>%
  select(norm_Time, norm_Average_Tturn, norm_Average_Ttotal, norm_mean_latency)

## Perform PCA --
pca_result <- prcomp(pca_data, scale. = FALSE)  # Set scale. to TRUE if you want to scale the variables

# Extract the results
pca_summary <- summary(pca_result)
pca_variance <- pca_summary$sdev^2  # Variance explained by each principal component
pca_loadings <- pca_result$rotation  # Loadings (coefficients) of each variable on each PC

# You can also access the scores of each observation on each PC
pca_scores_df <- data.frame(MouseID = df_normalized$MouseID, pca_result$x)

# Merge the PCA scores with the original DataFrame based on "MouseID"
subset <- pole_data %>% select(c("SLC_Genotype","MouseID","ASO_Tg","Sex"))
merged_df <- merge(subset,pca_scores_df,by="MouseID")

# Visualize the PCA scores
aso_behavior_pca <- ggplot(merged_df, aes(x = PC1, y = PC2, color = SLC_Genotype)) +
  geom_point(size=3) +
  labs(title = "ASO Motor Phenotypes", x = "PC1", y = "PC2") +
  theme_cowplot(16) +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(legend.position = "top", legend.justification = "center" )
aso_behavior_pca 

## Perform tSNE
# Select the columns for t-SNE
tsne_data <- df_normalized %>%
  select(norm_Time, norm_Average_Tturn, norm_Average_Ttotal, norm_mean_latency, norm_Score)

# Perform t-SNE
tsne_result <- Rtsne(tsne_data, dims = 2, perplexity =3, verbose = TRUE)  # You can adjust perplexity as needed

# Extract the t-SNE coordinates
tsne_coordinates <- tsne_result$Y
tsne_df <- data.frame(MouseID = df_normalized$MouseID, tsne_coordinates)
merged_df <- merge(subset,tsne_df,by="MouseID")

ggplot(merged_df, aes(x = X1, y = X2, color=SLC_Genotype)) +
  geom_point() +
  labs(title = "t-SNE Visualization", x = "t-SNE Dimension 1", y = "t-SNE Dimension 2")+
  theme_cowplot(12) +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(legend.position = "top", legend.justification = "center" )


