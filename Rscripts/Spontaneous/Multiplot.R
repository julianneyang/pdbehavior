library(here)
library(ggplot2)
library(rlang)
library(rstatix)  
library(nlme)
library(cowplot)
library(ggbeeswarm)
library(ggpubr)
library(ggsignif)
---------------------------------------
#ROTAROD
rotarod_data<-read.csv("Data_Rotarod_Analysis.csv", header=TRUE)

generate_boxplots <- function(input_data, X, Y, min,max){
  data<-as.data.frame(input_data)
  #Ensure correct ordering of levels 
  data$Genotype <- factor(data$Genotype, levels = c("WT", "HET", "MUT"))
  
  
  ggplot(data=data,aes(x={{X}},y={{Y}}, fill={{X}})) + 
    #geom_violin(alpha=0.25,position=position_dodge(width=.75),size=1,color="black",draw_quantiles=c(0.5))+
    geom_boxplot(alpha=0.25)+ 
    geom_quasirandom(alpha=0.1)+
    scale_fill_viridis_d()+
    geom_point(size=1,position=position_jitter(width=0.25),alpha=0.1)+
    theme_cowplot(16) +
    #ylim(min,max)+
    facet_wrap(~Day)+
    theme(legend.position = "none")
  
  
}

a<-generate_boxplots(rotarod_data, Genotype, Average_Latency_S,0,550)+stat_signif(comparisons =
                                                                      list(c("WT", "HET"), c("WT","MUT")),map_signif_level = TRUE, textsize = 6, test="wilcox.test")

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

b<-generate_longitudinal_boxplots(rotarod_data, Day, Average_Latency_S,0,200)

##aggregate
rotarod_plots <- plot_grid(a,b)
---------------------------------------
#BODY WEIGHTS
data<-read.csv("SLC Spontaneous Weights - Sheet1.csv", header=TRUE)

generate_boxplots <- function(input_data, X, Y, min,max){
  data<-as.data.frame(input_data)
  #Ensure correct ordering of levels 
  data$Genotype <- factor(data$Genotype, levels = c("WT", "HET", "MUT"))
  data$Sex <- factor(data$Sex, levels = c("Female","Male"))
  
  ggplot(data=data,aes(x={{X}},y={{Y}}, fill={{X}})) + 
    #geom_violin(alpha=0.25,position=position_dodge(width=.75),size=1,color="black",draw_quantiles=c(0.5))+
    geom_boxplot(alpha=0.25)+ 
    geom_quasirandom(alpha=0.1)+
    scale_fill_viridis_d()+
    geom_point(size=1,position=position_jitter(width=0.25),alpha=0.1)+
    theme_cowplot(16) +
    #ylim(min,max)+
    theme(legend.position = "none")
  
  
}

a2 <- generate_boxplots(data, Genotype, Weight..g., 0,40 ) + 
  stat_compare_means(comparisons = list(c("WT", "HET"),
                                        c("WT", "MUT"),
                                        c("HET","MUT")),method="wilcox", vjust=0.5,label="p.signif",step.increase=0.08, hide.ns = TRUE)

b2 <- generate_boxplots(data, Genotype, Weight..g., 0,40 ) + 
  facet_grid(~Sex) +
  stat_compare_means(comparisons = list(c("WT", "HET"),
                                        c("WT", "MUT"),
                                        c("HET","MUT")),method="wilcox", vjust=0.5,label="p.signif",step.increase=0.08, hide.ns = TRUE)

#aggregate
bodyweight_plots <- plot_grid(a2, b2)
---------------------------------------
#OPEN FIELD
openfield_data<-read.csv("SLC_Spontaneous_Open_Field_Analysis.csv", header=TRUE)

generate_boxplots <- function(input_data, X, Y, min,max){
  data<-as.data.frame(input_data)
  #Ensure correct ordering of levels 
  data$Genotype <- factor(data$Genotype, levels = c("WT", "HET", "MUT"))
  
  ggplot(data=data,aes(x={{X}},y={{Y}}, fill={{X}})) + 
    #geom_violin(alpha=0.25,position=position_dodge(width=.75),size=1,color="black",draw_quantiles=c(0.5))+
    geom_boxplot(alpha=0.25)+
    scale_fill_viridis_d()+
    geom_point(size=1,position=position_jitter(width=0.25),alpha=0.1)+
    theme_cowplot(16) +
    #ylim(min,max)+
    #facet_grid(~Sex)+    
    theme(legend.position = "none")
  
}

#Center Time vs. Genotype
a<-generate_boxplots(openfield_data, Genotype, Center_Time,0,550)+
  stat_compare_means(comparisons = list(c("WT", "HET"), 
                                        c("WT","MUT")),method="wilcox", vjust=0.3,label="p.signif",step.increase=0.05)
a3

#Distance vs Genotype
b<-generate_boxplots(openfield_data, Genotype, Distance,0,26)+
  stat_compare_means(comparisons = list(c("WT", "HET"), 
                                        c("WT","MUT")),method="wilcox", vjust=0.3,label="p.signif",step.increase=0.05)
b3

#Center Entries vs Genotype
c<-generate_boxplots(openfield_data, Genotype, Center.Entries,0,125)+
  stat_compare_means(comparisons = list(c("WT", "HET"), 
                                        c("WT","MUT")),method="wilcox", vjust=0.3,label="p.signif",step.increase=0.05)

c3

#aggregate
openfield_plots <- plot_grid(a3,b3,c3, ncol = 3, rel_heights = c(0.5,0.5,0.5))
---------------------------------------
#OLM
data_box_plot<- read.csv("Data_OLM_Analysis.csv", header=TRUE)

mytheme <- theme(panel.grid.minor=element_blank(), #gets rid of grey and lines in the middle
                 panel.grid.major=element_blank(), #gets rid of grey and lines in the middle
                 panel.background=element_rect(fill="white"),#gets rid of grey and lines in the middle
                 panel.border=element_blank(), #gets rid of square going around the entire graph
                 axis.line.x = element_line(colour = 'black', size = 1),#sets the axis line size
                 axis.line.y = element_line(colour = 'black', size = 1),#sets the axis line size
                 axis.ticks=element_line(colour = 'black', size = 0.5), #sets the tick lines
                 axis.title.x = element_text(size=10, color="black"), #size of x-axis title
                 axis.title.y = element_text(size=10, color="black"), #size of y-axis title
                 axis.text.x = element_text(size=12, color="black"), #size of x-axis text
                 axis.text.y = element_text(size=12, color="black"))#size of y-axis text

data_box_plot$Day <- factor(data_box_plot$Day)
data_box_plot$Day <- plyr::revalue(data_box_plot$Day, c('1' = "Training", '2' = "Testing"))

#Stratify by Day
generate_longitudinal_boxplots <- function(input_data, X, Y, min,max){
  data<-as.data.frame(input_data)
  #Ensure correct ordering of levels
  data$Genotype <- factor(data$Genotype, levels = c("WT","HET","MUT"))
  data$Day <- factor(data$Day, levels = c("Training", "Testing"))
  
  ggplot(data=data,aes(x={{X}},y={{Y}}, fill={{X}})) +
    geom_boxplot(alpha=0.25)+
    geom_line(aes(group = MouseID,color=Genotype),size=0.65)+
    scale_fill_viridis_d()+
    geom_point(size=1,position=position_jitter(width=0.25),alpha=0.1)+
    theme_cowplot(16) +
    ggtitle("OLM Analysis - Training v Testing") +
    scale_color_manual(values = c(WT = "#2b8cbe", HET = "#7BCB5B", MUT = "#FB4A4A")) +
    theme(legend.position = "top")
}

a4 <- generate_longitudinal_boxplots(data_box_plot, Day, Percent_Time_Investigated,0,100)

generate_boxplots <- function(input_data, X, Y, min,max){
  data<-as.data.frame(input_data)
  #Ensure correct ordering of levels 
  data$Genotype <- factor(data$Genotype, levels = c("WT", "HET", "MUT"))
  data$Day <- factor(data$Day, levels = c("1", "2", "3"))
  
  ggplot(data=data,aes(x={{X}},y={{Y}}, fill={{X}})) + 
    #geom_violin(alpha=0.25,position=position_dodge(width=.75),size=1,color="black",draw_quantiles=c(0.5))+
    geom_boxplot(alpha=0.25)+ 
    geom_quasirandom(alpha=0.1)+
    scale_fill_viridis_d()+
    geom_point(size=1,position=position_jitter(width=0.25),alpha=0.1)+
    theme_cowplot(16) +
    #ylim(min,max)+
    ggtitle("OLM Testing Day - Genotypes")  +
    theme(legend.position = "none")
  
  
}

b4<-generate_boxplots(fulltesting, Genotype, Percent_Time_Investigated,10,80)+stat_signif(comparisons = list(c("WT", "HET"), c("WT","MUT")),map_signif_level = TRUE, textsize = 6, test="wilcox.test")

#aggregate
plot_grid(a4,b4)
---------------------------------------
#GASTROINTESTINAL MOTILITY




