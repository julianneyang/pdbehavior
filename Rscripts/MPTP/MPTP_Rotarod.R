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

here::i_am("Rscripts/MPTP/MPTP_Rotarod.R")
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
    ylim(min,max)+
    theme(legend.position = "none") 
  
  
}

mptp_data <- data %>% filter(Treatment=="MPTP")
mptp_rotarod_plot <- generate_boxplots(mptp_data, SLC_Genotype, Average_Latency,0,250) + 
  ggtitle("MPTP-injected")+
  ylab("")+
  xlab("")+
  theme(plot.title = element_text(hjust = 0.5))

cs_rota_all_slc_posvneg <- generate_boxplots(data, Treatment, Average_Latency,0,550) + 
  ggtitle("Rotarod")+
  theme(plot.title = element_text(hjust = 0.5))
cs_rota_slc_posvneg <- generate_boxplots(data, SLC_Genotype, Average_Latency,0,550) + facet_wrap(~Treatment)+
  ggtitle("Rotarod by SLC Genotype")+
  theme(plot.title = element_text(hjust = 0.5))
cs_rota_slc_posvneg_batch <- generate_boxplots(data, SLC_Genotype, Average_Latency,0,550) + 
  facet_wrap(Treatment~Batch,nrow=2)+
  ggtitle("Rotarod by SLC Genotype")+
  theme(plot.title = element_text(hjust = 0.5))
cs_rota_slc_posvneg_sex <- generate_boxplots(data, SLC_Genotype, Average_Latency,0,550) + 
  facet_wrap(Treatment~Sex,ncol=2) +
  ggtitle("Rotarod by SLC Genotype")+
  theme(plot.title = element_text(hjust = 0.5))

weight_posvneg <- generate_boxplots(data, Treatment, Weight,0,550) + 
  ggtitle("Rotarod")+
  theme(plot.title = element_text(hjust = 0.5))
weight_slc_posvneg <- generate_boxplots(data, SLC_Genotype, Weight,0,550) + facet_wrap(~Treatment)+
  ggtitle("Rotarod by SLC Genotype")+
  theme(plot.title = element_text(hjust = 0.5))
weight_slc_posvneg_sex <- generate_boxplots(data, SLC_Genotype, Weight,0,550) + 
  facet_wrap(Treatment~Sex,ncol=2) +
  ggtitle("Rotarod by SLC Genotype")+
  theme(plot.title = element_text(hjust = 0.5))

### Statistics ---

## LM on Full Dataset --
all <- lm(Average_Latency ~Treatment + Weight + SLC_Genotype + Sex, data = data)
summary(all)
interact <- lm(Average_Latency ~Treatment*SLC_Genotype + Weight + Sex, data = data)
summary(interact)


# Save outputs -
# Open a connection to a text file
sink("Statistics/MPTP/Rotarod_Stats.md")
cat("Summary for all data, Tg + vs Tg -:\n")
print(summary(all))
cat("\n\nSummary for SLC_Genotype*Treatment Interaction:")
print(summary(interact))
sink()

## LM on Dataset Stratified by Treatment--
all_p <- lm(Average_Latency ~  Weight + SLC_Genotype + Sex, data =  subset(data, Treatment == "MPTP"))
summary(all_p)
all_n <- lm(Average_Latency ~  Weight + SLC_Genotype + Sex, data =  subset(data, Treatment == "SALINE"))
summary(all_n)

lm_day1_p_f <- lm(Average_Latency ~  Weight + SLC_Genotype, data = subset(data, Treatment == "MPTP" & Sex =="Female"))
summary(lm_day1_p_f)
lm_day1_n_f <- lm(Average_Latency ~  Weight + SLC_Genotype, data = subset(data, Treatment == "SALINE" & Sex == "Female"))
summary(lm_day1_n_f)


lm_day1_p_m <- lm(Average_Latency ~  Weight + SLC_Genotype, data = subset(data, Treatment == "MPTP" & Sex =="Male"))
summary(lm_day1_p_m)
lm_day1_n_m <- lm(Average_Latency ~  Weight + SLC_Genotype, data = subset(data, Treatment == "SALINE" & Sex == "Male"))
summary(lm_day1_n_m)

# Save outputs -
sink("Statistics/MPTP/Rotarod_Stats.md")
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

