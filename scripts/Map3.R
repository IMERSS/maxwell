## Project outline

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

#Layer 4: watercourses
watercourses <- mx_read("spatial_data/vectors/Shp_files/RAR_water_courses")

#Layer 5: watersheds
watersheds <- mx_read("spatial_data/vectors/Shp_files/Watershed_CRD")


# Render map #

ProjectMap <- leaflet() %>%
  addTiles(options = providerTileOptions(opacity = 1)) %>%
  addProviderTiles('Esri.WorldImagery') %>% 
  fitBounds(-123.564, 48.802, -123.516, 48.855) %>%
  addPolygons(data = islcoast, color = "black", weight = 1.5, fillOpacity = 0) %>%
  addPolygons(data = waterbodies, weight = 1.5, fillOpacity = 0.8, fillColor = "dodgerblue") %>%
  addPolylines(data = MCW, color = "#FF0000", weight = 2, fillColor = NA) %>%
  addCircles(lng = -123.5275413, lat = 48.8201072, color = "magenta", weight = 1, radius = 950, popup = MCW)
print(ProjectMap)

