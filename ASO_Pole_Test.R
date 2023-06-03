library(here)
library(ggplot2)
library(rlang)
library(rstatix)  
library(nlme)
library(cowplot)
library(ggbeeswarm)
library(ggpubr)
library(tidyr)
library(dplyr)
library(knitr)

setwd("../pdbehavior/")
data<-read.csv("ASO Pole Test - All_Cohorts_Assign_Maximum_Time.csv", header=TRUE)
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

# Compare the distribution between Positive and Negative mice
summary_table <- data %>%
  group_by(ASO_Tg, Best_Performance) %>%
  count()

category_counts <- summary_table %>%
  pivot_wider(names_from = Best_Performance, values_from = n, values_fill = 0)

result <- fisher.test(category_counts[, c("C", "S")])

# Compare the SLC distribution in Positive Mice 
summary_table <- data %>%
  filter(ASO_Tg=="Positive") %>%
  group_by(Best_Performance, SLC_Genotype) %>%
  count()

category_counts <- summary_table %>%
  pivot_wider(names_from = Best_Performance, values_from = n, values_fill = 0)

result <- fisher.test(category_counts[, c("C", "S")])

# Compare the SLC distribution in Positive Mice 
summary_table <- data %>%
  filter(ASO_Tg=="Negative") %>%
  group_by(Best_Performance, SLC_Genotype) %>%
  count()

category_counts <- summary_table %>%
  pivot_wider(names_from = Best_Performance, values_from = n, values_fill = 0)

result <- fisher.test(category_counts[, c("C", "S")])
print(result)

## Plot Tturn and Ttotal --
generate_boxplots <- function(input_data, X, Y, min,max){
  data<-as.data.frame(input_data)
  #Ensure correct ordering of levels 
  data$SLC_Genotype <- factor(data$SLC_Genotype, levels = c("WT", "HET", "MUT"))
  
  ggplot(data=data,aes(x={{X}},y={{Y}}, fill={{X}})) + 
    #geom_violin(alpha=0.25,position=position_dodge(width=.75),size=1,color="black",draw_quantiles=c(0.5))+
    #geom_violin(trim = FALSE, width = 0.4, alpha = 0.7) +
    geom_boxplot(alpha=0.25)+ 
    #geom_quasirandom(alpha=0.1)+
    scale_fill_viridis_d()+
    geom_point(size=1,position=position_jitter(width=0.25),alpha=0.3)+
    theme_cowplot(16) +
    #ylim(min,max)+
    theme(legend.position = "none") 
}

## Compare Tg Negative to Tg Positive -- 
posvneg_avg_tturn <- generate_boxplots(average_tturn, ASO_Tg, Time,0,20) +
  ylab("Time (seconds)")+
  ggtitle("Average Tturn")+
  theme(plot.title = element_text(hjust = 0.5)) 
posvneg_avg_ttotal <- generate_boxplots(average_ttotal, ASO_Tg, Time,0,20)+
  ylab("Time (seconds)")+
  ggtitle("Average Ttotal")+
  theme(plot.title = element_text(hjust = 0.5)) 
posvneg_fast_tturn <- generate_boxplots(fastest_tturn, ASO_Tg, Time,0,20) + 
  ylab("Time (seconds)")+
  ggtitle("Fastest Tturn")+
  theme(plot.title = element_text(hjust = 0.5)) 
posvneg_fast_ttotal <- generate_boxplots(fastest_ttotal, ASO_Tg, Time,0,20) +
  ylab("Time (seconds)")+
  ggtitle("Fastest Ttotal")+
  theme(plot.title = element_text(hjust = 0.5)) 

plot_grid(posvneg_avg_tturn, posvneg_avg_ttotal,
          posvneg_fast_tturn, posvneg_fast_ttotal)

## Compare SLC Genotypes within ASO_Tg --

posvneg_slc_sex <- generate_boxplots(data, SLC_Genotype, Average_Tturn,0,20) + facet_wrap(Sex~ASO_Tg) 
posvneg_slc_sex <- generate_boxplots(data, SLC_Genotype, Average_Tturn,0,20) + facet_wrap(~ASO_Tg) 

generate_boxplots(fastest_tturn, SLC_Genotype, Time,0,20) + facet_wrap(~ASO_Tg)
generate_boxplots(fastest_tturn, ASO_Tg, Time,0,20) 

## Statistics --
# Linear models and mixed effects linear models -

data_long<- data %>%
  pivot_longer(cols = c(Trial_1_Tturn, Trial_2_Tturn, Trial_3_Tturn, Trial_4_Tturn, Trial_5_Tturn), names_to = "Tturn", values_to = "Tturn_Time") %>%
  pivot_longer(cols = c(Trial_1_Ttotal, Trial_2_Ttotal, Trial_3_Ttotal, Trial_4_Ttotal, Trial_5_Ttotal), names_to = "Ttotal", values_to = "Ttotal_Time") 
data_long$SLC_Genotype <- factor(data_long$SLC_Genotype,levels=c("WT","HET","MUT"))

data_long_neg <- data_long %>% filter(ASO_Tg=="Negative")
data_long_pos <- data_long %>% filter(ASO_Tg=="Positive")

cs_variables <- c("Average_Tturn", "Average_Ttotal",
               "Fastest_Tturn", "Fastest_Ttotal")
long_variables <- c("Tturn_Time", "Ttotal_Time")

# Create a markdown file
output_file <- "Pole_Test_output.md"
knitr::knit_meta(output_file)

# Loop over the variables and perform analyses
for (variable in cs_variables) {
   
  # Fit linear model on full data
  formula_lm_full <- reformulate(c("Sex", "SLC_Genotype", "Weight", "ASO_Tg"), response = variable)
  output <- lm(formula_lm_full, data = data_long)
  cat("##", variable, "\n\n", file = output_file, append = TRUE)
  cat(kable(summary(output)$coefficients), "\n\n", file = output_file, append = TRUE)
  
  # Fit linear model on positive ASO_Tg data
  formula_lm_pos <- reformulate(c("Sex", "SLC_Genotype", "Weight"), response = variable)
  output <- lm(formula_lm_pos, data = data_long_pos)
  cat("##", variable, " (Positive ASO_Tg)\n\n", file = output_file, append = TRUE)
  cat(kable(summary(output)$coefficients), "\n\n", file = output_file, append = TRUE)
  
  # Fit linear model on negative ASO_Tg data
  formula_lm_neg <- reformulate(c("Sex", "SLC_Genotype", "Weight"), response = variable)
  output <- lm(formula_lm_neg, data = data_long_neg)
  cat("##", variable, " (Negative ASO_Tg)\n\n", file = output_file, append = TRUE)
  cat(kable(summary(output)$coefficients), "\n\n", file = output_file, append = TRUE)
  
}



average_tturn <- data %>% filter(Metric=="Average_Tturn")
fastest_tturn <- data %>% filter(Metric=="Fastest_Tturn")

average_ttotal <- data %>% filter(Metric=="Average_Ttotal")
fastest_ttotal <- data %>% filter(Metric=="Fastest_Ttotal")

average_tturn_neg <- data %>% filter(Metric=="Average_Tturn" & ASO_Tg=="Negative")  
average_tturn_pos<- data %>% filter(Metric=="Average_Tturn" & ASO_Tg=="Positive")  

average_tturn_neg_f <- data %>% filter(Metric=="Average_Tturn" & ASO_Tg=="Negative" & Sex =="Female")  
average_tturn_pos_f<- data %>% filter(Metric=="Average_Tturn" & ASO_Tg=="Positive" & Sex =="Female")  

wilcox.test(Time ~ ASO_Tg, average_tturn)
wilcox.test(Time ~ ASO_Tg, average_ttotal)

mut <- average_tturn_neg %>% filter(SLC_Genotype!="HET")
wilcox.test(Time ~ SLC_Genotype, mut)

mut <- average_tturn_pos %>% filter(SLC_Genotype!="HET")
wilcox.test(Time ~ SLC_Genotype, mut)

mut <- average_tturn_neg_f %>% filter(SLC_Genotype!="HET")
wilcox.test(Time ~ SLC_Genotype, mut)

mut <- average_tturn_pos_f %>% filter(SLC_Genotype!="HET")
wilcox.test(Time ~ SLC_Genotype, mut)



