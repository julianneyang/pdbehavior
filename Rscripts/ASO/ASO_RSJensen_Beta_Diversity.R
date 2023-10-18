library(ggplot2)
library(vegan)
library(dplyr)
library(rlang)
library(cowplot)
library(viridis)
#library(Microbiome.Biogeography)

metadata <- read.csv("Analysis_Files/ASO/Microbiome/ASO Metadata.csv",header=TRUE)
metadata <- metadata %>% filter(Exclude!="YES")
counts <- read.delim("Analysis_Files/ASO/Microbiome/ASO_ASV.tsv", header = TRUE, row.names=1)

## Store taxonomy in an annotation file --
annotation <- tibble::rownames_to_column(counts, "feature") %>% select(c("feature", "taxonomy"))
counts <- counts %>% select(-c("taxonomy"))
summary(colSums(counts))
## Apply minimum sequencing depth threshold --
counts <- counts[colSums(counts) >= 6000]

## Split counts into colon subsets -- 

# Luminal Colon 
lumcol_meta <- metadata %>% filter(Subset=="Luminal_Colon", SampleID %in% names(counts))
row.names(lumcol_meta) <- lumcol_meta$SampleID
lumcol <- lumcol_meta$SampleID
lumcol_counts <- counts %>% select(all_of(lumcol))

# Cecum
cecum_meta <- metadata %>% filter(Site=="Cecum", SampleID %in% names(counts))
row.names(cecum_meta) <- cecum_meta$SampleID
cecum <- cecum_meta$SampleID
cecum_counts <- counts %>% select(all_of(cecum))

# Jejunum
jej_meta <- metadata %>% filter(Site=="Jejunum", SampleID %in% names(counts))
row.names(jej_meta) <- jej_meta$SampleID
jej <- jej_meta$SampleID
jej_counts <- counts %>% select(all_of(jej))

# Colon
colon_meta <- metadata %>% filter(Site=="Colon", SampleID %in% names(counts))
row.names(colon_meta) <- colon_meta$SampleID
colon <- colon_meta$SampleID
colon_counts <- counts %>% select(all_of(colon))

## Prevalence filter datasets -- 
# Luminal Colon
aso_lumcol_counts <- prevalence_filter(lumcol_counts,3)

# Cecum
aso_cecum_counts <- prevalence_filter(cecum_counts,3)

# Jejunum
#pff_jej_counts <- pff_jej_counts %>% select(-c("PFF_Jejunum_1941"))
aso_jej_counts <- prevalence_filter(jej_counts,3)

# Colon
aso_colon_counts <- prevalence_filter(colon_counts,3)

## Calculate RS Jensen Shannon distance matrix -- 
aso_lumcol.dist <- calculate_rsjensen(aso_lumcol_counts)

## Calculate RS Jensen Shannon distance matrix -- 
aso_cecum.dist <- calculate_rsjensen(aso_cecum_counts)

## Calculate RS Jensen Shannon distance matrix -- 
aso_jej.dist <- calculate_rsjensen(aso_jej_counts)

## Calculate RS Jensen Shannon distance matrix -- 
aso_colon.dist <- calculate_rsjensen(aso_colon_counts)

## Principal Coordinates Analysis -- 

cols <- c("WT"="black", "HET"= "blue", "MUT"="red")

lc_pcoa <- generate_pcoA_plots(distance_matrix=aso_lumcol.dist,
                               counts = aso_lumcol_counts,
                               metadata = lumcol_meta,
                               title="ASO Colonic Lumen",
                               colorvariable = SLC_Genotype,
                               colorvector = cols,
                               wa_scores_filepath = "Analysis_Files/ASO/Microbiome/LumCol_RSJ_Top_Taxa_PcoA.csv")
lc_pcoa
cecum_pcoa <- generate_pcoA_plots(distance_matrix=aso_cecum.dist,
                                  counts = aso_cecum_counts,
                                  metadata = cecum_meta,
                                  title="aso - Cecum RS Jensen",
                                  colorvariable = SLC_Genotype,
                                  colorvector = cols,
                                  wa_scores_filepath = "Analysis_Files/ASO/Microbiome/Cecum_RSJ_Top_Taxa_PcoA.csv")
cecum_pcoa
colon_pcoa <- generate_pcoA_plots(distance_matrix=aso_colon.dist,
                                  counts = aso_colon_counts,
                                  metadata = colon_meta,
                                  title="aso - Colon RS Jensen",
                                  colorvariable = SLC_Genotype,
                                  colorvector = cols,
                                  wa_scores_filepath = "Analysis_Files/ASO/Microbiome/Colon_RSJ_Top_Taxa_PcoA.csv")

colon_pcoa
jejunum_pcoa <- generate_pcoA_plots(distance_matrix=aso_jej.dist,
                                    counts = aso_jej_counts,
                                    metadata = jej_meta,
                                    title="aso - Jejunum RS Jensen",
                                    colorvariable = SLC_Genotype,
                                    colorvector = cols,
                                    wa_scores_filepath = "Analysis_Files/ASO/Microbiome/Jejunum_RSJ_Top_Taxa_PcoA.csv")
jejunum_pcoa
cecum_pcoa +facet_wrap(~Sex)
jejunum_pcoa + facet_wrap(~Sex)
colon_pcoa + facet_wrap(~Sex)
baseline_pcoa + facet_wrap(~Sex)
lc_pcoa + facet_wrap(~Sex)
## Statistics --

## PERMANOVA

# Luminal Colon
data.dist<-aso_lumcol.dist
metadata <- lumcol_meta

target <- row.names(data.dist)
metadata = metadata[match(target, row.names(metadata)),]
target == row.names(metadata)
data.dist <- as.dist(as(data.dist, "matrix"))

set.seed(11)
data.adonis=adonis(data.dist ~ Sex + Site + SLC_Genotype, data=metadata, permutations=10000)
data.adonis$aov.tab

# Cecum
data.dist<-aso_cecum.dist
metadata <- cecum_meta

target <- row.names(data.dist)
metadata = metadata[match(target, row.names(metadata)),]
target == row.names(metadata)
data.dist <- as.dist(as(data.dist, "matrix"))

set.seed(11)
data.adonis=adonis(data.dist ~ Sex + SLC_Genotype, data=metadata, permutations=10000)
data.adonis$aov.tab

# Colon
data.dist<-aso_colon.dist
metadata <- colon_meta

target <- row.names(data.dist)
metadata = metadata[match(target, row.names(metadata)),]
target == row.names(metadata)
data.dist <- as.dist(as(data.dist, "matrix"))

set.seed(11)
data.adonis=adonis(data.dist ~ Sex + SLC_Genotype, data=metadata, permutations=10000)
data.adonis$aov.tab

# Jejunum
data.dist<-aso_jej.dist
metadata <-jej_meta

target <- row.names(data.dist)
metadata = metadata[match(target, row.names(metadata)),]
target == row.names(metadata)
data.dist <- as.dist(as(data.dist, "matrix"))

set.seed(11)
data.adonis=adonis(data.dist ~ Sex + SLC_Genotype, data=metadata, permutations=10000)
data.adonis$aov.tab

