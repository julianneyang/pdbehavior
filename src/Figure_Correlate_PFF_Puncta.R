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
ipsi_puncta_meta <- metadata %>% filter(Ipsilateral_Puncta!="NA", SampleID %in% names(counts))
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

## PFF Synucleinopathy-- 
data <- readr::read_csv(here("Analysis_Files/PFF/PFF Brain Staining and Imaging Record - Analysis_Rb_pS129.csv"))
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

contra_microbiome <- merge(df_meta_cont, microbiome_data, by="MouseID")
ipsi_microbiome <- merge(df_meta_ipsi, microbiome_data, by="MouseID")

write.csv(df_meta_ipsi, "Analysis_Files/PFF/PFF_Puncta_average_ipsi.csv")
write.csv(df_meta_cont, "Analysis_Files/PFF/PFF_Puncta_average_contra.csv")

## PCoA plot --
cols=c("WT"="black", "HET"="blue","MUT"="red")
contra <- ggplot(contra_microbiome, aes(x, y, colour=Genotype)) + 
  geom_point(size=3) + 
  labs(x = paste("PC1(", mds_var_per[1], "%)",sep=""),
       y = paste("PC2(", mds_var_per[2], "%)",sep="")) +
  scale_color_manual(values=cols)+
  #scale_colour_viridis_c(option = "B") +
  theme_cowplot(16)+
  facet_wrap(~Category)+
  #labs(title= paste0(("PFF Contralateral TH"))) +
  #theme(plot.title = element_text(hjust = 0.5)) +
  theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid")) +
  theme(legend.position = "none",legend.title = element_text(hjust = 0.5), legend.justification = "center")

ipsi <- ggplot(ipsi_microbiome, aes(x, y, colour=Genotype)) + 
  geom_point(size=3) + 
  labs(x = paste("PC1(", mds_var_per[1], "%)",sep=""),
       y = paste("PC2(", mds_var_per[2], "%)",sep="")) +
  scale_color_manual(values=cols)+
  #scale_colour_viridis_c(option = "B") +
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
data.adonis=adonis(data.dist ~Ipsilateral_Puncta*Genotype, data=metadata, permutations=10000)
data.adonis$aov.tab
set.seed(11)
data.adonis=adonis(data.dist ~ Contralateral_Puncta*Genotype , data=metadata, permutations=10000)
data.adonis$aov.tab

## Correlation analysis --
# Spearman
correlation <- cor(contra_microbiome$Average_Count, 
                   contra_microbiome$x, method = "spearman")
p_value <-  cor.test(contra_microbiome$Average_Count, 
                contra_microbiome$x, method = "spearman")
truncated_correlation <- round(correlation, 4)
truncated_p_value <- round(p_value$p.value, 4)

ggplot(contra_microbiome, aes(x, Average_Count)) + 
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "blue") +
  labs(title = paste("PFF pS129 aSyn Puncta vs PC1"),
       subtitle = paste(paste("r=", truncated_correlation), paste("p=", truncated_p_value))) + 
  ylab("pS129 aSyn Puncta Count") +
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

