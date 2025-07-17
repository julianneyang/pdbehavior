### Function for plotting alpha diversity ---
generate_adiv_plots <- function(input_data, X, Y, min, max){
  #read in files
  data <- as.data.frame(input_data)
  
  #declare order of variables
  data$Genotype <- factor(data$Genotype, levels=c("WT", "HET","MUT"))
  #graph plot
  ggplot(data=data,aes(x={{X}},y={{Y}}, fill=Genotype)) + 
    geom_boxplot(alpha=0.25)+
    scale_fill_viridis_d()+
    #geom_line(aes(group = MouseID,color=Genotype),size=1)+
    geom_point(size=2,position=position_jitter(width=0.25),alpha=1)+
    theme_cowplot(16) +
    ylim(min,max) +
    theme(legend.position = "none")
  
}

## Colon lumen --
otus<- readr::read_delim(here("data/ASO/Microbiome/alpha_ASO_ASV_table/otus_dir/alpha-diversity.tsv"))
row.names(otus) <- otus$...1
shannon<-readr::read_delim(here("data/ASO/Microbiome/alpha_ASO_ASV_table/shannon_dir/alpha-diversity.tsv"))
row.names(shannon) <- shannon$...1

data<- merge(otus,shannon, by="...1")
data$SampleID <- data$...1
data$SampleID <- gsub("-", ".", data$SampleID)

metadata <- read.csv(here("data/ASO/Microbiome/ASO_Metadata_2025.csv"), header=TRUE)
metadata$SampleID <- gsub("-", ".", metadata$SampleID)



metadata<- readr::read_delim(here("Trios/starting_files/SLC_TOTAL_OCT2020_FULL_Metadata.tsv"))
t_data_meta <- merge(data,metadata, by="SampleID")
t_data_meta <- t_data_meta %>% filter(Subset=="Luminal_Colon")

generate_adiv_plots(t_data_meta, Genotype, shannon_entropy, 0, 8) +
  #facet_wrap(Sex~Subset)+
  labs(x="",y="shannon")+
  ggtitle("2 month-old")+
  theme(plot.title = element_text(hjust = 0.5))

summary(t_data_meta$observed_features)
generate_adiv_plots(t_data_meta, Genotype, observed_features, 0, 250) +
  #facet_wrap(Sex~Subset)+
  labs(x="",y="shannon")+
  ggtitle("2 month-old")+
  theme(plot.title = element_text(hjust = 0.5))
