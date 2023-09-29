library(dplyr)

df <- read.csv("Analysis_Files/ASO/ASO Wire Hang - Wire_Hang.csv",header=TRUE)
df$SLC_Genotype <- factor(df$SLC_Genotype, levels= c("WT","HET", "MUT"))

### Data Wrangling ---
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
final_df <- rbind(df_filtered_2, df_filtered_greater) 
final_df <- rbind(final_df,df_one_trial)
write.csv(final_df, "Analysis_Files/ASO/Final_ASO_Wire_Hang.csv")

# Double check that each mouse is represented at least once in the dataframe
v2<- unique(final_df$MouseID)
v3 <-unique(df_excluded$MouseID)
vfinal <- union(v2,v3)
setdiff(v1, vfinal)

# Make a summary table of the mice that made it 
summary_table <- final_df %>%
  group_by(ASO_Tg, SLC_Genotype) %>%
  summarise(Mice_Count = n()) %>%
  ungroup()
print(summary_table)

### Plots ---
generate_boxplots <- function(input_data, X, Y, min,max){
  data<-as.data.frame(input_data)
  #Ensure correct ordering of levels 
  data$SLC_Genotype <- factor(data$SLC_Genotype, levels = c("WT", "HET", "MUT"))
  
  ggplot(data=data,aes(x={{X}},y={{Y}}, fill={{X}})) + 
    #geom_violin(alpha=0.25,position=position_dodge(width=.75),size=1,color="black",draw_quantiles=c(0.5))+
    geom_boxplot(alpha=0.25)+ 
    #geom_quasirandom(alpha=0.1)+
    scale_fill_viridis_d()+
    geom_point(size=1,position=position_jitter(width=0.25),alpha=0.3)+
    theme_cowplot(16) +
    ylim(min,max)+
    theme(legend.position = "none") 
  
}

a <-generate_boxplots(final_df, ASO_Tg, Time,0,200) +
  ggtitle("Wire Hang")+
  theme(plot.title = element_text(hjust = 0.5))
a
# Stratified by SLC Genotype
b<-generate_boxplots(final_df, SLC_Genotype, Time,0,200)+
  facet_wrap(~ASO_Tg)
b

# Stratified by SLC Genotype and Sex 
e<-generate_boxplots(final_df, SLC_Genotype, Time,0,200)+
  facet_wrap(Sex~ASO_Tg)
e

plot_grid(a,b,e)

# Stratified by SLC Genotype and Sex 
weight <-generate_boxplots(final_df, ASO_Tg, Weight,15,60)
f

plot_grid(a,b,e)

### Stats ---

lm1 <- lm(Time ~ Weight + Sex + ASO_Tg +SLC_Genotype, data = final_df)
summary(lm1)

interact <- lm(Time ~ Weight + Sex + ASO_Tg*SLC_Genotype, data = final_df)
summary(interact)

lm2 <- lm(Time ~ Weight + Sex + SLC_Genotype, data =  subset(final_df, ASO_Tg == "Positive"))
summary(lm2)

lm3 <- lm(Time ~ Weight + Sex + SLC_Genotype, data =  subset(final_df, ASO_Tg == "Negative"))
summary(lm3)

lm4 <- lm(Time ~ Weight + SLC_Genotype, 
          data =  subset(final_df, ASO_Tg == "Negative" & Sex=="Female"))
summary(lm4) 
lm5 <- lm(Total_Time ~ Weight + SLC_Genotype, 
          data =  subset(final_df, ASO_Tg == "Positive" & Sex=="Female"))
summary(lm5) 
lm6 <- lm(Time ~ Weight + SLC_Genotype, 
          data =  subset(final_df, ASO_Tg == "Negative" & Sex=="Male"))
summary(lm6) 
lm7 <- lm(Time ~ Weight + SLC_Genotype, 
          data =  subset(final_df, ASO_Tg == "Positive" & Sex=="Male"))
summary(lm7) 

# Save outputs -
sink("Wire_Hang_Stats.md")
cat("\n\nSummary for all data:\n")
print(summary(lm1))
cat("\n\nSummary for all days, Tg Neg:\n")
print(summary(lm3))
cat("\n\nSummary for Day 1, Tg Pos:\n")
print(summary(lm2))
cat("\n\nSummary for all days, Females Tg Neg:\n")
print(summary(lm4))
cat("\n\nSummary for Day 1, Females Tg Pos:\n")
print(summary(lm5))
cat("\n\nSummary for all days, Males Tg Neg:\n")
print(summary(lm6))
cat("\n\nSummary for Day 1, Males Tg Pos:\n")
print(summary(lm7))
cat("\n\nSummary for all data, ASO_Tg*SLC_Genotype:\n")
print(summary(interact))
sink()
