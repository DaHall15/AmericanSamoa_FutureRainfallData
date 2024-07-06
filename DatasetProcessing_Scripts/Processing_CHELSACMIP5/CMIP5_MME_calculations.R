# This scrip is used to develop Mulit-Model Ensembles (MMEs) from the CMIP5 model means from the script 'CMIP5_modelmean_calculations'

install.packages("sp")
install.packages("raster")
install.packages("utils")
install.packages("sf")
library(sp) #need sp to access extent function
library(raster)
library(utils)
library(sf)


island = "Guam"

rcp_list = c("RCP4.5", "RCP8.5")
ave_list = c("annual", "11-04_wetseason", "05-10_dryseason")

m = rcp_list[2]
a = ave_list[3]


for (m in rcp_list[2]){
      for (a in ave_list[3]){
      
      # Setting working directory
      wd <- paste("D:/CMIP5_CHELSA/RstudioProc_CMIP5_outputs/CMIP5_ModelAverages", paste(island,"ModelAve", sep = "_"), paste(m), 
                  paste(island, m, a, "ave", sep="_"), sep = "/")
      print(wd)
      setwd(wd)
      
      # Setting the output folder
      output_dir <- paste("D:/CMIP5_CHELSA/RstudioProc_CMIP5_outputs/CMIP5_MME", paste(island,"MMEs", sep= "_"), paste(m,island,"MMEs", sep = "_"),
                          paste(m,a,"MME",island, sep = "_"),sep = "/")
      dir.create(output_dir, recursive = T) # directory created only whne working with new RCP
      print(output_dir)
  
      
      # "A" Variable runs through annual and seasonal #
      MMscenarios <- list.files(wd)
      print(MMscenarios)
      
      #reading all files in as rasters for the stack
      for (r in MMscenarios){
        raster(r)
      }
      
      stack <- stack(MMscenarios)
      annual <- (sum(stack))/37     #36 for RCP4.5, 37 for RCP8.5
      raster_names <- paste(output_dir, paste(m,a,"MME",island, sep = "_"), sep = "/")
      writeRaster(annual, filename = raster_names, overwrite = TRUE, format = "GTiff")
      
      }
    }
      









###### Scrap Code
      # # WET SEASON #
      # MMwetseason = list.files(path = paste("D:/CMIP6_CHELSA/CMIP6_data_0723_clippedextent/Tutuila_CMIP6_means", paste(island,k,"model_means", sep = "_"), sep = "/"), 
      #                          pattern = "SSP126", recursive = TRUE, full.names = TRUE)
      # MMwetseason_list <- MMwetseason[!grepl(".aux.xml|annual|05-10", MMwetseason)]
      # print(MMwetseason_list)
      # #reading all files in as rasters for the stack
      # for (r in MMwetseason_list){
      #   raster(r)
      # }
      # 
      # wetseason_stack <- stack(MMwetseason_list)
      # wetseason_mean <- (sum(wetseason_stack))/5    #averaging the pixels from each of 5 models
      # wetseas_name <- paste(output_dir, paste(k,m,"11-04_wetseasonmean_MME",island, sep = "_"), sep = "/")
      # writeRaster(wetseason_mean, filename = wetseas_name, overwrite = TRUE, format = "GTiff")
      # 
      # 
      # # DRY SEASON #
      # 
      # MMdryseason = list.files(path = paste("D:/CMIP6_CHELSA/CMIP6_data_0723_clippedextent/Tutuila_CMIP6_means", paste(island,k,"model_means", sep = "_"), sep = "/"), 
      #                        pattern = "SSP126", recursive = TRUE, full.names = TRUE)
      # MMdryseason_list <- MMdryseason[!grepl(".aux.xml|annua|11-04", MMdryseason)]
      # print(MMdryseason_list)
      # #reading all files in as rasters for the stack
      # for (r in MMdryseason_list){
      #   raster(r)
      # }
      # 
      # dryseason_stack <- stack(MMdryseason_list)
      # dryseason_mean <- (sum(dryseason_stack))/5
      # dryseas_name <- paste(output_dir, paste(k,m,"05-10_dryseasonmean_MME",island, sep = "_"), sep = "/")
      # writeRaster(dryseason_mean, filename = dryseas_name, overwrite = TRUE, format = "GTiff")
      # 
      
   



# Setting working directory FOR ONLY ONE MODEL MME
#wd <- paste("D:/CMIP6_CHELSA/CMIP6_data_0723_clippedextent/Guam_CMIP6_means", paste(island,k,"model_means", sep = "_"), paste(l,k,"means", sep= "_"), sep = "/")
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





