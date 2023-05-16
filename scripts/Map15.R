# Soils #

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

#Layer 7: soils
soils <- mx_read("spatial_data//vectors/Shp_files/soils")

#  pallette #

soils <- c(“$AN”, “BDS”, “BLH”, “BGT”, “CWH”, “CFT”, “FBG”,  “GAI”, “HLM”, “MET”, “MEX”, “MUS”, “NPU”, “ZZZ”, “$TF”, “$UR”, “PKV”, “QUC”, “RUY”, “SAL”, “SNA”, “STM”, “SUF”, “TCN”, “TMI")"
soilColors = c("royalblue”,"dodgerblue”, "#FF0000”, "#990000”, "#CC6699”,  "#66CCFF”, "#003300”, "#990000”, "#FFCC66”, "#CC3300”, "#9966CC”, "#FF66CC”, "#669933”, "#006600”, "#339966”, "#FF9933”, "#66FFFF”, "#6600CC”, "#CC33CC”, "#FF66FF”, "#FF66FF”, 
               "#FF3323”,  "#330399”, “#0033CC”, "#6666FF")

jurisPalette <- colorFactor(jurisColors, juris)
# Render map #

WatershedMap <- leaflet() %>%
  addTiles(options = providerTileOptions(opacity = 1)) %>%
  addRasterImage(soils, colors = pal, opacity = 0.5) %>%
  addPolygons(data = islcoast, color = "black", weight = 1.5, fillOpacity = 0) %>%
  addPolygons(data = CAD_MCW, color = "black", weight = 1.5, fillOpacity = 0.8, fillColor = ~jurisPalette(LABEL)) %>%
  print(WatershedMap)



