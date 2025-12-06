library(here)
library(ggplot2)
library(dplyr)
library(nlme)
library(cowplot)
library(tidyr)

## Environment --
here::i_am("src/Figure_S5_GFAP.R")

generate_violinplots <- function(input_data, X, Y, min,max){
  data<-as.data.frame(input_data)
  ggplot(data=data,aes(x={{X}},y={{Y}}, fill={{X}})) + 
    #geom_violin(alpha=0.25,position=position_dodge(width=.75),size=1,color="black",draw_quantiles=c(0.5))+
    geom_boxplot(alpha=0.25)+ 
    #geom_quasirandom(alpha=0.1)+
    scale_fill_viridis_d()+
    geom_point(size=1,position=position_jitter(width=0.25),alpha=0.3)+
    theme_cowplot(12) +
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

subset <- unique(striatum %>% select("MouseID","Genotype", "Sex"))
df_meta <- merge(df, subset, by= "MouseID")

sex <- read.csv(here("data/ASO/Fig_S5B.csv")) %>%
  unique()

df_meta <- df_meta %>% 
  select(!c("Sex")) %>%
  inner_join(sex %>% dplyr::select("MouseID","Sex"), by="MouseID") %>%
  unique()

b <-generate_violinplots(df_meta, Genotype, Average_Count,0,400)+
  ggtitle("ASO GFAP")+
  ylab("GFAP + Cell Count")+
  xlab("")+
  #facet_wrap(~Sex)+
  theme(plot.title = element_text(hjust = 0.5))


lm <- lm(Average_Count~  Sex + Genotype, data = df_meta)
summary(lm)

### Read in significantly associated taxa 
corr_list <- read_rds(here("results/ASO/figures/lumcol_DAT_correlations_with_GFAP.rds"))
corr_list[[1]] <-  corr_list[[1]] + 
  theme(legend.justification = "center") + 
  xlab("Relative Abundance")
corr_list[[2]] <-  corr_list[[2]] + 
  theme(legend.justification = "center") + 
  xlab("Relative Abundance")

### Assemble figure 
plot_grid(b, NULL,corr_list[[1]], corr_list[[2]])

