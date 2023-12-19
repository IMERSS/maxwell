## Maxwell outlined

library(sf)
library(leaflet)
library(raster)
library(RColorBrewer)

source("scripts/utils.R")

#Layer 1: island coast
islcoast <- mx_read("spatial_data/vectors/Shp_files/Island")

#Layer 2: MCW
MCW <- mx_read("spatial_data/vectors/Shp_files/MCW")

#Layer 3: water bodies 
waterbodies <- mx_read("spatial_data/vectors/Shp_files/RAR_water_bodies")

# Render map #

MXmap <- leaflet() %>%
  addTiles(options = providerTileOptions(opacity = 1)) %>%
  fitBounds(-123.564, 48.802, -123.516, 48.855) %>%
  addProviderTiles('Esri.WorldImagery') %>% 
  addPolygons(data = islcoast, color = "black", weight = 1.5, fillOpacity = 0) %>%
  #addPolygons(data = waterbodies, weight = 1.5, fillOpacity = 0.8, fillColor = "lightblue") %>%
  addPolylines(data = MCW, color = "#FF0000", weight = 2, fillColor = NA)
print(MXmap)

