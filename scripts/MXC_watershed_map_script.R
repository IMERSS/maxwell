##Maxwell Creek Watershed Map: 
library(sf)
library(ggplot2)

#Layer 1: island coast
islcoast <- st_read("spatial_data/vectors/Shp_files/Island")

#layer 2: CAD_MCW
CAD_MCW <- st_read("spatial_data/vectors/Shp_files/MXCK_CAD_clipped_MXCW")

#Layer 3: MCW
MCW <- st_read("spatial_data/vectors/Shp_files/MCW")

#Layer 4: waterbodies 
waterbodies <- st_read("spatial_data/vectors/Shp_files/RAR_water_bodies")

#Layer 5: watercourses
watercourses <- st_read("spatial_data/vectors/Shp_files/RAR_water_courses")

#Layer 6: watersheds
watersheds <- st_read("spatial_data/vectors/Shp_files/Watershed_CRD")

#Mapping using ggplot2:

ggplot() +
  geom_sf(data = islcoast, color ="black", fill = "beige") +
  geom_sf(data = MCW, color = "black", fill = NA) +
  geom_sf(data = CAD_MCW, fill = NA) +
  geom_sf(data = watersheds, color = "blue2", fill = "NA") +
  geom_sf(data = waterbodies, color = "dodgerblue1", fill = "dodgerblue1") +
  geom_sf(data = watercourses, color = "royalblue4", fill = "royalblue4") +
  coord_sf(xlim = c(457989.4, 463653.3), ylim = c(5405057, 5411462), expand = FALSE) +
  ggtitle("Maxwell Creek Watershed Map")
