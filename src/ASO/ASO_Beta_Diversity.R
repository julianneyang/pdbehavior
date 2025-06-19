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
here::i_am("src/ASO/ASO_Beta_Diversity.R")


### Load metadata and count table 
metadata <- read.csv(here("data/ASO/Microbiome/ASO_Metadata_2025.csv"), header=TRUE)
metadata <- metadata %>% filter(Omit=="No")
#metadata$SampleID <- gsub("\\.","-",metadata$SampleID)
#write.table(metadata, here("Analysis_Files/ASO/Microbiome/ASO_Metadata_2025.tsv"),sep="\t",quote = FALSE,row.names = FALSE)

metadata$SampleID <- gsub("-",".",metadata$SampleID)


counts <- read.delim(here("data/ASO/Microbiome/ASO_ASV_table.tsv"), header = TRUE, row.names=1)


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
33*0.15
cec_counts <- prevalence_filter(cec_counts,5)
col_counts <- prevalence_filter(col_counts,5)
65*0.15
lumcol_counts <- prevalence_filter(lumcol_counts,10)


## Calculate RS Jensen Shannon distance matrix -- 
jej.dist <- calculate_rsjensen(jej_counts)
cec.dist <- calculate_rsjensen(cec_counts)
col.dist <- calculate_rsjensen(col_counts)
lumcol.dist <- calculate_rsjensen(lumcol_counts)

## Calculate Bray distance matrix -- 
# jej.dist <- vegdist(t(jej_counts),method="bray",diag=TRUE) %>% as.matrix()
# cec.dist <- vegdist(t(cec_counts),method="bray", diag=TRUE) %>% as.matrix()
# col.dist <- as.matrix(vegdist(t(col_counts),method="bray", diag=TRUE))
# lumcol.dist <- as.matrix(vegdist(t(lumcol_counts),method="bray", diag=TRUE))

# 
# ## Calculate RS Jensen Shannon distance matrix -- 
# 
# m_trios_muccol.dist <- calculate_rsjensen(m_trios_muccol_counts)
# f_trios_lumcol.dist <- calculate_rsjensen(f_trios_lumcol_counts)
# m_trios_lumcol.dist <- calculate_rsjensen(m_trios_lumcol_counts)


### Figure S4 ---
cols <- c("WT"="black", "HET"="navy", "MUT"="firebrick")
jej_pcoa <- generate_pcoA_plots(distance_matrix=jej.dist,
                                       counts = jej_counts,
                                       metadata = jej_meta,
                                       title="ASO Jejunum",
                                       colorvariable = Genotype,
                                       colorvector = cols,
                                       wa_scores_filepath = here("results/ASO/PCoA/Jejunum_RSJ_Top_Taxa_PcoA.csv"))
jej_pcoa + aes(label=MouseID) + geom_label()

cec_pcoa <- generate_pcoA_plots(distance_matrix=cec.dist,
                               counts = cec_counts,
                               metadata = cec_meta,
                               title="ASO Cecum",
                               colorvariable = Genotype,
                               colorvector = cols,
                               wa_scores_filepath = here("results/ASO/PCoA/Cecum_RSJ_Top_Taxa_PcoA.csv"))

cec_pcoa + aes(label=MouseID) + geom_label()
wa_scores <- read.csv(here("results/ASO/PCoA/Cecum_RSJ_Top_Taxa_PcoA.csv"))

col_pcoa <- generate_pcoA_plots(distance_matrix=col.dist,
                                counts = col_counts,
                                metadata = col_meta,
                                title="ASO Colon",
                                colorvariable = Genotype,
                                colorvector = cols,
                                wa_scores_filepath = here("results/ASO/PCoA/Colon_RSJ_Top_Taxa_PcoA.csv"))

col_pcoa + aes(label=MouseID) + geom_label()
lumcol_pcoa <- generate_pcoA_plots(distance_matrix=lumcol.dist,
                                 counts = lumcol_counts,
                                 metadata = lumcol_meta,
                                 title="ASO Colonic Lumen",
                                 colorvariable = Genotype,
                                 colorvector = cols,
                                 wa_scores_filepath = here("results/ASO/PCoA/LuminalColon_Bray_Top_Taxa_PcoA.csv"))
lumcol_pcoa <- lumcol_pcoa + scale_color_manual(values=cols)

write_rds(lumcol_pcoa, here("results/ASO/figures/lumcol_beta_diversity.RDS"))

lumcol_meta<- lumcol_meta %>%
  mutate(Repeat = if_else(str_starts(SampleID, "Rep"), "Repeat", "Not Repeat"))

# Some exploratory examination of patterns present in metadata - 

cols <- viridis::inferno(3)
generate_pcoA_plots(distance_matrix=lumcol.dist,
                    counts = lumcol_counts,
                    metadata = lumcol_meta,
                    title="ASO Colon and Cecum",
                    colorvariable = Cohort,
                    colorvector = cols,
                    wa_scores_filepath = here("results/ASO/PCoA/LuminalColon_RSJ_Top_Taxa_PcoA.csv"))



dev.new(width=10,height=10)
cowplot::plot_grid(jej_pcoa, cec_pcoa,
          col_pcoa, lumcol_pcoa,
          labels=c("A","B","C","D"),nrow=2)

### Statistics ---

### Append Rotarod data ---
ASO_rotarod <- read.csv(here("data/ASO/ASO Rotarod - Rotarod.csv"))
ASO_rotarod <- ASO_rotarod %>% filter(Day=="One") %>%
  filter(ASO_Tg=="Positive") %>%
  dplyr::select(c("MouseID", "Average_Latency"))

msid_conversion <- read.csv(here("data/ASO/ASO_From_Rotarod_To_Counts_MouseID.csv"))
msid_conversion$MouseID <- msid_conversion$From
ASO_rotarod <- ASO_rotarod %>%
  left_join(msid_conversion,by="MouseID") %>%
  mutate(MouseID=ifelse(is.na(From),MouseID,To)) %>% 
  dplyr::select(c("MouseID", "Average_Latency")) %>%
  unique()

lumcol_meta <- merge(lumcol_meta, ASO_rotarod, by="MouseID")

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

set.seed(11)
data.adonis=adonis2(data.dist ~ Sex + Site + Genotype + Average_Latency, data=metadata, by="terms",permutations=10000)
data.adonis


rotarod_beta_diversity <- generate_pcoA_plots(distance_matrix=lumcol.dist,
                    counts = lumcol_counts,
                    metadata = lumcol_meta,
                    title="ASO Colon and Cecum",
                    colorvariable = Average_Latency,
                    colorvector = cols,
                    wa_scores_filepath = here("results/ASO/PCoA/LuminalColon_RSJ_Top_Taxa_PcoA.csv")) +
  scale_color_viridis_c()

write_rds(rotarod_beta_diversity, here("results/ASO/figures/rotarod_beta_diversity.RDS"))

# Colon 
data.dist<-col.dist
metadata <- col_meta %>% 
  column_to_rownames("SampleID")

target <- row.names(data.dist)
metadata = metadata[match(target, row.names(metadata)),]
target == row.names(metadata)
data.dist <- as.dist(as(data.dist, "matrix"))

set.seed(11)
data.adonis=adonis2(data.dist ~ Sex+ Genotype, data=metadata, by="terms",permutations=10000)
data.adonis

# Cecum
data.dist<-cec.dist
metadata <- cec_meta %>% 
  column_to_rownames("SampleID")

target <- row.names(data.dist)
metadata = metadata[match(target, row.names(metadata)),]
target == row.names(metadata)
data.dist <- as.dist(as(data.dist, "matrix"))

set.seed(11)
data.adonis=adonis2(data.dist ~ Sex+ Genotype, data=metadata, by="terms",permutations=10000)
data.adonis

# Jejunum
data.dist<-jej.dist
metadata <- jej_meta %>% 
  column_to_rownames("SampleID")

target <- row.names(data.dist)
metadata = metadata[match(target, row.names(metadata)),]
target == row.names(metadata)
data.dist <- as.dist(as(data.dist, "matrix"))

set.seed(11)
data.adonis=adonis2(data.dist ~ Sex+ Genotype, data=metadata, by="terms",permutations=10000)
data.adonis
