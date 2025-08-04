library(Maaslin2)
library(funrar)
library(dplyr)
library(ggplot2)
library(cowplot)
library(plyr)
library(circlize)
library(here)
library(stringr)

here::i_am("src/PFF/PFF_PWY_Maaslin2.R")
## PFF Jejunum ---

input_data <- read.delim("data/PFF/PFF_Microbiome/starting_files/picrust2_output_min10000_no_tax_PFF_ASV_table.qza/export_pathway_abundance/feature-table.tsv", header=TRUE, row.names=1) # choose filtered non rarefied csv file
df_input_data <- as.data.frame(input_data)
df_input_data <- select(df_input_data, -c("taxonomy"))

input_metadata <-read.delim("starting_files/PFF_Mapping.tsv",sep="\t",header=TRUE, row.names=1)
input_metadata$SampleID <- row.names(input_metadata)

samples <- input_metadata %>% filter(Study =="PFF_Jejunum", SampleID %in% names(df_input_data)) %>% pull(SampleID)

df_input_data <- df_input_data[, samples]

target <- colnames(df_input_data)
input_metadata = input_metadata[match(target, row.names(input_metadata)),]
target == row.names(input_metadata)


df_input_metadata<-input_metadata
df_input_metadata$MouseID <- factor(df_input_metadata$MouseID)
df_input_metadata$Genotype <- factor(df_input_metadata$Genotype, levels=c("WT","HET", "MUT"))
df_input_metadata$Sex <- factor(df_input_metadata$Sex)
sapply(df_input_metadata,levels)

fit_data = Maaslin2(input_data=df_input_data, 
                    input_metadata=df_input_metadata, 
                    output = paste0("PICRUST2_PWY_Jejunum_Maaslin2__Sex_Genotype"), 
                    fixed_effects = c("Sex","Genotype"),normalization="TSS", 
                    min_prevalence = 0.15,
                    transform ="log",plot_heatmap = FALSE,plot_scatter = FALSE)

## PFF Cecum ---

input_data <- read.delim("starting_files/picrust2_output_min10000_no_tax_PFF_ASV_table.qza/export_pathway_abundance/feature-table.tsv", header=TRUE, row.names=1) # choose filtered non rarefied csv file
df_input_data <- as.data.frame(input_data)
df_input_data <- select(df_input_data, -c("taxonomy"))

input_metadata <-read.delim("starting_files/PFF_Mapping.tsv",sep="\t",header=TRUE, row.names=1)
input_metadata$SampleID <- row.names(input_metadata)

samples <- input_metadata %>% filter(Study =="PFF_Cecum", SampleID %in% names(df_input_data)) %>% pull(SampleID)

df_input_data <- df_input_data[, samples]

target <- colnames(df_input_data)
input_metadata = input_metadata[match(target, row.names(input_metadata)),]
target == row.names(input_metadata)


df_input_metadata<-input_metadata
df_input_metadata$MouseID <- factor(df_input_metadata$MouseID)
df_input_metadata$Genotype <- factor(df_input_metadata$Genotype, levels=c("WT","HET", "MUT"))
df_input_metadata$Sex <- factor(df_input_metadata$Sex)
sapply(df_input_metadata,levels)

fit_data = Maaslin2(input_data=df_input_data, 
                    input_metadata=df_input_metadata, 
                    output = paste0("PICRUST2_PWY_Cecum_Maaslin2_Sex_Genotype"), 
                    fixed_effects = c("Sex","Genotype"),normalization="TSS", 
                    min_prevalence = 0.15,
                    transform ="log",plot_heatmap = FALSE,plot_scatter = FALSE)

## PFF Colon---

input_data <- read.delim("starting_files/picrust2_output_min10000_no_tax_PFF_ASV_table.qza/export_pathway_abundance/feature-table.tsv", header=TRUE, row.names=1) # choose filtered non rarefied csv file
df_input_data <- as.data.frame(input_data)
df_input_data <- select(df_input_data, -c("taxonomy"))

input_metadata <-read.delim("starting_files/PFF_Mapping.tsv",sep="\t",header=TRUE, row.names=1)
input_metadata$SampleID <- row.names(input_metadata)

samples <- input_metadata %>% filter(Study =="PFF_Colon", SampleID %in% names(df_input_data)) %>% pull(SampleID)

df_input_data <- df_input_data[, samples]

target <- colnames(df_input_data)
input_metadata = input_metadata[match(target, row.names(input_metadata)),]
target == row.names(input_metadata)


df_input_metadata<-input_metadata
df_input_metadata$MouseID <- factor(df_input_metadata$MouseID)
df_input_metadata$Genotype <- factor(df_input_metadata$Genotype, levels=c("WT","HET", "MUT"))
df_input_metadata$Sex <- factor(df_input_metadata$Sex)
sapply(df_input_metadata,levels)

fit_data = Maaslin2(input_data=df_input_data, 
                    input_metadata=df_input_metadata, 
                    output = paste0("PICRUST2_Pathway_Colon_Maaslin2_Sex_Genotype"), 
                    fixed_effects = c("Sex","Genotype"),normalization="TSS", 
                    min_prevalence = 0.15,
                    transform ="log",plot_heatmap = FALSE,plot_scatter = FALSE)


## PFF Luminal Colon---

input_data <- read.delim("data/PFF/PFF_Microbiome/starting_files/picrust2_output_min10000_no_tax_PFF_ASV_table.qza/export_pathway_abundance/feature-table.tsv", header=TRUE, row.names=1) # choose filtered non rarefied csv file
df_input_data <- as.data.frame(input_data)
df_input_data <- select(df_input_data, -c("taxonomy"))

input_metadata <-read.delim("data/PFF/PFF_Microbiome/starting_files/PFF_Mapping.tsv",sep="\t",header=TRUE, row.names=1)
input_metadata$SampleID <- row.names(input_metadata)

samples <- input_metadata %>% filter(Subset =="Luminal_Colon", SampleID %in% names(df_input_data)) %>% pull(SampleID)

df_input_data <- df_input_data[, samples]

target <- colnames(df_input_data)
input_metadata = input_metadata[match(target, row.names(input_metadata)),]
target == row.names(input_metadata)

write.table(df_input_data, "data/PFF/PFF_Microbiome/differential_pathway/PWY_Subset_Luminal_Colon.tsv",sep="\t")
df_input_metadata<-input_metadata
df_input_metadata$MouseID <- factor(df_input_metadata$MouseID)
df_input_metadata$Genotype <- factor(df_input_metadata$Genotype, levels=c("WT","HET", "MUT"))
df_input_metadata$Sex <- factor(df_input_metadata$Sex)
sapply(df_input_metadata,levels)

fit_data = Maaslin2(input_data=df_input_data, 
                    input_metadata=df_input_metadata, 
                    output = paste0(here("results/PFF/differential_pathway/PICRUST2_Pathway_Luminal_Colon_Maaslin2_Sex_Site_Genotype")), 
                    fixed_effects = c("Sex", "Study", "Genotype"),normalization="TSS", 
                    min_prevalence = 0.15,
                    transform ="log",plot_heatmap = FALSE,plot_scatter = FALSE)

## PFF Baseline---

input_data <- read.delim("starting_files/picrust2_output_min10000_no_tax_PFF_ASV_table.qza/export_pathway_abundance/feature-table.tsv", header=TRUE, row.names=1) # choose filtered non rarefied csv file
df_input_data <- as.data.frame(input_data)
df_input_data <- select(df_input_data, -c("taxonomy"))

input_metadata <-read.delim("starting_files/PFF_Mapping.tsv",sep="\t",header=TRUE, row.names=1)
input_metadata$SampleID <- row.names(input_metadata)

samples <- input_metadata %>% filter(Study =="PFF_Baseline", SampleID %in% names(df_input_data)) %>% pull(SampleID)

df_input_data <- df_input_data[, samples]

target <- colnames(df_input_data)
input_metadata = input_metadata[match(target, row.names(input_metadata)),]
target == row.names(input_metadata)


df_input_metadata<-input_metadata
df_input_metadata$MouseID <- factor(df_input_metadata$MouseID)
df_input_metadata$Genotype <- factor(df_input_metadata$Genotype, levels=c("WT","HET", "MUT"))
df_input_metadata$Sex <- factor(df_input_metadata$Sex)
sapply(df_input_metadata,levels)

fit_data = Maaslin2(input_data=df_input_data, 
                    input_metadata=df_input_metadata, 
                    output = paste0("PICRUST2_PWY_Baseline_Maaslin2_Sex_Genotype"), 
                    fixed_effects = c("Sex","Genotype"),normalization="TSS", 
                    min_prevalence = 0.15,
                    transform ="log",plot_heatmap = FALSE,plot_scatter = FALSE)

### Visualize MetaCyc results  ---

# Baseline  - 3 PWY, 2 MUT, 1 HET
data<-read.table("../metagenomics/PICRUST2_PWY_Baseline_Maaslin2_Sex_Genotype/significant_results.tsv", header=TRUE)
data <- data %>% filter(qval <0.25)
data <- data %>% filter(metadata=="Genotype")

annotation <- read.delim("/home/julianne/Documents/slccolonpaper/slccolon/Baseline/starting_files/picrust2_output_Baseline_ASV_table_Silva_v138_1.qza/export_pathway_abundance/annotated_pwy.tsv", row.names=1)
annotation$feature <- row.names(annotation)
annotation <- annotation %>% select(c("feature","description"))
annotation$feature <- gsub("-", ".", annotation$feature)
data <- merge(data,annotation, by="feature")

write.csv(data,"../metagenomics/PICRUST2_PWY_Baseline_Maaslin2_Sex_Genotype/significant_results_annotated.tsv" )

# Cecum - 5 PWY, 5 HET 
data<-read.table("../metagenomics/PICRUST2_PWY_Cecum_Maaslin2_Sex_Genotype/significant_results.tsv", header=TRUE)
data <- data %>% filter(qval <0.25)
data <- data %>% filter(metadata=="Genotype")

annotation <- read.delim("/home/julianne/Documents/slccolonpaper/slccolon/Baseline/starting_files/picrust2_output_Baseline_ASV_table_Silva_v138_1.qza/export_pathway_abundance/annotated_pwy.tsv", row.names=1)
annotation$feature <- row.names(annotation)
annotation <- annotation %>% select(c("feature","description"))
annotation$feature <- gsub("-", ".", annotation$feature)
data <- merge(data,annotation, by="feature")

write.csv(data,"../metagenomics/PICRUST2_PWY_Cecum_Maaslin2_Sex_Genotype/significant_results_annotated.tsv")

# Colon - 0 PWY
data<-read.table("../metagenomics/PICRUST2_Pathway_Colon_Maaslin2_Sex_Genotype/significant_results.tsv", header=TRUE)
data <- data %>% filter(qval <0.25)
data <- data %>% filter(metadata=="Genotype")



# Jejunum - 5 MUT, 36 HET 
data<-read.table("../metagenomics/PICRUST2_PWY_Jejunum_Maaslin2__Sex_Genotype/significant_results.tsv", header=TRUE)
data <- data %>% filter(qval <0.25)
data <- data %>% filter(metadata=="Genotype")

annotation <- read.delim("/home/julianne/Documents/slccolonpaper/slccolon/Baseline/starting_files/picrust2_output_Baseline_ASV_table_Silva_v138_1.qza/export_pathway_abundance/annotated_pwy.tsv", row.names=1)
annotation$feature <- row.names(annotation)
annotation <- annotation %>% select(c("feature","description"))
annotation$feature <- gsub("-", ".", annotation$feature)
data <- merge(data,annotation, by="feature")
write.csv(data,"../metagenomics/PICRUST2_PWY_Jejunum_Maaslin2__Sex_Genotype/significant_results_annotated.tsv" )

# split the paths column by "|"
higher_classification <- read.delim("/home/julianne/Documents/slccolonpaper/slccolon/Huttenhower_MetaCyc_Hierarchy.txt",header=TRUE)
df <- higher_classification
df_split <- strsplit(df$annotation, "\\|")
df_new <- data.frame(do.call(rbind, df_split))
df_new$feature <- higher_classification$feature
df_new$feature <- gsub("-",".",df_new$feature)

# Merge higher_classification column
data <- merge(data,df_new, by="feature")
data <- data %>% mutate(coef_abs = abs(coef))

plot <- data %>% 
  select(c("feature", "X2","coef_abs"))
plot <- data %>% 
  select(c("description", "X2","coef_abs"))

mat <- plot
circos.clear()
dev.new(width=10,height=10)
chordDiagram(mat,annotationTrack = "grid",preAllocateTracks = list(track.height = max(strwidth(unlist(dimnames(mat))))))
obj <- circos.track(track.index = 1, panel.fun = function(x, y) {
  circos.text(CELL_META$xcenter, CELL_META$ylim[1], CELL_META$sector.index, 
              facing = "clockwise", niceFacing = TRUE, adj = 0.6,
              cex=1)
}, bg.border = NA) 
circos.clear()

# Luminal Colon - 0 PWY
lc_pwy<-read.table("results/PFF/differential_pathway/PICRUST2_Pathway_Luminal_Colon_Maaslin2_Sex_Site_Genotype/all_results.tsv", header=TRUE)
lc_pwy_het <- lc_pwy %>% filter(value=="HET") %>% filter(qval<0.25) %>% pull(feature)
lc_pwy_mut <- lc_pwy%>% filter(value=="MUT") %>% filter(qval<0.25) %>% pull(feature)
combined_significant_features <- c(lc_pwy_het, lc_pwy_mut)
lc_pwy <- lc_pwy %>% filter(feature %in% combined_significant_features) %>% 
  filter(metadata =="Genotype")

# Restrict visualization just to features agreeing in direction in both HET and MUT 
lc_pwy_filtered <- lc_pwy %>%
  group_by(feature) %>%
  filter(all(c("HET", "MUT") %in% value)) %>%
  filter({
    het_coef <- coef[value == "HET"]
    mut_coef <- coef[value == "MUT"]
    length(het_coef) == 1 && length(mut_coef) == 1 &&
      ((het_coef > 0 & mut_coef > 0) | (het_coef < 0 & mut_coef < 0))
  }) %>%
  ungroup() 

write_rds(lc_pwy_filtered, here("results/PFF/differential_pathway/PFF_Combined_Significant_PWY.RDS"))

# Read and clean annotation
annotation <- read.delim(here("data/PFF/PFF_Microbiome/starting_files/picrust2_output_min10000_no_tax_PFF_ASV_table.qza/export_pathway_abundance/annotated_pwy.tsv"), row.names = 1) %>%
  tibble::rownames_to_column("feature") %>%
  mutate(feature = gsub("-", ".", feature)) %>%
  select(feature, description)

# Merge annotation into main table
lc_pwy <- inner_join(lc_pwy_filtered, annotation, by = "feature")

# Add higher-order annotations
higher_classification <- read.delim(here("data/Huttenhower_MetaCyc_Hierarchy.txt"),header=TRUE)
df <- higher_classification
df_split <- strsplit(df$annotation, "\\|")
df_new <- data.frame(do.call(rbind, df_split))
df_new$feature <- higher_classification$feature
df_new$feature <- gsub("-",".",df_new$feature)

data <- merge(lc_pwy,df_new, by="feature")
# data <- data %>% mutate(coef_abs = abs(coef))

plot <- data %>% 
  filter(coef<= -0.5) %>% 
  select(c("description", "X2")) %>%
  unique()

plot$description
plot$description <- str_wrap(plot$description, width=50)

mat <- plot
circos.clear()
dev.new(width=10,height=10)
chordDiagram(mat,annotationTrack = "grid",preAllocateTracks = list(track.height = max(strwidth(unlist(dimnames(mat))))))
obj <- circos.track(track.index = 1, panel.fun = function(x, y) {
  circos.text(CELL_META$xcenter, CELL_META$ylim[1], CELL_META$sector.index, 
              facing = "clockwise", niceFacing = TRUE, adj = 0.4,
              cex=1)
}, bg.border = NA) 


plot <- data %>% 
  filter(coef>= 0.5) %>% 
  select(c("description", "X2")) %>%
  unique()

plot$description <- str_wrap(plot$description, width=50)

mat <- plot
circos.clear()
dev.new(width=10,height=10)
chordDiagram(mat,annotationTrack = "grid",preAllocateTracks = list(track.height = max(strwidth(unlist(dimnames(mat))))))
obj <- circos.track(track.index = 1, panel.fun = function(x, y) {
  circos.text(CELL_META$xcenter, CELL_META$ylim[1], CELL_META$sector.index, 
              facing = "clockwise", niceFacing = TRUE, adj = 0.6,
              cex=1)
}, bg.border = NA) 

