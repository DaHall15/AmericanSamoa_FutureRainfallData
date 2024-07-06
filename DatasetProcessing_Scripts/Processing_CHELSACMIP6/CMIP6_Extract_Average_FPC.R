# This Script was used to extract the average Future Percent Change (FPC) for each island

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


############################################  F         P            C   ##################################################################
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


#presentday_annual <- "D:/CMIP6_CHELSA/CMIP6_data_0723_clippedextent/Tutuila_CMIP6_means/Tutuila_1981-2010_means/Tutuila_1981-2010_annual.mean.tif"


#future_annual_dir <- paste("D:/CMIP6_CHELSA/CMIP6_data_0723_clippedextent/MMEs", paste(island,"MMEs", sep= "_"), 
                           #paste(k,island,"MMEs", sep = "_"), paste(k,m,"MME",island, sep = "_"),sep = "/")
#future_annual <- list.files(future_annual_dir, pattern = "annual")
#print(future_annual)


# Setting working directory FOR ONLY ONE MODEL MME
#wd <- paste("D:/CMIP6_CHELSA/CMIP6_data_0723_clippedextent/Tutuila_CMIP6_means", paste(island,k,"model_means", sep = "_"), paste(l,k,"means", sep= "_"), sep = "/")
#print(wd)
#setwd(wd)





#historical
#setwd("F:/CMIP6_CHELSA/CMIP6_data_0723_clippedextent/Guam_CHELSA_CMIP6_data/Guam_1981-2010_data")
#output_dir = "F:/CMIP6_CHELSA/CMIP6_data_0723_clippedextent/Guam_CHELSA_CMIP6_data/Guam_1981-2010_means"


#setwd("F:/CMIP6_CHELSA/CMIP6_data_0723_clippedextent/Guam_CHELSA_CMIP6_data/Guam_2011-2040_data/GFDL_2011-2040")
#wd = "F:/CMIP6_CHELSA/CMIP6_data_0723_clippedextent/Guam_CHELSA_CMIP6_data/Guam_2011-2040_data/GFDL_2011-2040"
# Guam #
#output_dir = "F:/CMIP6_CHELSA/CMIP6_data_0723_clippedextent/Guam_CMIP6_means/Guam_2011-2040_means"
# Tutuila #
#output_dir2 = "F:/CMIP6_CHELSA/CMIP6_data_0723_clippedextent/Tutuila_CHELSA_CMIP6_data/Tutuila_1981-2010_data"



#MMscenarios_annual <- list.files(path = paste("D:/CMIP6_CHELSA/CMIP6_data_0723_clippedextent/Guam_CMIP6_means//", paste(island,k,"model_means", sep = "_"), sep = "/"), 
                                 #pattern = "SSP126", recursive = TRUE, full.names = TRUE)  #paste(l,k,"means", sep= "_"), sep = "/") to specify model folder
#print(MMscenarios_annual)

#MMscenario_list_annual <- MMscenarios_annual[!grepl(".aux.xml|11-04|05-10", MMscenarios_annual)]
#print(MMscenario_list_annual)








############### Don't delete used to develop 1981-2010 means ###############################

##First need to create a list of the files in the 1981-2010 folder

# ANNUAL #
annual_list = list.files(pattern = past0(substr(ssp,"","")), full.names = T, recursive = T)
print(annual_list)

annual_list = list.files(pattern = ".tif$", full.names = T, recursive = T)
print(annual_list)


annual_stack <- stack(annual_list)
annual_mean <- sum(annual_stack)
raster_names <- paste(output_dir, paste0(c(island, "1981-2010_annualmean"), collapse = "_"), sep = "/")
writeRaster(annual_mean, filename = raster_names, overwrite = TRUE, format = "GTiff")


 
# WET SEASON #

wetseason = list.files(wd, pattern = "_01_|_02_|_03_|_04_|_11_|_12_", all.files = F, full.names = T, recursive = T)
wetseason_list <- wetseason[!grepl(".aux.xml", wetseason)]
print(wetseason_list)

wetseason_stack <- stack(wetseason_list)
wetseason_mean <- sum(wetseason_stack)
wetseas_name <- paste(output_dir, paste0(c(island, "1981-2010_11-04_wetseason_mean"), collapse = "_"), sep = "/")
writeRaster(wetseason_mean, filename = wetseas_name, overwrite = TRUE, format = "GTiff")

# DRY SEASON #

dryseason = list.files(wd, pattern = "_05_|_06_|_07_|_08_|_09_|_10_", all.files = F, full.names = T, recursive = T)
dryseason_list <- dryseason[!grepl(".aux.xml", dryseason)]
print(dryseason_list)

dryseason_stack <- stack(dryseason_list)
dryseason_mean <- sum(dryseason_stack)
dryseas_name <- paste(output_dir, paste0(c(island, "1981-2010_05-10_dryseason_mean"), collapse = "_"), sep = "/")
writeRaster(dryseason_mean, filename = dryseas_name, overwrite = TRUE, format = "GTiff")



# FOR LOOP TO LOOP THROUGH ALL: # 
  # TIME PERIODS
  # SCENARIOS
  # MODELS

time_list = c("2010-2040", "2041-2070", "2071-2100")
ssp_list = c("SSP126", "SSP370","SSP585")
model_list = c("GDFL", "IPSL", "MPI", "MRI", "UKES")


for (i in annual_list) {
  #creating a raster stack so they'll be able to be summed
  annual_stack <- stack(annual_list)
  
  #annual_mean <- calc(annual_stack, fun = sum())  #using calc and sum() functions to calculate the sum of the pixels within the raster stack
  annual_mean <- sum(annual_stack)
  raster_names <- paste(output_dir, paste0(substr(i, 1, 33),"_annualmean"), sep = "/")
  writeRaster(annual_mean, filename = raster_names, overwrite = TRUE, format = "GTiff")
}

