
library(ggplot2)
library(rlang)
library(cowplot)
library(ggpubr)
library(viridis)
library(tidyr)
library(dplyr)
library(tidyverse)

setwd("~/Documents/slcspontaneous/Analysis_Files/")
data<-read.csv("SLC_Spontaneous_Open_Field_Analysis.csv", header=TRUE)


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
a<-generate_boxplots(data, Genotype, Center_Time,0,550)+
                    stat_compare_means(comparisons = list(c("WT", "HET"), 
                    c("WT","MUT")),method="wilcox", vjust=0.3,label="p.signif",step.increase=0.05)
a

#Distance vs Genotype
b<-generate_boxplots(data, Genotype, Distance,0,26)+
  stat_compare_means(comparisons = list(c("WT", "HET"), 
                                        c("WT","MUT")),method="wilcox", vjust=0.3,label="p.signif",step.increase=0.05)
b

#Center Entries vs Genotype
c<-generate_boxplots(data, Genotype, Center.Entries,0,125)+
  stat_compare_means(comparisons = list(c("WT", "HET"), 
                                        c("WT","MUT")),method="wilcox", vjust=0.3,label="p.signif",step.increase=0.05)

c

##aggregate Plots




## Stratify by Sex


d<-generate_boxplots(data, Genotype, Center_Time,0,550)+
  stat_compare_means(comparisons = list(c("WT", "HET"), 
                                        c("WT","MUT")),method="wilcox", vjust=0.3,label="p.signif",step.increase=0.05)+
                                        facet_grid(~Sex)
d

e<-generate_boxplots(data, Genotype, Distance,0,26)+
  stat_compare_means(comparisons = list(c("WT", "HET"), 
                                        c("WT","MUT")),method="wilcox", vjust=0.3,label="p.signif",step.increase=0.05)+
                                     facet_grid(~Sex)
e

f<-generate_boxplots(data, Genotype, Center.Entries,0,125)+
  stat_compare_means(comparisons = list(c("WT", "HET"), 
                                        c("WT","MUT")),method="wilcox", vjust=0.3,label="p.signif",step.increase=0.05)+
  facet_grid(~Sex)
f


plot_grid(a,b,c,d,e,f)

#Center_Time
# Add parametric and non-parametric stats to README.md
# WT vs MUT
data<-read.csv("SLC_Spontaneous_Open_Field_Analysis.csv", header=TRUE)
data <- data %>% filter(Genotype!="HET")
t.test(Center_Time~Genotype,data)
wilcox.test(Center_Time~Genotype,data)

data<-read.csv("SLC_Spontaneous_Open_Field_Analysis.csv", header=TRUE)

# WT vs HET
data <- data %>% filter(Genotype!="MUT")
t.test(Center_Time~Genotype,data)
wilcox.test(Center_Time~Genotype,data)

#Distance
# Add parametric and non-parametric stats to README.md
# WT vs MUT
data<-read.csv("SLC_Spontaneous_Open_Field_Analysis.csv", header=TRUE)
data <- data %>% filter(Genotype!="HET")
t.test(Distance~Genotype,data)
wilcox.test(Distance~Genotype,data)

data<-read.csv("SLC_Spontaneous_Open_Field_Analysis.csv", header=TRUE)

# WT vs HET
data <- data %>% filter(Genotype!="MUT")
t.test(Distance~Genotype,data)
wilcox.test(Distance~Genotype,data)

#Center.Entries
# WT vs MUT
data<-read.csv("SLC_Spontaneous_Open_Field_Analysis.csv", header=TRUE)
data <- data %>% filter(Genotype!="HET")
t.test(Center.Entries~Genotype,data)
wilcox.test(Center.Entries~Genotype,data)

data<-read.csv("SLC_Spontaneous_Open_Field_Analysis.csv", header=TRUE)

# WT vs HET
data <- data %>% filter(Genotype!="MUT")
t.test(Center.Entries~Genotype,data)
wilcox.test(Center.Entries~Genotype,data)

