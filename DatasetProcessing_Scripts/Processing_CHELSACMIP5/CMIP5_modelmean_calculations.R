# CHELSA CMIP5 annual and seasonal averaging PER MODEL (GLOBAL)
  # Monthly global scale climate model projections are summed for each model

install.packages(sp)
install.packages(raster)
library(sp) #need sp to access extent function
library(raster)


island = "Tutuila"
model_list = c("ACCESS1-0", "bcc-csm1-1", "BNU-ESM", "CanESM2", "CCSM4", "CESM1-BGC","CESM1-CAM5","CMCC-CESM",
               "CMCC-CM", "CMCC-CMS", "CNRM-CM5", "CSIRO-Mk3-6-0", "CSIRO-Mk3L-1-2", 
               "EC-EARTH", "FGOALS-g2", "FIO-ESM", "GFDL-CM3", "GFDL-ESM2G", "GFDL-ESM2M",
               "GISS-E2-H", "GISS-E2-H-CC", "GISS-E2-R", "GISS-E2-R-CC", "HadGEM2-AO", 
               "HadGEM2-CC", "HadGEM2-ES", "inmcm4", "IPSL-CM5A-LR", "IPSL-CM5A-MR","MIROC5",
               "MIROC-ESM", "MIROC-ESM-CHEM", "MPI-ESM-LR", "MPI-ESM-MR", "MRI-CGCM3", "MRI-ESM1","NorESM1-M",
               "NorESM1-ME")
rcp_list = c("RCP4.5", "RCP8.5")
ave_list = c("annual", "11-04_wetseason", "05-10_dryseason")

l = model_list[1]
m = rcp_list[1]
a = ave_list[1]


#### FIRST CLIP ALL TO ISLAND EXTENT ##### (was giving me issue with the extent when originally tried to stack)

#working dir as folders were raw model monthly data is
wd <- paste("D:/CMIP5_CHELSA", m, l, sep = "/")
print(wd)
setwd(wd)


clip_ouput <- paste("D:/CMIP5_CHELSA/RstudioProc_CMIP5_outputs/CMIP5_raw_islandextent/Tutuila_CMIP5data/RCP8.5", l, sep= "/")

all_list = list.files(pattern = ".tif", full.names = T, recursive = T)
all_rast_list <- all_list[!grepl(".aux.xml|.ovr", all_list)]
print(all_rast_list)


#TUTUILA extent
for(i in all_rast_list){
  #defining the first tif as raster
  r2 <- raster(i)

  r2_tutuila_crop <- crop(r2, extent(-170.9237, -170.4265, -14.457, -14.182))

  x<-paste(clip_ouput, paste(i, "tutuila", sep = "_"),sep="/")
  # x variable is defined as the name of the output directory, plus the name of the original file with
  # _guam indicator at the end
  writeRaster(r2_tutuila_crop, filename=x, overwrite=TRUE, format="GTiff")
}




# GUAM extent
for (i in all_rast_list) {
  #defining the first tif as raster
  r1 <-raster(i) 
  
  r1_guam_crop <- crop(r1, extent(144.448, 145.061, 13.172, 13.734))
  
  x<-paste(clip_ouput, paste(i, "guam", sep = "_"),sep="/")
  print(x)
  # x variable is defined as the name of the output directory, plus the name of the original file with 
  # _guam indicator at the end
  writeRaster(r1_guam_crop, filename=x, overwrite=TRUE, format="GTiff")
}



##########################################################################

        ##calculating model averages##

island = "Guam"
model_list = c("ACCESS1-0", "bcc-csm1-1", "BNU-ESM", "CanESM2", "CCSM4", "CESM1-BGC","CESM1-CAM5",#"CMCC-CESM",
               "CMCC-CM", "CMCC-CMS", "CNRM-CM5", "CSIRO-Mk3-6-0", "CSIRO-Mk3L-1-2", 
               "EC-EARTH", "FGOALS-g2", "FIO-ESM", "GFDL-CM3", "GFDL-ESM2G", "GFDL-ESM2M",
               "GISS-E2-H", "GISS-E2-H-CC", "GISS-E2-R", "GISS-E2-R-CC", "HadGEM2-AO", 
               "HadGEM2-CC", "HadGEM2-ES", "inmcm4", "IPSL-CM5A-LR", "IPSL-CM5A-MR","MIROC5",
               "MIROC-ESM", "MIROC-ESM-CHEM", "MPI-ESM-LR", "MPI-ESM-MR", "MRI-CGCM3", #"MRI-ESM1",
               "NorESM1-M",
               "NorESM1-ME")


                ## Total 38 Models, but RCP4.5 only has 36, and RCP8.5 has 37. Models vary between RCPs. 
                  # RCP8.5 doesn't have CSIRO-Mk3L-1-2
                  # RCP4.5 doesn't have CMCC-CESM, or MRI-ESM1

rcp_list = c("RCP4.5", "RCP8.5")
ave_list = c("annual", "11-04_wetseason", "05-10_dryseason")

l = model_list[1] #manually changed per model,rcp,and island
m = rcp_list[1]


for (l in model_list[35]){
  for(m in rcp_list[1]) {
    # for (a in ave_list[1]){
      
      # Setting working directory as model folder containing monthly data
    
      #working dir as folders were raw model monthly data is
      wd <- paste("D:/CMIP5_CHELSA/RstudioProc_CMIP5_outputs/CMIP5_raw_islandextent", paste(island, "CMIP5data", sep="_"), m, l, sep = "/")
      print(wd)
      setwd(wd)
      
      # Setting the output folder

      output_dir <- paste("D:/CMIP5_CHELSA/RstudioProc_CMIP5_outputs/CMIP5_ModelAverages", paste(island, "ModelAve", sep="_"), m, sep = "/")
      print(output_dir)
      #dir.create(output_dir)
      
      
      # ANNUAL #
      all_list = (list.files(pattern = ".tif", full.names = T, recursive = T))
      annual_list <- all_list[!grepl(".aux.xml|.ovr", all_list)]
      print(annual_list)
      
      
      annual_stack <- stack(annual_list)
      annual_mean <- sum(annual_stack)
      raster_names <- paste(output_dir, paste(l,m,"annualmean",island, sep = "_"), sep = "/")
      writeRaster(annual_mean, filename = raster_names, overwrite = TRUE, format = "GTiff")
      
      # WET SEASON #
      
      wetseason = list.files(wd, pattern = "_1_|_2_|_3_|_4_|_11_|_12_", all.files = F, full.names = T, recursive = T)
      wetseason_list <- wetseason[!grepl(".aux.xml", wetseason)]
      print(wetseason_list)
      
      wetseason_stack <- stack(wetseason_list)
      wetseason_mean <- sum(wetseason_stack)
      wetseas_name <- paste(output_dir, paste(l,m,"11-04_wetseasonmean",island, sep = "_"), sep = "/")
      writeRaster(wetseason_mean, filename = wetseas_name, overwrite = TRUE, format = "GTiff")
      
      # DRY SEASON #
      
      dryseason = list.files(wd, pattern = "_5_|_6_|_7_|_8_|_9_|_10_", all.files = F, full.names = T, recursive = T)
      dryseason_list <- dryseason[!grepl(".aux.xml", dryseason)]
      print(dryseason_list)
      
      dryseason_stack <- stack(dryseason_list)
      dryseason_mean <- sum(dryseason_stack)
      dryseas_name <- paste(output_dir, paste(l,m,"05-10_dryseasonmean",island, sep = "_"), sep = "/")
      writeRaster(dryseason_mean, filename = dryseas_name, overwrite = TRUE, format = "GTiff")
      
      
    #}
  }
}








