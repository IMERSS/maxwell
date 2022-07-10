##MCW land use history map:
library(sf)
library(ggplot2)

#Layer 1: Protected Areas (clipped to MCW)
PA_MCW <- st_read("spatial_data/vectors/Shp_files/IT_protected_areas_clipped")

#Layer 2: Logging roads and trails
Lroads <- st_read("spatial_data/vectors/Shp_files/Logging_roads_trails")

#Layer 3: Roads
roads <- st_read("spatial_data/vectors/Shp_files/DataBC_roads")

#Layer 4: Historic fires
h_fires <- st_read("spatial_data/vectors/Shp_files/Historic_fires")