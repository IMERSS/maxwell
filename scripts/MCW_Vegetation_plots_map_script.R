##MCW study sites map script
library(sf)
library(ggplot2)
library(leaflet)

source("scripts/utils.R")

#Layer 1: island coastline
islcoast <- mx_read("spatial_data/vectors/Shp_files/Island")

#Layer 2: MCW
MCW <- mx_read("spatial_data/vectors/Shp_files/MCW")

#Layer 3: Observational Study sites
study_sites <- mx_read("spatial_data/vectors/Shp_files/Observational_Study")

study_sites$label <- substring(study_sites$siteID, 6)

#Veg data:

veg <- read.csv("tabular_data/MXCW_vegetation_percent_cover_data.csv")

# Remove first character so that labels agree with those in siteData.json
veg$site <- substr(veg$site, 2, nchar(veg$site))

taxaHash <- split(x = veg$species_name, f = veg$site)

vascularData <- list(taxa = taxaHash, mapTitle = "Map 1. Vegetation plots")

# Write summarized plants to JSON file for viz

write(jsonlite::toJSON(vascularData, auto_unbox = TRUE, pretty = TRUE), "viz_data/Vascular-plotData.json")

# Generate map

VegMap <- leaflet(study_sites, options=list(mx_mapId="Vascular")) %>%
  addTiles(options = providerTileOptions(opacity = 0.5)) %>%
  addPolygons(data = islcoast, color = "black", weight = 1.5, fillOpacity = 0, fillColor = NA) %>%
  addPolygons(data = MCW, color = "blue", weight = 2, fillOpacity = 0) %>%
  addMarkers(lng = ~longitude, lat = ~latitude, label = ~label, 
             labelOptions = labelOptions(noHide = TRUE, direction = 'top', textOnly = TRUE, className = "mxcw-mapLabel mxcw-siteLabel", style = list("color" = "white"))) %>%
  addLegend(position = "topright", labels = "Observational Study Sites", colors = "black") %>%
  fitBounds(-123.564, 48.802, -123.516, 48.855) %>%
  
print(VegMap)
