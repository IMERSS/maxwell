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

# Adding circle #

center <- c(488179305, -123.529860)
radius <- 200
# setView(lng = center[2], lat = center[1], zoom = 13) %>%
#  addCircles(lng = 488179305, lat = -123.529860, weight = 1, radius = 50) %>%


# Render map #

ProjectMap <- leaflet() %>%
  addTiles(options = providerTileOptions(opacity = 1)) %>%
  fitBounds(-123.564, 48.802, -123.516, 48.855) %>%
  addCircles(lng = 488179305, lat = -123.529860, radius = 50, color = "black") %>%
  addPolygons(data = islcoast, color = "black", weight = 1.5, fillOpacity = 0) %>%
  addPolygons(data = waterbodies, weight = 1.5, fillOpacity = 0.8, fillColor = "dodgerblue") %>%
  addPolylines(data = MCW, color = "#FF0000", weight = 2, fillColor = NA)
print(ProjectMap)

