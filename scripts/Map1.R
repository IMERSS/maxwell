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

#Layer 6: bare earth raster 
hillshade <- raster("spatial_data/rasters/BareEarth_hillshade_resampled_5m.tif")

# New datasets #

watershed_arnoldcreek = subset(watersheds, watersheds$Name == "Arnold Creek")
watershed_bullockscreek = subset(watersheds, watersheds$Name == "Bullocks Creek")
watershed_cusheoncreek = subset(watersheds, watersheds$Name == "Cusheon Creek")
watershed_diffincreek = subset(watersheds, watersheds$Name == "Diffin Creek")
watershed_natural = subset(watersheds, watersheds$Name == "Direct - Natural")
watershed_storm = subset(watersheds, watersheds$Name == "Direct - Storm")
watershed_dowlingbrook = subset(watersheds, watersheds$Name == "Dowling Brook")
watershed_duckcreek = subset(watersheds, watersheds$Name == "Duck Creek")
watershed_fulfordcreek = subset(watersheds, watersheds$Name == "Fulford Creek")
watershed_gangescreek = subset(watersheds, watersheds$Name == "Ganges Creek")
watershed_geraldcreek = subset(watersheds, watersheds$Name == "Gerald Creek")
watershed_larlowcreek = subset(watersheds, watersheds$Name == "Larlow Creek")
watershed_macalpinebrook = subset(watersheds, watersheds$Name == "MacAlpine Brook")
watershed_mansellcreek = subset(watersheds, watersheds$Name == "Mansell Creek")
watershed_maxwellcreek = subset(watersheds, watersheds$Name == "Macwell Creek")
watershed_mcfaddencreek = subset(watersheds, watersheds$Name == "McFadden Creek")
watershed_montycreek = subset(watersheds, watersheds$Name == "Monty Creek")
watersheds$Name[is.na(watersheds$Name)] = 0
watershed_na = subset(watersheds, watersheds$Name == "0")
watershed_okanocreek = subset(watersheds, watersheds$Name == "Okano Creek")
watershed_oldlowthercreek = subset(watersheds, watersheds$Name == "Old Lowther Creek")
watershed_sharpecreek = subset(watersheds, watersheds$Name == "Sharpe Creek")
watershed_soulecreek = subset(watersheds, watersheds$Name == "Soule Creek")
watershed_stowellcreek = subset(watersheds, watersheds$Name == "Stowell Creek")
watershed_trenchcreek = subset(watersheds, watersheds$Name == "Trench Creek")
watershed_unnamed = subset(watersheds, watersheds$Name == "Unnamed")
watershed_walkerbrook = subset(watersheds, watersheds$Name == "Walker Brook")
watershed_westoncreek = subset(watersheds, watersheds$Name == "Weston Creek")
watershed_xwaaqwum = subset(watersheds, watersheds$Name == "Xwaaqw'um")
 
# Hillshade pallette #

pal <- colorNumeric(c("#0C2C84", "#41B6C4", "#FFFFCC"), values(hillshade),
                    na.color = "transparent")

# Render map #

WatershedsMap <- leaflet() %>%
  addTiles(options = providerTileOptions(opacity = 1)) %>%
  addRasterImage(hillshade, colors = pal, opacity = 0.8) %>%
  addPolygons(data = islcoast, color = "black", weight = 1.5, fillOpacity = 0) %>%
  addPolylines(data = watercourses, weight = 1.5, fillOpacity = 0.8, fillColor = "royalblue") %>%
  addPolygons(data = waterbodies, weight = 1.5, fillOpacity = 0.8, fillColor = "dodgerblue") %>%
  addPolygons(data = watershed_arnoldcreek, weight = 0, fillOpacity = 0.3, fillColor = "#FF0000") %>%
  addPolygons(data = watershed_bullockscreek, weight = 0, fillOpacity = 0.3, fillColor = "#990000") %>%
  addPolygons(data = watershed_cusheoncreek, weight = 0, fillOpacity = 0.3, fillColor = "#CC6699") %>%
  addPolygons(data = watershed_diffincreek, weight = 0, fillOpacity = 0.3, fillColor = "#66CCFF") %>%
  addPolygons(data = watershed_natural, weight = 0, fillOpacity = 0.3, fillColor = "#003300") %>%
  addPolygons(data = watershed_storm, weight = 0, fillOpacity = 0.3, fillColor = "#990000") %>%
  addPolygons(data = watershed_dowlingbrook, weight = 0, fillOpacity = 0.3, fillColor = "#FFCC66") %>%
  addPolygons(data = watershed_duckcreek, weight = 0, fillOpacity = 0.3, fillColor = "#CC3300") %>%
  addPolygons(data = watershed_fulfordcreek, weight = 0, fillOpacity = 0.6, fillColor = "#9966CC") %>%
  addPolygons(data = watershed_gangescreek, weight = 0, fillOpacity = 0.3, fillColor = "#FF66CC") %>%
  addPolygons(data = watershed_geraldcreek, weight = 0, fillOpacity = 0.3, fillColor = "#669933") %>%
  addPolygons(data = watershed_larlowcreek, weight = 0, fillOpacity = 0.3, fillColor = "#006600") %>%
  addPolygons(data = watershed_macalpinebrook, weight = 0, fillOpacity = 0.3, fillColor = "#339966") %>%
  addPolygons(data = watershed_mansellcreek, weight = 0, fillOpacity = 0.3, fillColor = "#FF9933") %>%
  addPolygons(data = watershed_arnoldcreek, weight = 0, fillOpacity = 0.3, fillColor = "#66FFFF") %>%
  addPolygons(data = watershed_mcfaddencreek, weight = 0, fillOpacity = 0.3, fillColor = "#6600CC") %>%
  addPolygons(data = watershed_montycreek, weight = 0, fillOpacity = 0.3, fillColor = "#3399FF") %>%
  addPolygons(data = watershed_na, weight = 0, fillOpacity = 0.3, fillColor = "#0066CC") %>%
  addPolygons(data = watershed_okanocreek, weight = 0, fillOpacity = 0.3, fillColor = "#003366") %>%
  addPolygons(data = watershed_oldlowthercreek, weight = 0, fillOpacity = 0.3, fillColor = "#333399") %>%
  addPolygons(data = watershed_sharpecreek, weight = 0, fillOpacity = 0.3, fillColor = "#6666FF") %>%
  addPolygons(data = watershed_soulecreek, weight = 0, fillOpacity = 0.3, fillColor = "#666699") %>%
  addPolygons(data = watershed_stowellcreek, weight = 0, fillOpacity = 0.3, fillColor = "#0033CC") %>%
  addPolygons(data = watershed_trenchcreek, weight = 0, fillOpacity = 0.3, fillColor = "#330399") %>%
  addPolygons(data = watershed_unnamed, weight = 0, fillOpacity = 0.3, fillColor = "#FF3323") %>%
  addPolygons(data = watershed_walkerbrook, weight = 0, fillOpacity = 0.3, fillColor = "#003333") %>%
  addPolygons(data = watershed_westoncreek, weight = 0, fillOpacity = 0.3, fillColor = "#FF66FF") %>%
  addPolygons(data = watershed_xwaaqwum, weight = 0, fillOpacity = 0.3, fillColor = "#CC33CC") %>%
  addPolylines(data = watersheds, color = "black", weight = 0.5) %>%
  addPolylines(data = MCW, color = "#FF0000", weight = 2, fillColor = NA) %>%
print(WatershedsMap)

