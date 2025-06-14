

## Wire Hang --
wire_hang <- readr::read_csv(here("Analysis_Files", "PFF", "PFF_Wire_Hang - Wire_Hang.csv"))
wire_hang <- wire_hang %>% filter(DPI!=90)
wire_hang$Genotype <- factor(wire_hang$Genotype,levels=c("WT","HET","MUT"))
wire_hang$DPI <- as.character(wire_hang$DPI)
wire_hang$DPI <- plyr::revalue(wire_hang$DPI, c("150"="150_DPI", "120" = "120_DPI", "180"="180_DPI"))

# Stratified by SLC Genotype
b<-generate_boxplots(wire_hang, Genotype, Total_Hang_Time,0,1000)+
  facet_wrap(~DPI)
b

