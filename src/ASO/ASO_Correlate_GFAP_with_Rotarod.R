library(here)
library(tidyverse)
library(cowplot)
library(ggplot2)

### Establish location ---

here::i_am("src/ASO/ASO_Correlate_DAT_with_Rotarod.R")

### Read in input files ---

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

gfap <- read.csv(here("data/ASO/GFAP_meta.csv"),row.names = 1)

combined <- merge(ASO_rotarod, gfap, by="MouseID")

### Make scatterplot
# Spearman correlation test
cor_test <- cor.test(combined$Average_Latency, combined$Average_GFAP, method = "spearman")

# Generate ggplot
p <- ggplot(combined, aes(x = Average_GFAP, y = Average_Latency))+
  geom_point(aes(fill=Genotype),shape = 21, color = "black", stroke = 0.5, alpha = 0.6) +
  geom_smooth(method = "lm", se = TRUE, color = "blue") +
  labs(
    title="Rotarod vs. GFAP",
    subtitle = paste("Spearman rho =", round(cor_test$estimate, 3), 
                     "| p =", signif(cor_test$p.value, 3)),
    x = "GFAP+ Cell Count",
    y = "Average Latency Day One"
  ) +
  theme_cowplot(10) +
  theme(legend.position = "top")+
  scale_fill_manual(values=genotype_cols) +
  theme(
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5)
  )
p

write_rds(p, here("results/ASO/figures/GFAP_rotarod_correlation.RDS"))
