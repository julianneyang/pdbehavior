library(here)
library(ggplot2)
library(dplyr)
library(nlme)
library(cowplot)
library(tidyr)

## Environment --
here::i_am("src/Figure_3_TH_staining.R")

generate_violinplots <- function(input_data, X, Y, min,max){
  data<-as.data.frame(input_data)
    ggplot(data=data,aes(x={{X}},y={{Y}}, fill={{X}})) + 
    geom_boxplot(alpha=0.25,position=position_dodge(width=.75),size=1,color="black")+
    #geom_boxplot(alpha=0.25)+ 
    #geom_quasirandom(alpha=0.1)+
    scale_fill_viridis_d()+
    geom_point(size=1,position=position_jitter(width=0.25),alpha=0.3)+
    theme_cowplot(16) +
    ylim(min,max)+
    theme(legend.position = "none") 
  
  
}

## ASO TH-- 
data <- readr::read_csv(here("data", "ASO","ASO_TH_CTCF.csv"))
data$Genotype<-factor(data$Genotype,levels=c("WT","HET","MUT"))

striatum <- data %>% filter(Category=="Striatum_1" | Category=="Striatum_2")

aso_th_corrected_mean <- generate_violinplots(striatum, Genotype, Corrected_Mean,0,200)+
  ggtitle("ASO TH Quantification")+
  ylab("Mean")+
  xlab("")+
  theme(plot.title = element_text(hjust = 0.5))


# Plot results as an average of each mouse - Corrected Mean 
df <- striatum %>%
  group_by(MouseID) %>%
  summarise(Average_Mean = mean(Corrected_Mean)) %>%
  ungroup()

subset <- unique(striatum %>% select("MouseID","Genotype","Sex"))

df_meta <- merge(df, subset, by= "MouseID")

write.csv(df_meta, here("data/ASO/Fig_3D.csv"))

aso_th_average_corrected_mean_per_mouse <- generate_violinplots(df_meta, Genotype, Average_Mean,0,150)+
  ggtitle("ASO")+
  ylab("Corrected Mean")+
  xlab("")+
  theme(plot.title = element_text(hjust = 0.5))


## PFF TH-- 
data <- readr::read_csv(here("data","PFF","PFF_TH_CTCF.csv"))
data$Genotype<-factor(data$Genotype,levels=c("WT","HET","MUT"))
data$Category <- factor(data$Category)
data$Category

striatum <- data %>% filter(Category=="Contralateral" | Category=="Ipsilateral")
striatum <- striatum %>% filter(Exclude=="No")

# Plot results as an average of each mouse - Corrected Mean 
df <- striatum %>%
  group_by(MouseID, Category) %>%
  summarise(Average_Mean = mean(Corrected_Mean)) %>%
  ungroup()

subset <- unique(striatum %>% select("MouseID","Genotype","Sex"))
df_meta <- merge(df, subset, by= "MouseID")

ipsi_df_meta <- df_meta %>% filter(Category=="Ipsilateral")
contra_df_meta <- df_meta %>% filter(Category=="Contralateral")

# write.csv(ipsi_df_meta,here("data/PFF/Fig_3E.csv"))
# write.csv(contra_df_meta,here("data/PFF/Fig_3F.csv"))
ipsi_pff_th_average_mean_per_mouse <- generate_violinplots(ipsi_df_meta, Genotype, Average_Mean,0,150)+
  ggtitle("PFF Ipsilateral")+
  ylab("Corrected Mean")+
  xlab("")+
  theme(plot.title = element_text(hjust = 0.5))

contra_pff_th_average_mean_per_mouse <- generate_violinplots(contra_df_meta, Genotype, Average_Mean,0,150)+
  ggtitle("PFF Contralateral")+
  ylab("Corrected Mean")+
  xlab("")+
  theme(plot.title = element_text(hjust = 0.5))


## Statistics -- 

# Fig 3D 
df_meta_wt_mut <- df_meta %>% filter(Genotype!="HET")
lm <- lm(Average_Mean ~ Sex + Genotype, data = df_meta_wt_mut)
summary(lm)

df_meta_wt_het <- df_meta %>% filter(Genotype!="MUT")
lm <- lm(Average_Mean ~ Sex + Genotype, data = df_meta_wt_mut)
summary(lm)

# Fig 3E
wt_het <- df_meta %>% filter(Genotype!="MUT" & Category=="Ipsilateral") 
lm <- lm(Average_Mean ~ Sex + Genotype, data = wt_het)
summary(lm)

wt_mut <- df_meta %>% filter(Genotype!="HET" & Category=="Ipsilateral") 
lm <- lm(Average_Mean ~ Sex + Genotype, data = wt_mut)
summary(lm)

# Fig 3F
wt_het <- df_meta %>% filter(Genotype!="MUT" & Category=="Contralateral") 
lm <- lm(Average_Mean ~ Sex + Genotype, data = wt_het)
summary(lm)

wt_mut <- df_meta %>% filter(Genotype!="HET" & Category=="Contralateral") 
lm <- lm(Average_Mean ~ Sex + Genotype, data = wt_mut)
summary(lm)

## Final Figure --

plot_grid(NULL,NULL,NULL,NULL,NULL,NULL, nrow=2, labels=c("A","","",
                           "B","",""))

plot_grid(
          aso_th_average_corrected_mean_per_mouse,
          ipsi_pff_th_average_mean_per_mouse,
          contra_pff_th_average_mean_per_mouse,
          nrow=1, labels=c("D","E","F"))
