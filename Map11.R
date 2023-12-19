## Texada

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

#Layer 4: texada
texada <- mx_read("spatial_data/rasters/texada_harvesting_resampled.tif")

# Render map #

Texadamap <- leaflet() %>%
  addTiles(options = providerTileOptions(opacity = 1)) %>%
  fitBounds(-123.564, 48.802, -123.516, 48.855) %>%
  addProviderTiles('Esri.WorldImagery') %>% 
  addRasterImage(texada, colors = , opacity = 0.8) %>%
  addPolygons(data = islcoast, color = "black", weight = 1.5, fillOpacity = 0) %>%
  #addPolygons(data = waterbodies, weight = 1.5, fillOpacity = 0.8, fillColor = "lightblue") %>%
  addPolylines(data = MCW, color = "#FF0000", weight = 2, fillColor = NA)
print(Texadamap)

