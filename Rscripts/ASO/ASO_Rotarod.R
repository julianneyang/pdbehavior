library(here)
library(ggplot2)
library(rlang)
library(rstatix)  
library(nlme)
library(cowplot)
library(ggbeeswarm)
library(ggpubr)
library(ggsignif)
library(knitr)


data <- readr::read_csv(here("Analysis_Files", "MPTP","MPTP_Rotarod.csv"))
data$SLC_Genotype <- factor(data$SLC_Genotype, levels=c("WT", "HET", "MUT"))

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
    #ylim(min,max)+
    theme(legend.position = "none") 
  
  
}


cs_rota_all_slc_posvneg <- generate_boxplots(data, Treatment, Average_Latency,0,550) + 
  ggtitle("Rotarod")+
  theme(plot.title = element_text(hjust = 0.5))
cs_rota_slc_posvneg <- generate_boxplots(data, SLC_Genotype, Average_Latency,0,550) + facet_wrap(~Treatment)+
  ggtitle("Rotarod by SLC Genotype")+
  theme(plot.title = element_text(hjust = 0.5))
cs_rota_slc_posvneg_sex <- generate_boxplots(data, SLC_Genotype, Average_Latency,0,550) + 
  facet_wrap(Treatment~Sex,ncol=2) 

cs_rota_all_posvneg <- generate_boxplots(data, Treatment, Average_Latency,0,300) +
  ggtitle("Rotarod All Days")+
  theme(plot.title = element_text(hjust = 0.5))
cs_rota_posvneg <- generate_boxplots(data, Treatment, Average_Latency,0,300) + facet_wrap(~Day)


###  Calculate mean and standard errors by Treatment ---
## ASO Pos vs Neg --
summary_data <- data %>%
  group_by( Day,Treatment) %>%
  summarise(mean_latency = mean(Average_Latency),
            se_latency = sd(Average_Latency) / sqrt(n()))

# Plot the trajectory lines and mean lines
traj_posvneg <- ggplot(summary_data, aes(x = Day, y = mean_latency, color = Treatment,group=Treatment)) +
  geom_line() +
  geom_errorbar(aes(ymin = mean_latency - se_latency, ymax = mean_latency + se_latency),
                width = 0.2) +
  labs(x = "Day", y = "Mean Latency") +
  scale_color_viridis_d()  +
  theme_cowplot(16) + 
  theme(legend.position = "top",legend.justification = "center") +
  ggtitle("Rotarod Tg+ vs Tg -")+
  theme(plot.title = element_text(hjust = 0.5))


## SLC Genotype within ASO Pos or Neg --
summary_data <- data %>%
  group_by(SLC_Genotype,Day,Treatment) %>%
  summarise(mean_latency = mean(Average_Latency),
            se_latency = sd(Average_Latency) / sqrt(n()))

# Plot the trajectory lines and mean lines
traj_slc_posvneg <- ggplot(summary_data, aes(x = Day, y = mean_latency, color = SLC_Genotype,group=SLC_Genotype)) +
  geom_line() +
  geom_errorbar(aes(ymin = mean_latency - se_latency, ymax = mean_latency + se_latency),
                width = 0.2) +
  labs(x = "Day", y = "Mean Latency") +
  scale_color_viridis_d()  +
  theme_cowplot(16) + 
  facet_wrap(~Treatment) +
  theme(legend.position = "top",legend.justification = "center") +
  ggtitle("Rotarod SLC within Tg status")+
  theme(plot.title = element_text(hjust = 0.5))


## SLC Genotype within ASO Pos or Neg and Sex- Stratified --
summary_data <- data %>%
  group_by(Sex,SLC_Genotype,Day,Treatment) %>%
  summarise(mean_latency = mean(Average_Latency),
            se_latency = sd(Average_Latency) / sqrt(n()))

# Plot the trajectory lines and mean lines
traj_slc_posvneg_sex <- ggplot(summary_data, aes(x = Day, y = mean_latency, color = SLC_Genotype,group=SLC_Genotype)) +
  geom_line() +
  geom_errorbar(aes(ymin = mean_latency - se_latency, ymax = mean_latency + se_latency),
                width = 0.2) +
  labs(x = "Day", y = "Mean Latency") +
  scale_color_viridis_d()  +
  theme_cowplot(16) + 
  facet_wrap(Sex~Treatment) +
  theme(legend.position = "top",legend.justification = "center") +
  ggtitle("Rotarod SLC within Tg status by Sex")+
  theme(plot.title = element_text(hjust = 0.5))

plot_grid(traj_posvneg, traj_slc_posvneg)

### Statistics ---

## LM on Full Dataset --
all <- lm(Average_Latency ~ Day+ Treatment + Weight + SLC_Genotype + Sex, data = data)
summary(all)
interact <- lm(Average_Latency ~ Day+ Treatment*SLC_Genotype + Weight + Sex, data = data)
summary(interact)
lm_day1 <- lm(Average_Latency ~ Treatment + Weight + SLC_Genotype + Sex, data = subset(data, Day == "One"))
summary(lm_day1)
lm_day2 <- lm(Average_Latency ~ Treatment + Weight + SLC_Genotype + Sex , data = subset(data, Day == "Two"))
summary(lm_day2)
lm_day3 <- lm(Average_Latency ~ Treatment + Weight + SLC_Genotype + Sex , data = subset(data, Day == "Three"))
summary(lm_day3)
# Save outputs -
# Open a connection to a text file
sink("Rotarod_Stats.md")
cat("Summary for all days, Tg + vs Tg -:\n")
print(summary(all))
cat("\n\nSummary for Day 1, Tg + vs Tg -:\n")
print(summary(lm_day1))
cat("\n\nSummary for Day 2, Tg + vs Tg -:\n")
print(summary(lm_day2))
cat("\n\nSummary for Day 3, Tg + vs Tg -:\n")
print(summary(lm_day3))
cat("\n\nSummary for SLC_Genotype*Treatment Interaction:")
print(summary(interact))
sink()

## LM on Dataset Stratified by Treatment--
all_p <- lm(Average_Latency ~ Day+ Weight + SLC_Genotype + Sex, data =  subset(data, Treatment == "Positive"))
summary(all_p)
all_n <- lm(Average_Latency ~ Day+ Weight + SLC_Genotype + Sex, data =  subset(data, Treatment == "Negative"))
summary(all_n)
lm_day1_p <- lm(Average_Latency ~  Weight + SLC_Genotype + Sex, data = subset(data, Day == "One" & Treatment == "Positive"))
summary(lm_day1_p)
lm_day1_n <- lm(Average_Latency ~  Weight + SLC_Genotype + Sex, data = subset(data, Day == "One" & Treatment == "Negative"))
summary(lm_day1_n)
lm_day2_p <- lm(Average_Latency ~  Weight + SLC_Genotype + Sex , data = subset(data, Day == "Two" & Treatment == "Positive"))
summary(lm_day2_p)
lm_day2_n <- lm(Average_Latency ~  Weight + SLC_Genotype + Sex , data = subset(data, Day == "Two" & Treatment == "Negative"))
summary(lm_day2_n)
lm_day3_p <- lm(Average_Latency ~ Weight + SLC_Genotype + Sex , data = subset(data, Day == "Three" & Treatment == "Positive"))
summary(lm_day3_p)
lm_day3_n <- lm(Average_Latency ~ Weight + SLC_Genotype + Sex , data = subset(data, Day == "Three" & Treatment == "Negative"))
summary(lm_day3_n)

lm_day1_p_f <- lm(Average_Latency ~  Weight + SLC_Genotype, data = subset(data, Day == "One" & Treatment == "Positive" & Sex =="Female"))
summary(lm_day1_p_f)
lm_day1_n_f <- lm(Average_Latency ~  Weight + SLC_Genotype, data = subset(data, Day == "One" & Treatment == "Negative" & Sex == "Female"))
summary(lm_day1_n_f)
lm_day2_p_f <- lm(Average_Latency ~  Weight + SLC_Genotype, data = subset(data, Day == "Two" & Treatment == "Positive" & Sex =="Female"))
summary(lm_day2_p_f)
lm_day2_n_f <- lm(Average_Latency ~  Weight + SLC_Genotype, data = subset(data, Day == "Two" & Treatment == "Negative" & Sex == "Female"))
summary(lm_day2_n_f)
lm_day3_p_f <- lm(Average_Latency ~ Weight + SLC_Genotype, data = subset(data, Day == "Three" & Treatment == "Positive" & Sex == "Female"))
summary(lm_day3_p_f)
lm_day3_n_f <- lm(Average_Latency ~ Weight + SLC_Genotype, data = subset(data, Day == "Three" & Treatment == "Negative" & Sex == "Female"))
summary(lm_day3_n_f)

lm_day1_p_m <- lm(Average_Latency ~  Weight + SLC_Genotype, data = subset(data, Day == "One" & Treatment == "Positive" & Sex =="Male"))
summary(lm_day1_p_m)
lm_day1_n_m <- lm(Average_Latency ~  Weight + SLC_Genotype, data = subset(data, Day == "One" & Treatment == "Negative" & Sex == "Male"))
summary(lm_day1_n_m)
lm_day2_p_m <- lm(Average_Latency ~  Weight + SLC_Genotype, data = subset(data, Day == "Two" & Treatment == "Positive" & Sex =="Male"))
summary(lm_day2_p_m)
lm_day2_n_m <- lm(Average_Latency ~  Weight + SLC_Genotype, data = subset(data, Day == "Two" & Treatment == "Negative" & Sex == "Male"))
summary(lm_day2_n_m)
lm_day3_p_m <- lm(Average_Latency ~ Weight + SLC_Genotype, data = subset(data, Day == "Three" & Treatment == "Positive" & Sex == "Male"))
summary(lm_day3_p_m)
lm_day3_n_m <- lm(Average_Latency ~ Weight + SLC_Genotype, data = subset(data, Day == "Three" & Treatment == "Negative" & Sex == "Male"))
summary(lm_day3_n_m)
# Save outputs -
sink("Rotarod_Stats.md")
cat("\n\nSummary for all days, Tg Pos:\n")
print(summary(all_p))
cat("\n\nSummary for all days, Tg Neg:\n")
print(summary(all_n))
cat("\n\nSummary for Day 1, Tg Pos:\n")
print(summary(lm_day1_p))
cat("\n\nSummary for Day 1, Tg Neg:\n")
print(summary(lm_day1_n))
cat("\n\nSummary for Day 2, Tg Pos:\n")
print(summary(lm_day2_p))
cat("\n\nSummary for Day 2, Tg Neg:\n")
print(summary(lm_day2_n))
cat("\n\nSummary for Day 3, Tg Pos:\n")
print(summary(lm_day3_p))
cat("\n\nSummary for Day 3, Tg Neg:\n")
print(summary(lm_day3_n))
sink()

## LMEM on full dataset --
# Tg + vs Tg - 
lme_model <- lme(Average_Latency ~ Treatment*Day + Weight + SLC_Genotype + Sex, 
                 random = ~ 1 | MouseID, 
                 data = data)
summary(lme_model)

# SLC Genotype given Tg Status
lme_model_p <- lme(Average_Latency ~ SLC_Genotype*Day + Weight + SLC_Genotype + Sex, 
                 random = ~ 1 | MouseID, 
                 data = subset(data,Treatment =="Positive"))
summary(lme_model_p)
lme_model_n <- lme(Average_Latency ~ SLC_Genotype*Day + Weight + SLC_Genotype + Sex, 
                   random = ~ 1 | MouseID, 
                   data = subset(data,Treatment =="Negative"))
summary(lme_model_n)

# Save outputs -
sink("Rotarod_Stats.md")
cat("\n\nLMEM on Full Dataset, Tg + vs Tg -:\n")
print(summary(lme_model))
cat("\n\nLMEM on Tg Pos:\n")
print(summary(lme_model_p))
cat("\n\nLMEM on Tg Neg:\n")
print(summary(lme_model_n))
sink()
