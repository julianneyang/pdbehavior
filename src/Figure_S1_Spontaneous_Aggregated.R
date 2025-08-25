library(ggplot2)
library(dplyr)
library(cowplot)
library(here)
library(tidyr)

## Environment --
here::i_am("Rscripts/Figure_S1_Spontaneous_Aggregated.R")

## Functions --
generate_boxplots <- function(input_data, X, Y, min,max){
  data<-as.data.frame(input_data)
  #Ensure correct ordering of levels 
  #data$Genotype <- data$SLC_Genotype
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

## Rotarod -- 
rotarod<-readr::read_csv(here("data", "Spontaneous", "Data_Rotarod_Analysis.csv"))
rotarod$Day <- factor(rotarod$Day, levels=c("One", "Two", "Three"))
summary(rotarod$Average_Latency)

Rotarod_plot_by_Day <- generate_boxplots(rotarod, SLC_Genotype, Average_Latency,0,250) +
  ggtitle("Rotarod")+
  ylab("Average Latency to Fall (s)")+
  xlab("")+
  facet_wrap(~Day)+
  theme(plot.title = element_text(hjust = 0.5))

## Open Field --
of <-readr::read_csv(here("data", "Spontaneous", "SLC_Spontaneous_Open_Field_Analysis.csv"))
of$SLC_Genotype <- factor(of$SLC_Genotype, levels = c("WT", "HET", "MUT"))
summary(of$Center_Time)
summary(of$Distance)
of_center <- generate_boxplots(of, SLC_Genotype, Center_Time,0,550) + 
  ggtitle("Open Field")+
  ylab("Time in Center (s)")+
  xlab("")+
  theme(plot.title = element_text(hjust = 0.5))
of_distance <- generate_boxplots(of, SLC_Genotype, Distance,0,30) + 
  ggtitle("Open Field")+
  ylab("Distance Traveled (cm)")+
  xlab("")+
  theme(plot.title = element_text(hjust = 0.5))

## Object Location Memory -- 
olm<- readr::read_csv(here("data", "Spontaneous", "Data_OLM_Analysis.csv"))
olm$Day <- factor(olm$Day)
olm$Day <- plyr::revalue(olm$Day, c('1' = "Training", '2' = "Testing"))

olm_plot <- generate_boxplots(olm, SLC_Genotype, Percent_Time_Investigated,0,100) +
  facet_wrap(~Day) +
  ggtitle("Object Location Memory")+
  ylab("Time Investigated (%)")+
  xlab("")+
  theme(plot.title = element_text(hjust = 0.5))

## Weights -- 
bw <- readr::read_csv(here("data", "Spontaneous", "SLC Spontaneous Weights - Sheet1.csv"))
weight <- generate_boxplots(bw, SLC_Genotype, Weight,0,50) +
  ggtitle("Body Weight")+
  ylab("Weight (g)")+
  xlab("")+
  theme(plot.title = element_text(hjust = 0.5))

## Full figure S1 
top <- plot_grid(Rotarod_plot_by_Day, olm_plot, labels=c("A", "B"), rel_widths = c(1.5,1))
top
bottom <- plot_grid(of_center, of_distance, weight, labels=c("C","D", "E"), nrow=1)
bottom
plot_grid(top, bottom, nrow=2)

### Accompanying statistics ---

## Rotarod -- 
rotarod_bw <- merge(rotarod, bw,by="MouseID")
rotarod_bw$SLC_Genotype.x <- factor(rotarod_bw$SLC_Genotype.x, levels = c("WT", "HET", "MUT"))
lm_day1 <- lm(Average_Latency ~  Weight + SLC_Genotype.x + Sex.x, data = subset(rotarod_bw, Day == "One"))
summary(lm_day1)
lm_day2 <- lm(Average_Latency ~  Weight + SLC_Genotype.x + Sex.x, data = subset(rotarod_bw, Day == "Two"))
summary(lm_day2)
lm_day3 <- lm(Average_Latency ~  Weight + SLC_Genotype.x + Sex.x, data = subset(rotarod_bw, Day == "Three"))
summary(lm_day3)

## OLM -- 
olm_bw <- merge(bw, olm,by="MouseID")
olm_bw$SLC_Genotype.x <- factor(olm_bw$SLC_Genotype.x, levels = c("WT", "HET", "MUT"))
lm_day1 <- lm(Percent_Time_Investigated~  SLC_Genotype.x + Sex.x, data = subset(olm_bw, Day == "Training"))
summary(lm_day1)
lm_day2 <- lm(Percent_Time_Investigated~  SLC_Genotype.x + Sex.x, data = subset(olm_bw, Day == "Testing"))
summary(lm_day2)

## Body Weight -- 
bw$SLC_Genotype <- factor(bw$SLC_Genotype, levels=c("WT","HET", "MUT"))
lm_day1 <- lm(Weight ~ Sex + SLC_Genotype, data = bw)
summary(lm_day1)

## Open Field --
of$SLC_Genotype <- factor(of$SLC_Genotype, levels=c("WT","HET", "MUT"))
lm_day1 <- lm(Center_Time ~ Sex + SLC_Genotype, data = of)
summary(lm_day1)

of_bw <- merge(bw, of,by="MouseID")
of_bw$SLC_Genotype.x <- factor(of_bw$SLC_Genotype.x, levels = c("WT", "HET", "MUT"))
lm_day1 <- lm(Distance ~  Weight+SLC_Genotype.x + Sex.x, data = of_bw)
summary(lm_day1)


