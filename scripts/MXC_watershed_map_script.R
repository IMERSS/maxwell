##Maxwell Creek Watershed Map: 
library(sf)
library(ggplot2)

#layer 1: CAD_MCW
CAD_MCW <- st_read("spatial_data/vectors/Shp_files/MXCK_CAD_clipped_MXCW")

#Layer 2: MCW
MCW <- st_read("spatial_data/vectors/Shp_files/MCW")

#Layer 3: waterbodies 
waterbodies <- st_read("spatial_data/vectors/Shp_files/RAR_water_bodies")

#Layer 4: watercourses
watercourses <- st_read("spatial_data/vectors/Shp_files/RAR_water_courses")

#Layer 5: watersheds
watersheds <- st_read("spatial_data/vectors/Shp_files/Watershed_CRD")watersheds <- st_read("spatial_data/vectors/Shp_files/Watershed_CRD")

#Layer 6: streams 
streams <- st_read("spatial_data/vectors/Shp_files/Streams")

#layer 7: wetlands
wetlands <- st_read("spatial_data/vectors/Shp_files/Wetlands")

#Mapping using ggplot2:

ggplot() +
  geom_sf(data = CAD_MCW) +
  geom_sf(data = MCW, color = "black", fill = NA) +
  geom_sf(data = watersheds, color = "blue2", fill = NA) +
  geom_sf(data = waterbodies, fill = "dodgerblue1") +
  geom_sf(data = watercourses, fill = "royalblue3") +
  geom_sf(data = streams) +
  geom_sf(data = wetlands) +
  coord_sf(xlim = c(457989.4, 463653.3), ylim = c(5405057, 5411462), expand = FALSE) +
  ggtitle("Maxwell Creek Watershed Map")
