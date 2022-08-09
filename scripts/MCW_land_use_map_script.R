library(sf)
library(leaflet)
library(rgdal)
library(dplyr)

lat_lon <- function (data) {
  return(st_transform(data, "+proj=longlat +datum=WGS84"))
}


#Layer 1: island coastline
islcoast <- st_read("spatial_data/vectors/Shp_files/Island", quiet=TRUE)

#Layer 2: CAD_MCW
CAD_MCW <- st_read("spatial_data/vectors/Shp_files/MXCK_CAD_clipped_MXCW", quiet=TRUE)

#Layer 3: Protected Areas (clipped to MCW)
PA_MCW <- st_read("spatial_data/vectors/Shp_files/IT_protected_areas_clipped", quiet=TRUE)

#Layer 4: Logging roads and trails
Lroads <- st_read("spatial_data/vectors/Shp_files/Logging_roads_trails", quiet=TRUE)

# drop Z and M dimensions from Lroads 
Lroads <- st_zm(Lroads, drop = T, what = "ZM")

Trails <- Lroads %>%
  filter(Lroads$Type == "trail")
nrow(Trails)

Roads <- Lroads %>%
  filter(Lroads$Type == "road")
nrow(Roads)

landUseMap <- leaflet() %>%
    addTiles(options = providerTileOptions(opacity = 0.5)) %>%
    addPolygons(data = lat_lon(islcoast), color = "black", weight = 1.5, fillOpacity = 0, fillColor = NA) %>%
    addPolygons(data = lat_lon(CAD_MCW), color = "black", weight = 2, fillOpacity = 0) %>%
    addPolylines(data = lat_lon(Trails), color = "green", weight = 4) %>%
    addPolylines(data = lat_lon(Roads), color = "orange", weight = 4) %>%
    fitBounds(-123.564, 48.802, -123.516, 48.855) %>%
    addLegend(position="topright", labels = c("Trails", "Logging Roads"), colors = c("green", "orange"))

#Note that this statement is only effective in standalone R
print(landUseMap)

