# Contours #

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

#Layer 7: contours
contours <- raster("spatial_data/rasters/14mcontours.tif")

# Hillshade pallette #

pal <- colorNumeric(c("transparent", "purple", "purple"), values(contours),
                    na.color = "transparent")

# Render map #

ContoursMap <- leaflet() %>%
  addTiles(options = providerTileOptions(opacity = 1)) %>%
  addProviderTiles('Esri.WorldImagery') %>% 
  addRasterImage(contours, colors = pal, opacity = 0.5) %>%
  addPolygons(data = islcoast, color = "black", weight = 1.5, fillOpacity = 0) %>%
  fitBounds(-123.564, 48.802, -123.516, 48.855) %>%
  print(ContoursMap)

