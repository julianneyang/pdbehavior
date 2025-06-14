library(ggplot2)
library(vegan)
library(dplyr)
library(rlang)
library(cowplot)
library(viridis)
library(here)

## Environment --
here::i_am("Rscripts/Figure_Correlate_ASO_Rotarod.R")

## Produce Luminal Colon Distance Matrix --
metadata <- read.csv("Analysis_Files/ASO/Microbiome/ASO Metadata.csv",header=TRUE)
metadata <- metadata %>% filter(Exclude!="YES")
counts <- read.delim("Analysis_Files/ASO/Microbiome/ASO_ASV.tsv", header = TRUE, row.names=1)

## Store taxonomy in an annotation file --
annotation <- tibble::rownames_to_column(counts, "feature") %>% select(c("feature", "taxonomy"))
counts <- counts %>% select(-c("taxonomy"))
summary(colSums(counts))

counts <- counts[colSums(counts) >= 6000]

# Luminal Colon 
lumcol_meta <- metadata %>% filter(Subset=="Luminal_Colon", SampleID %in% names(counts))
row.names(lumcol_meta) <- lumcol_meta$SampleID
lumcol <- lumcol_meta$SampleID
lumcol_counts <- counts %>% select(all_of(lumcol))

aso_lumcol_counts <- prevalence_filter(lumcol_counts,3)

aso_lumcol.dist <- calculate_rsjensen(aso_lumcol_counts)

## Perform mds --
lumcol.dist <- aso_lumcol.dist
lumcol_counts <- aso_lumcol_counts 
lumcol_meta <- lumcol_meta

mds <- cmdscale(lumcol.dist, eig = TRUE, x.ret = TRUE)

mds_values <- mds$points

mds_var_per <- round(mds$eig/sum(mds$eig) * 100, 1)

mds_data <- data.frame(sample = rownames(mds_values),
                       x = mds_values[,1],
                       y = mds_values[,2])


#merge phenotypic data 
lumcol_meta$sample <- lumcol_meta$SampleID
mds_meta <- merge(mds_data, lumcol_meta, by = "sample")
mds_meta$SLC_Genotype <- factor(mds_meta$SLC_Genotype, levels=c("WT", "HET", "MUT"))
microbiome_data <- mds_meta %>% select("MouseID","x","y")

cols <- c("WT"="black", "HET"= "blue", "MUT"="red")

## Merge Rotarod Data --
data <- readr::read_csv(here("Analysis_Files/ASO/ASO Rotarod - Rotarod.csv"))
data$SLC_Genotype <- factor(data$SLC_Genotype, levels=c("WT", "HET", "MUT"))

df <- data%>%
  group_by(MouseID) %>%
  summarise(Average_Performance = mean(Average_Latency)) %>%
  ungroup()

subset <- unique(data %>% select("MouseID","SLC_Genotype","Sex"))
df_meta <- merge(df, subset, by= "MouseID")  

rotarod_microbiome <- merge(df_meta, microbiome_data, by="MouseID")


## PCoA plot --
ggplot(rotarod_microbiome, aes(x, y, colour=Average_Performance)) + 
  geom_point(size=3) + 
  labs(x = paste("PC1(", mds_var_per[1], "%)",sep=""),
       y = paste("PC2(", mds_var_per[2], "%)",sep="")) +
  scale_colour_viridis_c() +
  theme_cowplot(16)+
  labs(title= paste0(("ASO Colonic Lumen"))) +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid")) +
  theme(legend.position = "top",legend.title = element_text(hjust = 0.5), legend.justification = "center")






# PERMANOVA 
data.dist<-aso_lumcol.dist
metadata <- merge(lumcol_meta,df, by="MouseID")
row.names(metadata) = metadata$SampleID

target <- row.names(data.dist)
metadata = metadata[match(target, metadata$SampleID),]
target == row.names(metadata)
data.dist <- as.dist(as(data.dist, "matrix"))

set.seed(11)
data.adonis=adonis(data.dist ~ Average_Performance, data=metadata, permutations=10000)
data.adonis$aov.tab
