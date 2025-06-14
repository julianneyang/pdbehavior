library(here)
library(ggplot2)
library(dplyr)
library(nlme)
library(cowplot)
library(tidyr)

## Environment --
here::i_am("Rscripts/Figure_2_TH_staining.R")

generate_violinplots <- function(input_data, X, Y, min,max){
  data<-as.data.frame(input_data)
    ggplot(data=data,aes(x={{X}},y={{Y}}, fill={{X}})) + 
    geom_violin(alpha=0.25,position=position_dodge(width=.75),size=1,color="black",draw_quantiles=c(0.5))+
    #geom_boxplot(alpha=0.25)+ 
    #geom_quasirandom(alpha=0.1)+
    scale_fill_viridis_d()+
    geom_point(size=1,position=position_jitter(width=0.25),alpha=0.3)+
    theme_cowplot(16) +
    ylim(min,max)+
    theme(legend.position = "none") 
  
  
}

## ASO TH-- 
data <- readr::read_csv(here("Analysis_Files", "ASO","ASO_TH_CTCF.csv"))
data$Genotype<-factor(data$Genotype,levels=c("WT","HET","MUT"))

striatum <- data %>% filter(Category=="Striatum_1" | Category=="Striatum_2")
summary(striatum$CTCF)

aso_th_by_sex <- generate_violinplots(striatum, Genotype, CTCF,0,312000000)+
  ggtitle("ASO TH Quantification")+
  ylab("Corrected Integrated Density")+
  xlab("")+
  facet_wrap(~Sex)+
  theme(plot.title = element_text(hjust = 0.5))

aso_th_intden <- generate_violinplots(striatum, Genotype, CTCF,0,312000000)+
  ggtitle("ASO TH Quantification")+
  ylab("Corrected Integrated Density")+
  xlab("")+
  theme(plot.title = element_text(hjust = 0.5))

plot_grid(aso_th_intden,aso_th_by_sex)

# by Corrected Mean
aso_th_by_sex <- generate_violinplots(striatum, Genotype, Corrected_Mean,0,200)+
  ggtitle("ASO TH Quantification")+
  ylab("Mean")+
  xlab("")+
  facet_wrap(~Sex)+
  theme(plot.title = element_text(hjust = 0.5))

aso_th_corrected_mean <- generate_violinplots(striatum, Genotype, Corrected_Mean,0,200)+
  ggtitle("ASO TH Quantification")+
  ylab("Mean")+
  xlab("")+
  theme(plot.title = element_text(hjust = 0.5))

plot_grid(aso_th_corrected_mean,aso_th_by_sex)

# Plot results as an average of each mouse - Corrected Mean 
df <- striatum %>%
  group_by(MouseID) %>%
  summarise(Average_Mean = mean(Corrected_Mean)) %>%
  ungroup()

subset <- unique(striatum %>% select("MouseID","Genotype","Sex"))
df_meta <- merge(df, subset, by= "MouseID")
aso_th_average_corrected_mean_per_mouse <- generate_violinplots(df_meta, Genotype, Average_Mean,0,150)+
  ggtitle("ASO")+
  ylab("Corrected Mean")+
  xlab("")+
  theme(plot.title = element_text(hjust = 0.5))

# Plot results as an average of each mouse - Corrected Mean 
df <- striatum %>%
  group_by(MouseID) %>%
  summarise(Average_IntDen = mean(CTCF)) %>%
  ungroup()

subset <- unique(striatum %>% select("MouseID","Genotype","Sex"))
df_meta <- merge(df, subset, by= "MouseID")
aso_th_average_corrected_mean_per_mouse <- generate_violinplots(df_meta, Genotype, Average_IntDen,0,312000000)+
  ggtitle("ASO TH")+
  ylab("Average Corrected IntDen per Mouse)")+
  xlab("")+
  theme(plot.title = element_text(hjust = 0.5))

## Statistics -- 
names(striatum)
lme_model <- lme(CTCF ~ Genotype, 
                 random = ~ 1 | MouseID, 
                 data = striatum)
summary(lme_model)

striatum_wt_mut <- striatum %>% filter(Genotype!="HET")
wilcox.test(CTCF~Genotype, data=striatum_wt_mut)

lme_model <- lme(Corrected_Mean ~ Sex + Genotype, 
                 random = ~ 1 | MouseID, 
                 data = striatum)
summary(lme_model)

striatum_wt_mut <- striatum %>% filter(Genotype!="HET")
wilcox.test(Corrected_Mean~Genotype, data=striatum_wt_mut)

df_meta_wt_mut <- df_meta %>% filter(Genotype!="HET")
wilcox.test(Average_Mean~Genotype, data=df_meta_wt_mut)
t.test(Average_Mean~Genotype, data=df_meta_wt_mut)
lm <- lm(Average_Mean ~ Sex + Genotype, data = df_meta_wt_mut)
summary(lm)

df_meta_wt_mut <- df_meta %>% filter(Genotype!="HET")
wilcox.test(Average_IntDen~Genotype, data=df_meta_wt_mut)
t.test(Average_IntDen~Genotype, data=df_meta_wt_mut)

## Final Figure --
plot_grid(aso_th_intden, aso_th_mean,
          labels=c("A","B"))

## PFF TH-- 
data <- readr::read_csv(here("Analysis_Files","PFF","PFF_TH_CTCF.csv"))
data$Genotype<-factor(data$Genotype,levels=c("WT","HET","MUT"))
data$Category <- factor(data$Category)
data$Category

striatum <- data %>% filter(Category=="Contralateral" | Category=="Ipsilateral")
striatum <- striatum %>% filter(Exclude=="No")
summary(striatum$CTCF)

pff_th_by_category_intden <- generate_violinplots(striatum, Genotype, CTCF,0,200000000)+
  ggtitle("PFF TH Quantification")+
  ylab("Corrected Integrated Density")+
  xlab("")+
  facet_wrap(~Category)+
  theme(plot.title = element_text(hjust = 0.5))

summary(striatum$Corrected_Mean)
pff_th_by_category_mean <- generate_violinplots(striatum, Genotype, Corrected_Mean,0,150)+
  ggtitle("PFF TH Quantification")+
  ylab("Corrected Mean")+
  xlab("")+
  facet_wrap(~Category)+
  theme(plot.title = element_text(hjust = 0.5))

#ggplot(striatum, aes(Genotype,Corrected_Mean,label=Merged_ID)) +
  #geom_point()+
  #geom_label(position=position_jitter(width=0.25))+
  #facet_wrap(~Category)

df <- striatum %>%
  group_by(Merged_ID) %>%
  mutate(Ratio_Means = Corrected_Mean[Category == "Ipsilateral"] / Corrected_Mean[Category == "Contralateral"]) %>%
  ungroup()

pff_th_by_category_corrected_mean <- generate_violinplots(df, Genotype, Ratio_Means,0,2)+
  ggtitle("PFF Corrected Means Ratio")+
  ylab("Ratio(Mean_Ipsi/Mean_Contra)")+
  xlab("")+
  theme(plot.title = element_text(hjust = 0.5))
pff_th_by_category_corrected_mean

df <- striatum %>%
  group_by(Merged_ID) %>%
  mutate(Ratio_Means = Mean[Category == "Ipsilateral"] / Mean[Category == "Contralateral"]) %>%
  ungroup()

pff_th_by_category_mean <- generate_violinplots(df, Genotype, Ratio_Means,0.3,1.2)+
  ggtitle("PFF Means Ratio")+
  ylab("Ratio(Mean_Ipsi/Mean_Contra)")+
  xlab("")+
  theme(plot.title = element_text(hjust = 0.5))
pff_th_by_category_mean

df <- striatum %>%
  group_by(Merged_ID) %>%
  mutate(Ratio_Means = IntDen[Category == "Ipsilateral"] / IntDen[Category == "Contralateral"]) %>%
  ungroup()

pff_th_by_category_corrected_intden <- generate_violinplots(df, Genotype, Ratio_Means,0,2)+
  ggtitle("PFF IntDen Ratio")+
  ylab("Ratio(IntDen_Ipsi/IntDen_Contra)")+
  xlab("")+
  theme(plot.title = element_text(hjust = 0.5))
pff_th_by_category_corrected_intden

# Plot results as an average of each mouse - Corrected Mean 
df <- striatum %>%
  group_by(MouseID, Category) %>%
  summarise(Average_Mean = mean(Corrected_Mean)) %>%
  ungroup()

subset <- unique(striatum %>% select("MouseID","Genotype","Sex"))
df_meta <- merge(df, subset, by= "MouseID")

ipsi_df_meta <- df_meta %>% filter(Category=="Ipsilateral")
contra_df_meta <- df_meta %>% filter(Category=="Contralateral")

ipsi_pff_th_average_mean_per_mouse <- generate_violinplots(ipsi_df_meta, Genotype, Average_Mean,0,150)+
  ggtitle("PFF")+
  ylab("Corrected Mean")+
  xlab("")+
  theme(plot.title = element_text(hjust = 0.5))+
  facet_wrap(~Category)

contra_pff_th_average_mean_per_mouse <- generate_violinplots(contra_df_meta, Genotype, Average_Mean,0,150)+
  ggtitle("PFF")+
  ylab("Corrected Mean")+
  xlab("")+
  theme(plot.title = element_text(hjust = 0.5))+
  facet_wrap(~Category)


# Plot results as an average of each mouse - Corrected IntDen 
df <- striatum %>%
  group_by(MouseID, Category) %>%
  summarise(Average_IntDen = mean(CTCF)) %>%
  ungroup()

subset <- unique(striatum %>% select("MouseID","Genotype","Sex"))
df_meta <- merge(df, subset, by= "MouseID")
pff_th_average_corrected_intden_per_mouse <- generate_violinplots(df_meta, Genotype, Average_IntDen,0,200000000)+
  ggtitle("PFF Contralateral")+
  ylab("Average Corrected IntDen per Mouse")+
  xlab("")+
  theme(plot.title = element_text(hjust = 0.5))+
  facet_wrap(~Category)

pff_th_average_corrected_intden_per_mouse

## Statistics -- 
names(striatum)
ipsilateral <- striatum %>% filter(Category=="Ipsilateral")
contralateral <- striatum %>% filter(Category=="Contralateral")

lme_model <- lme(Corrected_Mean ~  Genotype, 
                 random = ~ 1 | MouseID, 
                 data = ipsilateral)
summary(lme_model)

lme_model <- lme(Corrected_Mean ~  Genotype, 
                 random = ~ 1 | MouseID, 
                 data = contralateral)
summary(lme_model)

lme_model <- lme(CTCF ~  Genotype, 
                 random = ~ 1 | MouseID, 
                 data = contralateral)
summary(lme_model)


lme_model <- lme(CTCF ~  Genotype, 
                 random = ~ 1 | MouseID, 
                 data = ipsilateral)
summary(lme_model)

wt_het <- df_meta %>% filter(Genotype!="MUT" & Category=="Ipsilateral") 
wilcox.test(Average_Mean~Genotype, data=wt_het)
t.test(Average_Mean~Genotype, data=wt_het)
lm <- lm(Average_Mean ~ Sex + Genotype, data = wt_het)
summary(lm)

wt_het <- df_meta %>% filter(Genotype!="MUT" & Category=="Contralateral") 
wilcox.test(Average_Mean~Genotype, data=wt_het)
t.test(Average_Mean~Genotype, data=wt_het)
lm <- lm(Average_Mean ~ Sex + Genotype, data = wt_het)
summary(lm)

wt_mut <- df_meta %>% filter(Genotype!="HET" & Category=="Ipsilateral") 
wilcox.test(Average_Mean~Genotype, data=wt_mut)
t.test(Average_Mean~Genotype, data=wt_mut)
lm <- lm(Average_Mean ~ Sex + Genotype, data = wt_mut)
summary(lm)

wt_mut <- df_meta %>% filter(Genotype!="HET" & Category=="Contralateral") 
wilcox.test(Average_Mean~Genotype, data=wt_mut)
t.test(Average_Mean~Genotype, data=wt_mut)
lm <- lm(Average_Mean ~ Sex + Genotype, data = wt_mut)
summary(lm)

## Final Figure --

plot_grid(NULL,NULL,NULL,NULL,NULL,NULL, nrow=2, labels=c("A","","",
                           "B","",""))

plot_grid(NULL,NULL,NULL,
          aso_th_average_corrected_mean_per_mouse,
          ipsi_pff_th_average_mean_per_mouse,
          contra_pff_th_average_mean_per_mouse,
          nrow=2, labels=c("C","","",
                           "D","E","F"))
