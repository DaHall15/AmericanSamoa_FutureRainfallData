## CONVERTING ASC FILES FOR TUTUILA TO RASTER ##
  # Zhang and Wang data for Tutuila was downloaded as ASCII files, needed to be converted to raster

install.packages("sp")
install.packages("raster")
install.packages("sf")
install.packages("terra")
library(sp) #need sp to access extent function
library(raster)
library(sf)
library(terra)

setwd("D:/Zhang_Data/Tutuila_ASCII")

#Listing the files from the folder
asc_list <- list.files("D:/Zhang_Data/Tutuila_ASCII", pattern='\\.asc$', full=TRUE)
print(asc_list)
ftif <- gsub("\\.asc$", ".tif", asc_list) #setting to substitute the asc file ending with that of a raster
print(ftif)
output_rast = "D:/Zhang_Data/Tutuila_Raster"

for (i in 1:length(asc_list)) {
  r <- rast(asc_list[i])
  r <- writeRaster(r, ftif[i], overwrite = T)
}

############ Setting the Coordinate System ############

raster_files <- list.files("D:/Zhang_Data/Tutuila_ASCII", pattern = ".tif", full = T)
print(raster_files)


raster_list <- lapply(raster_files, raster)


output_dir <- "D:/Zhang_Data/Tutuila_Raster"

#Setting CS example 

cs_set <- "D:/Zhang_Data/Guam_Raster/RAIN_present/annual/annual_sum/guam_RAIN_present_1990_sum.tif"
cs <- raster(cs_set)

# 
# st_crs("EPSG:4326")
# 
# st_crs(coords_test)

for (r in raster_list[1]){
  #well knonw text of r layer cs is given
  raster_lyr <- wkt(r)
  
  #make a raster
  raster(r)
  
  crs(r) <- cs
  output_name <- paste(output_dir, r, sep = "/")
  writeRaster(r, filename = output_name, format = "GTif", overwrite = T)
}


https://stackoverflow.com/questions/49919166/batch-process-multiple-ascii-to-raster-files-in-r#:~:text=You%20can%20do%20something%20along%20these%20lines%3A%20library,%5Bi%5D%29%20r%20%3C-%20writeRaster%20%28r%2C%20ftif%20%5Bi%5D%29%20%7D



guam_proj = "D:/Zhang_Data/Finalupdated_Zhang_calc_Rproc/Final_Tutuila_calc/Presentday_means_Tutuila/Tutuila_1990-2009_present_annualmean.tif"
print("CRS:{}")
