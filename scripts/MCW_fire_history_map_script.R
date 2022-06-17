##Historic fires ggplot
library(sf)
library(ggplot2)

#Layer 1: island coastline
islcoast <- st_read("spatial_data/vector/Shp_files/Island")

#Layer 2: MCW
MCW <- st_read("spatial_data/vectors/Shp_files/MCW")

#Layer #3: historic fires
h_fires <- st_read("spatial_data/vectors/Shp_files/Historic_fires")

##Mapping based on fire year: 
#changing FIRE_YEAR numeric attribute to character:
h_fires$FIRE_YEAR <- as.character(h_fires$FIRE_YEAR)

ggplot() +
  geom_sf(data = islcoast, color ="black", fill = "NA") +
  geom_sf(data = h_fires, mapping = aes(fill = FIRE_YEAR), fill = "red") +
  geom_sf_text(data = h_fires, aes(label = FIRE_YEAR),check_overlap = TRUE) + 
  geom_sf(data = MCW, color = "royalblue4", fill = "NA") +
  ggtitle("Fire History Reference Map")
coord_sf()

#Map clipped to MXCW:
ggplot() +
  geom_sf(data = h_fires, mapping = aes(fill = FIRE_YEAR)) +
  scale_fill_gradient(low = "red", high = "orange") +
  geom_sf_text(data = h_fires, aes(label = FIRE_YEAR), check_overlap = TRUE) + 
  geom_sf(data = MCW, color = "royalblue4", fill = "NA") +
  geom_sf(data = CAD_MCW$geometry, fill = "NA") +
  coord_sf(xlim = c(457989.4, 463653.3), ylim = c(5405057, 5411462), expand = FALSE)

