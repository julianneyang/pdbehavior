library(cowplot)

plot_grid(spontaneous_gi, MPTP_gi, pff_gi,aso_gi, nrow=1,
          rel_widths = c(1,1,1,1))

spontaneous_gi <- spontaneous_gi + 
  theme(legend.position = "none")

aso_gi <- aso_gi + 
  theme(legend.position = "none")

spontaneous_gi+theme(legend.position="right")