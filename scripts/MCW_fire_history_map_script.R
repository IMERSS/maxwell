##Historic fires ggplot
library(sf)
library(ggplot2)

#Layer 1: MCW
MCW <- st_read("spatial_data/vectors/Shp_files/MCW")

#Layer 2: historic fires
h_fires <- st_read("spatial_data/vectors/Shp_files/Historic_fires")

ggplot() +
  geom_sf(data = islcoast, fill = "NA") +
  geom_sf(data = MCW, color = "black", fill = "blue1") +
  geom_sf(data = h_fires$geometry) +
  coord_sf()