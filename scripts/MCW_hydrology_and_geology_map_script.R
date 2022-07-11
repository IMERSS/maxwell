##Hydrology and geology map:

#Layer 1: CAD_MCW
CAD_MCW <- st_read("spatial_data/vectors/Shp_files/MXCK_CAD_clipped_MXCW")

#Layer 2: watercourses
watercourses <- st_read("spatial_data/vectors/Shp_files/RAR_water_courses")

#Layer 3: watersheds
watersheds <- st_read("spatial_data/vectors/Shp_files/Watershed_CRD")

#layer 4: geology
geology <- st_read("/Users/angeline.emmott/Documents/GitHub/maxwell-rstudio/spatial_data/vectors/Shp_files/Geology")