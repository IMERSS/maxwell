##Historic fires ggplot
library(sf)
library(ggplot2)

#Layer 1: island coastline
islcoast <- st_read("spatial_data/vectors/Shp_files/Island")

#Layer 2: MCW
MCW <- st_read("spatial_data/vectors/Shp_files/MCW")

#Layer #3: historic fires
h_fires <- st_read("spatial_data/vectors/Shp_files/Historic_fires")

#Layer 4: CAD_MCW
CAD_MCW <- st_read("spatial_data/vectors/Shp_files/MXCK_CAD_clipped_MXCW")

##Mapping based on fire year: 
#changing FIRE_YEAR numeric attribute to character:
h_fires$FIRE_YEAR <- as.character(h_fires$FIRE_YEAR)

#Map clipped to MXCW:
ggplot() +
  geom_sf(data = islcoast, color ="black", fill = "beige") +
  geom_sf(data = h_fires, mapping = aes(fill = FIRE_YEAR)) +
  geom_sf_text(data = h_fires, aes(label = FIRE_YEAR), check_overlap = TRUE) + 
  geom_sf(data = MCW, color = "royalblue4", fill = "NA") +
  geom_sf(data = CAD_MCW$geometry, fill = "NA") +
  coord_sf(xlim = c(457989.4, 463653.3), ylim = c(5405057, 5411462), expand = FALSE) +
  ggtitle("Fire History Reference Map")
