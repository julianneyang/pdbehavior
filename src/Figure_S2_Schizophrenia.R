library(ggplot2)
library(here)
library(tidyr)

here::i_am("src/Figure_S1_Schizophrenia.R")

data<-read.csv("data/Q22/Startle_PPI_Analysis - Analysis.csv", header=TRUE)
data$SLC_Genotype<-data$SLC
data$SLC_Genotype <- factor(data$SLC_Genotype, levels=c("WT", "HET", "MUT"))
data$Q22 <- factor(data$Q22, levels=c("WT","KO"))
data_long <- tidyr::pivot_longer(data, 
                          cols = ends_with("VMax"), 
                          names_to = "Stage", 
                          values_to = "Startle_Response")
data_long$Stage <- factor(data_long$Stage,levels=c("First_average_VMax","middle_average_VMax", "last_average_VMax"))

generate_boxplots <- function(input_data, X, Y, min,max){
  data<-as.data.frame(input_data)
  
  ggplot(data=data,aes(x={{X}},y={{Y}}, fill={{X}})) + 
    #geom_violin(alpha=0.25,position=position_dodge(width=.75),size=1,color="black",draw_quantiles=c(0.5))+
    geom_boxplot(alpha=0.25)+
    scale_fill_viridis_d()+
    geom_point(size=1,position=position_jitter(width=0.25),alpha=0.5)+
    theme_cowplot(12) +
    ylim(min,max)+ 
    #facet_grid(~Sex)+    
    theme(legend.position = "none") +
    labs(x=NULL)
  
}

summary(data$X70db_Percent_Inhibition)
db70 <-generate_boxplots(data, SLC_Genotype, X70db_Percent_Inhibition,-40,85) +
  ggtitle("70 db")+
  theme(plot.title = element_text(hjust = 0.5)) + 
  facet_wrap(~Q22) +
  labs(y="% Prepulse Inhibition")
#+ stat_compare_means(comparisons=list(c("WT","HET"),
#                                     c("HET","MUT"),
#                                     c("WT", "MUT")))

db70
saveRDS(db70, "results/Q22/db70_PPI.RDS")

db75 <-generate_boxplots(data, SLC_Genotype, X75db_Percent_Inhibition,-40,85) +
  ggtitle("75 db")+
  theme(plot.title = element_text(hjust = 0.5))+
  facet_wrap(~Q22)+
  labs(y="% Prepulse Inhibition")
db75
readr::write_rds(db75, "results/Q22/db75_PPI.RDS")

db80 <-generate_boxplots(data, SLC_Genotype, X75db_Percent_Inhibition,-40,85) +
  ggtitle("80 db")+
  theme(plot.title = element_text(hjust = 0.5)) + 
  facet_wrap(~Q22)+
  labs(y="% Prepulse Inhibition")
  # stat_compare_means(comparisons=list(c("WT","HET"),
  #                                     c("HET","MUT"),
  #                                     c("WT", "MUT")))
db80
readr::write_rds(db80, "results/Q22/db80_PPI.RDS")

summary(data$First_average_VMax)
first_startle <-generate_boxplots(data, SLC_Genotype, First_average_VMax, 0,1200) +
  ggtitle("First Startle")+
  theme(plot.title = element_text(hjust = 0.5))+
  facet_wrap(~Q22)+
  labs(y="Average VMax")
# stat_compare_means(comparisons=list(c("WT","HET"),
#                                     c("HET","MUT"),
#                                     c("WT", "MUT")))
first_startle
readr::write_rds(first_startle, "results/Q22/first_startle.RDS")

summary(data$middle_average_VMax)
middle_startle <-generate_boxplots(data, SLC_Genotype, middle_average_VMax, 0,1200) +
  ggtitle("Middle Startle")+
  theme(plot.title = element_text(hjust = 0.5))+
  facet_wrap(~Q22)+
  stat_compare_means(comparisons=list(c("HET","MUT")),method="wilcox.test")+
  labs(y="Average VMax")

middle_startle
readr::write_rds(middle_startle, "results/Q22/middle_startle.RDS")


summary(data$last_average_VMax)
data$last_average_VMax <- as.numeric(data$last_average_VMax)
last_startle <-generate_boxplots(data, SLC_Genotype, last_average_VMax, 0,1200) +
  ggtitle("Last Startle")+
  theme(plot.title = element_text(hjust = 0.5))+
  facet_wrap(~Q22)+
  labs(y="Average VMax")
# stat_compare_means(comparisons=list(c("WT","HET"),
#                                     c("HET","MUT"),
#                                     c("WT", "MUT")))
last_startle
readr::write_rds(last_startle, "results/Q22/last_startle.RDS")

### Create multi-panel figure --
plot_grid(first_startle, middle_startle, last_startle,
          db70, db75, db80, labels=c("A","","","B","",""))
