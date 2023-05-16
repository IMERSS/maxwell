# Geology #

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

#Layer 3: water bodies 
waterbodies <- mx_read("spatial_data/vectors/Shp_files/RAR_water_bodies")

#Layer 4: watercourses
watercourses <- mx_read("spatial_data/vectors/Shp_files/RAR_water_courses")

#Layer 5: bare earth raster 
hillshade <- raster("spatial_data/rasters/BareEarth_hillshade_resampled_5m.tif")

#Layer 6: streams
streams <- mx_read("spatial_data/vectors/Shp_files/Streams")

#Layer 7: MXCK_CAD_clipped
MXCKCADCLIPPED <- mx_read("spatial_data/vectors/Shp_files/MXCK_CAD_clipped_MXCW")

#layer 4: geology
geology <- mx_read("spatial_data/vectors/Shp_files/Geology")

# New datasets #
KB = subset(geology, geology$Name == "KB")
KEc = subset(geology, geology$Name == "KEc")
KEs = subset(geology, geology$Name == "KEs")
KH = subset(geology, geology$Name == "KH")
DMg = subset(geology, geology$Name == "DMg")
DN = subset(geology, geology$Name == "DN")
TrMg = subset(geology, geology$Name == "TrMg")
KC = subset(geology, geology$Name == "KC")
Dg = subset(geology, geology$Name == "Dg")

# Legeng #

geology <- c("KB", "KEc", "KEs", "KH", "DMg", "DN", "TrMg", "KC", "Dg")
geologyColors = c("#FFCC66", "#9996FF", "#FF9933", "#FF66CC","#66CCFF","#990000", "#666699", "#66FFFF", "#669933")

geologyPalette <- colorFactor(geologyColors, geology)

# Render Map #

GeologyMap <- leaflet() %>%
  addPolygons(data = islcoast, color = "black", weight = 1.5, fillOpacity = 0, fillColor = NA) %>%
  addTiles(options = providerTileOptions(opacity = 0.5)) %>%
  addProviderTiles('Esri.WorldImagery') %>% 
  fitBounds(-123.564, 48.802, -123.516, 48.855) %>%
  addPolygons(data = KB, weight = 0, fillOpacity = 0.7, fillColor = "#FFCC66") %>%
  addPolygons(data = KEc, weight = 0, fillOpacity = 0.7, fillColor = "#9996FF") %>%
  addPolygons(data = KEs, weight = 0, fillOpacity = 0.7, fillColor = "#FF9933") %>%
  addPolygons(data = KH, weight = 0, fillOpacity = 0.7, fillColor = "#FF66CC") %>%
  addPolygons(data = DMg, weight = 0, fillOpacity = 0.7, fillColor = "#66CCFF") %>%
  addPolygons(data = DN, weight = 0, fillOpacity = 0.7, fillColor = "#990000") %>%
  addPolygons(data = TrMg, weight = 0, fillOpacity = 0.7, fillColor = "#666699") %>%
  addPolygons(data = KC, weight = 0, fillOpacity = 0.7, fillColor = "#66FFFF") %>%
  addPolygons(data = Dg, weight = 0, fillOpacity = 0.7, fillColor = "#669933") %>%
  addPolylines(data = MCW, color = "red", weight = 2, fillColor = NA) %>%
  addLegend(position="topright", labels = geology, colors = geologyColors)
print(GeologyMap)

