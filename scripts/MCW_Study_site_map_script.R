##MCW study sites map script
library(sf)
library(ggplot2)
library(rgdal)
library(leaflet)

source("scripts/utils.R")

#Layer 1: island coastline
islcoast <- mx_read("spatial_data/vectors/Shp_files/Island")

#Layer 2: MCW
MCW <- mx_read("spatial_data/vectors/Shp_files/MCW")

#Layer #3: Observational Study sites
study_sites <- mx_read("spatial_data/vectors/Shp_files/Observational_Study")

StudySiteMap <- leaflet() %>%
  addTiles(options = providerTileOptions(opacity = 0.5)) %>%
  addPolygons(data = islcoast, color = "black", weight = 1.5, fillOpacity = 0, fillColor = NA) %>%
  addPolygons(data = MCW, color = "blue", weight = 2, fillOpacity = 0) %>%
  #addPolygons(data = study_sites, color = "black", weight = 2, fillOpacity = 0) %>%
  addLabelOnlyMarkers(data = study_sites, lng = -123.5289, lat = 48.81571, label = "001", labelOptions = labelOptions(noHide = TRUE, direction = 'middle', textOnly = TRUE)) %>%
  addLabelOnlyMarkers(data = study_sites, lng = -123.5260, lat = 48.81747, label = "003", labelOptions = labelOptions(noHide = TRUE, direction = 'middle', textOnly = TRUE)) %>%
  addLabelOnlyMarkers(data = study_sites, lng = -123.5268, lat = 48.81844, label = "005", labelOptions = labelOptions(noHide = TRUE, direction = 'middle', textOnly = TRUE)) %>%
  addLabelOnlyMarkers(data = study_sites, lng = -123.5242, lat = 48.81204, label = "006", labelOptions = labelOptions(noHide = TRUE, direction = 'middle', textOnly = TRUE)) %>%
  addLabelOnlyMarkers(data = study_sites, lng = -123.5346, lat = 48.82443, label = "007", labelOptions = labelOptions(noHide = TRUE, direction = 'middle', textOnly = TRUE)) %>%
  addLabelOnlyMarkers(data = study_sites, lng = -123.5460, lat = 48.82612, label = "008", labelOptions = labelOptions(noHide = TRUE, direction = 'middle', textOnly = TRUE)) %>%
  addLabelOnlyMarkers(data = study_sites, lng = -123.5287, lat = 48.81979, label = "011", labelOptions = labelOptions(noHide = TRUE, direction = 'middle', textOnly = TRUE)) %>%
  addLabelOnlyMarkers(data = study_sites, lng = -123.5374, lat = 48.81917, label = "012", labelOptions = labelOptions(noHide = TRUE, direction = 'middle', textOnly = TRUE)) %>%
  addLabelOnlyMarkers(data = study_sites, lng = -123.5212, lat = 48.81516, label = "014", labelOptions = labelOptions(noHide = TRUE, direction = 'middle', textOnly = TRUE)) %>%
  addLabelOnlyMarkers(data = study_sites, lng = -123.5332, lat = 48.82016, label = "015", labelOptions = labelOptions(noHide = TRUE, direction = 'middle', textOnly = TRUE)) %>%
  addLabelOnlyMarkers(data = study_sites, lng = -123.5453, lat = 48.82768, label = "100", labelOptions = labelOptions(noHide = TRUE, direction = 'middle', textOnly = TRUE)) %>%
  addLabelOnlyMarkers(data = study_sites, lng = -123.5308, lat = 48.82157, label = "103", labelOptions = labelOptions(noHide = TRUE, direction = 'middle', textOnly = TRUE)) %>%
  addLabelOnlyMarkers(data = study_sites, lng = -123.5204, lat = 48.81091, label = "104", labelOptions = labelOptions(noHide = TRUE, direction = 'middle', textOnly = TRUE)) %>%
  addLabelOnlyMarkers(data = study_sites, lng = -123.5241, lat = 48.81959, label = "106", labelOptions = labelOptions(noHide = TRUE, direction = 'middle', textOnly = TRUE)) %>%
  addLabelOnlyMarkers(data = study_sites, lng = -123.5297, lat = 48.81609, label = "107", labelOptions = labelOptions(noHide = TRUE, direction = 'middle', textOnly = TRUE)) %>%
  addLabelOnlyMarkers(data = study_sites, lng = -123.5473, lat = 48.82846, label = "109", labelOptions = labelOptions(noHide = TRUE, direction = 'middle', textOnly = TRUE)) %>% 
  addLabelOnlyMarkers(data = study_sites, lng = -123.5321, lat = 48.82224, label = "110", labelOptions = labelOptions(noHide = TRUE, direction = 'middle', textOnly = TRUE)) %>% 
  addLabelOnlyMarkers(data = study_sites, lng = -123.5283, lat = 48.81529, label = "111", labelOptions = labelOptions(noHide = TRUE, direction = 'middle', textOnly = TRUE)) %>% 
  addLabelOnlyMarkers(data = study_sites, lng = -123.5191, lat = 48.81212, label = "112", labelOptions = labelOptions(noHide = TRUE, direction = 'middle', textOnly = TRUE)) %>% 
  addLabelOnlyMarkers(data = study_sites, lng = -123.5354, lat = 48.82061, label = "114", labelOptions = labelOptions(noHide = TRUE, direction = 'middle', textOnly = TRUE)) %>% 
  addLabelOnlyMarkers(data = study_sites, lng = -123.5192, lat = 48.81667, label = "200", labelOptions = labelOptions(noHide = TRUE, direction = 'middle', textOnly = TRUE)) %>% 
  addLabelOnlyMarkers(data = study_sites, lng = -123.5298, lat = 48.82041, label = "201", labelOptions = labelOptions(noHide = TRUE, direction = 'middle', textOnly = TRUE)) %>% 
  addLabelOnlyMarkers(data = study_sites, lng = -123.5202, lat = 48.81592, label = "202", labelOptions = labelOptions(noHide = TRUE, direction = 'middle', textOnly = TRUE)) %>% 
  addLabelOnlyMarkers(data = study_sites, lng = -123.5252, lat = 48.81239, label = "203", labelOptions = labelOptions(noHide = TRUE, direction = 'middle', textOnly = TRUE)) %>% 
  addLabelOnlyMarkers(data = study_sites, lng = -123.5437, lat = 48.82674, label = "204", labelOptions = labelOptions(noHide = TRUE, direction = 'middle', textOnly = TRUE)) %>% 
  addLabelOnlyMarkers(data = study_sites, lng = -123.5216, lat = 48.81756, label = "206", labelOptions = labelOptions(noHide = TRUE, direction = 'middle', textOnly = TRUE)) %>% 
  addLabelOnlyMarkers(data = study_sites, lng = -123.5385, lat = 48.81821, label = "213", labelOptions = labelOptions(noHide = TRUE, direction = 'middle', textOnly = TRUE)) %>% 
  addLabelOnlyMarkers(data = study_sites, lng = -123.5297, lat = 48.81804, label = "214", labelOptions = labelOptions(noHide = TRUE, direction = 'middle', textOnly = TRUE)) %>%
  addLabelOnlyMarkers(data = study_sites, lng = -123.5426, lat = 48.82747, label = "215", labelOptions = labelOptions(noHide = TRUE, direction = 'middle', textOnly = TRUE)) %>%
  addLabelOnlyMarkers(data = study_sites, lng = -123.5406, lat = 48.82552, label = "220", labelOptions = labelOptions(noHide = TRUE, direction = 'middle', textOnly = TRUE)) %>%
  addLabelOnlyMarkers(data = study_sites, lng = -123.5232, lat = 48.81125, label = "303", labelOptions = labelOptions(noHide = TRUE, direction = 'middle', textOnly = TRUE)) %>%
  addLabelOnlyMarkers(data = study_sites, lng = -123.5322, lat = 48.82449, label = "305", labelOptions = labelOptions(noHide = TRUE, direction = 'middle', textOnly = TRUE)) %>%
  addLabelOnlyMarkers(data = study_sites, lng = -123.5180, lat = 48.80824, label = "307", labelOptions = labelOptions(noHide = TRUE, direction = 'middle', textOnly = TRUE)) %>%
  addLabelOnlyMarkers(data = study_sites, lng = -123.5480, lat = 48.82565, label = "308", labelOptions = labelOptions(noHide = TRUE, direction = 'middle', textOnly = TRUE)) %>%
  addLabelOnlyMarkers(data = study_sites, lng = -123.5274, lat = 48.82243, label = "309", labelOptions = labelOptions(noHide = TRUE, direction = 'middle', textOnly = TRUE)) %>%
  addLabelOnlyMarkers(data = study_sites, lng = -123.5269, lat = 48.81795, label = "318", labelOptions = labelOptions(noHide = TRUE, direction = 'middle', textOnly = TRUE)) %>%
  addLabelOnlyMarkers(data = study_sites, lng = -123.5268, lat = 48.81739, label = "322", labelOptions = labelOptions(noHide = TRUE, direction = 'middle', textOnly = TRUE)) %>%
  addLabelOnlyMarkers(data = study_sites, lng = -123.5448, lat = 48.82947, label = "324", labelOptions = labelOptions(noHide = TRUE, direction = 'middle', textOnly = TRUE)) %>%
  addLabelOnlyMarkers(data = study_sites, lng = -123.5280, lat = 48.82097, label = "357", labelOptions = labelOptions(noHide = TRUE, direction = 'middle', textOnly = TRUE)) %>%
  addLabelOnlyMarkers(data = study_sites, lng = -123.5273, lat = 48.82260, label = "389", labelOptions = labelOptions(noHide = TRUE, direction = 'middle', textOnly = TRUE)) %>%
  addLegend(position = "topright", labels = "Observational Study Sites", colors = "black") %>%
  fitBounds(-123.564, 48.802, -123.516, 48.855) %>%
  
  print(StudySiteMap)