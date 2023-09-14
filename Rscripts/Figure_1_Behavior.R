## ASO dimensionality reduction 

library(cowplot)

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

## ASO Rotarod --
data <- readr::read_csv(here("Analysis_Files", "ASO","ASO Rotarod - Rotarod.csv"))
data$SLC_Genotype <- factor(data$SLC_Genotype, levels=c("WT", "HET", "MUT"))
data$Day <- factor(data$Day, levels=c("One", "Two", "Three"))

aso_data_positive <- data %>% filter(ASO_Tg=="Positive")
aso_data_positive_plot_by_Day <- generate_boxplots(aso_data_positive, SLC_Genotype, Average_Latency,0,250) +
  ggtitle("ASO Rotarod")+
  ylab("")+
  xlab("")+
  facet_wrap(~Day)+
  theme(plot.title = element_text(hjust = 0.5))

## PFF Rotarod --
data <- readr::read_csv(here("Analysis_Files/PFF/PFF Rotarod - PFF_Rotarod_Analysis.csv"))
data$SLC_Genotype <- factor(data$SLC_Genotype, levels=c("WT", "HET", "MUT"))
data$Day <- plyr::revalue(data$Day, c("one"="One","two"="Two","three"="Three")) 

?plyr::revalue()
pff_data_positive_plot_by_Day <- generate_boxplots(data, SLC_Genotype, Average_Latency,0,250) +
  ggtitle("PFF Rotarod")+
  ylab("")+
  xlab("")+
  facet_wrap(~Day)+
  theme(plot.title = element_text(hjust = 0.5))

## Final Figure --
plot_grid(aso_data_positive_plot_by_Day,
          pff_data_positive_plot_by_Day,
          nrow=2,
          labels=c("A","B"))
