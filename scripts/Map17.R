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

#Layer 3: MXCK_CAD_clipped
MXCKCADCLIPPED <- mx_read("spatial_data/vectors/Shp_files/MXCK_CAD_clipped_MXCW")

#Layer 4: lidar
drainagechannels <- mx_read("spatial_data/vectors//Shp_files/lidar_drainage_channels")

#Layer 5: bare earth raster 
hillshade <- raster("spatial_data/rasters/BareEarth_hillshade_resampled_5m.tif")

# Map #

lidarMap <- leaflet() %>%
  addPolygons(data = islcoast, color = "black", weight = 1.5, fillOpacity = 0, fillColor = NA) %>%
  addTiles(options = providerTileOptions(opacity = 0.5)) %>%
  fitBounds(-123.564, 48.802, -123.516, 48.855) %>%
  addProviderTiles('Esri.WorldImagery') %>% 
  addPolylines(data = drainagechannels, weight = 1.5, fillOpacity = 0.8, fillColor = "royalblue") %>%
  addRasterImage(hillshade, colors = gray.colors(100), opacity = 0.8) %>%
  addPolylines(data = MCW, color = "red", weight = 2, fillColor = NA) %>%
  #addPolylines(data = streams, weight = 1.5, fillOpacity = 0.8, fillColor = "royalblue") %>%
  #addPolylines(data = MXCKCADCLIPPED, weight = 1.5, fillOpacity = 0.8, fillColor = "red") %>%
  #addRasterImage(hillshade, colors = pal, opacity = 0.8) %>%
  #addPolylines(data = watercourses, weight = 1.5, fillOpacity = 0.8, fillColor = "royalblue") %>%
  #addPolylines(data = waterbodies, weight = 1.5, fillOpacity = 0.8, fillColor = "royalblue") %>%

print(lidarMap)

