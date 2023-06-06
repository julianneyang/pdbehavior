library(ggplot2)
library(rlang)
library(cowplot)
library(viridis)
library(tidyr)
library(dplyr)

setwd("~/Documents/pdbehavior/")
data<-read.csv("ASO Food Pellet - Buried_Food_Pellet.csv", header=TRUE)
data$SLC_Genotype <- factor(data$SLC_Genotype, levels=c("WT", "HET", "MUT"))

generate_boxplots <- function(input_data, X, Y, min,max){
  data<-as.data.frame(input_data)
  #Ensure correct ordering of levels 
  data$Genotype <- factor(data$ASO_Tg, levels = c("Negative", "Positive"))
  
  ggplot(data=data,aes(x={{X}},y={{Y}}, fill={{X}})) + 
    #geom_violin(alpha=0.25,position=position_dodge(width=.75),size=1,color="black",draw_quantiles=c(0.5))+
    geom_boxplot(alpha=0.25)+
    scale_fill_viridis_d()+
    geom_point(size=1,position=position_jitter(width=0.25),alpha=0.5)+
    theme_cowplot(16) +
    #ylim(min,max)+ 
    #facet_grid(~Sex)+    
    theme(legend.position = "none")
  
}

# Total_Time vs ASO_Tg

a <-generate_boxplots(data, ASO_Tg, Total_Time,0,900) +
  ggtitle("Buried Food Pellet")+
  theme(plot.title = element_text(hjust = 0.5))

a

d<-generate_boxplots(data, ASO_Tg, Total_Time,0,900) +
  ggtitle("Buried Food Pellet")+
  theme(plot.title = element_text(hjust = 0.5))+
  facet_wrap(~Sex)

d

# Stratified by SLC Genotype
b<-generate_boxplots(data, SLC_Genotype, Total_Time,0,51)+
  facet_wrap(~ASO_Tg)
b

# Stratified by SLC Genotype and Sex 
e<-generate_boxplots(data, SLC_Genotype, Total_Time,0,51)+
  facet_wrap(Sex~ASO_Tg)
e

## Parametric Stats --
lm1 <- lm(Total_Time ~ Weight + Sex + ASO_Tg +SLC_Genotype, data = data)
summary(lm1)

interact <- lm(Total_Time ~ Weight + Sex + ASO_Tg*SLC_Genotype, data = data)
summary(interact)

lm2 <- lm(Total_Time ~ Weight + Sex + SLC_Genotype, data =  subset(data, ASO_Tg == "Positive"))
summary(lm2)

lm3 <- lm(Total_Time ~ Weight + Sex + SLC_Genotype, data =  subset(data, ASO_Tg == "Negative"))
summary(lm3)

lm4 <- lm(Total_Time ~ Weight + SLC_Genotype, 
          data =  subset(data, ASO_Tg == "Negative" & Sex=="Female"))
summary(lm4) 
lm5 <- lm(Total_Time ~ Weight + SLC_Genotype, 
          data =  subset(data, ASO_Tg == "Positive" & Sex=="Female"))
summary(lm5) 

lm6 <- lm(Total_Time ~ Weight + SLC_Genotype, 
          data =  subset(data, ASO_Tg == "Negative" & Sex=="Male"))
summary(lm6) 
lm7 <- lm(Total_Time ~ Weight + SLC_Genotype, 
          data =  subset(data, ASO_Tg == "Positive" & Sex=="Male"))
summary(lm7) 

# Save outputs -
sink("Buried_Food_Pellet_Stats.md")
cat("\n\nSummary for all data:\n")
print(summary(lm1))
cat("\n\nSummary for interaction:\n")
print(summary(interact))
cat("\n\nSummary for Tg Neg:\n")
print(summary(lm3))
cat("\n\nSummary for Tg Pos:\n")
print(summary(lm2))
cat("\n\nSummary for Females Tg Neg:\n")
print(summary(lm4))
cat("\n\nSummary for Females Tg Pos:\n")
print(summary(lm5))
cat("\n\nSummary for Males Tg Neg:\n")
print(summary(lm6))
cat("\n\nSummary for Males Tg Pos:\n")
print(summary(lm7))
sink()
