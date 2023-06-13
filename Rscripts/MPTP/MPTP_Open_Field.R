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
library(here)

here::i_am("Rscripts/MPTP/MPTP_Open_Field.R")
data <- readr::read_csv(here("Analysis_Files", "MPTP","MPTP_Open_Field.csv"))
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


center_time_posvneg <- generate_boxplots(data, Treatment, Center_Time,0,550) + 
  ggtitle("Center Time")+
  theme(plot.title = element_text(hjust = 0.5))
center_time_slc_posvneg <- generate_boxplots(data, SLC_Genotype, Center_Time,0,550) + facet_wrap(~Treatment)+
  ggtitle("Center Time by SLC Genotype")+
  theme(plot.title = element_text(hjust = 0.5))
center_time_slc_posvneg_batch <- generate_boxplots(data, SLC_Genotype, Center_Time,0,550) + 
  facet_wrap(Treatment~Batch,nrow=2)+
  ggtitle("Center Time by SLC Genotype")+
  theme(plot.title = element_text(hjust = 0.5))
center_time_slc_posvneg_sex <- generate_boxplots(data, SLC_Genotype, Center_Time,0,550) + 
  facet_wrap(Treatment~Sex,ncol=2) +
  ggtitle("Center Time by SLC Genotype")+
  theme(plot.title = element_text(hjust = 0.5))

distance_posvneg <- generate_boxplots(data, Treatment, Distance,0,550) + 
  ggtitle("Distance")+
  theme(plot.title = element_text(hjust = 0.5))
distance_slc_posvneg <- generate_boxplots(data, SLC_Genotype, Distance,0,550) + facet_wrap(~Treatment)+
  ggtitle("Distance by SLC Genotype")+
  theme(plot.title = element_text(hjust = 0.5))
distance_slc_posvneg_sex <- generate_boxplots(data, SLC_Genotype, Distance,0,550) + 
  facet_wrap(Treatment~Sex,ncol=2) +
  ggtitle("Distance by SLC Genotype")+
  theme(plot.title = element_text(hjust = 0.5))

### Statistics ---

## LM on Full Dataset --
all <- lm(Center_Time ~Treatment + SLC_Genotype + Sex, data = data)
summary(all)
interact <- lm(Center_Time ~Treatment*SLC_Genotype + Sex, data = data)
summary(interact)

all <- lm(Distance ~Treatment + SLC_Genotype + Sex, data = data)
summary(all)
interact <- lm(Distance ~Treatment*SLC_Genotype + Sex, data = data)
summary(interact)

# Save outputs -
# Open a connection to a text file
sink("Statistics/MPTP/Center Time_Stats.md")
cat("Summary for all data, Tg + vs Tg -:\n")
print(summary(all))
cat("\n\nSummary for SLC_Genotype*Treatment Interaction:")
print(summary(interact))
sink()

## LM on Dataset Stratified by Treatment--
all_p <- lm(Center_Time ~  SLC_Genotype + Sex, data =  subset(data, Treatment == "MPTP"))
summary(all_p)
all_n <- lm(Center_Time ~   SLC_Genotype + Sex, data =  subset(data, Treatment == "SALINE"))
summary(all_n)

lm_day1_p_f <- lm(Center_Time ~  SLC_Genotype, data = subset(data, Treatment == "MPTP" & Sex =="Female"))
summary(lm_day1_p_f)
lm_day1_n_f <- lm(Center_Time ~ SLC_Genotype, data = subset(data, Treatment == "SALINE" & Sex == "Female"))
summary(lm_day1_n_f)


lm_day1_p_m <- lm(Center_Time ~ SLC_Genotype, data = subset(data, Treatment == "MPTP" & Sex =="Male"))
summary(lm_day1_p_m)
lm_day1_n_m <- lm(Center_Time ~  SLC_Genotype, data = subset(data, Treatment == "SALINE" & Sex == "Male"))
summary(lm_day1_n_m)

## LM on Dataset Stratified by Treatment--
all_p <- lm(Distance ~  SLC_Genotype + Sex, data =  subset(data, Treatment == "MPTP"))
summary(all_p)
all_n <- lm(Distance ~   SLC_Genotype + Sex, data =  subset(data, Treatment == "SALINE"))
summary(all_n)

lm_day1_p_f <- lm(Distance ~  SLC_Genotype, data = subset(data, Treatment == "MPTP" & Sex =="Female"))
summary(lm_day1_p_f)
lm_day1_n_f <- lm(Distance ~ SLC_Genotype, data = subset(data, Treatment == "SALINE" & Sex == "Female"))
summary(lm_day1_n_f)


lm_day1_p_m <- lm(Distance ~ SLC_Genotype, data = subset(data, Treatment == "MPTP" & Sex =="Male"))
summary(lm_day1_p_m)
lm_day1_n_m <- lm(Distance ~  SLC_Genotype, data = subset(data, Treatment == "SALINE" & Sex == "Male"))
summary(lm_day1_n_m)


# Save outputs -
sink("Statistics/MPTP/Center Time_Stats.md")
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

