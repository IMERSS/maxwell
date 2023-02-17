# R script for generating biodiversity visualization map

library(dplyr)

veg <- read.csv("D:/Simon/Sync/Root/GitHub/maxwell/tabular_data/MXCW_vegetation_percent_cover_data.csv") %>%
    rename(siteID = ï..siteID)

plot <- read.csv("D:/Simon/Sync/Root/GitHub/maxwell/tabular_data/observational_study_plots.csv")

veg.plots <- left_join(plot,veg)

veg.coordinates <- left_join(veg,plot)

write.csv(veg.plots, "D:/Simon/Sync/Root/GitHub/maxwell/tabular_data/veg_plots.csv")
write.csv(veg.coordinates,"D:/Simon/Sync/Root/GitHub/maxwell/tabular_data/species_occurrences.csv")