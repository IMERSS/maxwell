##Historic fires ggplot
library(sf)
library(ggplot2)
library(rgdal)
library(leaflet)

lat_lon <- function (data) {
  return(st_transform(data, "+proj=longlat +datum=WGS84"))
}

#Layer 1: island coastline
# islcoast <- st_read("spatial_data/vectors/Shp_files/Island", quiet = TRUE)

#Layer 2: MCW
MCW <- st_read("spatial_data/vectors/Shp_files/MCW", quiet = TRUE)

# drop Z and M dimensions from MCW
MCW <- st_zm(MCW, drop = T, what = "ZM")

#Layer #3: historic fires
h_fires <- st_read("spatial_data/vectors/Shp_files/Historic_fires", quiet = TRUE)

##Mapping based on fire year: 
#changing FIRE_YEAR numeric attribute to character:
h_fires$FIRE_YEAR <- as.character(h_fires$FIRE_YEAR)

#sf coordinates at centroid
Coord_h_fires <- lat_lon(h_fires)
sf::st_coordinates(st_centroid(Coord_h_fires$geometry))

#Map clipped to MXCW:
p <- ggplot() +
  geom_sf(data = islcoast, color ="black", fill = "beige") +
  geom_sf(data = h_fires, mapping = aes(fill = FIRE_YEAR)) +
  geom_sf(data = MCW, color = "royalblue4", fill = "NA") +
  geom_sf_text(data = h_fires, aes(label = FIRE_YEAR), check_overlap = TRUE) +
  theme(legend.position = "none") +
  coord_sf(xlim = c(457989.4, 463653.3), ylim = c(5405057, 5411462), expand = FALSE) +
  ggtitle("Fire History Reference Map")

print(p)


##Leaflet map: 

FirehistMap <- leaflet() %>%
  addTiles(options = providerTileOptions(opacity = 0.5)) %>%
  addPolygons(data = lat_lon(islcoast), color = "black", weight = 1.5, fillOpacity = 0, fillColor = NA) %>%
  addPolygons(data = lat_lon(h_fires), color = "#050505", weight = 2, fillOpacity = 0.7, fillColor = "red") %>%
  addPolygons(data = lat_lon(MCW), color = "blue", weight = 2, fillOpacity = 0) %>%
  addLabelOnlyMarkers(data = lat_lon(h_fires), lng = -123.5670, lat = 48.84805, label = "1934", labelOptions = labelOptions(noHide = TRUE, direction = 'middle', textOnly = TRUE)) %>%
  addLabelOnlyMarkers(data = lat_lon(h_fires), lng = -123.5519, lat = 48.85045, label = "1935", labelOptions = labelOptions(noHide = TRUE, direction = 'middle', textOnly = TRUE)) %>%
  addLabelOnlyMarkers(data = lat_lon(h_fires), lng = -123.5230, lat = 48.82397 , label = "1935", labelOptions = labelOptions(noHide = TRUE, direction = 'middle', textOnly = TRUE)) %>%
  addLabelOnlyMarkers(data = lat_lon(h_fires), lng = -123.5207, lat = 48.81398, label = "1942", labelOptions = labelOptions(noHide = TRUE, direction = 'middle', textOnly = TRUE)) %>%
  fitBounds(-123.564, 48.802, -123.516, 48.855) %>%
  addLegend(position = "topright", labels = "Fire Years", colors = "red")

print(FirehistMap)
