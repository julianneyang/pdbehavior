library(ggplot2)
library(dplyr)
library(cowplot)
library(here)

generate_boxplots <- function(input_data, X, Y, min,max){
  data<-as.data.frame(input_data)
  #Ensure correct ordering of levels 
  #data$Genotype <- data$SLC_Genotype
  #data$SLC_Genotype <- factor(data$SLC_Genotype, levels = c("WT", "HET", "MUT"))
  
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

## ASO Rotarod --
data <- readr::read_csv(here("Analysis_Files", "ASO","ASO Rotarod - Rotarod.csv"))
data$SLC_Genotype <- factor(data$SLC_Genotype, levels=c("WT", "HET", "MUT"))
data$Day <- factor(data$Day, levels=c("One", "Two", "Three"))

aso_data_positive <- data %>% filter(ASO_Tg=="Positive")
aso_data_positive_plot_by_Day <- generate_boxplots(aso_data_positive, SLC_Genotype, Average_Latency,0,250) +
  ggtitle("ASO Rotarod")+
  ylab("Average Latency to Fall (s)")+
  xlab("")+
  facet_wrap(~Day)+
  theme(plot.title = element_text(hjust = 0.5))

## PFF Rotarod --
data <- readr::read_csv(here("Analysis_Files/PFF/PFF Rotarod - PFF_Rotarod_Analysis.csv"))
data$SLC_Genotype <- factor(data$SLC_Genotype, levels=c("WT", "HET", "MUT"))
data$Day <- plyr::revalue(data$Day, c("one"="One","two"="Two","three"="Three")) 
data$Day <- factor(data$Day, levels =c("One", "Two", "Three"))
pff_data_positive_plot_by_Day <- generate_boxplots(data, SLC_Genotype, Average_Latency,0,250) +
  ggtitle("PFF Rotarod")+
  ylab("")+
  xlab("")+
  facet_wrap(~Day)+
  theme(plot.title = element_text(hjust = 0.5))

## MPTP Rotarod
data <- readr::read_csv(here("Analysis_Files", "MPTP","MPTP_Rotarod.csv"))
data$SLC_Genotype <- factor(data$SLC_Genotype, levels=c("WT", "HET", "MUT"))
mptp_data <- data %>% filter(Treatment=="MPTP")
mptp_rotarod_plot <- generate_boxplots(mptp_data, SLC_Genotype, Average_Latency,0,250) + 
  ggtitle("MPTP Rotarod")+
  ylab("")+
  xlab("")+
  theme(plot.title = element_text(hjust = 0.5))

## ASO Olfaction --
data <- readr::read_csv(here("Analysis_Files", "ASO","ASO Food Pellet - Buried_Food_Pellet.csv"))
data$SLC_Genotype <- factor(data$SLC_Genotype, levels=c("WT", "HET", "MUT"))
data <- data %>% filter(ASO_Tg=="Positive")
buried_food_pellet <-generate_boxplots(data, SLC_Genotype, Total_Time,0,900) +
  ggtitle("ASO Buried Food")+
  ylab("Time to find (s)")+
  xlab("")+
  theme(plot.title = element_text(hjust = 0.5))
buried_food_pellet

## grip strength --
grip <- readr::read_csv(here("Analysis_Files", "PFF", "PFF_Forelimb_Grip_Strength.csv"))

pff_grip <-generate_boxplots(grip, SLC_Genotype, Average,0,1.5)+
  ggtitle("PFF Grip Strength")+
  ylab("Force (N)")+
  xlab("")+
  theme(plot.title = element_text(hjust = 0.5))

pff_grip


## Final Figure --
top_row <- plot_grid(aso_data_positive_plot_by_Day, pff_data_positive_plot_by_Day, 
                     labels = c("A","B"),
                     nrow=1, 
                     rel_widths = c(2,2,1))
middle_row <- plot_grid(mptp_rotarod_plot,buried_food_pellet, pff_grip, 
                        labels =c("C","D","E"), nrow=1)
plot_grid(top_row,
          middle_row,
          nrow=2)

## Accompanying Statistics --

# PFF Wire Hang -
wire_hang <- readr::read_csv(here("Analysis_Files", "PFF", "PFF_Wire_Hang - Wire_Hang.csv"))
wire_hang <- wire_hang %>% filter(DPI==120)
pff_bw <- readr::read_csv(here("Analysis_Files/PFF/PFF Rotarod - PFF_Rotarod_Analysis.csv"))
pff_bw <- unique(pff_bw %>% select(c("MouseID","Weight")))

hang_bw <- merge(pff_bw, wire_hang, by="MouseID")
hang_bw$SLC_Genotype <- factor(hang_bw$SLC_Genotype, levels=c("WT","HET","MUT"))
lm <- lm(Total_Hang_Time~  Weight + Sex + SLC_Genotype, data = hang_bw)
summary(lm)

wire_hang <- readr::read_csv(here("Analysis_Files", "PFF", "PFF_Wire_Hang - Wire_Hang.csv"))
wire_hang <- wire_hang %>% filter(DPI==180)
pff_bw <- readr::read_csv(here("Analysis_Files/PFF/PFF Rotarod - PFF_Rotarod_Analysis.csv"))
pff_bw <- unique(pff_bw %>% select(c("MouseID","Weight")))

hang_bw <- merge(pff_bw, wire_hang, by="MouseID")
hang_bw$SLC_Genotype <- factor(hang_bw$SLC_Genotype, levels=c("WT","HET","MUT"))
lm <- lm(Total_Hang_Time~  Weight + Sex + SLC_Genotype, data = hang_bw)
summary(lm)
