library(ggplot2)
library(dplyr)
library(cowplot)
library(here)
library(ggpubr)

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
data <- readr::read_csv(here("data", "ASO","ASO Rotarod - Rotarod.csv"))
data$SLC_Genotype <- factor(data$SLC_Genotype, levels=c("WT", "HET", "MUT"))
data$Day <- factor(data$Day, levels=c("One", "Two", "Three"))

aso_data_positive <- data %>% filter(ASO_Tg=="Positive")
aso_data_positive_plot_by_Day <- generate_boxplots(aso_data_positive, SLC_Genotype, Average_Latency,0,250) +
  ggtitle("ASO Rotarod")+
  ylab("Average Latency to Fall (s)")+
  xlab("")+
  facet_wrap(~Day)+
  theme(plot.title = element_text(hjust = 0.5)) #+
  # stat_compare_means(comparisons=c("WT", "MUT"))
                                      

## PFF Rotarod --
pff_data <- readr::read_csv(here("data/PFF/PFF Rotarod - PFF_Rotarod_Analysis.csv"))
pff_data$SLC_Genotype <- factor(pff_data$SLC_Genotype, levels=c("WT", "HET", "MUT"))
pff_data$Day <- plyr::revalue(pff_data$Day, c("one"="One","two"="Two","three"="Three")) 
pff_data$Day <- factor(pff_data$Day, levels =c("One", "Two", "Three"))
pff_data_positive_plot_by_Day <- generate_boxplots(pff_data, SLC_Genotype, Average_Latency,0,250) +
  ggtitle("PFF Rotarod")+
  ylab("")+
  xlab("")+
  facet_wrap(~Day)+
  theme(plot.title = element_text(hjust = 0.5))

## MPTP Rotarod
data <- readr::read_csv(here("data", "MPTP","MPTP_Rotarod.csv"))
data$SLC_Genotype <- factor(data$SLC_Genotype, levels=c("WT", "HET", "MUT"))
mptp_data <- data %>% filter(Treatment=="MPTP")
mptp_rotarod_plot <- generate_boxplots(mptp_data, SLC_Genotype, Average_Latency,0,250) + 
  ggtitle("MPTP/p Rotarod")+
  ylab("")+
  xlab("")+
  theme(plot.title = element_text(hjust = 0.5))

## ASO Olfaction --
olf_data <- readr::read_csv(here("data", "ASO","ASO Food Pellet - Buried_Food_Pellet.csv"))
olf_data$SLC_Genotype <- factor(olf_data$SLC_Genotype, levels=c("WT", "HET", "MUT"))
olf_data <- olf_data %>% filter(ASO_Tg=="Positive")
buried_food_pellet <-generate_boxplots(olf_data, SLC_Genotype, Total_Time,0,900) +
  ggtitle("ASO Buried Food")+
  ylab("Time to find (s)")+
  xlab("")+
  theme(plot.title = element_text(hjust = 0.5))
buried_food_pellet

## grip strength --
grip <- readr::read_csv(here("data", "PFF", "PFF_Forelimb_Grip_Strength.csv"))
grip$SLC_Genotype <- factor(grip$SLC_Genotype, levels=c("WT", "HET", "MUT"))
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

## Statistics --

# Fig 2A 
data <- aso_data_positive
lm_day1_p <- lm(Average_Latency ~  Weight + SLC_Genotype + Sex, data = subset(data, Day == "One" & ASO_Tg == "Positive"))
summary(lm_day1_p)
lm_day2_p <- lm(Average_Latency ~  Weight + SLC_Genotype + Sex , data = subset(data, Day == "Two" & ASO_Tg == "Positive"))
summary(lm_day2_p)
lm_day3_p <- lm(Average_Latency ~ Weight + SLC_Genotype + Sex , data = subset(data, Day == "Three" & ASO_Tg == "Positive"))
summary(lm_day3_p)

# Fig 2B
data <- pff_data
lm_day1 <- lm(Average_Latency ~  Weight + SLC_Genotype + Sex, data = subset(data, Day == "One"))
summary(lm_day1)
lm_day2 <- lm(Average_Latency ~ Weight + SLC_Genotype + Sex , data = subset(data, Day == "Two"))
summary(lm_day2)
lm_day3 <- lm(Average_Latency ~ Weight + SLC_Genotype + Sex , data = subset(data, Day == "Three"))
summary(lm_day3)

# Fig 2C 
data <- mptp_data
all_p <- lm(Average_Latency ~  Weight + SLC_Genotype + Sex, data =  subset(data, Treatment == "MPTP"))
summary(all_p)

# Fig 2D
data <- olf_data
lm2 <- lm(Total_Time ~ Sex + SLC_Genotype, data =  subset(data, ASO_Tg == "Positive"))
summary(lm2)


# Fig 2E
data <- grip
lm <- lm(Average ~ Sex + SLC_Genotype, data =  data)
summary(lm)
