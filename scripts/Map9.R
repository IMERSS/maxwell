#CHM#

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

#Layer 3: CHM
# chm <- raster("spatial_data/rasters/CHM_2m.tif")


# Pal #

# pal <- colorNumeric(c("#0C2C84", "#41B6C4", "#FFFFCC"), values(chm),
                    na.color = "transparent")

# Map #

chmMap <- leaflet() %>%
  addPolygons(data = islcoast, color = "black", weight = 1.5, fillOpacity = 0, fillColor = NA) %>%
  addTiles(options = providerTileOptions(opacity = 0.5)) %>%
  fitBounds(-123.564, 48.802, -123.516, 48.855) %>%
  addPolylines(data = MCW, weight = 1.5, fillOpacity = 0.8, fillColor = "red") %>%
  # addRasterImage(chm, colors = pal, opacity = 0.8) %>%
  addPolylines(data = MCW, color = "red", weight = 2, fillColor = NA) %>%
  
  print(chmMap)

