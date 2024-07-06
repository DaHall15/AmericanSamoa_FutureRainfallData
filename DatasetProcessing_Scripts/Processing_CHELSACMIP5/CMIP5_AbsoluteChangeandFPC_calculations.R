# Calculating Absolute Change in Precipitaiton and Future Percent Change for CHELSA CMIP5

install.packages("sp")
install.packages("raster")
install.packages("utils")
install.packages("sf")
library(sp) #need sp to access extent function
library(raster)
library(utils)
library(sf)


island = "Tutuila"    #when running between islands - NEED TO MAKE SURE TO MANUALLY CHANGE ISLAND IN FUTURE & PRESENT DAY FILE FOLDER LOCATION
rcp_list = c("RCP4.5", "RCP8.5")
ave_list = c("annual", "11-04_wetseason", "05-10_dryseason")

m = rcp_list[1]

a = ave_list[1]
      # Setting the output folder
      period_output_dir <- paste("D:/CMIP5_CHELSA/RstudioProc_CMIP5_outputs/CMIP5_AbsoluteChange", paste(island,"AbsoluteChange", "final", sep= "_"), 
                                 paste(m, island,"AbsoluteChange","final", sep = "_"),sep = "/")
      dir.create(period_output_dir, recursive = T)
      ##Only use once per RCP development


      ## ANNUAL ##
      
      presentday_annual <- raster(paste("D:/CMIP5_CHELSA/RstudioProc_CMIP5_outputs/CMIP5_1979-2013_PresentDay", paste(island, "PresentDay", sep = "_"),
                                        paste(island, "1979-2013_annualmean.tif", sep = "_"), sep = "/"))
      print(presentday_annual)
      
      future_annual <- raster(paste("D:/CMIP5_CHELSA/RstudioProc_CMIP5_outputs/CMIP5_MME", paste(island, "MMEs", sep = "_"),
                                    paste(m, island, "MMEs", sep = "_"),  paste(m,a, "MME", island, sep = "_"),paste(m,a, "MME", "Tutuila_masked.tif", sep = "_"), sep = "/"))
      print(future_annual)
      
      
      # absolute change = future - historic    **DOESN'T NEED SCALING!!!
      annual_absch <- future_annual - presentday_annual
      absch_name <- paste(period_output_dir, paste(m,"annual_AbsoluteChange",island, sep = "_"),sep = "/") 
      writeRaster(annual_absch, absch_name, overwrite = T, format = "GTiff" )
      
      
      
      
      
      
      a = ave_list[2]   
      # WET SEASON #
      presentday_wet <- raster(paste("D:/CMIP5_CHELSA/RstudioProc_CMIP5_outputs/CMIP5_1979-2013_PresentDay", paste(island, "PresentDay", sep = "_"),
                                     paste(island, "1979-2013_11-04_wetseasonmean_Tutuila.tif", sep = "_"), sep = "/"))
      print(presentday_wet)
      future_wet <- raster(paste("D:/CMIP5_CHELSA/RstudioProc_CMIP5_outputs/CMIP5_MME", paste(island, "MMEs", sep = "_"),
                                 paste(m, island, "MMEs", sep = "_"),  paste(m,a, "MME", island, sep = "_"),paste(m,a, "MME", "Tutuila_masked.tif", sep = "_"), sep = "/"))
      print(future_wet)
      
      # absolute change = future - historic    **DOESN'T NEED SCALING!!!
      wetseason_absch <- future_wet - presentday_wet
      wet_absch_name <- paste(period_output_dir, paste(m,"11-04_wetseason_AbsoluteChange",island, sep = "_"),sep = "/") 
      writeRaster(wetseason_absch, wet_absch_name, overwrite = T, format = "GTiff" )
      
      
      
      
      
      
      
      a = ave_list[3]   
      # DRY SEASON #
      presentday_dry <- raster(paste("D:/CMIP5_CHELSA/RstudioProc_CMIP5_outputs/CMIP5_1979-2013_PresentDay", paste(island, "PresentDay", sep = "_"),
                                     paste(island, "1979-2013_05-10_dryseasonmean_Tutuila.tif", sep = "_"), sep = "/"))
      print(presentday_dry)
      
      future_dry <- raster(paste("D:/CMIP5_CHELSA/RstudioProc_CMIP5_outputs/CMIP5_MME", paste(island, "MMEs", sep = "_"),
                                 paste(m, island, "MMEs", sep = "_"),  paste(m,a, "MME", island, sep = "_"),paste(m,a, "MME", "Tutuila_masked.tif", sep = "_"), sep = "/"))
      print(future_dry)
      
      # absolute change = future - historic    **DOESN'T NEED SCALING!!!
      dryseason_absch <- future_dry - presentday_dry
      dry_absch_name <- paste(period_output_dir, paste(m,"05-10_dryseason_AbsoluteChange",island, sep = "_"),sep = "/") 
      writeRaster(dryseason_absch, dry_absch_name, overwrite = T, format = "GTiff" )
      
 


############################################  Future  Percent  Change  ##################################################################

island = "Tutuila"
rcp_list = c("RCP4.5", "RCP8.5")
ave_list = c("annual", "11-04_wetseason", "05-10_dryseason")
      
m = rcp_list[2]
      
for (m in rcp_list[2]){ # When manually switching islands, be sure to change some of input directories for islands
      a = ave_list[1]
      #FPC Output Folder
      fpc_dir <- paste("D:/CMIP5_CHELSA/RstudioProc_CMIP5_outputs/CMIP5_FPC", paste(island,"FPC", sep= "_"), 
                       paste(m, island,"FPC_final", sep = "_"),sep = "/")
      dir.create(fpc_dir, recursive = T) #Do this for each RCP
      print(fpc_dir)

  

      ## ANNUAL ##
      
      
      presentday_annual <- raster(paste("D:/CMIP5_CHELSA/RstudioProc_CMIP5_outputs/CMIP5_1979-2013_PresentDay", paste(island, "PresentDay", sep = "_"),
                                        paste(island, "1979-2013_annualmean.tif", sep = "_"), sep = "/"))
      print(presentday_annual)
      
    
      
      absch_annual <- raster(paste("D:/CMIP5_CHELSA/RstudioProc_CMIP5_outputs/CMIP5_AbsoluteChange", paste(island, "AbsoluteChange_final", sep = "_"),
                                   paste(m, island, "AbsoluteChange_final", sep = "_"), paste(m,a,"AbsoluteChange", "Tutuila.tif", sep = "_"), sep = "/"))
      print(absch_annual)
      
      
      # FPC = (absch/pres day)*100
      annual_fpc_unscaled  = absch_annual/presentday_annual
      annual_fpc = annual_fpc_unscaled*100
      fpc_name <- paste(fpc_dir, paste(m,"annual_FPC",island, sep = "_"),sep = "/")
      writeRaster(annual_fpc, fpc_name, overwrite = T, format = "GTiff" )


      
      
      
      ## WET SEASON ##
      a = ave_list[2]
      presentday_wet <- raster(paste("D:/CMIP5_CHELSA/RstudioProc_CMIP5_outputs/CMIP5_1979-2013_PresentDay", paste(island, "PresentDay", sep = "_"),
                                     paste(island, "1979-2013_11-04_wetseasonmean_Tutuila.tif", sep = "_"), sep = "/"))
      print(presentday_wet)
      
      wetseason_absch <- raster(paste("D:/CMIP5_CHELSA/RstudioProc_CMIP5_outputs/CMIP5_AbsoluteChange", paste(island, "AbsoluteChange_final", sep = "_"),
                                      paste(m, island, "AbsoluteChange_final", sep = "_"), paste(m,a,"AbsoluteChange", "Tutuila.tif", sep = "_"), sep = "/"))
      print(wetseason_absch)
      
      
      # FPC = (absch/pres day)*100
      wetseason_fpc_unscaled = wetseason_absch/presentday_wet
      wetseason_fpc = wetseason_fpc_unscaled*100
      wet_fpc_name <- paste(fpc_dir, paste(m,"11-04_wetseason_FPC",island, sep = "_"),sep = "/")
      writeRaster(wetseason_fpc, wet_fpc_name, overwrite = T, format = "GTiff")
      
      
      
      
      
      
      
      
      ## DRY SEASON ##
      a = ave_list[3]
      presentday_dry <- raster(paste("D:/CMIP5_CHELSA/RstudioProc_CMIP5_outputs/CMIP5_1979-2013_PresentDay", paste(island, "PresentDay", sep = "_"),
                                     paste(island, "1979-2013_05-10_dryseasonmean_Tutuila.tif", sep = "_"), sep = "/"))
      print(presentday_dry)
      
      dryseason_absch <- raster(paste("D:/CMIP5_CHELSA/RstudioProc_CMIP5_outputs/CMIP5_AbsoluteChange", paste(island, "AbsoluteChange_final", sep = "_"),
                                      paste(m, island, "AbsoluteChange_final", sep = "_"), paste(m,a,"AbsoluteChange", "Tutuila.tif", sep = "_"), sep = "/"))
      print(dryseason_absch)
      
      # FPC = (absch/pres day)*100
      dryseason_fpc_unscaled = dryseason_absch/presentday_dry
      dryseason_fpc = dryseason_fpc_unscaled*100
      dry_fpc_name <- paste(fpc_dir, paste(m,"05-10_dryseason_FPC",island, sep = "_"),sep = "/")
      writeRaster(dryseason_fpc, dry_fpc_name, overwrite = T, format = "GTiff")
  
}
