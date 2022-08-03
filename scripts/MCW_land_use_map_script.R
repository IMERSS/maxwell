library(sf)
library(leaflet)
library(rgdal)
library(dplyr)

lat_lon <- function (data) {
  return(st_transform(data, "+proj=longlat +datum=WGS84"))
}

#Layer 2: CAD_MCW
CAD_MCW <- st_read("spatial_data/vectors/Shp_files/MXCK_CAD_clipped_MXCW", quiet=TRUE)

#Layer 2: Protected Areas (clipped to MCW)
PA_MCW <- st_read("spatial_data/vectors/Shp_files/IT_protected_areas_clipped", quiet=TRUE)

#Layer 3: Logging roads and trails
Lroads <- st_read("spatial_data/vectors/Shp_files/Logging_roads_trails", quiet=TRUE)

Trails <- Lroads %>%
  filter(Lroads$Type == "trail")
nrow(Trails)

Roads <- Lroads %>%
  filter(Lroads$Type == "road")
nrow(Roads)

#Layer 4: Historic fires
h_fires <- st_read("spatial_data/vectors/Shp_files/Historic_fires", quiet=TRUE)

landUseMap <- leaflet() %>%
    addTiles(options = providerTileOptions(opacity = 0.5)) %>%
    addPolygons(data = lat_lon(CAD_MCW), color = "black", weight = 2, fillOpacity = 0) %>%
    addPolygons(data = lat_lon(h_fires), color = "#050505", weight = 2, fillOpacity = 0.7, fillColor = "red") %>%
    addPolylines(data = lat_lon(Trails), color = "green", weight = 4) %>%
    addPolylines(data = lat_lon(Roads), color = "orange", weight = 4) %>%
    fitBounds(-123.564, 48.802, -123.516, 48.855) %>%
    addLegend(position="topright", labels = c("Trails", "Logging Roads", "Historic fires"), colors = c("green", "orange", "red"))

#Note that this statement is only effective in standalone R
print(landUseMap)

