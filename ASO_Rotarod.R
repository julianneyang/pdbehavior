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


data<-read.csv("ASO Rotarod - Rotarod.csv", header=TRUE)
data$Day <- factor(data$Day, levels =c("One","Two","Three"))
data$SLC_Genotype <- factor(data$SLC_Genotype, levels=c("WT", "HET", "MUT"))
day3 <- data%>% filter(Day=="Three")
day2 <- data%>% filter(Day=="Two")
day2 <- data%>% filter(Day=="One")

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


cs_rota_all_slc_posvneg <- generate_boxplots(data, SLC_Genotype, Average_Latency,0,550) + 
  facet_wrap(~ASO_Tg)+
  ggtitle("Rotarod All Days")+
  theme(plot.title = element_text(hjust = 0.5))
cs_rota_slc_posvneg <- generate_boxplots(data, SLC_Genotype, Average_Latency,0,550) + facet_wrap(ASO_Tg~Day)
cs_rota_slc_posvneg_sex <- generate_boxplots(data, SLC_Genotype, Average_Latency,0,550) + 
  facet_wrap(ASO_Tg~Sex+Day,ncol=6) 

cs_rota_all_posvneg <- generate_boxplots(data, ASO_Tg, Average_Latency,0,300) +
  ggtitle("Rotarod All Days")+
  theme(plot.title = element_text(hjust = 0.5))
cs_rota_posvneg <- generate_boxplots(data, ASO_Tg, Average_Latency,0,300) + facet_wrap(~Day)


###  Calculate mean and standard errors by ASO_Tg ---
## ASO Pos vs Neg --
summary_data <- data %>%
  group_by( Day,ASO_Tg) %>%
  summarise(mean_latency = mean(Average_Latency),
            se_latency = sd(Average_Latency) / sqrt(n()))

# Plot the trajectory lines and mean lines
traj_posvneg <- ggplot(summary_data, aes(x = Day, y = mean_latency, color = ASO_Tg,group=ASO_Tg)) +
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
  group_by(SLC_Genotype,Day,ASO_Tg) %>%
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
  facet_wrap(~ASO_Tg) +
  theme(legend.position = "top",legend.justification = "center") +
  ggtitle("Rotarod SLC within Tg status")+
  theme(plot.title = element_text(hjust = 0.5))


## SLC Genotype within ASO Pos or Neg and Sex- Stratified --
summary_data <- data %>%
  group_by(Sex,SLC_Genotype,Day,ASO_Tg) %>%
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
  facet_wrap(Sex~ASO_Tg) +
  theme(legend.position = "top",legend.justification = "center") +
  ggtitle("Rotarod SLC within Tg status by Sex")+
  theme(plot.title = element_text(hjust = 0.5))

plot_grid(traj_posvneg, traj_slc_posvneg)

### Statistics ---

## LM on Full Dataset --
all <- lm(Average_Latency ~ Day+ ASO_Tg + Weight + SLC_Genotype + Sex, data = data)
summary(all)
interact <- lm(Average_Latency ~ Day+ ASO_Tg*SLC_Genotype + Weight + Sex, data = data)
summary(interact)
lm_day1 <- lm(Average_Latency ~ ASO_Tg + Weight + SLC_Genotype + Sex, data = subset(data, Day == "One"))
summary(lm_day1)
lm_day2 <- lm(Average_Latency ~ ASO_Tg + Weight + SLC_Genotype + Sex , data = subset(data, Day == "Two"))
summary(lm_day2)
lm_day3 <- lm(Average_Latency ~ ASO_Tg + Weight + SLC_Genotype + Sex , data = subset(data, Day == "Three"))
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
cat("\n\nSummary for SLC_Genotype*ASO_Tg Interaction:")
print(summary(interact))
sink()

## LM on Dataset Stratified by ASO_Tg--
all_p <- lm(Average_Latency ~ Day+ Weight + SLC_Genotype + Sex, data =  subset(data, ASO_Tg == "Positive"))
summary(all_p)
all_n <- lm(Average_Latency ~ Day+ Weight + SLC_Genotype + Sex, data =  subset(data, ASO_Tg == "Negative"))
summary(all_n)
lm_day1_p <- lm(Average_Latency ~  Weight + SLC_Genotype + Sex, data = subset(data, Day == "One" & ASO_Tg == "Positive"))
summary(lm_day1_p)
lm_day1_n <- lm(Average_Latency ~  Weight + SLC_Genotype + Sex, data = subset(data, Day == "One" & ASO_Tg == "Negative"))
summary(lm_day1_n)
lm_day2_p <- lm(Average_Latency ~  Weight + SLC_Genotype + Sex , data = subset(data, Day == "Two" & ASO_Tg == "Positive"))
summary(lm_day2_p)
lm_day2_n <- lm(Average_Latency ~  Weight + SLC_Genotype + Sex , data = subset(data, Day == "Two" & ASO_Tg == "Negative"))
summary(lm_day2_n)
lm_day3_p <- lm(Average_Latency ~ Weight + SLC_Genotype + Sex , data = subset(data, Day == "Three" & ASO_Tg == "Positive"))
summary(lm_day3_p)
lm_day3_n <- lm(Average_Latency ~ Weight + SLC_Genotype + Sex , data = subset(data, Day == "Three" & ASO_Tg == "Negative"))
summary(lm_day3_n)

lm_day1_p_f <- lm(Average_Latency ~  Weight + SLC_Genotype, data = subset(data, Day == "One" & ASO_Tg == "Positive" & Sex =="Female"))
summary(lm_day1_p_f)
lm_day1_n_f <- lm(Average_Latency ~  Weight + SLC_Genotype, data = subset(data, Day == "One" & ASO_Tg == "Negative" & Sex == "Female"))
summary(lm_day1_n_f)
lm_day2_p_f <- lm(Average_Latency ~  Weight + SLC_Genotype, data = subset(data, Day == "Two" & ASO_Tg == "Positive" & Sex =="Female"))
summary(lm_day2_p_f)
lm_day2_n_f <- lm(Average_Latency ~  Weight + SLC_Genotype, data = subset(data, Day == "Two" & ASO_Tg == "Negative" & Sex == "Female"))
summary(lm_day2_n_f)
lm_day3_p_f <- lm(Average_Latency ~ Weight + SLC_Genotype, data = subset(data, Day == "Three" & ASO_Tg == "Positive" & Sex == "Female"))
summary(lm_day3_p_f)
lm_day3_n_f <- lm(Average_Latency ~ Weight + SLC_Genotype, data = subset(data, Day == "Three" & ASO_Tg == "Negative" & Sex == "Female"))
summary(lm_day3_n_f)

lm_day1_p_m <- lm(Average_Latency ~  Weight + SLC_Genotype, data = subset(data, Day == "One" & ASO_Tg == "Positive" & Sex =="Male"))
summary(lm_day1_p_m)
lm_day1_n_m <- lm(Average_Latency ~  Weight + SLC_Genotype, data = subset(data, Day == "One" & ASO_Tg == "Negative" & Sex == "Male"))
summary(lm_day1_n_m)
lm_day2_p_m <- lm(Average_Latency ~  Weight + SLC_Genotype, data = subset(data, Day == "Two" & ASO_Tg == "Positive" & Sex =="Male"))
summary(lm_day2_p_m)
lm_day2_n_m <- lm(Average_Latency ~  Weight + SLC_Genotype, data = subset(data, Day == "Two" & ASO_Tg == "Negative" & Sex == "Male"))
summary(lm_day2_n_m)
lm_day3_p_m <- lm(Average_Latency ~ Weight + SLC_Genotype, data = subset(data, Day == "Three" & ASO_Tg == "Positive" & Sex == "Male"))
summary(lm_day3_p_m)
lm_day3_n_m <- lm(Average_Latency ~ Weight + SLC_Genotype, data = subset(data, Day == "Three" & ASO_Tg == "Negative" & Sex == "Male"))
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
lme_model <- lme(Average_Latency ~ ASO_Tg*Day + Weight + SLC_Genotype + Sex, 
                 random = ~ 1 | MouseID, 
                 data = data)
summary(lme_model)

# SLC Genotype given Tg Status
lme_model_p <- lme(Average_Latency ~ SLC_Genotype*Day + Weight + SLC_Genotype + Sex, 
                 random = ~ 1 | MouseID, 
                 data = subset(data,ASO_Tg =="Positive"))
summary(lme_model_p)
lme_model_n <- lme(Average_Latency ~ SLC_Genotype*Day + Weight + SLC_Genotype + Sex, 
                   random = ~ 1 | MouseID, 
                   data = subset(data,ASO_Tg =="Negative"))
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
