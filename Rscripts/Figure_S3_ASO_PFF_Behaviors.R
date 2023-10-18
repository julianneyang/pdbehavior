library(ggplot2)
library(dplyr)
library(cowplot)
library(here)
library(tidyr)
library(ggbeeswarm)

## Environment --
here::i_am("Rscripts/Figure_S3_ASO_PFF_Behaviors.R")

## Functions --
generate_boxplots <- function(input_data, X, Y, min,max){
  data<-as.data.frame(input_data)
  #Ensure correct ordering of levels 
  #data$Genotype <- data$SLC_Genotype
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

## ASO Pole Test --
data<-readr::read_csv(here("Analysis_Files", "ASO", "ASO Pole Test - All_Cohorts_Assign_Maximum_Time.csv"))
data <- data %>%
  rowwise() %>%
  mutate(Average_Tturn = mean(c(Trial_1_Tturn, Trial_2_Tturn, Trial_3_Tturn, Trial_4_Tturn, Trial_5_Tturn), na.rm = TRUE)) %>%
  mutate(Fastest_Tturn = pmin(Trial_1_Tturn, Trial_2_Tturn, Trial_3_Tturn, Trial_4_Tturn, Trial_5_Tturn, na.rm = TRUE))

data <- data %>%
  rowwise() %>%
  mutate(Average_Ttotal = mean(c(Trial_1_Ttotal, Trial_2_Ttotal, Trial_3_Ttotal, Trial_4_Ttotal, Trial_5_Ttotal), na.rm = TRUE)) %>%
  mutate(Fastest_Ttotal = pmin(Trial_1_Ttotal, Trial_2_Ttotal, Trial_3_Ttotal, Trial_4_Ttotal, Trial_5_Ttotal, na.rm = TRUE))

data <- data %>%
  mutate(Best_Performance = case_when(
    any(Trial_1_Mode == "C" | Trial_2_Mode == "C" | Trial_3_Mode == "C" | Trial_4_Mode == "C" | Trial_5_Mode == "C") ~ "C",
    any(Trial_1_Mode == "S" | Trial_2_Mode == "S" | Trial_3_Mode == "S" | Trial_4_Mode == "S" | Trial_5_Mode == "S") ~ "S",
    TRUE ~ "S"
  ))
data$SLC_Genotype <- factor(data$SLC_Genotype, levels =c("WT","HET","MUT"))

pole_tg_pos <- data %>% filter(ASO_Tg=="Positive")
pos_slc_avg_turn <- generate_boxplots(pole_tg_pos, SLC_Genotype, Average_Tturn,0,20) +
  ylab("Average time to turn (s)")+
  xlab("")+
  labs(title= "ASO Pole Test - Tturn")+
  theme(plot.title = element_text(hjust = 0.5)) 

pos_slc_avg_total <- generate_boxplots(pole_tg_pos, SLC_Genotype, Average_Tturn,0,20) +
  ylab("Average time to descend (s)")+
  xlab("")+
  ggtitle("ASO Pole Test - Ttotal")+
  theme(plot.title = element_text(hjust = 0.5)) 

summary_table <- pole_tg_pos %>%
  group_by(Best_Performance, SLC_Genotype) %>%
  count()

category_counts <- summary_table %>%
  pivot_wider(names_from = Best_Performance, values_from = n, values_fill = 0)

result <- fisher.test(category_counts[, c("C", "S")])

## ASO Wire Hang --
data<-readr::read_csv(here("Analysis_Files", "ASO", "Final_ASO_Wire_Hang.csv"))
wirehang_tg_pos <- data %>% filter(ASO_Tg=="Positive")
wirehang <-generate_boxplots(wirehang_tg_pos, SLC_Genotype, Time,0,200)+
  ylab("Total Hang Time (s)")+
  xlab("")+
  ggtitle("ASO Wire Hang")+
  theme(plot.title = element_text(hjust = 0.5)) 

## ASO Hindlimb Clasp -- 
data<- readr::read_csv(here("Analysis_Files", "ASO", "ASO_Hindlimb_Clasping .csv"))
data$SLC_Genotype <- factor(data$SLC_Genotype, levels=c("WT", "HET", "MUT"))
clasp_tg_pos <- data %>% filter(ASO_Tg=="Positive")

clasp_score <-  ggplot(data=clasp_tg_pos,aes(x=SLC_Genotype,y=Score_Truncated, color=SLC_Genotype)) + 
  stat_summary(aes(x=SLC_Genotype, y=Score_Truncated), fun=median, geom="crossbar", colour="black")+
  geom_beeswarm(cex = 3,priority = "density",size=3)+
  scale_color_viridis_d(option = "D")+
  theme_cowplot(16) +
  theme(legend.position = "none")+
  ggtitle("ASO Hindlimb Clasping")+
  ylab("Score")+
  xlab("")+
  theme(plot.title = element_text(hjust = 0.5))
clasp_score

clasp_wt_het <- clasp_tg_pos %>% filter(SLC_Genotype!="MUT")
wilcox.test(Score~SLC_Genotype, clasp_wt_het)

clasp_wt_mut <- clasp_tg_pos %>% filter(SLC_Genotype!="HET")
wilcox.test(Score~SLC_Genotype, clasp_wt_mut)

## ASO Weights -- 
bw <- readr::read_csv(here("Analysis_Files", "ASO","ASO Rotarod - Rotarod.csv"))
bw_tg_pos <- bw %>% filter(ASO_Tg=="Positive") %>% 
  select(c("MouseID","Weight", "SLC_Genotype"))
bw_tg_pos <- unique(bw_tg_pos)
summary(bw_tg_pos$Weight)
weight <- generate_boxplots(bw_tg_pos, SLC_Genotype, Weight,0,53) +
  ggtitle("ASO Body Weight")+
  ylab("Weight (g)")+
  xlab("")+
  theme(plot.title = element_text(hjust = 0.5))
weight 

## PFF Hindlimb Clasp
pff_clasp<- readr::read_csv(here("Analysis_Files", "PFF", "PFF_Hindlimb_Clasp.csv"))
pff_clasp$SLC_Genotype <- factor(pff_clasp$SLC_Genotype, levels=c("WT", "HET", "MUT"))

pff_clasp_score <-  ggplot(data=pff_clasp,aes(x=SLC_Genotype,y=Score_Severe_HB, color=SLC_Genotype)) + 
  stat_summary(aes(x=SLC_Genotype, y=Score_Severe_HB), fun=median, geom="crossbar", colour="black")+
  geom_beeswarm(cex = 3,priority = "density",size=3)+
  scale_color_viridis_d(option = "D")+
  theme_cowplot(16) +
  theme(legend.position = "none")+
  ggtitle("PFF Hindlimb Clasping")+
  ylab("Score")+
  xlab("")+
  theme(plot.title = element_text(hjust = 0.5))
pff_clasp_score

clasp_wt_het <- pff_clasp %>% filter(SLC_Genotype!="MUT")
wilcox.test(Score_Severe_HB~SLC_Genotype, clasp_wt_het)

clasp_wt_mut <- pff_clasp %>% filter(SLC_Genotype!="HET")
wilcox.test(Score_Severe_HB~SLC_Genotype, clasp_wt_mut)


## PFF Nesting
pff_nest<- readr::read_csv(here("Analysis_Files", "PFF", "PFF_Nesting_Score.csv"))
pff_nest$SLC_Genotype <- factor(pff_nest$SLC_Genotype, levels=c("WT", "HET", "MUT"))

pff_nest_score <-  ggplot(data=pff_nest,aes(x=SLC_Genotype,y=Score_Severe, color=SLC_Genotype)) + 
  stat_summary(aes(x=SLC_Genotype, y=Score_Severe), fun=median, geom="crossbar", colour="black")+
  geom_beeswarm(cex = 3,priority = "density",size=3)+
  scale_color_viridis_d(option = "D")+
  theme_cowplot(16) +
  theme(legend.position = "none")+
  ggtitle("PFF Nest Construction")+
  ylim(0,5)+
  ylab("Score")+
  xlab("")+
  theme(plot.title = element_text(hjust = 0.5))
pff_nest_score

nest_wt_het <- pff_nest %>% filter(SLC_Genotype!="MUT")
wilcox.test(Score_Severe~SLC_Genotype, nest_wt_het)

nest_wt_mut <- pff_nest %>% filter(SLC_Genotype!="HET")
wilcox.test(Score_Severe~SLC_Genotype, nest_wt_mut)

## PFF Wire Hang --
wire_hang <- readr::read_csv(here("Analysis_Files", "PFF", "PFF_Wire_Hang - Wire_Hang.csv"))
wire_hang <- wire_hang %>% filter(DPI==90)
wire_hang$DPI <- as.character(wire_hang$DPI)
wire_hang$DPI <- plyr::revalue(wire_hang$DPI, c("90"="90 DPI"))

summary(wire_hang$Total_Hang_Time)
pff_wire_hang<-generate_boxplots(wire_hang, SLC_Genotype, Total_Hang_Time,0,650)+
  facet_wrap(~DPI)+
  ggtitle("PFF Wire Hang")+
  ylab("Total Hang Time (s)")+
  xlab("")+
  theme(plot.title = element_text(hjust = 0.5))

pff_wire_hang

## PFF wire hang --
wire_hang <- readr::read_csv(here("Analysis_Files", "PFF", "PFF_Wire_Hang - Wire_Hang.csv"))
wire_hang$DPI <- as.character(wire_hang$DPI)
wire_hang$DPI <- factor(wire_hang$DPI, levels=c("90_DPI", "120_DPI","150_DPI","180_DPI"))
wire_hang$DPI <- plyr::revalue(wire_hang$DPI, c("90"="90_DPI","150"="150_DPI", "120" = "120_DPI", "180"="180_DPI"))

pff_wire_hang<-generate_boxplots(wire_hang, SLC_Genotype, Total_Hang_Time,0,1000)+
  facet_wrap(~DPI,nrow=1)+ 
  ggtitle("PFF Wire Hang")+
  ylab("Hang Time (s)")+
  xlab("")+
  theme(plot.title = element_text(hjust = 0.5))

pff_wire_hang

## PFF Weights --
pff_bw <- readr::read_csv(here("Analysis_Files/PFF/PFF Rotarod - PFF_Rotarod_Analysis.csv"))
pff_bw <- unique(pff_bw %>% select(c("MouseID","Weight","SLC_Genotype")))
pff_weight <- generate_boxplots(pff_bw, SLC_Genotype, Weight,0, 40)+
  ggtitle("PFF Body Weight")+
  ylab("Weight (g)")+
  xlab("")+
  theme(plot.title = element_text(hjust = 0.5))

pff_weight

## Full figure S3 --

top <- plot_grid(pos_slc_avg_turn, pos_slc_avg_total, wirehang, weight, 
                 labels=c("A","B","C","D"), nrow=1)

middle <- plot_grid(clasp_score,pff_wire_hang, 
                    labels=c("E","F"))
bottom <- plot_grid(pff_clasp_score, pff_weight, pff_nest_score,
          labels=c("G","H","I"), nrow=1)
top
middle
bottom

### Accompanying statistics ---

## PFF Wire Hang -- 
hang_bw <- merge(pff_bw, wire_hang, by="MouseID")
hang_bw$SLC_Genotype <- factor(hang_bw$SLC_Genotype, levels=c("WT","HET","MUT"))
lm <- lm(Total_Hang_Time~  Weight + Sex + SLC_Genotype, data = hang_bw)
summary(lm)

## PFF grip strength -- 
pff_bw <- pff_bw %>% select(c("MouseID","Weight"))
grip_bw <- merge(pff_bw, grip, by="MouseID")
grip_bw$SLC_Genotype <- factor(grip_bw$SLC_Genotype, levels=c("WT","HET","MUT"))
lm <- lm(Average ~  Sex + SLC_Genotype, data = grip_bw)
summary(lm)


## Body Weight -- 
bw$SLC_Genotype <- factor(bw$SLC_Genotype, levels=c("WT","HET", "MUT"))
lm_day1 <- lm(Weight ~ Sex + SLC_Genotype, data = bw)
summary(lm_day1)

## Open Field --
of$SLC_Genotype <- factor(of$SLC_Genotype, levels=c("WT","HET", "MUT"))
lm_day1 <- lm(Center_Time ~ Sex + SLC_Genotype, data = of)
summary(lm_day1)

of_bw <- merge(bw, of,by="MouseID")
of_bw$SLC_Genotype.x <- factor(of_bw$SLC_Genotype.x, levels = c("WT", "HET", "MUT"))
lm_day1 <- lm(Distance ~  Weight+SLC_Genotype.x + Sex.x, data = of_bw)
summary(lm_day1)


