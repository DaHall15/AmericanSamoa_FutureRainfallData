# This script develops MMEs for CHELSA CMIP6 data 

install.packages("sp")
install.packages("raster")
install.packages("utils")
install.packages("sf")
library(sp) #need sp to access extent function
library(raster)
library(utils)
library(sf)


island = "Guam" # Need to change island, and go through models manually
time_list = c("2011-2040", "2041-2070", "2071-2100")
model_list = c("GFDL", "IPSL", "MPI", "MRI", "UKES")
ssp_list = c("SSP126", "SSP370","SSP585")

k = time_list[3]
m = ssp_list[3]


for (k in time_list[3]){
    for (m in ssp_list[2]){     # When changing between ssps NEED TO CHANGE MANUALLY IN CODE!!
      
      # Setting working directory
      wd <- paste("D:/CMIP6_CHELSA/CMIP6_data_0723_clippedextent", paste(island, "CMIP6_means", sep = "_"), paste(island,k,"model_means_final", sep = "_"), sep = "/")
      print(wd)
      setwd(wd)
      
      # Setting the output folder
      #period_output_dir <- paste("D:/CMIP6_CHELSA/CMIP6_data_0723_clippedextent/MMEs", paste(island,"MMEs", sep= "_"), paste(k,island,"MMEs", sep = "_"),sep = "/")
      #dir.create(period_output_dir) #only use once per time period
      output_dir <- paste("D:/CMIP6_CHELSA/CMIP6_data_0723_clippedextent/MMEs", paste(island,"MMEs_final", sep= "_"), paste(k,island,"MMEs_final", sep = "_"),
                          paste(k,m,"MME",island, sep = "_"),sep = "/")
      dir.create(output_dir, recursive = T) 
      print(output_dir)
      
      # ANNUAL #
      MMscenarios_annual <- list.files(path = paste("D:/CMIP6_CHELSA/CMIP6_data_0723_clippedextent/Guam_CMIP6_means", paste(island,k,"model_means", sep = "_"), sep = "/"), 
                                       pattern = "SSP370", recursive = TRUE, full.names = TRUE)
      print(MMscenarios_annual)
      MMscenario_list_annual <- MMscenarios_annual[!grepl(".aux.xml|11-04|05-10", MMscenarios_annual)]
      print(MMscenario_list_annual)
      #reading all files in as rasters for the stack
      for (r in MMscenario_list_annual){
        raster(r)
      }
      
      annual_stack <- stack(MMscenario_list_annual)
      annual_mean <- (sum(annual_stack))/5
      raster_names <- paste(output_dir, paste(k,m,"annual_MME",island, sep = "_"), sep = "/")
      writeRaster(annual_mean, filename = raster_names, overwrite = TRUE, format = "GTiff")
      
      
      
      # WET SEASON #
      MMwetseason = list.files(path = paste("D:/CMIP6_CHELSA/CMIP6_data_0723_clippedextent/Guam_CMIP6_means", paste(island,k,"model_means", sep = "_"), sep = "/"), 
                               pattern = "SSP370", recursive = TRUE, full.names = TRUE)
      MMwetseason_list <- MMwetseason[!grepl(".aux.xml|annual|05-10", MMwetseason)]
      print(MMwetseason_list)
      #reading all files in as rasters for the stack
      for (r in MMwetseason_list){
        raster(r)
      }
      
      wetseason_stack <- stack(MMwetseason_list)
      wetseason_mean <- (sum(wetseason_stack))/5    #averaging the pixels from each of 5 models
      wetseas_name <- paste(output_dir, paste(k,m,"11-04_wetseasonmean_MME",island,sep = "_"), sep = "/")
      writeRaster(wetseason_mean, filename = wetseas_name, overwrite = TRUE, format = "GTiff")
      
      
      # DRY SEASON #
      
      MMdryseason = list.files(path = paste("D:/CMIP6_CHELSA/CMIP6_data_0723_clippedextent/Guam_CMIP6_means", paste(island,k,"model_means", sep = "_"), sep = "/"), 
                             pattern = "SSP370", recursive = TRUE, full.names = TRUE)
      MMdryseason_list <- MMdryseason[!grepl(".aux.xml|annual|11-04", MMdryseason)]
      print(MMdryseason_list)
      #reading all files in as rasters for the stack
      for (r in MMdryseason_list){
        raster(r)
      }

      dryseason_stack <- stack(MMdryseason_list)
      dryseason_mean <- (sum(dryseason_stack))/5
      dryseas_name <- paste(output_dir, paste(k,m,"05-10_dryseasonmean_MME",island, sep = "_"), sep = "/")
      writeRaster(dryseason_mean, filename = dryseas_name, overwrite = TRUE, format = "GTiff")
      
      
    }
  
}




