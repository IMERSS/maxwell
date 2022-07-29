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

#Layer 11: Protected areas (PA) clipped to MCW area
PA_MCW <- st_read("spatial_data/vectors/Shp_files/IT_protected_areas_clipped")
names(PA_MCW) #use "DISTRIB" attribute to show private vs public landownership

#Mapping ggplot with spatial extent restricted to MXCW:
#CAD values = xmin: 458583 ymin: 5406080 xmax: 462136.9 ymax: 5411074
p <- ggplot() +
  geom_sf(data = islcoast, color = "black") +
  geom_sf(data = CAD_MCW, mapping = aes(fill = LABEL)) +
  geom_sf(data = PA_MCW, mapping = aes(fill = COV_HLD1)) +
  geom_sf(data = roads, color = "grey") +
  geom_sf(data = MCW, color = "black", fill = NA) +
  geom_sf(data = watersheds, color = "blue2", fill = NA) +
  geom_sf(data = waterbodies, fill = "dodgerblue1") +
  geom_sf(data = watercourses, fill = "royalblue3") +
  scale_fill_manual(name = "Jurisdictions", breaks = c("Islands Trust Conservancy", "North Salt Spring Waterworks District", "Participating neighbours", "Private", "Salt Spring Island Local Trust Committee"), values = c("Islands Trust Conservancy" = "coral1", "North Salt Spring Waterworks District" = "mediumpurple", "Participating neighbours" = "palegreen", "Private" = "paleturquoise", "Salt Spring Island Local Trust Committee" = "orange")) +
  coord_sf(xlim = c(458583, 462136.9), ylim = c(5406080, 5411074), expand = FALSE) +
  ggtitle("Jurisdictional Reference Map")

print(p)
