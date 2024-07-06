# Clip all of the historical to Guam and Tutuila extent 
install.packages(sp)
install.packages(raster)
library(sp) #need sp to access extent function

library(raster)


setwd("F:/CMIP6_CHELSA/CMIP6_data_0623/2071-2100/UKESM1-0-LL/ssp585/precip")
#setwd("F:/CMIP6_CHELSA/CMIP6_data_0723_clippedextent/CMIP6_1981-2010") - present day
output_dir = "F:/CMIP6_CHELSA/CMIP6_data_0723_clippedextent/Guam_CHELSA_CMIP6_data/Guam_2071-2100_data/UKES_2071-2100"
output_dir2 = "F:/CMIP6_CHELSA/CMIP6_data_0723_clippedextent/Tutuila_CHELSA_CMIP6_data/Tutuila_2071-2100_data/UKES_2071-2100"


##First need to create a list of the files in the 1981-2010 folder
clim_list = list.files(pattern = ".tif$", full.names = T, recursive = T)
print(clim_list)




# GUAM EXTENT
#Loop to crop all rasters to Guam extent - run on each folder
for (i in clim_list) {
  #defining the first tif as raster
  r1 <-raster(i) 
  
  r1_guam_crop <- crop(r1, extent(144.448, 145.061, 13.172, 13.734))

  x<-paste(output_dir, paste0(substr(i,36,57),"_UKES_guam.tif"), sep="/")
  # x variable is defined as the name of the output directory, plus the name of the original file with 
  # _guam indicator at the end
  writeRaster(r1_guam_crop, filename=x, overwrite=TRUE, format="GTiff")
}
  
  

  
# TUTUILA EXTENT 
for(i in clim_list){
  #defining the first tif as raster
  r2 <- raster(i)
  
  r2_tutuila_crop <- crop(r2, extent(-170.9237, -170.4265, -14.457, -14.182))
  
  x<-paste(output_dir2, paste0(substr(i, 36, 57),"_UKES_tutuila.tif"),sep="/")
  # x variable is defined as the name of the output directory, plus the name of the original file with 
  # _guam indicator at the end
  writeRaster(r2_tutuila_crop, filename=x, overwrite=TRUE, format="GTiff")
}

  
  
  





  
  # ALL OUTPUT RASTERS ARE 0.1 VALUE OF ORIGINAL - I AM NOT SURE HOW  - BUTTHEY WERE SCALED
  # THEY ARE ALL WGS CS
  
  
  






























  # TEST LOOP #
  #r1 <-raster(i) 
  
  #need to get the extent of the raster first so we can clip properly
  #print(extent(r1))
  #xmin       : -180.0001 
  #xmax       : 179.9999 
  #ymin       : -90.00014 
  #ymax       : 83.99986 
  
  #x1 <- crop(r1, extent(144.448, 145.061, 13.172, 13.734))
                      #extent(xmin, xmax, ymin, ymax)
  #writeRaster(x1, filename = "1981-2010_guam_crop_test.tif", overwrite=TRUE, format="GTiff")
  



  ## NOT NEEDED ##

#defining the extent of the raster
#x1 <- crop(r1, extent (-180, 0, -90, 84))
#x2 <- crop(r1, extent (0, 180, -90, 84))
#extent(x1) <- c(180, 360, -90, 84)

#r1_global <- merge(x1, x2)

    # Was originally used in example - NOT THIS - to define and then crop to Pacific extent (when the layers were being projected)
  
  