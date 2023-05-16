##LiDAR:drainage channels #

library(sf)
library(leaflet)
library(dplyr)
library(raster)
library(RColorBrewer)

source("scripts/utils.R")

#Layer 1: island coast
islcoast <- mx_read("spatial_data/vectors/Shp_files/Island")

#Layer 2: MCW
MCW <- mx_read("spatial_data/vectors/Shp_files/MCW")

#Layer 3: water bodies 
waterbodies <- mx_read("spatial_data/vectors/Shp_files/RAR_water_bodies")

#Layer 4: watercourses
watercourses <- mx_read("spatial_data/vectors/Shp_files/RAR_water_courses")

#Layer 5: bare earth raster 
hillshade <- raster("spatial_data/rasters/BareEarth_hillshade_resampled_5m.tif")

#Layer 6: streams
streams <- mx_read("spatial_data/vectors/Shp_files/Streams")

#Layer 7: MXCK_CAD_clipped
MXCKCADCLIPPED <- mx_read("spatial_data/vectors/Shp_files/MXCK_CAD_clipped_MXCW")

#Layer 8: lidar
drainagechannels <- mx_read("spatial_data/vectors/Shp_files/lidar_drainage_channels")

# Pal #

pal <- colorNumeric(c("#0C2C84", "#41B6C4", "#FFFFCC"), values(hillshade),
                    na.color = "transparent")

# Map #

lidarMap <- leaflet() %>%
  addPolygons(data = islcoast, color = "black", weight = 1.5, fillOpacity = 0, fillColor = NA) %>%
  addTiles(options = providerTileOptions(opacity = 0.5)) %>%
  fitBounds(-123.564, 48.802, -123.516, 48.855) %>%
  addPolylines(data = watercourses, weight = 1.5, fillOpacity = 0.8, fillColor = "royalblue") %>%
  addPolylines(data = waterbodies, weight = 1.5, fillOpacity = 0.8, fillColor = "royalblue") %>%
  addPolylines(data = streams, weight = 1.5, fillOpacity = 0.8, fillColor = "royalblue") %>%
  addPolylines(data = MXCKCADCLIPPED, weight = 1.5, fillOpacity = 0.8, fillColor = "red") %>%
  addRasterImage(hillshade, colors = pal, opacity = 0.8) %>%
  addPolylines(data = MCW, color = "red", weight = 2, fillColor = NA) %>%

print(lidarMap)

