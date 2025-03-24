library(here) #v 1.0.1
library(dplyr) #v 1.0.7
library(funrar)
library(ggplot2)
library(cowplot)
library(paletteer)
library(rlang)
library(wakefield)
library(vegan)
library(here)
library(tidyverse)


### Declare path to current script 
here::i_am("Rscripts/ASO/ASO_Beta_Diversity.R")


### Load metadata and count table 
metadata <- read.csv(here("Analysis_Files/ASO/Microbiome/ASO_Metadata_2025.csv"), header=TRUE)
#write.table(metadata, here("Analysis_Files/ASO/Microbiome/ASO_Metadata_2025.tsv"),sep="\t",quote = FALSE,row.names = FALSE)

metadata$SampleID <- gsub("-",".",metadata$SampleID)


counts <- read.delim(here("Analysis_Files/ASO/Microbiome/ASO_ASV_table.tsv"), header = TRUE, row.names=1)


## Store taxonomy in an annotation file --
annotation <- tibble::rownames_to_column(counts, "Feature ID") %>% select(c("Feature ID", "taxonomy"))
annotation <- dplyr::rename(annotation, Taxon = taxonomy)
#write.table(annotation, here("Analysis_Files/ASO/Microbiome/taxonomy.tsv"),sep="\t",quote = FALSE,row.names = FALSE)

counts <- counts %>% select(-c("taxonomy"))

## Apply minimum sequencing depth threshold --
counts <- counts[colSums(counts) >= 6000]

# Jejunum 
jej_meta <- metadata %>% filter(Site=="JEJ", SampleID %in% names(counts))
samples_jej_meta <- jej_meta$SampleID
jej_counts <- counts %>% select(all_of(samples_jej_meta))
names(jej_counts)==jej_meta$SampleID

# Cecum
cec_meta <- metadata %>% filter(Site=="CEC", SampleID %in% names(counts))
samples_cec_meta <- cec_meta$SampleID
cec_counts <- counts %>% select(all_of(samples_cec_meta))
names(cec_counts)==cec_meta$SampleID

# Colon
col_meta <- metadata %>% filter(Site=="COL", SampleID %in% names(counts))
samples_col_meta <- col_meta$SampleID
col_counts <- counts %>% select(all_of(samples_col_meta))
names(col_counts)==col_meta$SampleID

# Luminal Colon
lumcol_meta <- metadata %>% filter(Site=="COL" | Site=="CEC", SampleID %in% names(counts))
samples_lumcol_meta <- lumcol_meta$SampleID
lumcol_counts <- counts %>% select(all_of(samples_lumcol_meta))
names(lumcol_counts)==samples_lumcol_meta


# Prevalence Filtering -
33*0.15
jej_counts <- prevalence_filter(jej_counts,5)
34*0.15
cec_counts <- prevalence_filter(cec_counts,5)
col_counts <- prevalence_filter(col_counts,5)
67*0.15
lumcol_counts <- prevalence_filter(lumcol_counts,10)

# Luminal Colon M
53*0.15
m_trios_lumcol_counts <- prevalence_filter(m_lumcol_counts,8)

# Mucosal Colon M
51*0.15
m_trios_muccol_counts <- prevalence_filter(m_muccol_counts,8)

# Mucosal Colon F
53*0.15
f_trios_muccol_counts <- prevalence_filter(f_muccol_counts,8)

## Calculate RS Jensen Shannon distance matrix -- 
jej.dist <- calculate_rsjensen(jej_counts)
cec.dist <- calculate_rsjensen(cec_counts)
col.dist <- calculate_rsjensen(col_counts)
lumcol.dist <- calculate_rsjensen(lumcol_counts)

m_trios_muccol.dist <- calculate_rsjensen(m_trios_muccol_counts)
f_trios_lumcol.dist <- calculate_rsjensen(f_trios_lumcol_counts)
m_trios_lumcol.dist <- calculate_rsjensen(m_trios_lumcol_counts)

## Calculate RS Jensen Shannon distance matrix -- 

m_trios_muccol.dist <- calculate_rsjensen(m_trios_muccol_counts)
f_trios_lumcol.dist <- calculate_rsjensen(f_trios_lumcol_counts)
m_trios_lumcol.dist <- calculate_rsjensen(m_trios_lumcol_counts)


### Figure S4 ---
cols <- c("WT"="black", "HET"="blue", "MUT"="red")
jej_pcoa <- generate_pcoA_plots(distance_matrix=jej.dist,
                                       counts = jej_counts,
                                       metadata = jej_meta,
                                       title="ASO Jejunum",
                                       colorvariable = Genotype,
                                       colorvector = cols,
                                       wa_scores_filepath = here("Analysis_Files/ASO/Microbiome/Jejunum_RSJ_Top_Taxa_PcoA.csv"))

cec_pcoa <- generate_pcoA_plots(distance_matrix=cec.dist,
                               counts = cec_counts,
                               metadata = cec_meta,
                               title="ASO Cecum",
                               colorvariable = Genotype,
                               colorvector = cols,
                               wa_scores_filepath = here("Analysis_Files/ASO/Microbiome/Cecum_RSJ_Top_Taxa_PcoA.csv"))


wa_scores <- read.csv(here("Analysis_Files/ASO/Microbiome/Cecum_RSJ_Top_Taxa_PcoA.csv"))

col_pcoa <- generate_pcoA_plots(distance_matrix=col.dist,
                                counts = col_counts,
                                metadata = col_meta,
                                title="ASO Colon",
                                colorvariable = Genotype,
                                colorvector = cols,
                                wa_scores_filepath = here("Analysis_Files/ASO/Microbiome/Colon_RSJ_Top_Taxa_PcoA.csv"))

lumcol_pcoa <- generate_pcoA_plots(distance_matrix=lumcol.dist,
                                 counts = lumcol_counts,
                                 metadata = lumcol_meta,
                                 title="ASO Colon and Cecum",
                                 colorvariable = Genotype,
                                 colorvector = cols,
                                 wa_scores_filepath = here("Analysis_Files/ASO/Microbiome/LuminalColon_RSJ_Top_Taxa_PcoA.csv"))

f_jax_baseline_pcoa <- generate_pcoA_plots(distance_matrix=f_JAX.dist,
                                           counts = f_JAX_counts_prev,
                                           metadata = f_JAX_meta,
                                           title="3-4 month Females: Fecal Pellet",
                                           colorvariable = Genotype,
                                           colorvector = cols,
                                           wa_scores_filepath = here("Baseline/beta_diversity/f_JAX_Top_Taxa_PcoA.csv"))

m_jax_baseline_pcoa <- generate_pcoA_plots(distance_matrix=m_JAX.dist,
                                           counts = m_JAX_counts_prev,
                                           metadata = m_JAX_meta,
                                           title="3-4 month Males: Fecal Pellet",
                                           colorvariable = Genotype,
                                           colorvector = cols,
                                           wa_scores_filepath = here("Baseline/beta_diversity/m_JAX_Top_Taxa_PcoA.csv"))

dev.new(width=10,height=10)
plot_grid(f_trios_mc_pcoa, m_trios_mc_pcoa,
          f_trios_lc_pcoa, m_trios_lc_pcoa,
          f_jax_baseline_pcoa,m_jax_baseline_pcoa,
          labels=c("A","B","C","D","E","F"),nrow=3)

### Statistics ---

# Luminal Colon 
data.dist<-lumcol.dist
metadata <- lumcol_meta %>% 
  column_to_rownames("SampleID")

target <- row.names(data.dist)
metadata = metadata[match(target, row.names(metadata)),]
target == row.names(metadata)
data.dist <- as.dist(as(data.dist, "matrix"))

set.seed(11)
data.adonis=adonis2(data.dist ~ Sex + Site + Genotype, data=metadata, by="terms",permutations=10000)
data.adonis

# Luminal Colon Males
data.dist<-m_trios_lumcol.dist
metadata <- m_trios_lumcol_meta

target <- row.names(data.dist)
metadata = metadata[match(target, row.names(metadata)),]
target == row.names(metadata)
data.dist <- as.dist(as(data.dist, "matrix"))

set.seed(11)
data.adonis=adonis(data.dist ~ Sequencing_Run + Litter +  Site + Genotype, data=metadata, permutations=10000)
data.adonis$aov.tab

# Mucosal Colon Females
data.dist<-f_trios_muccol.dist
metadata <- f_trios_muccol_meta

target <- row.names(data.dist)
metadata = metadata[match(target, row.names(metadata)),]
target == row.names(metadata)
data.dist <- as.dist(as(data.dist, "matrix"))

set.seed(11)
data.adonis=adonis(data.dist ~ Litter + Site + Genotype, data=metadata, permutations=10000)
data.adonis$aov.tab

# Mucosal Colon Males
data.dist<-m_trios_muccol.dist
metadata <- m_trios_muccol_meta

target <- row.names(data.dist)
metadata = metadata[match(target, row.names(metadata)),]
target == row.names(metadata)
data.dist <- as.dist(as(data.dist, "matrix"))

set.seed(11)
data.adonis=adonis(data.dist ~ Sequencing_Run + Litter + Site + Genotype, data=metadata, permutations=10000)
data.adonis$aov.tab

## Baseline --
# Females
data.dist<-f_JAX.dist
metadata <- f_JAX_meta
row.names(metadata) <- f_JAX_meta$SampleID

target <- row.names(data.dist)
metadata = metadata[match(target, row.names(metadata)),]
target == row.names(metadata)
data.dist <- as.dist(as(data.dist, "matrix"))

set.seed(11)
data.adonis=adonis(data.dist ~ Genotype, data=metadata, permutations=10000)
data.adonis$aov.tab

# Males
data.dist<-m_JAX.dist
metadata <- m_JAX_meta
row.names(metadata) <- m_JAX_meta$SampleID

target <- row.names(data.dist)
metadata = metadata[match(target, row.names(metadata)),]
target == row.names(metadata)
data.dist <- as.dist(as(data.dist, "matrix"))

set.seed(11)
data.adonis=adonis(data.dist ~ Genotype, data=metadata, permutations=10000)
data.adonis$aov.tab