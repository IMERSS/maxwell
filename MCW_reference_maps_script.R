##Making reference maps using ggplot2:

#MAP 1: Overlapping jurisdictions:
#Layer 1: island coastline
library(sf)
library(ggplot2)
islcoast <- st_read("/Users/angeline.emmott/Documents/GitHub/maxwell-rstudio/spatial_data/vectors/Shp_files/Island")
names(islcoast) #use "area" attribute

#Layer 2: watersheds
watersheds <- st_read("/Users/angeline.emmott/Documents/GitHub/maxwell-rstudio/spatial_data/vectors/Shp_files/Watershed_CRD")
plot(watersheds)
names(watersheds)

#Layer 3: CAD
CAD <- st_read("/Users/angeline.emmott/Documents/GitHub/maxwell-rstudio/spatial_data/vectors/Shp_files/MXCK_CAD")
names(CAD) # use "LAND_DISTR" attribute to show parcels of land
Jurisdictions <-CAD$LAND_DISTR

ggplot() + 
  geom_sf(CAD, mapping = aes(fill = Jurisdictions)) + 
  coord_sf()

#Layer 4: MCW
MCW <- st_read("/Users/angeline.emmott/Documents/GitHub/maxwell-rstudio/spatial_data/vectors/Shp_files/MCW")

#Layer 5: Protected areas clipped to MCW
PA_MCW <- st_read("/Users/angeline.emmott/Documents/GitHub/maxwell-rstudio/spatial_data/vectors/Shp_files/IT_protected_areas_clipped")
names(PA_MCW) #use "DISTRIB" attribute to show private vs public landownership

ggplot() + 
  geom_sf(PA_MCW, mapping = aes(fill = DISTRIB)) + 
  coord_sf()

#Layer 6: Protected Areas (SSI)
PA <- st_read("/Users/angeline.emmott/Documents/GitHub/maxwell-rstudio/spatial_data/vectors/Shp_files/IT_protected_areas_2022-05")
names(PA) # use "DISTRIB" attribute to show private vs public land-ownership

ggplot() + 
  geom_sf(PA, mapping = aes(fill = DISTRIB)) + 
  coord_sf()

#Layer 7: Roads
roads <- st_read("/Users/angeline.emmott/Documents/GitHub/maxwell-rstudio/spatial_data/vectors/Shp_files/DataBC_roads")

#Layer 8: waterbodies 
waterbodies <- st_read("/Users/angeline.emmott/Documents/GitHub/maxwell-rstudio/spatial_data/vectors/Shp_files/RAR_water_bodies")

#Layer 9: watercourses
watercourses <- st_read("/Users/angeline.emmott/Documents/GitHub/maxwell-rstudio/spatial_data/vectors/Shp_files/RAR_water_courses")

#Mapping ggplot: 
ggplot() + 
  geom_sf(data = islcoast, color = "black") +
  geom_sf(data = watersheds, color = "royalblue3") +
  geom_sf(data = CAD, mapping = aes(fill = Jurisdictions)) +
  geom_sf(data = MCW, color = "grey2", fill = "blue1") +
  geom_sf(data = PA_MCW, mapping = aes(fill = DISTRIB)) +
  geom_sf(data = PA, mapping = aes(fill = TYPE_1)) +
  geom_sf(data = roads, color = "grey") +
  geom_sf(data = waterbodies, fill = "cyan") +
  geom_sf(data = watercourses, fill = "dodgerblue4") +
  coord_sf()

##MAP 2: Highlighting cooperating jursdictions
#Layers: islcoast, watersheds, CAD, CAD_MCW, roads, waterbodies, watercourses

#Layer 10: CAD_MCW
CAD_MCW <- st_read("/Users/angeline.emmott/Documents/GitHub/maxwell-rstudio/spatial_data/vectors/Shp_files/MXCK_CAD_clipped_MXCW")
names(CAD_MCW) #use "LABEL" attribute to show landowner jurisdictions

ggplot() + 
  geom_sf(CAD_MCW, mapping = aes(fill = LABEL)) + 
  coord_sf()

#Mapping ggplot:
ggplot() +
  geom_sf(data = islcoast, color = "black") +
  geom_sf(data = watersheds, color = "royalblue3") +
  geom_sf(data = CAD, mapping = aes(fill = Jurisdictions)) +
  geom_sf(data = MCW, color = "grey2", fill ="blue1") +
  geom_sf(data = CAD_MCW, mapping = aes(fill = LABEL)) +
  geom_sf(data = roads, color = "grey") +
  geom_sf(data = waterbodies, fill = "cyan") +
  geom_sf(data = watercourses, fill = "dodgerblue4") +
  coord_sf()
  