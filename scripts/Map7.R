##Bare Earth

library(sf)
library(leaflet)
library(dplyr)
library(RColorBrewer)
library(raster)
library(rgdal)

source("scripts/utils.R")

#Layer 1: island coast
islcoast <- mx_read("spatial_data/vectors/Shp_files/Island")

#Layer 2: MCW
MCW <- mx_read("spatial_data/vectors/Shp_files/MCW")

#Layer 3: bare earth raster 
hillshade <- raster("spatial_data/rasters/BareEarth_hillshade_resampled_5m.tif")

# Crop and pallette #

pal <- colorNumeric(c(pale ="Greys"), values(hillshade), na.color = "transparent")

# Trying to mask #

# rs(islcoast)
# crs(hillshade) +proj=utm +zone=10 +ellps=GRS80 +units=m +no_defs 
# crs(MCW)
# st_crs(hillshade)
# new_crs <- st_crs('+proj=utm +zone=10 +ellps=GRS80 +units=m +no_defs')
# MCW_new <- st_transform(MCW, new_crs)
# hillshade_cropped <- crop(hillshade, extent(MCW_new))

# crs(hillshade)<- CRS('+proj=longlat +datum=WGS84 +no_defs')
# crs(MCW) <- CRS('+proj=longlat +datum=WGS84 +no_defs')
# crs(islcoast) <- CRS('+proj=longlat +datum=WGS84 +no_defs')


# Map #

EarthMap <- leaflet() %>%
  addPolygons(data = islcoast, color = "black", weight = 1.5, fillOpacity = 0, fillColor = NA) %>%
  addTiles(options = providerTileOptions(opacity = 0.5)) %>%
  addProviderTiles('Esri.WorldImagery') %>% 
  addRasterImage(hillshade, colors = pal, opacity = 0.8) %>%
  addPolygons(data = MCW, color = "red", weight = 2, fillOpacity = 0) %>%
print(EarthMap)

