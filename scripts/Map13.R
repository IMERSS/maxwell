# Historic fires #

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

#Layer 7: historic fires
historic_fires <- mx_read("spatial_data/vectors/Shp_files/Historic_fires")

# New datasets #

a = subset(historic_fires, historic_fires$FIRE_NO == "154")
b = subset(historic_fires, historic_fires$FIRE_NO == "363")
c = subset(historic_fires, historic_fires$FIRE_NO == "388")

d = subset(historic_fires, historic_fires$FIRE_NO == "377")

# Legend # 

fires <- c("1934", "1935", "1935", "1942")
firesColors = c("#FF9933", "#003366", "maroon", "#003300")

firesPalette <- colorFactor(firesColors, fires)

# Render Map #

FiresMap <- leaflet() %>%
  addPolygons(data = islcoast, color = "black", weight = 1.5, fillOpacity = 0, fillColor = NA) %>%
  addTiles(options = providerTileOptions(opacity = 0.5)) %>%
  addProviderTiles('Esri.WorldImagery') %>% 
  fitBounds(-123.564, 48.802, -123.516, 48.855) %>%
  addPolygons(data = a, weight = 0, fillOpacity = 0.7, fillColor = "#FF9933") %>%
  addPolygons(data = b, weight = 0, fillOpacity = 0.7, fillColor = "#003366") %>%
  addPolygons(data = c, weight = 0, fillOpacity = 0.7, fillColor = "maroon") %>%
  addPolygons(data = d, weight = 0, fillOpacity = 0.7, fillColor = "#003300") %>%
  addPolylines(data = MCW, color = "red", weight = 2, fillColor = NA) %>%
  addLegend(position="topright", labels = fires, colors = firesColors)

  print(FiresMap)




