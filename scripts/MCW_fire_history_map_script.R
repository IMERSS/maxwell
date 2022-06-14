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

fire_20s <- c("1929", "1929", "1929", "1929", "1929", "1927", "1920", "1925", "1926", "1923", "1922", "1922", "1929", "1922", "1922", "1924")
fire_30s <- c("1934", "1938", "1936", "1936", "1930", "1935", "1935")

ggplot() +
  geom_sf(data = islcoast, color = "black", fill = "NA") +
  geom_sf(data = h_fires, mapping = aes(fill = FIRE_YEAR)) +
  geom_sf(data = MCW, color = "royalblue4", fill = "NA") +
  coord_sf()

##Mapping based on fire cause (clipped to CAD_MCW):

ggplot() +
  geom_sf(data = h_fires, mapping = aes(fill = FIRE_CAUSE)) +
  scale_fill_manual(values = c("yellow", "darkred")) +
  geom_sf(data = MCW, color = "royalblue4", fill = "NA") +
  geom_sf(data = CAD_MCW$geometry, fill = "NA") +
  coord_sf(xlim = c(457989.4, 463653.3), ylim = c(5405057, 5411462), expand = FALSE)

