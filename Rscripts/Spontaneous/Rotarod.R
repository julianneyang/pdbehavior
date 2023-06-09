
library(here)
library(ggplot2)
library(rlang)
library(rstatix)  
library(nlme)
library(cowplot)
library(ggbeeswarm)
library(ggpubr)
library(ggsignif)

data<-read.csv("Analysis_Files/Spontaneous/Data_Rotarod_Analysis.csv", header=TRUE)
data$SLC_Genotype <- data$Genotype
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

spontaneous_rotarod <-generate_boxplots(data, SLC_Genotype, Average_Latency_S,0,250)+
  ggtitle("Spontaneous")+
  theme(plot.title = element_text(hjust = 0.5)) + 
  ylab("Average Latency (s)")+
  xlab("")

a<-generate_boxplots(data, Genotype, Average_Latency_S,0,550)+
  facet_wrap(~Day)
a

generate_longitudinal_boxplots <- function(input_data, X, Y, min,max){
  data<-as.data.frame(input_data)
  #Ensure correct ordering of levels 
  data$Genotype <- factor(data$Genotype, levels = c("WT", "HET", "MUT"))
  data$Day <- factor(data$Day, levels = c("1", "2", "3"))
  
  ggplot(data=data,aes(x={{X}},y={{Y}}, fill={{X}})) + 
    #geom_violin(alpha=0.25,position=position_dodge(width=.75),size=1,color="black",draw_quantiles=c(0.5))+
    geom_boxplot(alpha=0.25)+ 
    geom_line(aes(group = MouseID,color=Genotype),size=1)+
    scale_fill_viridis_d()+
    geom_point(size=1,position=position_jitter(width=0.25),alpha=0.1)+
    theme_cowplot(16) +
    #ylim(min,max)+
    theme(legend.position = "top")
  
  
}

b<-generate_longitudinal_boxplots(data, Day, Average_Latency_S,0,200)

##aggregate Plots
plot_grid(a,b)

## Stratify by Sex 
males <- data %>% filter(Sex=="Male")
females <- data %>% filter(Sex=="Female")

c<-generate_boxplots(females, Genotype, Average_Latency_S,0,200) + ggtitle("Females")
d<-generate_boxplots(males, Genotype, Average_Latency_S,0,200) + ggtitle("Males")
e<-generate_longitudinal_boxplots(females, Day, Average_Latency_S,0,200)
f<-generate_longitudinal_boxplots(males, Day, Average_Latency_S,0,200)

plot_grid(c,e) + ggtitle("Females")
plot_grid(d,f) + ggtitle("Males")

