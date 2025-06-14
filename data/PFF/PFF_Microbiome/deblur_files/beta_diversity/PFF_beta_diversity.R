library(ggplot2)
library(vegan)
library(dplyr)
library(rlang)
library(cowplot)
library(viridis)

setwd("/Users/rochellelai/Documents/JacobsGit/slcproject/PFF_Microbiome/beta_diversity/")
# here::i_am("PFF_Microbiome_RProj/_Beta_Diversity.R")

### Read data
data_meta <- "/Users/rochellelai/Documents/JacobsGit/slcproject/PFF_Microbiome/beta_diversity/PFF_Mapping.tsv"

# JEJUNUM
tissue <- "Jejunum"
ordination <- "/Users/rochellelai/Documents/JacobsGit/slcproject/PFF_Microbiome/beta_diversity/Jejunum/pcoa_rpca_s3_min6000_PFF_Jejunum_PFF_ASV_table.qza.txt/ordination.csv"
data.dist<-read.table(file = "/Users/rochellelai/Documents/JacobsGit/slcproject/PFF_Microbiome/beta_diversity/Jejunum/dm_rpca_s3_min6000_PFF_Jejunum_PFF_ASV_table.qza.txt/distance-matrix.tsv")

# COLON
tissue <- "Colon"
ordination <- "/Users/rochellelai/Documents/JacobsGit/slcproject/PFF_Microbiome/beta_diversity/Colon/pcoa_rpca_s3_min6000_PFF_Colon_PFF_ASV_table.qza.txt/ordination.csv"
data.dist<-read.table(file = "/Users/rochellelai/Documents/JacobsGit/slcproject/PFF_Microbiome/beta_diversity/Colon/dm_rpca_s3_min6000_PFF_Colon_PFF_ASV_table.qza.txt/distance-matrix.tsv")

# CECUM
tissue <- "Cecum"
ordination <- "/Users/rochellelai/Documents/JacobsGit/slcproject/PFF_Microbiome/beta_diversity/Cecum/pcoa_rpca_s3_min6000_PFF_Cecum_PFF_ASV_table.qza.txt/ordination.csv"
data.dist<-read.table(file = "/Users/rochellelai/Documents/JacobsGit/slcproject/PFF_Microbiome/beta_diversity/Cecum/dm_rpca_s3_min6000_PFF_Cecum_PFF_ASV_table.qza.txt/distance-matrix.tsv")

# BASELINE
tissue <- "Baseline"
ordination <- "/Users/rochellelai/Documents/JacobsGit/slcproject/PFF_Microbiome/beta_diversity/Baseline/pcoa_rpca_s3_min6000_PFF_Baseline_PFF_ASV_table.qza.txt/ordination.csv"
data.dist<-read.table(file = "/Users/rochellelai/Documents/JacobsGit/slcproject/PFF_Microbiome/beta_diversity/Baseline/dm_rpca_s3_min6000_PFF_Baseline_PFF_ASV_table.qza.txt/distance-matrix.tsv")

# Make function for plot
generate_PFF_longitudinal_pcoA_plots <- function(ordination_file, metadata, title, colorvariable, colorvector){
  data<-read.csv(ordination_file, header=FALSE)
  metadata <- read.delim(metadata, header=TRUE)
  
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
  
  p <- ggplot(data, aes(x=PC1, y=PC2, colour={{colorvariable}})) + 
    geom_point(size=3) + 
    scale_colour_manual(name="",values={{colorvector}}) +
    scale_shape_manual(name="", values=c(10,16)) +
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

genotype_cols<- c("WT" = "black", "HET" = "blue", "MUT" = "red")

# Make plot
PFF_rpca<- generate_PFF_longitudinal_pcoA_plots(ordination, data_meta, tissue, Genotype,genotype_cols)+
  theme(legend.background = element_rect(fill="lightblue", size=0.5, linetype="solid")) +
  theme(plot.title = element_text(hjust = 0.5))

# Save plot
ggsave(paste(tissue, "PFF_beta_diversity.png", sep = ("_")), PFF_rpca, width = 9, height = 12.6)

### Beta Diversity Stats
# Read mapping file
data_meta1 <- read.table(file = data_meta, header = T)

target <- row.names(data.dist)
data_meta1 = data_meta1[match(target, data_meta1$SampleID),]
target == data_meta1$SampleID
data.dist <- as.dist(as(data.dist, "matrix"))

sink(paste(tissue,"beta_diversity_statistics.txt", sep = ("_")))
data.adonis=adonis2(data.dist ~ Genotype, data=data_meta1, permutations=10000)
data.adonis
sink()
