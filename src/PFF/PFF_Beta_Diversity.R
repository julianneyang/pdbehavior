library(ggplot2)
library(vegan)
library(dplyr)
library(rlang)
library(cowplot)
library(viridis)
library(Microbiome.Biogeography)

metadata <- read.table("../starting_files/PFF_Mapping.tsv",header=TRUE)
counts <- read.table("../starting_files/PFF_ASV_table_Silva_v138_1.tsv", header = TRUE, row.names=1)

## Store taxonomy in an annotation file --
annotation <- tibble::rownames_to_column(counts, "feature") %>% select(c("feature", "taxonomy"))
counts <- counts %>% select(-c("taxonomy"))

## Apply minimum sequencing depth threshold --
counts <- counts[colSums(counts) >= 10000]

## Split counts into colon subsets -- 

# Luminal Colon 
lumcol_meta <- metadata %>% filter(Study=="Luminal_Colon", SampleID %in% names(counts))
row.names(lumcol_meta) <- lumcol_meta$SampleID
lumcol <- lumcol_meta$SampleID
lumcol_counts <- counts %>% select(all_of(lumcol))

generate_longitudinal_pcoA_plots <- function(ordination_file, metadata, title, colorvariable,colorvector){
  data<-read.csv(ordination_file, header=FALSE)
  #data<-read.csv("rpca/pcoa_rpca_s9_min10000_Yes_min10000_no_tax_PFF_ASV_table.qza.txt/ordination.csv", header=FALSE)
  
  metadata <- read.delim(metadata, header=TRUE)
  #metadata <- read.delim("../starting_files/PFF_Mapping.tsv", header=TRUE)
  metadata$SampleID <- metadata$X.SampleID
  
  #store PC1 and Pc2
  PC1<-data[5,1]
  PC1 <-round(as.numeric(PC1)*100, digits=1)
  PC2<-data[5,2]
  PC2 <-round(as.numeric(PC2)*100, digits=1)
  PC1 <-as.character(PC1)
  str_PC1<-paste0("PC 1 (", PC1,"%)")
  str_PC2<-paste0("PC 2 (", PC2, "%)")
  
  #edit dataframe
  data<-data[,1:4]
  data <- slice(data, 1:(n() - 4))     # Apply slice & n functions
  data<-data[-c(1,2,3,4,5,6,7,8,9),]
  
  #rename columns
  names(data)[names(data) == "V1"] <- "SampleID" 
  names(data)[names(data)=="V2"] <- "PC1" 
  names(data)[names(data)=="V3"] <- "PC2"
  names(data)[names(data)=="V4"] <- "PC3"
  # data$SampleID<-gsub(".","",data$SampleID)
  #append metadata
  intermediate<- (merge(data, metadata, by = 'SampleID'))
  data<- intermediate
  
  #declare factors
  data$Genotype<-factor(data$Genotype, levels=c("WT", "HET", "MUT"))
  #data <- data %>% arrange(Timepoint) 

  p<- ggplot(data, aes(x=PC1, y=PC2, colour={{colorvariable}},shape= Study)) + 
    geom_point(size=3) + 
    scale_colour_manual(name="",values={{colorvector}}) +
    scale_shape_manual(name="", values=c(16,10)) +
    #scale_color_viridis_d()+
    xlab(str_PC1) +
    ylab(str_PC2) +
    theme_cowplot(16)+
    theme(legend.position="top",legend.justification = "center") +
    #geom_line(aes(group = MouseID),color="darkgrey", arrow = arrow(type = "closed",length=unit(0.075, "inches")))+
    #geom_point(aes(x = PC1, y = PC2, shape = Timepoint), size = 3) + 
    geom_path(aes(x = PC1, y = PC2, group = MouseID), arrow = arrow(length = unit(0.55, "cm")))
    #coord_fixed(ratio=1/2)+
    labs(title= paste0({{title}})) 
  p
}

genotype_cols<- c("MUT" = "red", "WT" = "black", "HET"="blue")

longitudinal_colon_rpca<- generate_longitudinal_pcoA_plots("rpca/pcoa_rpca_s9_min10000_Yes_min10000_no_tax_PFF_ASV_table.qza.txt/ordination.csv", "../starting_files/PFF_Mapping.tsv", "Longitudinal Colon", Genotype,genotype_cols)+
  theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid")) +
  ggtitle("Longitudinal Colon RPCA") + 
  theme(plot.title = element_text(hjust = 0.5))
longitudinal_colon_rpca

longitudinal_colon_bray_curtis<- generate_longitudinal_pcoA_plots("bray_curtis/s9_min10000_Yes_min10000_no_tax_PFF_ASV_table_pcoa/ordination.csv", "../starting_files/PFF_Mapping.tsv", "Longitudinal Colon", Genotype,genotype_cols)+
  theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid")) +
  ggtitle("Longitudinal Colon BC")+
  theme(plot.title = element_text(hjust = 0.5)) 
longitudinal_colon_bray_curtis

plot_grid(longitudinal_colon_rpca, longitudinal_colon_bray_curtis, labels= c("A", "B"))

generate_cs_pcoA_plots <- function(ordination_file, metadata, title, colorvariable,colorvector){
  data<-read.csv(ordination_file, header=FALSE)
 # data<-read.csv("rpca/pcoa_rpca_s5_min10000_PFF_Jejunum_min10000_no_tax_PFF_ASV_table.qza.txt/ordination.csv", header=FALSE)
  
  metadata <- read.delim(metadata, header=TRUE)
  #metadata <- read.delim("../starting_files/PFF_Mapping.tsv", header=TRUE)
  metadata$SampleID <- metadata$X.SampleID
  
  #store PC1 and Pc2
  PC1<-data[5,1]
  PC1 <-round(as.numeric(PC1)*100, digits=1)
  PC2<-data[5,2]
  PC2 <-round(as.numeric(PC2)*100, digits=1)
  PC1 <-as.character(PC1)
  str_PC1<-paste0("PC 1 (", PC1,"%)")
  str_PC2<-paste0("PC 2 (", PC2, "%)")
  
  #edit dataframe
  data<-data[,1:4]
  data <- slice(data, 1:(n() - 4))     # Apply slice & n functions
  data<-data[-c(1,2,3,4,5,6,7,8,9),]
  
  #rename columns
  names(data)[names(data) == "V1"] <- "SampleID" 
  names(data)[names(data)=="V2"] <- "PC1" 
  names(data)[names(data)=="V3"] <- "PC2"
  names(data)[names(data)=="V4"] <- "PC3"
  # data$SampleID<-gsub(".","",data$SampleID)
  #append metadata
  intermediate<- (merge(data, metadata, by = 'SampleID'))
  data<- intermediate
  
  #declare factors
  data$Genotype<-factor(data$Genotype, levels=c("WT", "HET", "MUT"))
  #data <- data %>% arrange(Timepoint) 
  
  p<- ggplot(data, aes(x=PC1, y=PC2, colour={{colorvariable}},shape=Sex)) + 
    geom_point(size=3) + 
    scale_colour_manual(name="",values={{colorvector}}) +
    scale_shape_manual(name="", values=c(16,10)) +
    #scale_color_viridis_d()+
    xlab(str_PC1) +
    ylab(str_PC2) +
    theme_cowplot(16)+
    theme(legend.position="top",legend.justification = "center") +
    #geom_line(aes(group = MouseID),color="darkgrey", arrow = arrow(type = "closed",length=unit(0.075, "inches")))+
    #geom_point(aes(x = PC1, y = PC2, shape = Timepoint), size = 3) + 
    #geom_path(aes(x = PC1, y = PC2, group = MouseID), arrow = arrow(length = unit(0.55, "cm")))
  #coord_fixed(ratio=1/2)+
  labs(title= paste0({{title}})) 
  p
}
baseline_rpca<- generate_cs_pcoA_plots("rpca/pcoa_rpca_s3_min10000_PFF_Baseline_min10000_no_tax_PFF_ASV_table.qza.txt/ordination.csv", "../starting_files/PFF_Mapping.tsv", "Baseline RPCA", Genotype,genotype_cols)+
  theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid")) +
  theme(plot.title = element_text(hjust = 0.5))
jejunum_rpca<- generate_cs_pcoA_plots("rpca/pcoa_rpca_s5_min10000_PFF_Jejunum_min10000_no_tax_PFF_ASV_table.qza.txt/ordination.csv", "../starting_files/PFF_Mapping.tsv", "Jejunum RPCA", Genotype,genotype_cols)+
  theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid")) +
  theme(plot.title = element_text(hjust = 0.5))
cecum_rpca<- generate_cs_pcoA_plots("rpca/pcoa_rpca_s5_min10000_PFF_Cecum_min10000_no_tax_PFF_ASV_table.qza.txt/ordination.csv" , "../starting_files/PFF_Mapping.tsv", "Cecum RPCA", Genotype,genotype_cols)+
  theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid")) +
  theme(plot.title = element_text(hjust = 0.5))
colon_rpca<- generate_cs_pcoA_plots("rpca/pcoa_rpca_s5_min10000_PFF_Colon_min10000_no_tax_PFF_ASV_table.qza.txt/ordination.csv" , "../starting_files/PFF_Mapping.tsv", "Colon RPCA", Genotype,genotype_cols)+
  theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid")) +
  theme(plot.title = element_text(hjust = 0.5))

plot_grid(baseline_rpca, jejunum_rpca, cecum_rpca, colon_rpca, nrow=2, ncol=2, labels=c("A", "B", "C", "D"))

baseline_bc<- generate_cs_pcoA_plots("bray_curtis/s3_min10000_PFF_Baseline_min10000_no_tax_PFF_ASV_table_pcoa/ordination.csv", "../starting_files/PFF_Mapping.tsv", "Baseline BC", Genotype,genotype_cols)+
  theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid")) +
  theme(plot.title = element_text(hjust = 0.5))
jejunum_bc<- generate_cs_pcoA_plots("bray_curtis/s5_min10000_PFF_Jejunum_min10000_no_tax_PFF_ASV_table_pcoa/ordination.csv", "../starting_files/PFF_Mapping.tsv", "Jejunum BC", Genotype,genotype_cols)+
  theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid")) +
  theme(plot.title = element_text(hjust = 0.5))
cecum_bc<- generate_cs_pcoA_plots("bray_curtis/s5_min10000_PFF_Cecum_min10000_no_tax_PFF_ASV_table_pcoa/ordination.csv" , "../starting_files/PFF_Mapping.tsv", "Cecum BC", Genotype,genotype_cols)+
  theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid")) +
  theme(plot.title = element_text(hjust = 0.5))
colon_bc<- generate_cs_pcoA_plots("bray_curtis/s5_min10000_PFF_Colon_min10000_no_tax_PFF_ASV_table_pcoa/ordination.csv" , "../starting_files/PFF_Mapping.tsv", "Colon BC", Genotype,genotype_cols)+
  theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid")) +
  theme(plot.title = element_text(hjust = 0.5))

plot_grid(baseline_bc, jejunum_bc, cecum_bc, colon_bc, nrow=2, ncol=2, labels=c("A", "B", "C", "D"))

### Beta - Diversity Stats ---

## RPCA --
# longitudinal
metadata <-read.delim("../starting_files/PFF_Mapping.tsv",sep="\t",header=TRUE, row.names=1) #mapping file
write.csv(metadata, "../starting_files/PFF_Metadata.csv")

names(metadata)
permutewithin <- c("Study")
subjectdata <- c("Sex","Genotype", "MouseID")

?Microbiome.Biogeography::run_repeated_PERMANOVA()
run_repeated_PERMANOVA("rpca/dm_rpca_s9_min10000_Yes_min10000_no_tax_PFF_ASV_table.qza.txt/distance-matrix.tsv",
                       "../starting_files/PFF_Metadata.csv",
                       permute_columns_vector = permutewithin,
                       subject_metadata_vector = subjectdata)

# Jejunum
data.dist<-read.table(file= "rpca/dm_rpca_s5_min10000_PFF_Jejunum_min10000_no_tax_PFF_ASV_table.qza.txt/distance-matrix.tsv")
metadata <- read.csv("../starting_files/PFF_Metadata.csv", header=TRUE, row.names=1)

target <- row.names(data.dist)
metadata = metadata[match(target, row.names(metadata)),]
target == row.names(metadata)
data.dist <- as.dist(as(data.dist, "matrix"))

data.adonis=adonis(data.dist ~ Sex+ Genotype, data=metadata, permutations=10000)
data.adonis$aov.tab

data.adonis=adonis(data.dist ~ Sex*Genotype, data=metadata, permutations=10000)
data.adonis$aov.tab

# Baseline
data.dist<-read.table(file= "rpca/dm_rpca_s3_min10000_PFF_Baseline_min10000_no_tax_PFF_ASV_table.qza.txt/distance-matrix.tsv")
metadata <- read.csv("../starting_files/PFF_Metadata.csv", header=TRUE, row.names=1)


target <- row.names(data.dist)
metadata = metadata[match(target, row.names(metadata)),]
target == row.names(metadata)
data.dist <- as.dist(as(data.dist, "matrix"))

data.adonis=adonis(data.dist ~ Sex+ Genotype, data=metadata, permutations=10000)
data.adonis$aov.tab

data.adonis=adonis(data.dist ~ Sex*Genotype, data=metadata, permutations=10000)
data.adonis$aov.tab

# Cecum
data.dist<-read.table(file= "rpca/dm_rpca_s5_min10000_PFF_Cecum_min10000_no_tax_PFF_ASV_table.qza.txt/distance-matrix.tsv")
metadata <- read.csv("../starting_files/PFF_Metadata.csv", header=TRUE, row.names=1)


target <- row.names(data.dist)
metadata = metadata[match(target, row.names(metadata)),]
target == row.names(metadata)
data.dist <- as.dist(as(data.dist, "matrix"))

data.adonis=adonis(data.dist ~ Sex+ Genotype, data=metadata, permutations=10000)
data.adonis$aov.tab

data.adonis=adonis(data.dist ~ Sex*Genotype, data=metadata, permutations=10000)
data.adonis$aov.tab

# Colon
data.dist<-read.table(file= "rpca/dm_rpca_s5_min10000_PFF_Colon_min10000_no_tax_PFF_ASV_table.qza.txt/distance-matrix.tsv")
metadata <- read.csv("../starting_files/PFF_Metadata.csv", header=TRUE, row.names=1)

target <- row.names(data.dist)
metadata = metadata[match(target, row.names(metadata)),]
target == row.names(metadata)
data.dist <- as.dist(as(data.dist, "matrix"))

data.adonis=adonis(data.dist ~ Sex+ Genotype, data=metadata, permutations=10000)
data.adonis$aov.tab

data.adonis=adonis(data.dist ~ Sex*Genotype, data=metadata, permutations=10000)
data.adonis$aov.tab 

## Bray Curtis --
# longitudinal
names(metadata)
permutewithin <- c("Study")
subjectdata <- c("Sex","Genotype", "MouseID")

?Microbiome.Biogeography::run_repeated_PERMANOVA()
run_repeated_PERMANOVA("bray_curtis/DM/export_s9_min10000_Yes_min10000_no_tax_PFF_ASV_table_DM/distance-matrix.tsv",
                       "../starting_files/PFF_Metadata.csv",
                       permute_columns_vector = permutewithin,
                       subject_metadata_vector = subjectdata)

# Jejunum
data.dist<-read.table(file= "bray_curtis/DM/export_s5_min10000_PFF_Jejunum_min10000_no_tax_PFF_ASV_table_DM/distance-matrix.tsv")
metadata <- read.csv("../starting_files/PFF_Metadata.csv", header=TRUE, row.names=1)

target <- row.names(data.dist)
metadata = metadata[match(target, row.names(metadata)),]
target == row.names(metadata)
data.dist <- as.dist(as(data.dist, "matrix"))

data.adonis=adonis(data.dist ~ Sex+ Genotype, data=metadata, permutations=10000)
data.adonis$aov.tab

data.adonis=adonis(data.dist ~ Sex*Genotype, data=metadata, permutations=10000)
data.adonis$aov.tab

# Baseline
data.dist<-read.table(file= "bray_curtis/DM/export_s3_min10000_PFF_Baseline_min10000_no_tax_PFF_ASV_table_DM/distance-matrix.tsv")
metadata <- read.csv("../starting_files/PFF_Metadata.csv", header=TRUE, row.names=1)


target <- row.names(data.dist)
metadata = metadata[match(target, row.names(metadata)),]
target == row.names(metadata)
data.dist <- as.dist(as(data.dist, "matrix"))

data.adonis=adonis(data.dist ~ Sex+ Genotype, data=metadata, permutations=10000)
data.adonis$aov.tab

data.adonis=adonis(data.dist ~ Sex*Genotype, data=metadata, permutations=10000)
data.adonis$aov.tab

# Cecum
data.dist<-read.table(file= "bray_curtis/DM/export_s5_min10000_PFF_Cecum_min10000_no_tax_PFF_ASV_table_DM/distance-matrix.tsv")
metadata <- read.csv("../starting_files/PFF_Metadata.csv", header=TRUE, row.names=1)


target <- row.names(data.dist)
metadata = metadata[match(target, row.names(metadata)),]
target == row.names(metadata)
data.dist <- as.dist(as(data.dist, "matrix"))

data.adonis=adonis(data.dist ~ Sex+ Genotype, data=metadata, permutations=10000)
data.adonis$aov.tab

data.adonis=adonis(data.dist ~ Sex*Genotype, data=metadata, permutations=10000)
data.adonis$aov.tab

# Colon
data.dist<-read.table(file= "rpca/dm_rpca_s5_min10000_PFF_Colon_min10000_no_tax_PFF_ASV_table.qza.txt/distance-matrix.tsv")
metadata <- read.csv("../starting_files/PFF_Metadata.csv", header=TRUE, row.names=1)

target <- row.names(data.dist)
metadata = metadata[match(target, row.names(metadata)),]
target == row.names(metadata)
data.dist <- as.dist(as(data.dist, "matrix"))

data.adonis=adonis(data.dist ~ Sex+ Genotype, data=metadata, permutations=10000)
data.adonis$aov.tab

data.adonis=adonis(data.dist ~ Sex*Genotype, data=metadata, permutations=10000)
data.adonis$aov.tab 


