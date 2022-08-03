##Mapping ggplot with spatial extent restricted to MXCW:

library(sf)
library(leaflet)
library(rgdal)
library(dplyr)

lat_lon <- function (data) {
  return(st_transform(data, "+proj=longlat +datum=WGS84"))
}

#Layer 1: island coastline
islcoast <- st_read("spatial_data/vectors/Shp_files/Island", quiet=TRUE)

#Layer 2: watersheds
watersheds <- st_read("spatial_data/vectors/Shp_files/Watershed_CRD", quiet=TRUE)

#Layer 3: CAD
CAD <- st_read("spatial_data/vectors/Shp_files/MXCK_CAD", quiet=TRUE)

#Layer 4: MCW
MCW <- st_read("spatial_data/vectors/Shp_files/MCW", quiet=TRUE)

#Layer 5: Protected areas clipped to MCW
PA_MCW <- st_read("spatial_data/vectors/Shp_files/IT_protected_areas_clipped", quiet=TRUE)
names(PA_MCW) #use "DISTRIB" attribute to show private vs public landownership

#Layer 6: Protected Areas (SSI)
PA <- st_read("spatial_data/vectors/Shp_files/IT_protected_areas_2022-05", quiet=TRUE)
names(PA) # use "DISTRIB" attribute to show private vs public land-ownership

#Layer 7: Roads
roads <- st_read("spatial_data/vectors/Shp_files/DataBC_roads", quiet=TRUE)

#Layer 8: waterbodies 
waterbodies <- st_read("spatial_data/vectors/Shp_files/RAR_water_bodies", quiet=TRUE)

#Layer 9: watercourses
watercourses <- st_read("spatial_data/vectors/Shp_files/RAR_water_courses", quiet=TRUE)
#CAD values = xmin: 458858.3 ymin: 5406257 xmax: 463151.3 ymax: 5411194

#Layer 10: CAD_MCW
CAD_MCW <- st_read("spatial_data/vectors/Shp_files/MXCK_CAD_clipped_MXCW", quiet=TRUE)
names(CAD_MCW) #use "LABEL" attribute to show landowner jurisdictions
CAD_MCW$LABEL[CAD_MCW$LABEL == "NSSWD"] <- "North Salt Spring Waterworks District"

#Layer 11: Protected areas (PA) clipped to MCW area
PA_MCW <- st_read("spatial_data/vectors/Shp_files/IT_protected_areas_clipped", quiet=TRUE)
names(PA_MCW) #use "DISTRIB" attribute to show private vs public landownership

#Mapping ggplot with spatial extent restricted to MXCW:
#CAD values = xmin: 458583 ymin: 5406080 xmax: 462136.9 ymax: 5411074
# p <- ggplot() +
#   geom_sf(data = islcoast, color = "black") +
#   geom_sf(data = CAD_MCW, mapping = aes(fill = LABEL)) +
#   geom_sf(data = PA_MCW, mapping = aes(fill = COV_HLD1)) +
#   geom_sf(data = roads, color = "grey") +
#   geom_sf(data = MCW, color = "black", fill = NA) +
#   geom_sf(data = watersheds, color = "blue2", fill = NA) +
#   geom_sf(data = waterbodies, fill = "dodgerblue1") +
#   geom_sf(data = watercourses, fill = "royalblue3") +
#   scale_fill_manual(name = "Jurisdictions", breaks = c("Islands Trust Conservancy", "North Salt Spring Waterworks District", "Participating neighbours", "Private", "Salt Spring Island Local Trust Committee"), values = c("Islands Trust Conservancy" = "coral1", "North Salt Spring Waterworks District" = "mediumpurple", "Participating neighbours" = "palegreen", "Private" = "paleturquoise", "Salt Spring Island Local Trust Committee" = "orange")) +
#   coord_sf(xlim = c(458583, 462136.9), ylim = c(5406080, 5411074), expand = FALSE) +
#   ggtitle("Jurisdictional Reference Map")
# print(p)

juris <- c("Islands Trust Conservancy", "North Salt Spring Waterworks District", "Participating neighbours", "Private", "Salt Spring Island Local Trust Committee")
jurisColors = c("coral", "mediumpurple", "palegreen", "paleturquoise", "orange")

jurisPalette <- colorFactor(jurisColors, juris)

jurisMap <- leaflet() %>%
  addTiles(options = providerTileOptions(opacity = 0.5)) %>%
  addPolygons(data = lat_lon(CAD_MCW), color = "black", weight = 1.5, fillOpacity = 0.8, fillColor = ~jurisPalette(LABEL)) %>%
  addPolygons(data = lat_lon(PA_MCW), color = "black", weight = 1.5, fillOpacity = 0.8, fillColor = ~jurisPalette(COV_HLD1)) %>%
    # For some reason these three lines each give an "options" error even though we succeed in plotting "roads" in land use map
#  addPolylines(data = lat_lon(roads), color = "grey", weight = 4) %>%
#  addPolygons(data = lat_lon(MCW), color = "black", weight = 1.5, fillColor = NA) %>%
#  addPolylines(data = lat_lon(watersheds), color = "#0000EE", weight = 2) %>%
    addPolygons(data = lat_lon(waterbodies), weight = 1.5, fillOpacity = 0.8, fillColor = "dodgerblue") %>%
    # "watercourses generates 20MB of GeoJSON data we, need to filter this dataset - is it even necessary given our basemap?  
#  addPolygons(data = lat_lon(watercourses), weight = 1.5, fillOpacity = 0.8, fillColor = "royalblue") %>%
  fitBounds(-123.564, 48.802, -123.516, 48.855) %>%
  addLegend(position="topright", labels = juris, colors = jurisColors)

print(jurisMap)
