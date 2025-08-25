library(ggplot2)
library(dplyr)
library(cowplot)
library(here)
library(tidyr)
library(ggbeeswarm)

## Environment --
here::i_am("Rscripts/Figure_S2_MPTP_Behaviors.R")

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

## Open Field -- 
of <- readr::read_csv(here("Analysis_Files", "MPTP","MPTP_Open_Field.csv"))
summary(of$Center_Time)
summary(of$Distance)
of_mptp <- of %>% filter(Treatment=="MPTP")

of_center <- generate_boxplots(of_mptp, SLC_Genotype, Center_Time,0,400) +
  ggtitle("Open Field")+
  ylab("Time in Center (s)")+
  xlab("")+
  theme(plot.title = element_text(hjust = 0.5))

of_distance <- generate_boxplots(of_mptp, SLC_Genotype, Distance,0,40) + 
  ggtitle("Open Field")+
  ylab("Distance Traveled (cm)")+
  xlab("")+
  theme(plot.title = element_text(hjust = 0.5))

## Object Location Memory -- 
olm<- readr::read_csv(here("Analysis_Files", "MPTP", "MPTP_OPR.csv"))
olm$Day <- factor(olm$Day, levels=c("Training", "Testing"))
olm_MPTP <- olm %>% filter(Treatment=="MPTP")
olm_plot <- generate_boxplots(olm_MPTP, SLC_Genotype, Percent_Investigation_Time,0,100) +
  facet_wrap(~Day) +
  ggtitle("Object Location Memory")+
  ylab("Time Investigated (%)")+
  xlab("")+
  theme(plot.title = element_text(hjust = 0.5))
olm_plot

## Tail Suspension Test -- 
TST<- readr::read_csv(here("Analysis_Files", "MPTP", "MPTP_TST.csv"))
TST_MPTP <- TST %>% filter(Treatment=="MPTP")
TST_plot <- generate_boxplots(TST_MPTP, SLC_Genotype, Total_Time,0,300) +
  ggtitle("Tail Suspension Test")+
  ylab("Time spent mobile (s)")+
  xlab("")+
  theme(plot.title = element_text(hjust = 0.5))
TST_plot

## Novel Object Recognition --
nor<- readr::read_csv(here("Analysis_Files", "MPTP", "MPTP_NOR.csv"))
nor$Day <- factor(nor$Day, levels=c("Training", "Testing"))
nor_MPTP <- nor %>% filter(Treatment=="MPTP")
nor_plot <- generate_boxplots(nor_MPTP, SLC_Genotype, Percent_Investigation_Time,0,100) +
  facet_wrap(~Day) +
  ggtitle("Novel Object Recognition")+
  ylab("Time Investigated (%)")+
  xlab("")+
  theme(plot.title = element_text(hjust = 0.5))
nor_plot

## Nesting --
nest<- readr::read_csv(here("Analysis_Files", "MPTP", "MPTP_Nesting - All_Scores.csv"))
nest$SLC_Genotype <- factor(nest$SLC_Genotype, levels=c("WT", "HET", "MUT"))
nest_MPTP <- nest %>% filter(Treatment=="MPTP")

nest_score <-  ggplot(data=nest_MPTP,aes(x=SLC_Genotype,y=Score_Severe, color=SLC_Genotype)) + 
  stat_summary(aes(x=SLC_Genotype, y=Score_Severe), fun=median, geom="crossbar", colour="black")+
  geom_beeswarm(cex = 3,priority = "density",size=3)+
  scale_color_viridis_d(option = "D")+
  theme_cowplot(16) +
  theme(legend.position = "none")+
  ggtitle("Nest Construction")+
  ylab("Score")+
  xlab("")+
  theme(plot.title = element_text(hjust = 0.5))
nest_score

## Weights -- 
bw <- readr::read_csv(here("Analysis_Files", "MPTP","MPTP_Rotarod.csv"))
bw_mptp <- bw %>% filter(Treatment=="MPTP")
weight <- generate_boxplots(bw_mptp, SLC_Genotype, Weight,0,40) +
  ggtitle("Body Weight")+
  ylab("Weight (g)")+
  xlab("")+
  theme(plot.title = element_text(hjust = 0.5))
weight 

## Full figure S2 
top <- plot_grid(of_center, of_distance,weight, nest_score, labels=c("A", "B","C","D"), rel_widths = c(1,1,1,2), nrow=1)
top
bottom <- plot_grid(nor_plot, olm_plot, TST_plot, labels=c("E", "F", "G"), nrow=1)
bottom
plot_grid(top, bottom, nrow=2)

### Accompanying statistics ---

## Rotarod -- 
rotarod_bw <- merge(rotarod, bw,by="MouseID")
rotarod_bw$SLC_Genotype.x <- factor(rotarod_bw$SLC_Genotype.x, levels = c("WT", "HET", "MUT"))
lm_day1 <- lm(Average_Latency ~  Weight + SLC_Genotype.x + Sex.x, data = subset(rotarod_bw, Day == "One"))
summary(lm_day1)


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


