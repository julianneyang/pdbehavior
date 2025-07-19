library(here)
library(ggplot2)
library(dplyr)
library(nlme)
library(cowplot)
library(tidyr)

## Environment --
here::i_am("src/Figure_4_GFAP.R")

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
## ASO GFAP Cell Count-- 
data <- readr::read_csv(here("data/ASO/Analysis_GFAP.csv"))
data$Genotype<-factor(data$Genotype,levels=c("WT","HET","MUT", "Tg_Neg"))
data <- data %>% filter(Genotype!="Tg_Neg")
names(data)
striatum <- data %>% filter(Particle_Size=="3.5-10") %>%
  drop_na(Count)
summary(striatum$Count)
# Plot results as an average of each mouse 
df <- striatum %>%
  group_by(MouseID) %>%
  summarise(Average_Count = mean(Count)) %>%
  ungroup()

subset <- unique(striatum %>% select("MouseID","Genotype"))
df_meta <- merge(df, subset, by= "MouseID")

generate_violinplots(df_meta, Genotype, Average_Count,0,400)+
  ggtitle("ASO GFAP")+
  ylab("GFAP + Cell Count")+
  xlab("")+
 # facet_wrap(~Category)+
  theme(plot.title = element_text(hjust = 0.5))

wt_mut <- df_meta %>% filter(Genotype!="HET") %>% 
  filter(Genotype!="Tg_Neg")
wilcox.test(Average_Count~Genotype,wt_mut)


wt_mut <- df_meta %>% filter(Genotype!="MUT") %>% 
  filter(Genotype!="Tg_Neg")
wilcox.test(Average_Count~Genotype,wt_mut)

## PFF GFAP Cell Count-- 
data <- readr::read_csv(here("Analysis_Files/PFF/PFF_GFAP.csv"))
data$Genotype<-factor(data$Genotype,levels=c("WT","HET","MUT"))
names(data)
striatum <- data %>% filter(EXCLUDE=="NO" & Particle_Size=="0-Inf")
summary(striatum$Count)

ipsilateral <- striatum %>% filter(Category!="Contralateral")
contralateral <- striatum %>% filter(Category=="Contralateral")

ipsi_puncta <- generate_violinplots(ipsilateral, Genotype, Count,0,384)+
  #ggtitle("PFF Puncta Analysis")+
  ylab("GFAP + Cell Count")+
  xlab("")+
  #facet_wrap(~Category)+
  theme(plot.title = element_text(hjust = 0.5))
ipsi_puncta
contra_puncta <- generate_violinplots(contralateral, Genotype, Count,0,250)+
  #ggtitle("PFF Puncta Analysis")+
  ylab("pS129 a-Syn Puncta Count")+
  xlab("")+
  facet_wrap(~Category)+
  theme(plot.title = element_text(hjust = 0.5))

plot_grid(ipsi_puncta, contra_puncta)

# Plot results as an average of each mouse 
df <- striatum %>%
  group_by(MouseID, Category) %>%
  summarise(Average_Count = mean(Count)) %>%
  ungroup()

subset <- unique(striatum %>% select("MouseID","Genotype","Sex"))
df_meta <- merge(df, subset, by= "MouseID")
df_meta_cont <- df_meta %>% filter(Category=="Contralateral")
df_meta_ipsi <- df_meta %>% filter(Category!="Contralateral")

contra_average <- generate_violinplots(df_meta_cont, Genotype, Average_Count,0,250)+
  #ggtitle("PFF Contralateral")+
  ylab("GFAP + Cell Count")+
  xlab("")+
  facet_wrap(~Category)+
  theme(plot.title = element_text(hjust = 0.5))
ipsi_average <- generate_violinplots(df_meta_ipsi, Genotype, Average_Count,0,384)+
  #ggtitle("PFF Ipsilateral")+
  ylab("GFAP + Cell Count")+
  xlab("")+
  facet_wrap(~Category)+
  theme(plot.title = element_text(hjust = 0.5))

plot_grid(ipsi_average,contra_average,labels=c("A","B"))

plot_grid( NULL, NULL, NULL,
           NULL, NULL,NULL,
           ipsi_average,contra_average,
           labels=c("A","","",
                    "B","","",
                    "C","D"),
           ncol=3, nrow=3)

## Statistics -- 
names(striatum)
ipsilateral <- striatum %>% filter(Category=="Ipsilateral")
contralateral <- striatum %>% filter(Category=="Contralateral")

lme_model <- lme(Count ~  Genotype, 
                 random = ~ 1 | MouseID, 
                 data = ipsilateral)
summary(lme_model)

lme_model <- lme(Count ~  Genotype, 
                 random = ~ 1 | MouseID, 
                 data = contralateral)
summary(lme_model)


wt_mut <- df_meta %>% filter(Genotype!="HET" & Category=="Ipsilateral") 
wilcox.test(Average_Count~Genotype, data=wt_mut)
t.test(Average_Count~Genotype, data=wt_mut)
lm <- lm(Average_Count~  Sex + Genotype, data = wt_mut)
summary(lm)

wt_mut<- df_meta %>% filter(Genotype!="HET" & Category=="Contralateral") 
wilcox.test(Average_Count~Genotype, data=wt_mut)
t.test(Average_Count~Genotype, data=wt_mut)
lm <- lm(Average_Count~  Sex + Genotype, data = wt_mut)
summary(lm)


