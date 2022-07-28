##Mapping ggplot with spatial extent restricted to MXCW:

#Layer 1: island coastline
library(sf)
library(ggplot2)
islcoast <- st_read("spatial_data/vectors/Shp_files/Island")

#Layer 2: watersheds
watersheds <- st_read("spatial_data/vectors/Shp_files/Watershed_CRD")

#Layer 3: CAD
CAD <- st_read("spatial_data/vectors/Shp_files/MXCK_CAD")
Jurisdictions <-CAD$LAND_DISTR

#Layer 4: MCW
MCW <- st_read("spatial_data/vectors/Shp_files/MCW")

#Layer 5: Protected areas clipped to MCW
PA_MCW <- st_read("spatial_data/vectors/Shp_files/IT_protected_areas_clipped")
names(PA_MCW) #use "DISTRIB" attribute to show private vs public landownership

#Layer 6: Protected Areas (SSI)
PA <- st_read("spatial_data/vectors/Shp_files/IT_protected_areas_2022-05")
names(PA) # use "DISTRIB" attribute to show private vs public land-ownership

#Layer 7: Roads
roads <- st_read("spatial_data/vectors/Shp_files/DataBC_roads")

#Layer 8: waterbodies 
waterbodies <- st_read("spatial_data/vectors/Shp_files/RAR_water_bodies")

#Layer 9: watercourses
watercourses <- st_read("spatial_data/vectors/Shp_files/RAR_water_courses")
#CAD values = xmin: 458858.3 ymin: 5406257 xmax: 463151.3 ymax: 5411194

#Layer 10: CAD_MCW
CAD_MCW <- st_read("spatial_data/vectors/Shp_files/MXCK_CAD_clipped_MXCW")
names(CAD_MCW) #use "LABEL" attribute to show landowner jurisdictions

#Mapping ggplot with spatial extent restricted to MXCW:
#CAD values = xmin: 458858.3 ymin: 5406257 xmax: 463151.3 ymax: 5411194
p <- ggplot() +
  geom_sf(data = islcoast, color = "black") +
  geom_sf(data = CAD, mapping = aes(fill = Jurisdictions)) +
  geom_sf(data = CAD_MCW, mapping = aes(fill = LABEL)) +
  geom_sf(data = roads, color = "grey") +
  geom_sf(data = MCW, color = "black", fill = NA) +
  geom_sf(data = watersheds, color = "blue2", fill = NA) +
  geom_sf(data = waterbodies, fill = "dodgerblue1") +
  geom_sf(data = watercourses, fill = "royalblue3") +
  coord_sf(xlim = c(457989.4, 463653.3), ylim = c(5405057, 5411462), expand = FALSE) +
  ggtitle("Jurisdictional Reference Map 2")

print(p)
