##MCW land use history map:
library(sf)
library(ggplot2)

#Layer 1: island coastline
islcoast <- st_read("spatial_data/vectors/Shp_files/Island")

#Layer 2: CAD_MCW
CAD_MCW <- st_read("spatial_data/vectors/Shp_files/MXCK_CAD_clipped_MXCW")

#Layer 2: Protected Areas (clipped to MCW)
PA_MCW <- st_read("spatial_data/vectors/Shp_files/IT_protected_areas_clipped")

#Layer 3: Logging roads and trails
Lroads <- st_read("spatial_data/vectors/Shp_files/Logging_roads_trails")

#Layer 4: Roads
roads <- st_read("spatial_data/vectors/Shp_files/DataBC_roads")

#Layer 5: Historic fires
h_fires <- st_read("spatial_data/vectors/Shp_files/Historic_fires")

ggplot() +
  geom_sf(data = CAD_MCW) +
  geom_sf(data = PA_MCW, color ="black", fill = "NA") +
  geom_sf(data = h_fires) +
  geom_sf(data = Lroads, fill = "green4", color = "green4") +
  geom_sf(data = roads) +
  coord_sf(xlim = c(458938.9, 462136.9), ylim = c(5406261, 5409918)) + 
  ggtitle("Land-use History Reference Map")