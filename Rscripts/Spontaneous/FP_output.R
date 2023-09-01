library(ggplot2)
library(dplyr)
library(cowplot)
library(nlme)
library(tidyr)

data <- read.csv("Analysis_Files/Spontaneous/SLC Spontaneous Gastrointestinal Motility - Analysis_Wide.csv",header=TRUE)

data_long <- pivot_longer(data, 
                          cols = starts_with("X"), 
                          names_to = "timepoint", 
                          values_to = "FP_output")

data_long$timepoint <- as.integer(stringr::str_extract(data_long$timepoint, "\\d+"))
data_long$SLC_Genotype <- factor(data_long$SLC_Genotype, levels=c("WT", "HET", "MUT"))
data_long$timepoint <- factor(data_long$timepoint)

## Plots --
one_hour <- data_long %>% filter(timepoint==60)
generate_boxplots(one_hour,SLC_Genotype,FP_output,0, 20) + 
  facet_wrap(~Sex)+
  ggtitle("Tg Positive")

generate_boxplots(pos,SLC_Genotype,FP_output,0, 30) + 
  facet_wrap(Sex~timepoint,nrow=2)+
  ggtitle("Tg Positive by Sex")

generate_boxplots(neg,SLC_Genotype,FP_output,0, 30) + 
  facet_wrap(~timepoint)+
  ggtitle("Tg Negative")

generate_boxplots(neg,SLC_Genotype,FP_output,0, 30) + 
  facet_wrap(Sex~timepoint)+
  ggtitle("Tg Negative by Sex")


# Calculate the mean and standard error for each group

df_summary <- data_long %>%
  group_by(SLC_Genotype, timepoint) %>%
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
  ggtitle("Spontaneous") + 
  theme(legend.position = "none", legend.justification="center",legend.title = element_text(hjust = 0.5))+
  theme(plot.title = element_text(hjust = 0.5)) 


# Calculate the mean and standard error for each group -- Females
female <- data_long %>% filter(Sex=="Female")
female_df_summary <- female %>%
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
  ggtitle("Spontaneous Females")+
  theme(legend.position = "none",legend.title = element_text(hjust = 0.5))+
  theme(plot.title = element_text(hjust = 0.5))


# Calculate the mean and standard error for each group -- Males
male <- data_long %>% filter(Sex=="Male")
male_df_summary <- male %>%
  group_by(SLC_Genotype, timepoint) %>%
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
  ggtitle("Spontaneous Males") +
  theme(legend.position = "none")+
  theme(plot.title = element_text(hjust = 0.5))

## Final Figure --
spontaneous_gi <-  femaleplot 
plot_grid(slc_genotype,femaleplot,male_plot, nrow=1)

### Longitudinal Stats ---
nonpara_output <- kruskal.test(FP_output~SLC_Genotype, data=data_long)
print(nonpara_output)

lm1<- lme(fixed= FP_output ~ timepoint +Sex + SLC_Genotype, random = ~1|MouseID, data=data_long)
summary(lm1)

lm1_time_ASO<- lme(fixed= FP_output ~ timepoint*SLC_Genotype + Sex, random = ~1|MouseID, data=data_long)
summary(lm1_time_ASO)



males <- data_long %>% filter(Sex=="Male")
females <- data_long %>% filter(Sex=="Female")

lm4 <- lme(fixed= FP_output ~ timepoint+SLC_Genotype, random = ~1|MouseID, data=males)
summary(lm4)
lm5 <- lme(fixed= FP_output ~ timepoint+SLC_Genotype, random = ~1|MouseID, data=females)
summary(lm5)

t60_females <- data_long %>% filter(timepoint==60 & Sex=="Female")
t45_females <- data_long %>% filter(timepoint==45 & Sex=="Female")
t30_females <- data_long %>% filter(timepoint==30 & Sex=="Female")
t15_females <- data_long %>% filter(timepoint==15 & Sex=="Female")
t10_females <- data_long %>% filter(timepoint==10 & Sex=="Female")
t5_females <- data_long %>% filter(timepoint==10 & Sex=="Female")


lm6 <- lm(FP_output ~ SLC_Genotype,  data=t60_females)
summary(lm6)
lm7 <- lm(FP_output ~ SLC_Genotype,  data=t45_females)
summary(lm7)
lm8 <- lm(FP_output ~ SLC_Genotype,  data=t30_females)
summary(lm8)
lm9 <- lm(FP_output ~ SLC_Genotype,  data=t15_females)
summary(lm9)
lm10 <- lm(FP_output ~ SLC_Genotype,  data=t10_females)
summary(lm10)
lm11 <- lm(FP_output ~ SLC_Genotype,  data=t5_females)
summary(lm11)


t60 <- data_long %>% filter(timepoint==60 )
t45 <- data_long %>% filter(timepoint==45 )
t30 <- data_long %>% filter(timepoint==30 )
t15 <- data_long %>% filter(timepoint==15 )
t10 <- data_long %>% filter(timepoint==10 )
t5 <- data_long %>% filter(timepoint==5 )


lm6 <- lm(FP_output ~ SLC_Genotype,  data=t60)
summary(lm6)
lm7 <- lm(FP_output ~ SLC_Genotype,  data=t45)
summary(lm7)
lm8 <- lm(FP_output ~ SLC_Genotype,  data=t30)
summary(lm8)
lm9 <- lm(FP_output ~ SLC_Genotype,  data=t15)
summary(lm9)
lm10 <- lm(FP_output ~ SLC_Genotype,  data=t10)
summary(lm10)
lm11 <- lm(FP_output ~ SLC_Genotype,  data=t5)
summary(lm11)

