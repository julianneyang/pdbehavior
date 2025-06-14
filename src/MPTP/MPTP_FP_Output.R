library(ggplot2)
library(dplyr)
library(cowplot)
library(nlme)
library(here)
library(tidyverse)

here::here()

data <- readr::read_csv(here("Analysis_Files", "MPTP","MPTP_FP_Output.csv"))

data_long <- pivot_longer(data, 
                          cols = c("5","10","15","30","45","60"), 
                          names_to = "timepoint", 
                          values_to = "FP_output")


data_long$SLC_Genotype <- factor(data_long$SLC_Genotype, levels=c("WT", "HET", "MUT"))
data_long$timepoint <- factor(data_long$timepoint, levels=c("5","10","15","30","45","60"))

mptp <- data_long %>% 
  filter(Treatment =="MPTP")
saline <- data_long %>% 
  filter(Treatment =="Saline")

## Plots --
generate_boxplots(data_long,Treatment,FP_output,0, 30) + 
  facet_wrap(~timepoint)

generate_boxplots(mptp,SLC_Genotype,FP_output,0, 30) + 
  facet_wrap(~timepoint)+
  ggtitle("MPTP")

generate_boxplots(mptp,SLC_Genotype,FP_output,0, 30) + 
  facet_wrap(Sex~timepoint,nrow=2)+
  ggtitle("MPTP by Sex")

generate_boxplots(saline,SLC_Genotype,FP_output,0, 30) + 
  facet_wrap(~timepoint)+
  ggtitle("Saline")

generate_boxplots(saline,SLC_Genotype,FP_output,0, 30) + 
  facet_wrap(Sex~timepoint)+
  ggtitle("Saline by Sex")

# Calculate the mean and standard error for each group
df_summary <- data_long %>%
  group_by(Treatment, timepoint) %>%
  summarise(mean = mean(FP_output), 
            sd = sd(FP_output),
            se = sd / sqrt(n()))

# Plot the graph with error bars
posvneg <- ggplot(df_summary, aes(x = timepoint, y = mean, group = Treatment, color = Treatment)) +
  geom_line(size=2) +
  geom_errorbar(aes(ymin = mean - se, ymax = mean + se), width = 0.2) +
  labs(x = "Time (minutes)", y = "FP_output") +
  scale_color_viridis_d()  +
  theme_cowplot(16) + 
  ggtitle("MPTP FP output over time") + 
  theme(legend.position = "top",legend.justification = "center",legend.title = element_text(hjust = 0.5))+
  theme(plot.title = element_text(hjust = 0.5))


# Calculate the mean and standard error for each group

df_summary <- data_long %>%
  group_by(Treatment, SLC_Genotype, timepoint) %>%
  summarise(mean = mean(FP_output), 
            sd = sd(FP_output),
            se = sd / sqrt(n()))

# Plot the graph with error bars
slc_genotype <- ggplot(df_summary, aes(x = timepoint, y = mean, group = SLC_Genotype, color = SLC_Genotype)) +
  geom_line(size=2) +
  geom_errorbar(aes(ymin = mean - se, ymax = mean + se), width = 0.2) +
  labs(x = "Time (minutes)", y = "FP_output") +
  scale_color_viridis_d()  +
  theme_cowplot(16) + 
  ggtitle("SLC Genotype: ASO FP output over time") + 
  theme(legend.position = "top", legend.justification="center",legend.title = element_text(hjust = 0.5))+
  theme(plot.title = element_text(hjust = 0.5)) +
  facet_wrap(~Treatment)


# Calculate the mean and standard error for each group -- Females
female <- data_long %>% filter(Sex=="Female")
female_df_summary <- female %>%
  group_by(Treatment, SLC_Genotype, timepoint) %>%
  summarise(mean = mean(FP_output), 
            sd = sd(FP_output),
            se = sd / sqrt(n()))

# Plot the graph with error bars
femaleplot <- ggplot(female_df_summary, aes(x = timepoint, y = mean, group = SLC_Genotype, color = SLC_Genotype)) +
  geom_line(size=2) +
  geom_errorbar(aes(ymin = mean - se, ymax = mean + se), width = 0.2) +
  labs(x = "Time (minutes)", y = "FP_output") +
  scale_color_viridis_d()  +
  theme_cowplot(16) + 
  ggtitle("Females: ASO FP output over time") + 
  facet_wrap(~Treatment) +
  theme(legend.position = "top",legend.title = element_text(hjust = 0.5))+
  theme(plot.title = element_text(hjust = 0.5))


# Calculate the mean and standard error for each group -- Males
male <- data_long %>% filter(Sex=="Male")
male_df_summary <- male %>%
  group_by(Treatment, SLC_Genotype, timepoint) %>%
  summarise(mean = mean(FP_output), 
            sd = sd(FP_output),
            se = sd / sqrt(n()))

# Plot the graph with error bars
male_plot <- ggplot(male_df_summary, aes(x = timepoint, y = mean, group = SLC_Genotype, color = SLC_Genotype)) +
  geom_line(size=2) +
  geom_errorbar(aes(ymin = mean - se, ymax = mean + se), width = 0.2) +
  labs(x = "Time (minutes)", y = "FP_output") +
  scale_color_viridis_d()  +
  theme_cowplot(16) + 
  ggtitle("Males: ASO FP output over time") + 
  facet_wrap(~Treatment) +
  theme(legend.position = "top",legend.title = element_text(hjust = 0.5))+
  theme(plot.title = element_text(hjust = 0.5))

## Final Figure --
plot_grid(femaleplot, male_plot)

female_pos <- data_long %>% filter(Sex=="Female" & Treatment=="MPTP")
female_df_summary <- female_pos %>%
  group_by(SLC_Genotype, timepoint) %>%
  summarise(mean = mean(FP_output), 
            sd = sd(FP_output),
            se = sd / sqrt(n()))

# Plot the graph with error bars
femaleplot <- ggplot(female_df_summary, aes(x = timepoint, y = mean, group = SLC_Genotype, color = SLC_Genotype)) +
  geom_line(size=2) +
  geom_errorbar(aes(ymin = mean - se, ymax = mean + se), width = 0.2) +
  labs(x = "Time (minutes)", y = "FP_output") +
  scale_color_viridis_d()  +
  theme_cowplot(16) + 
  ggtitle("MPTP Females") + 
  theme(legend.position = "none")+
  theme(plot.title = element_text(hjust = 0.5))
MPTP_gi <- femaleplot

### Longitudinal Stats ---
nonpara_output <- kruskal.test(FP_output~Treatment, data=data_long)
print(nonpara_output)

lm1<- lme(fixed= FP_output ~ timepoint + Treatment +Sex + SLC_Genotype, random = ~1|MouseID, data=data_long)
summary(lm1)

lm1_time_ASO<- lme(fixed= FP_output ~ timepoint*Treatment +Sex + SLC_Genotype, random = ~1|MouseID, data=data_long)
summary(lm1_time_ASO)

lm1_SLC_ASO<- lme(fixed= FP_output ~ timepoint + Treatment*SLC_Genotype +Sex , random = ~1|MouseID, data=data_long)
summary(lm1_SLC_ASO)

pos <- data_long %>% filter(Treatment=="MPTP")
neg <- data_long %>% filter(Treatment=="Saline")

lm2 <- lme(fixed= FP_output ~ Sex+ timepoint*SLC_Genotype, random = ~1|MouseID, data=pos)
summary(lm2)
lm3 <- lme(fixed= FP_output ~ Sex + timepoint*SLC_Genotype, random = ~1|MouseID, data=neg)
summary(lm3)

pos_males <- data_long %>% filter(Treatment=="MPTP"& Sex=="Male")
neg_males <- data_long %>% filter(Treatment=="Saline"& Sex=="Male")

lm4 <- lme(fixed= FP_output ~ timepoint*SLC_Genotype, random = ~1|MouseID, data=pos_males)
summary(lm4)
lm5 <- lme(fixed= FP_output ~ timepoint*SLC_Genotype, random = ~1|MouseID, data=neg_males)
summary(lm5)

pos_females <- data_long %>% filter(Treatment=="MPTP"& Sex=="Female")
neg_females <- data_long %>% filter(Treatment=="Saline"& Sex=="Female")

lm6 <- lme(fixed= FP_output ~ timepoint*SLC_Genotype, random = ~1|MouseID, data=pos_females)
summary(lm6)
lm7 <- lme(fixed= FP_output ~ timepoint*SLC_Genotype, random = ~1|MouseID, data=neg_females)
summary(lm7)

# Save outputs -
sink("Statistics/MPTP/FP_output_Stats.md")
cat("\n\nSummary for all data:\n")
print(summary(lm1))
cat("\n\nSummary for all data, non parametric:\n")
print((nonpara_output))
cat("\n\nSummary for all data, time*ASO:\n")
print(summary(lm1_time_ASO))
cat("\n\nSummary for all data, SLC*ASO:\n")
print(summary(lm1_SLC_ASO))
cat("\n\nSummary for Tg Pos:\n")
print(summary(lm2))
cat("\n\nSummary for Tg Neg:\n")
print(summary(lm3))
cat("\n\nSummary for Males Tg Pos:\n")
print(summary(lm4))
cat("\n\nSummary for Males Tg Neg:\n")
print(summary(lm5))
cat("\n\nSummary for Males Tg Pos:\n")
print(summary(lm6))
cat("\n\nSummary for Males Tg Neg:\n")
print(summary(lm7))
sink()

### Cross-Sectional Stats ---
lm1 <- lm(FP_output ~ Treatment,  data=data_long)
summary(lm1)
kruskal.test(FP_output ~ Treatment,  data=data_long)

lm1 <- lm(FP_output ~ Sex + Treatment +SLC_Genotype,  subset(data_long, timepoint == 60))
summary(lm1)

lm1 <- lm(FP_output ~ Sex +SLC_Genotype,  subset(data_long, timepoint == 60 & Treatment=="MPTP"))
summary(lm1)

lm1 <- lm(FP_output ~ Sex +SLC_Genotype,  subset(data_long, timepoint == 60 & Treatment=="Saline"))
summary(lm1)

lm1 <- lm(FP_output ~SLC_Genotype,  subset(data_long, timepoint == 60 & Treatment=="MPTP" & Sex =="Female"))
summary(lm1)

lm1 <- lm(FP_output ~ Sex +SLC_Genotype,  subset(data_long, timepoint == 60 & Treatment=="Saline" ))
summary(lm1)
