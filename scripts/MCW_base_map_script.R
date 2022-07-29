##Island Base map:
library(sf)
library(ggplot2)

#Layer 1: island coastline
islcoast <- st_read("spatial_data/vectors/Shp_files/Island")

#Layer 2: CAD_MCW
CAD_MCW <- st_read("spatial_data/vectors/Shp_files/MXCK_CAD_clipped_MXCW")

#Layer 3: MCW
MCW <- st_read("spatial_data/vectors/Shp_files/MCW")

p <- ggplot() +
  geom_sf(data = islcoast, color = "black") + 
  geom_sf(data = MCW, fill = "blue") +
  geom_sf(data = CAD_MCW, color = "red") + 
  coord_sf() +
  ggtitle("Base Map of Maxwell Creek Watershed")
  
print(p)