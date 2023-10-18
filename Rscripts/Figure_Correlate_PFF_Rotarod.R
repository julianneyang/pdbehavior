library(ggplot2)
library(vegan)
library(dplyr)
library(rlang)
library(cowplot)
library(viridis)
library(here)

## Environment --
here::i_am("Rscripts/Figure_Correlate_PFF_Rotarod.R")

metadata <- read.table("Analysis_Files/PFF/PFF_Microbiome/starting_files/PFF_Mapping.tsv",header=TRUE)
counts <- read.table("Analysis_Files/PFF/PFF_Microbiome/starting_files/PFF_ASV_table_Silva_v138_1.tsv", header = TRUE, row.names=1)

## Store taxonomy in an annotation file --
annotation <- tibble::rownames_to_column(counts, "feature") %>% select(c("feature", "taxonomy"))
counts <- counts %>% select(-c("taxonomy"))

## Apply minimum sequencing depth threshold --
counts <- counts[colSums(counts) >= 10000]

## Split counts into colon subsets -- 

# Luminal Colon 
lumcol_meta <- metadata %>% filter(Subset=="Luminal_Colon", SampleID %in% names(counts))
row.names(lumcol_meta) <- lumcol_meta$SampleID
lumcol <- lumcol_meta$SampleID
lumcol_counts <- counts %>% select(all_of(lumcol))

# Cecum
cecum_meta <- metadata %>% filter(Study=="PFF_Cecum", SampleID %in% names(counts))
row.names(cecum_meta) <- cecum_meta$SampleID
cecum <- cecum_meta$SampleID
cecum_counts <- counts %>% select(all_of(cecum))

# Baseline
baseline_meta <- metadata %>% filter(Study=="PFF_Baseline", SampleID %in% names(counts))
row.names(baseline_meta) <- baseline_meta$SampleID
baseline <- baseline_meta$SampleID
baseline_counts <- counts %>% select(all_of(baseline))

## Prevalence filter datasets -- 
# Luminal Colon
pff_lumcol_counts <- prevalence_filter(lumcol_counts,3)

# Cecum
pff_cecum_counts <- prevalence_filter(cecum_counts,3)

# Baseline
pff_baseline_counts <- prevalence_filter(baseline_counts,3)

## Calculate RS Jensen Shannon distance matrix -- 
pff_lumcol.dist <- calculate_rsjensen(pff_lumcol_counts)
pff_cecum.dist <- calculate_rsjensen(pff_cecum_counts)
pff_baseline.dist <- calculate_rsjensen(pff_baseline_counts)

# Perform mds
  lumcol.dist <- pff_baseline.dist
  lumcol_counts <- pff_baseline_counts 
  lumcol_meta <- baseline_meta
  
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
  microbiome_data <- mds_meta %>% select("MouseID","x","y")


  # Feed in Rotarod data - 
  data <- readr::read_csv(here("Analysis_Files/PFF/PFF Rotarod - PFF_Rotarod_Analysis.csv"))
  data$SLC_Genotype <- factor(data$SLC_Genotype, levels=c("WT", "HET", "MUT"))

  df <- data%>%
    group_by(MouseID) %>%
    summarise(Average_Performance = mean(Average_Latency)) %>%
    ungroup()
  
  
  subset <- unique(data %>% select("MouseID","SLC_Genotype","Sex"))
  df_meta <- merge(df, subset, by= "MouseID")  

  rotarod_microbiome <- merge(df_meta, microbiome_data, by="MouseID")
  rotarod_microbiome <- merge(microbiome_data,df_meta,  by="MouseID")

  ## PCoA plot --
  ggplot(rotarod_microbiome, aes(x, y, colour=Average_Performance)) + 
    geom_point(size=3) + 
    labs(x = paste("PC1(", mds_var_per[1], "%)",sep=""),
         y = paste("PC2(", mds_var_per[2], "%)",sep="")) +
    scale_colour_viridis_c() +
    theme_cowplot(16)+
    labs(title= paste0(("PFF Colonic Lumen"))) +
    theme(plot.title = element_text(hjust = 0.5)) +
    theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid")) +
    theme(legend.position = "top",legend.title = element_text(hjust = 0.5), legend.justification = "center")
  
  
# PERMANOVA 
  data.dist<-pff_baseline.dist
  metadata <- merge(baseline_meta,df_meta, by="MouseID")
  row.names(metadata) = metadata$SampleID
  
  target <- row.names(data.dist)
  metadata = metadata[match(target, metadata$SampleID),]
  target == row.names(metadata)
  data.dist <- as.dist(as(data.dist, "matrix"))
  
  set.seed(11)
  data.adonis=adonis(data.dist ~ Average_Performance, data=metadata, permutations=10000)
  data.adonis$aov.tab

# Correlation analysis - 
  
  # Pearson
  correlation <- cor(rotarod_microbiome$Average_Performance, 
                     rotarod_microbiome$x, method = "pearson")
  p_value <- cor.test(rotarod_microbiome$Average_Performance, 
                      rotarod_microbiome$x, method = "pearson")
  truncated_correlation <- round(correlation, 4)
  truncated_p_value <- round(p_value, 4)
  
  #Spearman - with no log transformation
  correlation <- cor(rotarod_microbiome$Average_Performance, 
                     rotarod_microbiome$x, method = "spearman")
  p_value <- cor.test(rotarod_microbiome$Average_Performance, 
                      rotarod_microbiome$x, method = "spearman")
  truncated_correlation <- round(correlation, 4)
  truncated_p_value <- round(p_value$p.value, 4)

ggplot(rotarod_microbiome, aes(x, Average_Performance)) + 
    geom_point() +
    geom_smooth(method = "lm", se = FALSE, color = "blue") +
    labs(title = paste("PFF Rotarod Performance vs PC1"),
         subtitle = paste(paste("r=", truncated_correlation))) + 
    ylab("Average Performance") +
    xlab("PC1") +
    theme_cowplot(12) +
    theme(plot.title = element_text(hjust = 0.5),
          plot.subtitle =  element_text(hjust = 0.5)) 
  
  