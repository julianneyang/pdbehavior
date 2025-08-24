library(ggplot2)
library(vegan)
library(dplyr)
library(rlang)
library(cowplot)
library(viridis)
library(here)

here::i_am("src/PFF/PFF_RSJensen_Beta_Diversity.R")
fp <- "data/PFF/PFF_Microbiome/"
metadata <- read.table(here(paste0(fp,"/starting_files/PFF_Mapping.tsv")),header=TRUE)
counts <- read.table(here(paste0(fp,"starting_files/PFF_ASV_table_Silva_v138_1.tsv")), header = TRUE, row.names=1)


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

# Jejunum
jej_meta <- metadata %>% filter(Study=="PFF_Jejunum", SampleID %in% names(counts))
row.names(jej_meta) <- jej_meta$SampleID
jej <- jej_meta$SampleID
jej_counts <- counts %>% select(all_of(jej))

# Colon
colon_meta <- metadata %>% filter(Study=="PFF_Colon", SampleID %in% names(counts))
row.names(colon_meta) <- colon_meta$SampleID
colon <- colon_meta$SampleID
colon_counts <- counts %>% select(all_of(colon))

# Baseline
baseline_meta <- metadata %>% filter(Study=="PFF_Baseline", SampleID %in% names(counts))
row.names(baseline_meta) <- baseline_meta$SampleID
baseline <- baseline_meta$SampleID
baseline_counts <- counts %>% select(all_of(baseline))

## Prevalence filter datasets -- 
# Luminal Colon
71*0.15
pff_lumcol_counts <- prevalence_filter(lumcol_counts,11)

# Cecum
pff_cecum_counts <- prevalence_filter(cecum_counts,3)

# Jejunum
#pff_jej_counts <- pff_jej_counts %>% select(-c("PFF_Jejunum_1941"))
pff_jej_counts <- prevalence_filter(jej_counts,3)

# Colon
pff_colon_counts <- prevalence_filter(colon_counts,3)

# Baseline
pff_baseline_counts <- prevalence_filter(baseline_counts,3)

## Calculate RS Jensen Shannon distance matrix -- 
pff_lumcol.dist <- calculate_rsjensen(pff_lumcol_counts)

## Calculate RS Jensen Shannon distance matrix -- 
pff_cecum.dist <- calculate_rsjensen(pff_cecum_counts)

## Calculate RS Jensen Shannon distance matrix -- 
pff_jej.dist <- calculate_rsjensen(pff_jej_counts)

## Calculate RS Jensen Shannon distance matrix -- 
pff_colon.dist <- calculate_rsjensen(pff_colon_counts)

## Calculate RS Jensen Shannon distance matrix -- 
pff_baseline.dist <- calculate_rsjensen(pff_baseline_counts)

## Principal Coordinates Analysis -- 

cols <- c("WT"="black", "HET"= "navy", "MUT"="firebrick")
output_fp <- "results/PFF/"
lc_pcoa <- generate_pcoA_plots(distance_matrix=pff_lumcol.dist,
                                     counts = pff_lumcol_counts,
                                     metadata = lumcol_meta,
                                     title="PFF - Luminal Colon RS Jensen",
                                     colorvariable = Genotype,
                                     colorvector = cols,
                                     mds_meta_filepath = here(paste0(output_fp,"beta_diversity/Fig_6A_PcoA.csv")),
                                     wa_scores_filepath = here(paste0(output_fp,"beta_diversity/LumCol_RSJ_Top_Taxa_PcoA.csv")))

lc_pcoa <- lc_pcoa + scale_color_manual(values=cols)
write_rds(lc_pcoa, here("results/PFF/figures/lumcol_beta_diversity.RDS"))

cecum_pcoa <- generate_pcoA_plots(distance_matrix=pff_cecum.dist,
                               counts = pff_cecum_counts,
                               metadata = cecum_meta,
                               title="PFF - Cecum RS Jensen",
                               colorvariable = Genotype,
                               colorvector = cols,
                               wa_scores_filepath = here(paste0(fp,"beta_diversity/Cecum_RSJ_Top_Taxa_PcoA.csv")))

colon_pcoa <- generate_pcoA_plots(distance_matrix=pff_colon.dist,
                                  counts = pff_colon_counts,
                                  metadata = colon_meta,
                                  title="PFF - Colon RS Jensen",
                                  colorvariable = Genotype,
                                  colorvector = cols,
                                  wa_scores_filepath = here(paste0(fp,"beta_diversity/Colon_RSJ_Top_Taxa_PcoA.csv")))

jejunum_pcoa <- generate_pcoA_plots(distance_matrix=pff_jej.dist,
                                  counts = pff_jej_counts,
                                  metadata = jej_meta,
                                  title="PFF - Jejunum RS Jensen",
                                  colorvariable = Genotype,
                                  colorvector = cols,
                                  wa_scores_filepath = here(paste0(fp,"beta_diversity/Jejunum_RSJ_Top_Taxa_PcoA.csv")))

baseline_pcoa <- generate_pcoA_plots(distance_matrix=pff_baseline.dist,
                                    counts = pff_baseline_counts,
                                    metadata = baseline_meta,
                                    title="PFF - Baseline RS Jensen",
                                    colorvariable = Genotype,
                                    colorvector = cols,
                                    wa_scores_filepath = here(paste0(fp,"beta_diversity/Baseline_RSJ_Top_Taxa_PcoA.csv")))

cecum_pcoa +facet_wrap(~Sex)
jejunum_pcoa + facet_wrap(~Sex)
colon_pcoa + facet_wrap(~Sex)
baseline_pcoa + facet_wrap(~Sex)
lc_pcoa + facet_wrap(~Sex)

cowplot::plot_grid(baseline_pcoa,jejunum_pcoa,cecum_pcoa,colon_pcoa,lc_pcoa)
## Statistics --

## PERMANOVA

# Luminal Colon
data.dist<-pff_lumcol.dist
metadata <- lumcol_meta

target <- row.names(data.dist)
metadata = metadata[match(target, row.names(metadata)),]
target == row.names(metadata)
data.dist <- as.dist(as(data.dist, "matrix"))

set.seed(11)
data.adonis=adonis2(data.dist ~ Sex + Study + Genotype, data=metadata, by="terms",permutations=10000)
data.adonis

set.seed(11)
data.adonis=adonis2(data.dist ~ Sex + Study + Genotype, data=metadata, by="terms",permutations=10000)
data.adonis

# Feed in Rotarod data - 
data.dist<-pff_lumcol.dist
data <- readr::read_csv(here("data/PFF/PFF Rotarod - PFF_Rotarod_Analysis.csv"))
data$Genotype <- factor(data$SLC_Genotype, levels=c("WT", "HET", "MUT"))
data <- data %>% filter(Day=="one") %>%
  dplyr::select(c("MouseID","Average_Latency"))
metadata <- merge(lumcol_meta,data , by="MouseID") %>% column_to_rownames("SampleID")

target <- row.names(data.dist)
metadata = metadata[match(target, row.names(metadata)),]
target == row.names(metadata)
data.dist <- as.dist(as(data.dist, "matrix"))

set.seed(11)
data.adonis=adonis2(data.dist ~ Average_Latency,  data=metadata, by="terms",permutations=10000)
data.adonis

set.seed(11)
data.adonis=adonis2(data.dist ~ Ipsilateral_Puncta,  data=metadata, by="terms",permutations=10000)
data.adonis

lumcol_meta <- merge(lumcol_meta,data , by="MouseID")
rotarod_pcoa <- generate_pcoA_plots(distance_matrix=pff_lumcol.dist,
                               counts = pff_lumcol_counts,
                               metadata = lumcol_meta,
                               title="PFF - Luminal Colon RS Jensen",
                               colorvariable = Average_Latency,
                               colorvector = cols,
                               mds_meta_filepath = here(paste0(output_fp,"beta_diversity/Fig_6C_PcoA.csv")),
                               wa_scores_filepath = here(paste0(output_fp,"beta_diversity/LumCol_RSJ_Top_Taxa_PcoA.csv")))

rotarod_pcoa <- rotarod_pcoa + scale_color_viridis_c()

write_rds(rotarod_pcoa, here("results/PFF/figures/rotarod_beta_diversity.RDS"))

# Cecum
data.dist<-pff_cecum.dist
metadata <- cecum_meta

target <- row.names(data.dist)
metadata = metadata[match(target, row.names(metadata)),]
target == row.names(metadata)
data.dist <- as.dist(as(data.dist, "matrix"))

set.seed(11)
data.adonis=adonis(data.dist ~ Sex + Genotype, data=metadata, permutations=10000)
data.adonis$aov.tab

# Colon
data.dist<-pff_colon.dist
metadata <- colon_meta

target <- row.names(data.dist)
metadata = metadata[match(target, row.names(metadata)),]
target == row.names(metadata)
data.dist <- as.dist(as(data.dist, "matrix"))

set.seed(11)
data.adonis=adonis(data.dist ~ Sex + Genotype, data=metadata, permutations=10000)
data.adonis$aov.tab

# Jejunum
data.dist<-pff_jej.dist
metadata <-jej_meta

target <- row.names(data.dist)
metadata = metadata[match(target, row.names(metadata)),]
target == row.names(metadata)
data.dist <- as.dist(as(data.dist, "matrix"))

set.seed(11)
data.adonis=adonis(data.dist ~ Sex + Genotype, data=metadata, permutations=10000)
data.adonis$aov.tab

# Baseline
data.dist<-pff_baseline.dist
metadata <-baseline_meta

target <- row.names(data.dist)
metadata = metadata[match(target, row.names(metadata)),]
target == row.names(metadata)
data.dist <- as.dist(as(data.dist, "matrix"))

set.seed(11)
data.adonis=adonis(data.dist ~ Sex + Genotype, data=metadata, permutations=10000)
data.adonis$aov.tab
