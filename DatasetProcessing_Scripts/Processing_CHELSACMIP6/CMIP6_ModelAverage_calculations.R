# This script creates seasonal averages for all scenarios and time periods per model
  # Ex: develop raster of average annual rainfall projected for 2011-2040 under SSP1-2.6 by model GFDL

install.packages(sp)
install.packages(raster)
library(sp) #need sp to access extent function

library(raster)




island = "Tutuila"                                       # when developing menas for the two different islands, need to switch islands manually
time_list = c("2011-2040", "2041-2070", "2071-2100")
model_list = c("GFDL", "IPSL", "MPI", "MRI", "UKES")
ssp_list = c("SSP126", "SSP370","SSP585")

k = time_list[3]
l = model_list[5]
m = ssp_list[2]



#1. Do all respective ssps for EACH time period AND island 
#2. THEN change SSPs and proceed to do the same for each time period i.e. 2040 guam, then 2070 guam, THEN, 2011 tutuila, 2040 tutuila, 2070 tutuila 

  
  
        
      # Setting working directory
      timeperiod_wd <- paste("D:/CMIP6_CHELSA/CMIP6_data_0723_clippedextent/Tutuila_CHELSA_CMIP6_data", paste(island,k,"data", sep = "_"), sep = "/")
      wd <- paste(timeperiod_wd, paste(l,k,sep = "_"),sep= "/")
      print(wd)
      setwd(wd)
      
      # Setting the output folder
      output_dir <- paste("D:/CMIP6_CHELSA/CMIP6_data_0723_clippedextent/Tutuila_CMIP6_means", paste(island, k, "model_means_final", sep= "_"), paste(l,k, "means_final", sep= "_"),sep = "/")
      dir.create(output_dir, recursive = T) #only use once per model
      
      # ANNUAL #
      
      all_list = list.files(pattern = "ssp370", full.names = T, recursive = T)      # When changing between ssps - You need to change this part of the code - listing - manually!!!
      annual_list <- all_list[!grepl(".aux.xml", all_list)]
      print(annual_list)
      
      annual_stack <- stack(annual_list)
      annual_mean <- sum(annual_stack)
      raster_names <- paste(output_dir, paste(k,m,l,"annualmean",island, sep = "_"), sep = "/")
      writeRaster(annual_mean, filename = raster_names, overwrite = TRUE, format = "GTiff")
      
      # WET SEASON #
      
      wetseason = list.files(wd, pattern = "_01_|_02_|_03_|_04_|_11_|_12_", all.files = F, full.names = T, recursive = T)
      wetseason_list <- wetseason[!grepl(".aux.xml|ssp126|ssp585", wetseason)]
      print(wetseason_list)
      
      wetseason_stack <- stack(wetseason_list)
      wetseason_mean <- sum(wetseason_stack)
      wetseas_name <- paste(output_dir, paste(k,m,l,"11-04_wetseasonmean",island, sep = "_"), sep = "/")
      writeRaster(wetseason_mean, filename = wetseas_name, overwrite = TRUE, format = "GTiff")
      
      # DRY SEASON #
      
      dryseason = list.files(wd, pattern = "_05_|_06_|_07_|_08_|_09_|_10_", all.files = F, full.names = T, recursive = T)
      dryseason_list <- dryseason[!grepl(".aux.xml|ssp126|ssp585", dryseason)]
      print(dryseason_list)
      
      dryseason_stack <- stack(dryseason_list)
      dryseason_mean <- sum(dryseason_stack)
      dryseas_name <- paste(output_dir, paste(k,m,l,"05-10_dryseasonmean",island, sep = "_"), sep = "/")
      writeRaster(dryseason_mean, filename = dryseas_name, overwrite = TRUE, format = "GTiff")

