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

#Layer 7: soils
soils <- mx_read("spatial_data//vectors/Shp_files/soils")

#  pallette #
so <- c("AN", "BDS", "BLH", "BGT", "CWH", "CFT", "FBG",  "GAI", "HLM", "MET", "MEX", "MUS", "NPU", "ZZZ", "TF", "UR", "PKV", "QUC", "RUY", "SAL", "SNA", "STM", "SUF", "TCN", "TMI")
            
soC <- c("royalblue", "dodgerblue", "#FF0000", "#990000", "#CC6699",  "#66CCFF", "#003300", "#990000", "#FFCC66", "#CC3300", "#9966CC", "#FF66CC", "#669933", "#006600", "#339966", "#FF9933", "#66FFFF", "#6600CC", "#CC33CC", "#FF66FF", "#FF66FF", 
               "#FF3323",  "#330399", "#0033CC", "#6666FF")

# Render map #

SoilsMap <- leaflet() %>%
  addTiles(options = providerTileOptions(opacity = 1)) %>%
  addPolylines(data = MCW, color = "black", weight = 2, fillColor = NA) %>%
  addPolygons(data = islcoast, color = "black", weight = 1.5, fillOpacity = 0) %>%
  addPolygons(data = soils, color = "black", weight = 0.2, fillOpacity = 0.4, fillColor = ~soC) %>%
  addLegend(position="topright", labels = so, colors = soC)
print(SoilsMap)



