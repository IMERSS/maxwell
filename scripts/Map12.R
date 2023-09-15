# Vegetation resource Inventory #

library(sf)
library(leaflet)
library(raster)
library(RColorBrewer)

source("scripts/utils.R")

#Layer 1: island coast
islcoast <- mx_read("spatial_data/vectors/Shp_files/Island")

#Layer 2: MCW
MCW <- mx_read("spatial_data/vectors/Shp_files/MCW")

#Layer 3: VRI 
VRI <- mx_read("spatial_data/vectors/Shp_files/VRI/VRI_MCW.shp")

VRIpal <- colorFactor("spectral", VRI$OBJECTID)
# Render map #

VRIMap <- leaflet() %>%
  addTiles(options = providerTileOptions(opacity = 1)) %>%
  fitBounds(-123.564, 48.802, -123.516, 48.855) %>%
  addPolygons(data = islcoast, color = "black", weight = 1.5, fillOpacity = 0) %>%
  addPolylines(data = MCW, color = "#FF0000", weight = 2, fillColor = NA) %>%
  addPolygons(data = VRI, color = "black", weight = 1.5, fillOpacity = 0.2, fillColor = ~VRIpal) %>%

print(VRIMap)

