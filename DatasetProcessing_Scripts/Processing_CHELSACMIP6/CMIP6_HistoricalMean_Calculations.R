
# This script develops seasonal averages for the CHELSA CMIP6 historical period


# testing the annual and seasonal averaging 

install.packages(sp)
install.packages(raster)
library(sp) #need sp to access extent function

library(raster)

setwd("D:/CMIP6_CHELSA/CMIP6_data_0723_clippedextent/Tutuila_CHELSA_CMIP6_data/Tutuila_1981-2010_data")
wd = "D:/CMIP6_CHELSA/CMIP6_data_0723_clippedextent/Tutuila_CHELSA_CMIP6_data/Tutuila_1981-2010_data"
output_dir = "D:/CMIP6_CHELSA/CMIP6_data_0723_clippedextent/Tutuila_CHELSA_CMIP6_data/Tutuila_1981-2010_means"
dir.create(output_dir)
#output_dir2 = "F:/CMIP6_CHELSA/CMIP6_data_0723_clippedextent/Tutuila_CHELSA_CMIP6_data/Tutuila_1981-2010_data"



##First need to create a list of the files in the 1981-2010 folder

# ANNUAL LIST #
annual_list = list.files(pattern = ".tif$", full.names = T, recursive = T)
print(annual_list)

annual_stack <- stack(annual_list)
annual_mean <- sum(annual_stack)
raster_names <- paste(output_dir, paste0("Tutuila_1981-2010_annualmean"), sep = "/")
writeRaster(annual_mean, filename = raster_names, overwrite = TRUE, format = "GTiff")


# WET SEASON #

wetseason = list.files(wd, pattern = "_01_|_02_|_03_|_04_|_11_|_12_", all.files = F, full.names = T, recursive = T)
wetseason_list <- wetseason[!grepl(".aux.xml", wetseason)]
print(wetseason_list)

wetseason_stack <- stack(wetseason_list)
wetseason_mean <- sum(wetseason_stack)
wetseas_name <- paste(output_dir, paste0("Tutuila_1981-2010_11-04_wetseasonmean"), sep = "/")
writeRaster(wetseason_mean, filename = wetseas_name, overwrite = TRUE, format = "GTiff")


# DRY SEASON #

dryseason = list.files(wd, pattern = "_05_|_06_|_07_|_08_|_09_|_10_", all.files = F, full.names = T, recursive = T)
dryseason_list <- dryseason[!grepl(".aux.xml", dryseason)]
print(dryseason_list)


dryseason_stack <- stack(dryseason_list)
dryseason_mean <- sum(dryseason_stack)
dryseas_name <- paste(output_dir, paste0("Tutuila_1981-2010_05-10_dryseasonmean"), sep = "/")
writeRaster(dryseason_mean, filename = dryseas_name, overwrite = TRUE, format = "GTiff")



#timeperiod_list = 

#for (i in annual_list) {
  #creating a raster stack so they'll be able to be summed
  #annual_stack <- stack(annual_list)
  
  #annual_mean <- calc(annual_stack, fun = sum())  #using calc and sum() functions to calculate the sum of the pixels within the raster stack
#   annual_mean <- sum(annual_stack)
#   raster_names <- paste(output_dir, paste0(substr(i, 1, 33),"_annualmean"), sep = "/")
#   writeRaster(annual_mean, filename = raster_names, overwrite = TRUE, format = "GTiff")
# }

