library(ggplot2)
library(vegan)
library(dplyr)
library(rlang)
library(cowplot)
library(viridis)

## Environment --
here::i_am("Rscripts/Figure_Correlate_PFF_Puncta.R")

metadata <- read.csv("Analysis_Files/PFF/PFF_Microbiome/starting_files/PFF_Mapping.csv",header=TRUE)
counts <- read.table("Analysis_Files/PFF/PFF_Microbiome/starting_files/PFF_ASV_table_Silva_v138_1.tsv", header = TRUE, row.names=1)

## Store taxonomy in an annotation file --
annotation <- tibble::rownames_to_column(counts, "feature") %>% select(c("feature", "taxonomy"))
counts <- counts %>% select(-c("taxonomy"))

## Apply minimum sequencing depth threshold --
counts <- counts[colSums(counts) >= 10000]


## Split counts into colon subsets -- 

# Cecum 
cecum_meta <- metadata %>% filter(Study=="PFF_Cecum", SampleID %in% names(counts))
row.names(cecum_meta) <- cecum_meta$SampleID
cecum <- cecum_meta$SampleID
cecum_counts <- counts %>% select(all_of(cecum))

#Ipsi TH
ipsi_puncta_meta <- metadata %>% filter(Ipsilateral_TH!="NA", SampleID %in% names(counts))
ipsi_puncta_meta <- ipsi_puncta_meta %>% filter(Subset=="Luminal_Colon", SampleID %in% names(counts))
row.names(ipsi_puncta_meta) <- ipsi_puncta_meta$SampleID
ipsi_puncta <- ipsi_puncta_meta$SampleID
ipsi_puncta_counts <- counts %>% select(all_of(ipsi_puncta))

## Prevalence filter -- 
pff_cecum_counts <- prevalence_filter(cecum_counts,3)
pff_ipsi_puncta_counts <- prevalence_filter(ipsi_puncta_counts,3)

# Calculate RS Jensen Shannon distance matrix -
pff_cecum.dist <- calculate_rsjensen(pff_cecum_counts)
pff_ipsi_puncta.dist <- calculate_rsjensen(pff_ipsi_puncta_counts)

## Perform mds --
lumcol.dist <- pff_ipsi_puncta.dist
lumcol_counts <- pff_ipsi_puncta_counts 
lumcol_meta <- ipsi_puncta_meta

mds <- cmdscale(lumcol.dist, eig = TRUE, x.ret = TRUE)

mds_values <- mds$points

mds_var_per <- round(mds$eig/sum(mds$eig) * 100, 1)

mds_data <- data.frame(sample = rownames(mds_values),
                       x = mds_values[,1],
                       y = mds_values[,2])


#merge phenotypic data 
lumcol_meta$sample <- lumcol_meta$SampleID
mds_meta <- merge(mds_data, lumcol_meta, by = "sample")
mds_meta$Genotype <- factor(mds_meta$Genotype, levels=c("WT", "HET", "MUT"))

microbiome_data <- mds_meta %>% select("MouseID","x" ,"y")

## PFF TH-- 
data <- readr::read_csv(here("Analysis_Files","PFF","PFF_TH_CTCF.csv"))
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

write.csv(ipsi_df_meta, "Analysis_Files/PFF/PFF_TH_CTCF_average_ipsi.csv")
write.csv(contra_df_meta, "Analysis_Files/PFF/PFF_TH_CTCF_average_contra.csv")

contra_microbiome <- merge(contra_df_meta, microbiome_data, by="MouseID")
ipsi_microbiome <- merge(ipsi_df_meta, microbiome_data, by="MouseID")

## PCoA plot --
contra <- ggplot(contra_microbiome, aes(x, y, colour=Average_Mean)) + 
  geom_point(size=3) + 
  labs(x = paste("PC1(", mds_var_per[1], "%)",sep=""),
       y = paste("PC2(", mds_var_per[2], "%)",sep="")) +
  scale_colour_viridis_c(option = "C") +
  theme_cowplot(16)+
  facet_wrap(~Category)+
  #labs(title= paste0(("PFF Contralateral TH"))) +
  #theme(plot.title = element_text(hjust = 0.5)) +
  theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid")) +
  theme(legend.position = "none",legend.title = element_text(hjust = 0.5), legend.justification = "center")

ipsi <- ggplot(ipsi_microbiome, aes(x, y, colour=Average_Mean)) + 
  geom_point(size=3) + 
  labs(x = paste("PC1(", mds_var_per[1], "%)",sep=""),
       y = paste("PC2(", mds_var_per[2], "%)",sep="")) +
  scale_colour_viridis_c(option = "C") +
  theme_cowplot(16)+
  facet_wrap(~Category)+
  #labs(title= paste0(("PFF Contralateral TH"))) +
  #theme(plot.title = element_text(hjust = 0.5)) +
  theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid")) +
  theme(legend.position = "none",legend.title = element_text(hjust = 0.5), legend.justification = "center")

plot_grid(ipsi, contra)
## PERMANOVA --
data.dist<-pff_ipsi_puncta.dist
metadata <- ipsi_puncta_meta
row.names(metadata) = metadata$SampleID

target <- row.names(data.dist)
metadata = metadata[match(target, metadata$SampleID),]
target == row.names(metadata)
data.dist <- as.dist(as(data.dist, "matrix"))

set.seed(11)
data.adonis=adonis(data.dist ~  Ipsilateral_TH, data=metadata, permutations=10000)
data.adonis$aov.tab
set.seed(11)
data.adonis=adonis(data.dist ~ Contralateral_TH, data=metadata, permutations=10000)
data.adonis$aov.tab

## Correlation analysis --
# Spearman
correlation <- cor(contra_microbiome$Average_Mean, 
                   contra_microbiome$x, method = "spearman")
p_value <-  cor.test(contra_microbiome$Average_Mean, 
                     contra_microbiome$x, method = "spearman")
truncated_correlation <- round(correlation, 4)
truncated_p_value <- round(p_value$p.value, 4)

ggplot(contra_microbiome, aes(x, Average_Mean)) + 
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "blue") +
  labs(title = paste("PFF TH vs PC1"),
       subtitle = paste(paste("r=", truncated_correlation), paste("p=", truncated_p_value))) + 
  ylab("TH fluorescence") +
  xlab("PC1") +
  theme_cowplot(12) +
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle =  element_text(hjust = 0.5)) 

#Spearman - with no log transformation
correlation <- cor(ipsi_microbiome$norm_Average_Count, 
                   ipsi_microbiome$x, method = "pearson")
p_value <-  cor.test(ipsi_microbiome$norm_Average_Count, 
                     ipsi_microbiome$x, method = "pearson")
truncated_correlation <- round(correlation, 4)
truncated_p_value <- round(p_value$p.value, 4)

