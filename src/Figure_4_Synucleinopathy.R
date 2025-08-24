library(here)
library(ggplot2)
library(dplyr)
library(nlme)
library(cowplot)
library(tidyr)

## Environment --
here::i_am("src/Figure_4_Synucleinopathy.R")

generate_violinplots <- function(input_data, X, Y, min,max){
  data<-as.data.frame(input_data)
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

## PFF Synucleinopathy-- 
data <- readr::read_csv(here("data/PFF/PFF Brain Staining and Imaging Record - Analysis_Rb_pS129.csv"))
data$Genotype<-factor(data$Genotype,levels=c("WT","HET","MUT"))
names(data)
striatum <- data %>% filter(Exclude=="NO" & Optimal_Threshold=="YES" & Particle_Size=="3.5-10")
summary(striatum$Count)

ipsilateral <- striatum %>% filter(Category=="Ipsilateral")
contralateral <- striatum %>% filter(Category=="Contralateral")

# Plot results as an average of each mouse - Corrected Mean 
df <- striatum %>%
  group_by(MouseID, Category) %>%
  summarise(Average_Count = mean(Count)) %>%
  ungroup()

subset <- unique(striatum %>% select("MouseID","Genotype","Sex"))
df_meta <- merge(df, subset, by= "MouseID")
df_meta_cont <- df_meta %>% filter(Category=="Contralateral")
df_meta_ipsi <- df_meta %>% filter(Category=="Ipsilateral")

# write.csv(df_meta_cont, here("data/PFF/Fig_4D.csv"))
# write.csv(df_meta_ipsi, here("data/PFF/Fig_4C.csv"))

contra_average <- generate_violinplots(df_meta_cont, Genotype, Average_Count,0,250)+
  #ggtitle("PFF Contralateral")+
  ylab("Puncta Count")+
  xlab("")+
  facet_wrap(~Category)+
  theme(plot.title = element_text(hjust = 0.5))
ipsi_average <- generate_violinplots(df_meta_ipsi, Genotype, Average_Count,0,1600)+
  #ggtitle("PFF Ipsilateral")+
  ylab("Puncta Count")+
  xlab("")+
  facet_wrap(~Category)+
  theme(plot.title = element_text(hjust = 0.5))

top <- plot_grid( NULL, NULL, NULL,
           NULL, NULL,NULL,
           ipsi_average,contra_average,
          labels=c("A","","",
                   "B","",""),
          ncol=3, nrow=2)

bottom <- plot_grid(ipsi_average,contra_average,
                  labels=c("C","D"))
plot_grid(top,bottom, nrow=2, rel_heights = c(3,1))

## Statistics -- 
wt_mut <- df_meta %>% filter(Genotype!="HET" & Category=="Ipsilateral") 
lm <- lm(Average_Count~  Sex + Genotype, data = wt_mut)
summary(lm)

wt_mut<- df_meta %>% filter(Genotype!="HET" & Category=="Contralateral") 
lm <- lm(Average_Count~  Sex + Genotype, data = wt_mut)
summary(lm)


