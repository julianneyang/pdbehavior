library(ggplot2)
library(dplyr)
library(cowplot)
library(nlme)

data <- read.csv("ASO_FP_Output.csv",header=TRUE)

data_long <- pivot_longer(data, 
                          cols = starts_with("X"), 
                          names_to = "timepoint", 
                          values_to = "FP_output")

data_long$timepoint <- as.integer(stringr::str_extract(data_long$timepoint, "\\d+"))
data_long$SLC_Genotype <- factor(data_long$SLC_Genotype, levels=c("WT", "HET", "MUT"))

## All together -- 
# Calculate the mean and standard error for each group
df_summary <- data_long %>%
  group_by(ASO_Tg, timepoint) %>%
  summarise(mean = mean(FP_output), 
            sd = sd(FP_output),
            se = sd / sqrt(n()))

# Plot the graph with error bars
posvneg <- ggplot(df_summary, aes(x = timepoint, y = mean, group = ASO_Tg, color = ASO_Tg)) +
  geom_line(size=2) +
  geom_errorbar(aes(ymin = mean - se, ymax = mean + se), width = 0.2) +
  labs(x = "Time (minutes)", y = "FP_output") +
  scale_color_manual(values = c("Positive" = "red", "Negative" = "blue")) +
  theme_cowplot(16) + 
  ggtitle("ASO FP output over time") + 
  theme(legend.position = "top",legend.title = element_text(hjust = 0.5))+
  theme(plot.title = element_text(hjust = 0.5))


# Calculate the mean and standard error for each group

df_summary <- data_long %>%
  group_by(ASO_Tg, SLC_Genotype, timepoint) %>%
  summarise(mean = mean(FP_output), 
            sd = sd(FP_output),
            se = sd / sqrt(n()))

# Plot the graph with error bars
slc_genotype <- ggplot(df_summary, aes(x = timepoint, y = mean, group = SLC_Genotype, color = SLC_Genotype)) +
  geom_line(size=2) +
  geom_errorbar(aes(ymin = mean - se, ymax = mean + se), width = 0.2) +
  labs(x = "Time (minutes)", y = "FP_output") +
  #scale_color_manual(values = c("Positive" = "red", "Negative" = "blue")) +
  theme_cowplot(16) + 
  ggtitle("SLC Genotype: ASO FP output over time") + 
  theme(legend.position = "top",legend.title = element_text(hjust = 0.5))+
  theme(plot.title = element_text(hjust = 0.5)) +
  facet_wrap(~ASO_Tg)


# Calculate the mean and standard error for each group -- Females
female <- data_long %>% filter(Sex=="Female")
female_df_summary <- female %>%
  group_by(ASO_Tg, SLC_Genotype, timepoint) %>%
  summarise(mean = mean(FP_output), 
            sd = sd(FP_output),
            se = sd / sqrt(n()))

# Plot the graph with error bars
femaleplot <- ggplot(female_df_summary, aes(x = timepoint, y = mean, group = SLC_Genotype, color = SLC_Genotype)) +
  geom_line(size=2) +
  geom_errorbar(aes(ymin = mean - se, ymax = mean + se), width = 0.2) +
  labs(x = "Time (minutes)", y = "FP_output") +
  #scale_color_manual(values = c("Positive" = "red", "Negative" = "blue")) +
  theme_cowplot(16) + 
  ggtitle("Females: ASO FP output over time") + 
  facet_wrap(~ASO_Tg) +
  theme(legend.position = "top",legend.title = element_text(hjust = 0.5))+
  theme(plot.title = element_text(hjust = 0.5))


# Calculate the mean and standard error for each group -- Males
male <- data_long %>% filter(Sex=="Male")
male_df_summary <- male %>%
  group_by(ASO_Tg, SLC_Genotype, timepoint) %>%
  summarise(mean = mean(FP_output), 
            sd = sd(FP_output),
            se = sd / sqrt(n()))

# Plot the graph with error bars
male_plot <- ggplot(male_df_summary, aes(x = timepoint, y = mean, group = SLC_Genotype, color = SLC_Genotype)) +
  geom_line(size=2) +
  geom_errorbar(aes(ymin = mean - se, ymax = mean + se), width = 0.2) +
  labs(x = "Time (minutes)", y = "FP_output") +
  #scale_color_manual(values = c("Positive" = "red", "Negative" = "blue")) +
  theme_cowplot(16) + 
  ggtitle("Males: ASO FP output over time") + 
  facet_wrap(~ASO_Tg) +
  theme(legend.position = "top",legend.title = element_text(hjust = 0.5))+
  theme(plot.title = element_text(hjust = 0.5))

## Final Figure --
plot_grid(posvneg, slc_genotype, femaleplot, male_plot, nrow=2)

### Alpha Diversity Stats ---
#stool

output <- lme(fixed= FP_output ~ Sex + SLC_Genotype + ASO_Tg, random = ~1|MouseID, data=data_long)
summary(output)

pos <- data_long %>% filter(ASO_Tg=="Positive")
neg <- data_long %>% filter(ASO_Tg=="Negative")

output <- lme(fixed= FP_output ~ Sex +SLC_Genotype, random = ~1|MouseID, data=pos)
summary(output)
output <- lme(fixed= FP_output ~ Sex+SLC_Genotype, random = ~1|MouseID, data=neg)
summary(output)

pos_males <- data_long %>% filter(ASO_Tg=="Positive"& Sex=="Male")
neg_males <- data_long %>% filter(ASO_Tg=="Negative"& Sex=="Male")

output <- lme(fixed= FP_output ~ SLC_Genotype, random = ~1|MouseID, data=pos_males)
summary(output)
output <- lme(fixed= FP_output ~ SLC_Genotype, random = ~1|MouseID, data=neg_males)
summary(output)

pos_females <- data_long %>% filter(ASO_Tg=="Positive"& Sex=="Female")
neg_females <- data_long %>% filter(ASO_Tg=="Negative"& Sex=="Female")

output <- lme(fixed= FP_output ~ SLC_Genotype, random = ~1|MouseID, data=pos_females)
summary(output)
output <- lme(fixed= FP_output ~ SLC_Genotype, random = ~1|MouseID, data=neg_females)
summary(output)
