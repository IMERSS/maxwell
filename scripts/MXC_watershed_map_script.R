library(sf)
library(ggplot2)
library(leaflet)
library(rgdal)

lat_lon <- function (data) {
  return(st_transform(data, "+proj=longlat +datum=WGS84"))
}

#Layer 1: island coast
islcoast <- st_read("spatial_data/vectors/Shp_files/Island", quiet=TRUE)

#layer 2: CAD_MCW
CAD_MCW <- st_read("spatial_data/vectors/Shp_files/MXCK_CAD_clipped_MXCW", quiet=TRUE)

#Layer 3: MCW
MCW <- st_read("spatial_data/vectors/Shp_files/MCW", quiet=TRUE)

#Layer 4: waterbodies 
waterbodies <- st_read("spatial_data/vectors/Shp_files/RAR_water_bodies", quiet=TRUE)

#Layer 5: watercourses
watercourses <- st_read("spatial_data/vectors/Shp_files/RAR_water_courses", quiet=TRUE)

#Layer 6: watersheds
watersheds <- st_read("spatial_data/vectors/Shp_files/Watershed_CRD", quiet=TRUE)

#Mapping using ggplot2:

p <- ggplot() +
  geom_sf(data = islcoast, color ="black", fill = "beige") +
  geom_sf(data = MCW, color = "black", fill = NA) +
  geom_sf(data = CAD_MCW, fill = NA) +
  geom_sf(data = watersheds, color = "blue2", fill = "NA") +
  geom_sf(data = waterbodies, color = "dodgerblue1", fill = "dodgerblue1") +
  geom_sf(data = watercourses, color = "royalblue4", fill = "royalblue4") +
  coord_sf(xlim = c(457989.4, 463653.3), ylim = c(5405057, 5411462), expand = FALSE) +
  ggtitle("Maxwell Creek Watershed Map")

print(p)

#Leaflet map:

WatershedMap <- leaflet() %>%
  addTiles(options = providerTileOptions(opacity = 0.5)) %>%
  addPolygons(data = lat_lon(islcoast), color = "black", weight = 1.5, fillOpacity = 0) %>%
#  addPolygons(data = lat_lon(MCW), color = "black", weight = 1.5, fillColor = NA) %>%
#  addPolygons(data = lat_lon(CAD_MCW), color = "black", weight = 1.5, fillOpacity = 0.8) %>%
#  addPolylines(data = lat_lon(watersheds), color = "#0000EE", weight = 2) %>%
  addPolygons(data = lat_lon(watercourses), weight = 1.5, fillOpacity = 0.8, fillColor = "royalblue") %>%
  addPolygons(data = lat_lon(waterbodies), weight = 1.5, fillOpacity = 0.8, fillColor = "dodgerblue")  
  
print(WatershedMap)