# This script calculates Absolute Change in Precipitation and Future Percent Change in Precipitation for CHELSA CMIP6

install.packages("sp")
install.packages("raster")
install.packages("utils")
install.packages("sf")
library(sp) #need sp to access extent function
library(raster)
library(utils)
library(sf)


island = "Guam"
time_list = c("2011-2040", "2041-2070", "2071-2100")
model_list = c("GFDL", "IPSL", "MPI", "MRI", "UKES")
ssp_list = c("SSP126", "SSP370","SSP585")

k = time_list[1]
l = model_list[1] #- don't need to specify model when doing MMEs
m = ssp_list[1]



for (k in time_list[3]){
  for (m in ssp_list[3]){
      

      # Absch Output Folder
       output_dir <- paste("D:/CMIP6_CHELSA/CMIP6_data_0723_clippedextent/AbsoluteChange", paste(island,"AbsoluteChange_final", sep= "_"), paste(k,"AbsoluteChange",island, sep = "_"),sep = "/")
       print(output_dir)
       dir.create(output_dir, recursive = T) 


      ## ANNUAL ##
      
      presentday_annual <- raster(paste0("D:/CMIP6_CHELSA/CMIP6_data_0723_clippedextent/Guam_CMIP6_means/Guam_1981-2010_means/Guam_1981-2010_annualmean.tif"))
      print(presentday_annual)
      
      future_annual <- raster(paste("D:/CMIP6_CHELSA/CMIP6_data_0723_clippedextent/MMEs", paste(island,"MMEs_final", sep= "_"), 
                                    paste(k,island,"MMEs_final", sep = "_"), paste(k,m,"MME",island, sep = "_"), paste(k,m,"annual", "MME","Guam.tif", sep = "_"),sep = "/"))
      print(future_annual)
      
      # absolute change = future - historic    **DOESN'T NEED SCALING!!!
      annual_absch <- future_annual - presentday_annual
      absch_name <- paste(output_dir, paste(k,m,"annual_AbsoluteChange",island, sep = "_"),sep = "/") 
      writeRaster(annual_absch, absch_name, overwrite = T, format = "GTiff" )
      
      
      # WET SEASON #
      presentday_wet <- raster(paste("D:/CMIP6_CHELSA/CMIP6_data_0723_clippedextent/Guam_CMIP6_means/Guam_1981-2010_means/Guam_1981-2010_11-04_wetseasonmean.tif"))
      print(presentday_wet)
      
      future_wet <- raster(paste("D:/CMIP6_CHELSA/CMIP6_data_0723_clippedextent/MMEs", paste(island,"MMEs_final", sep= "_"), 
                                 paste(k,island,"MMEs_final", sep = "_"), paste(k,m,"MME",island, sep = "_"), paste(k,m,"11-04_wetseasonmean", "MME","Guam.tif", sep = "_"),sep = "/"))
      print(future_wet)
      
      # absolute change = future - historic    **DOESN'T NEED SCALING!!!
      wetseason_absch <- future_wet - presentday_wet
      wet_absch_name <- paste(output_dir, paste(k,m,"11-04_wetseason_AbsoluteChange",island, sep = "_"),sep = "/") 
      writeRaster(wetseason_absch, wet_absch_name, overwrite = T, format = "GTiff" )
      
      
      
      # DRY SEASON #
      presentday_dry <- raster(paste("D:/CMIP6_CHELSA/CMIP6_data_0723_clippedextent/Guam_CMIP6_means/Guam_1981-2010_means/Guam_1981-2010_05-10_dryseasonmean.tif"))
      print(presentday_dry)
      
      future_dry <- raster(paste("D:/CMIP6_CHELSA/CMIP6_data_0723_clippedextent/MMEs", paste(island,"MMEs_final", sep= "_"), 
                                 paste(k,island,"MMEs_final", sep = "_"), paste(k,m,"MME",island, sep = "_"), paste(k,m,"05-10_dryseasonmean", "MME","Guam.tif", sep = "_"),sep = "/"))
      print(future_dry)
      
      # absolute change = future - historic    **DOESN'T NEED SCALING!!!
      dryseason_absch <- future_dry - presentday_dry
      dry_absch_name <- paste(output_dir, paste(k,m,"05-10_dryseason_AbsoluteChange",island, sep = "_"),sep = "/") 
      writeRaster(dryseason_absch, dry_absch_name, overwrite = T, format = "GTiff" )
      
  }
}


############################################    Future    Percent    Change   ##################################################################
island = "Guam"
for (k in time_list[3]){
  for (m in ssp_list[1:3]){


      #FPC Output Folder
       fpc_dir <- paste("D:/CMIP6_CHELSA/CMIP6_data_0723_clippedextent/FuturePercentChange", paste(island,"FPC_final", sep= "_"), paste(k,"FPC",island, "final",sep = "_"),sep = "/")
       print(fpc_dir)
       dir.create(fpc_dir, recursive = T)


      ## ANNUAL ##
      
      presentday_annual <- raster(paste0("D:/CMIP6_CHELSA/CMIP6_data_0723_clippedextent/Guam_CMIP6_means/Guam_1981-2010_means/Guam_1981-2010_annualmean.tif"))
      print(presentday_annual)
      
      absch_annual <- raster(paste("D:/CMIP6_CHELSA/CMIP6_data_0723_clippedextent/AbsoluteChange", paste(island,"AbsoluteChange_final", sep= "_"), 
                                   paste(k,"AbsoluteChange", island, sep = "_"), paste(k,m,"annual", "AbsoluteChange","Guam.tif", sep = "_"),sep = "/"))
      print(absch_annual)
      # FPC = (future / absch)*100
      annual_fpc_unscaled  = absch_annual/presentday_annual
      annual_fpc = annual_fpc_unscaled*100
      fpc_name <- paste(fpc_dir, paste(k,m,"annual_FPC",island, sep = "_"),sep = "/")
      writeRaster(annual_fpc, fpc_name, overwrite = T, format = "GTiff" )


      
      
      
      ## WET SEASON ##
      
      presentday_wet <- raster(paste("D:/CMIP6_CHELSA/CMIP6_data_0723_clippedextent/Guam_CMIP6_means/Guam_1981-2010_means/Guam_1981-2010_11-04_wetseasonmean.tif"))
      print(presentday_wet)
      
      wetseason_absch <- raster(paste("D:/CMIP6_CHELSA/CMIP6_data_0723_clippedextent/AbsoluteChange", paste(island,"AbsoluteChange_final", sep= "_"), 
                                 paste(k,"AbsoluteChange",island, sep = "_"), paste(k,m,"annual","AbsoluteChange", "Guam.tif", sep = "_") ,sep = "/"))
      print(wetseason_absch)
      
      
      # FPC = (future / absch)*100
      wetseason_fpc_unscaled = wetseason_absch/presentday_wet
      wetseason_fpc = wetseason_fpc_unscaled*100
      wet_fpc_name <- paste(fpc_dir, paste(k,m,"11-04_wetseason_FPC",island, sep = "_"),sep = "/")
      writeRaster(wetseason_fpc, wet_fpc_name, overwrite = T, format = "GTiff" )
      
      
      
      
      
      
      
      
      ## DRY SEASON ##
      
      presentday_dry <- raster(paste("D:/CMIP6_CHELSA/CMIP6_data_0723_clippedextent/Guam_CMIP6_means/Guam_1981-2010_means/Guam_1981-2010_05-10_dryseasonmean.tif"))
      print(presentday_dry)
      
      dryseason_absch <- raster(paste("D:/CMIP6_CHELSA/CMIP6_data_0723_clippedextent/AbsoluteChange", paste(island,"AbsoluteChange_final", sep= "_"), 
                                      paste(k,"AbsoluteChange",island, sep = "_"), paste(k,m,"annual","AbsoluteChange", "Guam.tif", sep = "_") ,sep = "/"))
      print(dryseason_absch)
      
      # FPC = (future / absch)*100
      dryseason_fpc_unscaled = dryseason_absch/presentday_dry
      dryseason_fpc = dryseason_fpc_unscaled*100
      dry_fpc_name <- paste(fpc_dir, paste(k,m,"05-10_dryseason_FPC",island, sep = "_"),sep = "/")
      writeRaster(dryseason_fpc, dry_fpc_name, overwrite = T, format = "GTiff" )
  }
}
