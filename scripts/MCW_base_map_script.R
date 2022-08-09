##Island Base map:
library(sf)
library(leaflet)
library(rgdal)
library(dplyr)

lat_lon <- function (data) {
  return(st_transform(data, "+proj=longlat +datum=WGS84"))
}

#Layer 1: island coastline
islcoast <- st_read("spatial_data/vectors/Shp_files/Island", quiet=TRUE)

#Layer 2: MCW
MCW <- st_read("spatial_data/vectors/Shp_files/MCW", quiet=TRUE)

# drop Z and M dimensions from MCW
MCW <- st_zm(MCW, drop = T, what = "ZM")

# p <- ggplot() +
#   geom_sf(data = islcoast, color = "black") + 
#   geom_sf(data = MCW, fill = "blue") +
#   geom_sf(data = CAD_MCW, color = "red") + 
#   coord_sf() +
#   ggtitle("Base Map of Maxwell Creek Watershed")
#   
# print(p)

baseMap <- leaflet() %>%
  addTiles(options = providerTileOptions(opacity = 0.5)) %>%
  addPolygons(data = lat_lon(MCW), color = "blue", weight = 2, fillOpacity = 0) %>%
  fitBounds(-123.564, 48.802, -123.516, 48.855)

print(baseMap)
