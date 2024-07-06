# Within this script - Zhang and Wang data is processed:
    # Present day (historical) averages for annual, wet season and dry season are calculated
    # Averages for scenarios are calculated (annual, wet season and dry season for RCP4.5 and RCP8.5)
    # Absolute Change is calculated and output rasters are written
    # Future Percent Change is calculated and output rasters are written

install.packages("sp")
install.packages("raster")
install.packages("sf")
library(sp) #need sp to access extent function

library(raster)
library(sf)

island = "Tutuila"
wd = "D:/Zhang_Data/Guam_Raster/RAIN_present/annual/annual_sum"
setwd(wd)
output_dir = "D:/Zhang_Data/Processed_Averages/Tutuila_averages/PresentDay_means_Tutuila"


#output_dir = "D:/Zhang_Data/Guam_calculations/PresentDay_calculations_Rprocess"
#dir.create(output_dir)
#output_dir2 = "F:/CMIP6_CHELSA/CMIP6_data_0723_clippedextent/Tutuila_CHELSA_CMIP6_data/Tutuila_1981-2010_data"



##First need to create a list of the files in the 1981-2010 folder

# ANNUAL LIST # Guam

output_dir = "D:/Zhang_Data/Processed_Averages/Guam_averages/PresentDay_means_Guam"
wd = "D:/Zhang_Data/Guam_Raster/RAIN_present/annual/annual_sum"
setwd(wd)
annual_list = list.files(pattern = ".tif$", full.names = T, recursive = T)
print(annual_list)

annual_raster <- lapply(annual_list, raster)

annual_stack <- stack(annual_raster)
annual_mean <- sum(annual_stack)/20
raster_names <- paste(output_dir, paste0("Guam_1990-2009_present_annualmean"), sep = "/")
writeRaster(annual_mean, filename = raster_names, overwrite = TRUE, format = "GTiff")


# ANNUAL LIST # Tutuila
annual_list = list.files(pattern = "present_prj.tif$", full.names = T, recursive = T)
print(annual_list)

annual_raster <- lapply(annual_list, raster)
annual_stack <- stack(annual_raster)
annual_mean <- (sum(annual_stack))*10
raster_names <- paste(output_dir, paste0("Tutuila_1990-2009_present_annualmean"), sep = "/")
writeRaster(annual_mean, filename = raster_names, overwrite = TRUE, format = "GTiff")



# WET SEASON #
#Monthly Sum for working directory bc of months

pd_years = c("1990", "1991", "1992", "1993", "1994", "1995", "1996", "1997", "1998", "1999", "2000", "2001", "2002",
            "2003", "2004", "2005", "2006", "2007", "2008", "2009")
y = pd_years[1]

for (y in pd_years[20]){
  
  monthly_sum = "D:/Zhang_Data/Guam_Raster/RAIN_present/monthly/monthly_sum"
  wetseason = list.files(monthly_sum, pattern = "_2009-", all.files = F, full.names = T, recursive = T)
  wetseason_list <- wetseason[!grepl(".aux.xml|-05_|-06_|-07_|-08_|-09_|-10_", wetseason)]
  print(wetseason_list)
  wetseason_raster <- lapply(wetseason_list, raster)
  
  output_wet ="D:/Zhang_Data/Processed_Averages/Guam_averages/PresentDay_means_Guam"

  wetseason_stack <- stack(wetseason_raster)
  wetseason_mean <- sum(wetseason_stack)
  wetseas_name <- paste(output_wet, paste("Guam", y, "present_11-04_wetseasonmean", sep = "_"), sep = "/")
  writeRaster(wetseason_mean, filename = wetseas_name, overwrite = TRUE, format = "GTiff")
}


# WETSEASON # Tutuila

  monthly_sum = "D:/Zhang_Data/Tutuila_Raster"
  wetseason = list.files(monthly_sum, pattern = "present_prj.tif$", all.files = F, full.names = T, recursive = T)
  wetseason_list <- wetseason[!grepl(".aux.xml|5|6|7|8|9|10|yearly", wetseason)]
  print(wetseason_list)
  wetseason_raster <- lapply(wetseason_list, raster)
  
  output_wet ="D:/Zhang_Data/Processed_Averages/Tutuila_averages/PresentDay_means_Tutuila"
  
  wetseason_stack <- stack(wetseason_raster)
  wetseason_mean <- (sum(wetseason_stack))*10
  wetseas_name <- paste(output_wet, paste("Tutuila", "present_11-04_wetseasonmean", sep = "_"), sep = "/")
  writeRaster(wetseason_mean, filename = wetseas_name, overwrite = TRUE, format = "GTiff")


  # DRY SEASON #

for (y in pd_years[20]){
  
  monthly_sum = "D:/Zhang_Data/Guam_Raster/RAIN_present/monthly/monthly_sum"
  dryseason = list.files(monthly_sum, pattern = "2009", all.files = F, full.names = T, recursive = T)
  dryseason_list <- dryseason[!grepl(".aux.xml|04_|03_|02_|01_|11_|12_", dryseason)]
  print(dryseason_list)
  dryseason_raster <- lapply(dryseason_list, raster)

  output_dry ="D:/Zhang_Data/Processed_Averages/Guam_averages/PresentDay_means_Guam"
  
  dryseason_stack <- stack(dryseason_raster)
  dryseason_mean <- sum(dryseason_stack)
  dryseas_name <- paste(output_dry, paste("Guam", y, "present_05-10_dryseasonmean", sep = "_"), sep = "/")
  writeRaster(dryseason_mean, filename = dryseas_name, overwrite = TRUE, format = "GTiff")
}

  # DRYSEASON # Tutuila
  
  monthly_sum = "D:/Zhang_Data/Tutuila_Raster"
  dryseason = list.files(monthly_sum, pattern = "present_prj.tif$", all.files = F, full.names = T, recursive = T)
  dryseason_list <- dryseason[!grepl(".aux.xml|4|3|2|1_|11|12|yearly", dryseason)]
  print(dryseason_list)
  dryseason_raster <- lapply(dryseason_list, raster)
  
  output_dry ="D:/Zhang_Data/Processed_Averages/Tutuila_averages/PresentDay_means_Tutuila"
  
  dryseason_stack <- stack(dryseason_raster)
  dryseason_mean <- (sum(dryseason_stack))*10
  dryseas_name <- paste(output_dry, paste("Tutuila", "present_05-10_dryseasonmean", sep = "_"), sep = "/")
  writeRaster(dryseason_mean, filename = dryseas_name, overwrite = TRUE, format = "GTiff")



#averaging the present day period   # Only for Guam!


  
  output_yw = "D:/Zhang_Data/Processed_Averages/Guam_averages/PresentDay_means_Guam"
  
  yearly_sum_wet = "D:/Zhang_Data/Processed_Averages/Guam_averages/PresentDay_means_Guam/Guam_1990-2009_wetseason_means"
  yearly_wet_list <- list.files(yearly_sum_wet, all.files = T, full.names = T, recursive = T)
  print(yearly_wet_list)
  yearlywet_rast <- lapply(yearly_wet_list, raster)
  wet_yearly_stack = stack(yearlywet_rast)
  wet_yearly_mean = sum(wet_yearly_stack)/20
  wet_yearly_name <- paste(output_yw, paste("Guam_present_11-04_wetseasonmean"), sep = "/")
  writeRaster(wet_yearly_mean, filename = wet_yearly_name, overwrite = TRUE, format = "GTiff")




  
  
  output_yd = "D:/Zhang_Data/Processed_Averages/Guam_averages/PresentDay_means_Guam"
  
  yearly_sum_dry = "D:/Zhang_Data/Processed_Averages/Guam_averages/PresentDay_means_Guam/Guam_1990-2009_dryseason_means"
  yearly_dry_list <- list.files(yearly_sum_dry, all.files = T, full.names = T, recursive = T)
  print(yearly_dry_list)
  yearlydry_rast <- lapply(yearly_dry_list, raster)
  dry_yearly_stack = stack(yearlydry_rast)
  dry_yearly_mean = sum(dry_yearly_stack)/20
  dry_yearly_name <- paste(output_yd, paste("Guam_present_05-10_dryseasonmean"), sep = "/")
  writeRaster(dry_yearly_mean, filename = dry_yearly_name, overwrite = TRUE, format = "GTiff")
  


###############################################################

#RCP4.5 Annual and seasonal ave
  
  
# Annual RCP4.5  #code run for both RCP4.5 and RCP8.5, but RCPs just searched and replaced...
  
  RCP45_wd = "D:/Zhang_Data/Guam_Raster/RAIN_rcp45/annual/annual_sum"
  RCP45_od = "D:/Zhang_Data/Processed_Averages/Guam_averages/RCP45_Guam"
  
  
  annualrcp45_list = list.files(RCP45_wd,pattern = ".tif$", full.names = T, recursive = T)
  print(annualrcp45_list)
  
  annual_raster <- lapply(annualrcp45_list, raster)
  
  annual_stack <- stack(annual_raster)
  annual_mean <- (sum(annual_stack)/20) 
  raster_names <- paste(RCP45_od, paste0("Guam_RCP45_2080-2099_annualmean"), sep = "/")
  writeRaster(annual_mean, filename = raster_names, overwrite = TRUE, format = "GTiff")
  
  
# Wet Season RCP4.5 
  
  RCP45_wet_wd = "D:/Zhang_Data/Guam_Raster/RAIN_rcp45/monthly/monthly_sum"
  RCP45_wet_od = "D:/Zhang_Data/Processed_Averages/Guam_averages/RCP45_Guam"
  
  wetrcp45 = list.files(RCP45_wet_wd,pattern = "rcp45", full.names = T, recursive = T)
  wetrcp45_list <- wetrcp45[!grepl(".aux.xml|05_|06_|07_|08_|09_|10_", wetrcp45)]
  print(wetrcp45_list)
  
  wetrcp45_raster <- lapply(wetrcp45_list, raster)
  
  wetrcp45_stack <- stack(wetrcp45_raster)
  wetrcp45_mean <- (sum(wetrcp45_stack)/20)
  #wetrcp45_mean <- (sum(wetrcp45_stack))*10
  wetrcp45_names <- paste(RCP45_od, paste0("Guam_RCP45_2080-2099_11-04_wetseasonmean"), sep = "/")
  writeRaster(wetrcp45_mean, filename = wetrcp45_names, overwrite = TRUE, format = "GTiff")
  

  
# Dry Season RCP4.5 
  
  RCP45_dry_wd = "D:/Zhang_Data/Guam_Raster/RAIN_rcp45/monthly/monthly_sum"
  RCP45_dry_od = "D:/Zhang_Data/Processed_Averages/Guam_averages/RCP45_Guam"
  
  dryrcp45 = list.files(RCP45_dry_wd,pattern = ".tif", full.names = T, recursive = T)
  dryrcp45_list <- dryrcp45[!grepl(".aux.xml|04_|03_|02_|1_|11_|12_", dryrcp45)]
  print(dryrcp45_list)
  
  dryrcp45_raster <- lapply(dryrcp45_list, raster)
  
  dryrcp45_stack <- stack(dryrcp45_raster)
  dryrcp45_mean <- (sum(dryrcp45_stack)/20)
  #dryrcp45_mean <- (sum(dryrcp45_stack))*10
  dryrcp45_names <- paste(RCP45_od, paste0("Guam_RCP45_2080-2099_05-10_dryseasonmean"), sep = "/")
  writeRaster(dryrcp45_mean, filename = dryrcp45_names, overwrite = TRUE, format = "GTiff")
  
  
  ###############################################################
  
  #RCP8.5 Annual and seasonal ave
  
  
  
  #RCP8.5 Annual and seasonal ave
  
  
  # Annual RCP8.5 
  
  island = "Guam"
  
  RCP85_wd = "D:/Zhang_Data/Guam_Raster/RAIN_rcp85/monthly/monthly_sum"
  RCP85_od = "D:/Zhang_Data/Processed_Averages/Guam_averages/RCP85_Guam"
  
  
  annualrcp85_list = list.files(RCP85_wd,pattern = "rcp85", full.names = T, recursive = T)
  print(annualrcp85_list)
  
  annual_raster <- lapply(annualrcp85_list, raster)
  
  annual_stack <- stack(annual_raster)
  annual_mean <- (sum(annual_stack))*10
  raster_names <- paste(RCP85_od, paste0("Tutuila_RCP85_2080-2099_annualmean"), sep = "/")
  writeRaster(annual_mean, filename = raster_names, overwrite = TRUE, format = "GTiff")
  
  
  # Wet Season RCP8.5 
  
  RCP85_wet_wd = "D:/Zhang_Data/Tutuila_Raster"
  RCP85_wet_od = "D:/Zhang_Data/Processed_Averages/Tutuila_averages/RCP85_Tutuila"
  
  wetrcp85 = list.files(RCP85_wet_wd,pattern = "rcp85_prj.tif$", full.names = T, recursive = T)
  wetrcp85_list <- wetrcp85[!grepl(".aux.xml|_5_|_6_|_7_|_8_|_9_|10_", wetrcp85)]
  print(wetrcp85_list)
  
  wetrcp85_raster <- lapply(wetrcp85_list, raster)
  
  wetrcp85_stack <- stack(wetrcp85_raster)
  wetrcp85_mean <- (sum(wetrcp85_stack))*10
  wetrcp85_names <- paste(RCP85_od, paste0("Tutuila_RCP85_2080-2099_11-04_wetseasonmean"), sep = "/")
  writeRaster(wetrcp85_mean, filename = wetrcp85_names, overwrite = TRUE, format = "GTiff")
  
  
  
  # Dry Season RCP8.5 
  
  RCP85_dry_wd = "D:/Zhang_Data/Tutuila_Raster"
  RCP85_dry_od = "D:/Zhang_Data/Processed_Averages/Tutuila_averages/RCP85_Tutuila"
  
  dryrcp85 = list.files(RCP85_dry_wd,pattern = "rcp85_prj.tif$", full.names = T, recursive = T)
  dryrcp85_list <- dryrcp85[!grepl(".aux.xml|_4_|_3_|_2_|_1_|11_|12_", dryrcp85)]
  print(dryrcp85_list)
  
  dryrcp85_raster <- lapply(dryrcp85_list, raster)
  
  dryrcp85_stack <- stack(dryrcp85_raster)
  dryrcp85_mean <- (sum(dryrcp85_stack))*10
  dryrcp85_names <- paste(RCP85_od, paste0("Tutuila_RCP85_2080-2099_05-10_dryseasonmean"), sep = "/")
  writeRaster(dryrcp85_mean, filename = dryrcp85_names, overwrite = TRUE, format = "GTiff")
  
  
############ Absolute Change ############

  
  ## ANNUAL ##          #code run for both RCP4.5 and RCP8.5, but RCPs just searched and replaced...
  
  RCP85_absch_od = "D:/Zhang_Data/Guam_calculations/PresentDay_calculations_Rprocess/GUAM_RCP85_RProcess/Guam_RCP85_Absch"
  
  
  future_annual <- raster(paste0("D:/Zhang_Data/Guam_calculations/PresentDay_calculations_Rprocess/GUAM_RCP85_RProcess/Guam_RCP85_2080-2099_annualmean.tif"))

  
  pd_annual <- raster(paste("D:/Zhang_Data/Guam_calculations/PresentDay_calculations_Rprocess/Guam_1990-2009_present_annualmean.tif"))
 
  
  
  # absolute change = future - historic    **DOESN'T NEED SCALING!!!
  annual_absch <- future_annual - pd_annual
  absch_name <- paste(RCP85_absch_od, paste("Guam_RCP85_annual_AbsoluteChange"),sep = "/") 
  writeRaster(annual_absch, absch_name, overwrite = T, format = "GTiff" )
  
  
  
  ## WET SEASON ##
  
  RCP85_absch_od = "D:/Zhang_Data/Guam_calculations/PresentDay_calculations_Rprocess/GUAM_RCP85_RProcess/Guam_RCP85_Absch"
  
  future_wet <- raster(paste0("D:/Zhang_Data/Guam_calculations/PresentDay_calculations_Rprocess/GUAM_RCP85_RProcess/Guam_RCP85_2080-2099_11-04_wetseasonmean.tif"))
  pd_wet <- raster(paste("D:/Zhang_Data/Guam_calculations/PresentDay_calculations_Rprocess/Guam_present_11-04_wetseasonmean.tif"))
 
  # absolute change = future - historic    **DOESN'T NEED SCALING!!!
  wet_absch <- future_wet - pd_wet
  wetabsch_name <- paste(RCP85_absch_od, paste("Guam_RCP85_11-04_wetseasonmean_AbsoluteChange"),sep = "/") 
  writeRaster(wet_absch, wetabsch_name, overwrite = T, format = "GTiff" )
  
  
  ## DRY SEASON ##
  
  RCP85_absch_od = "D:/Zhang_Data/Guam_calculations/PresentDay_calculations_Rprocess/GUAM_RCP85_RProcess/Guam_RCP85_Absch"
  
  future_dry <- raster(paste0("D:/Zhang_Data/Guam_calculations/PresentDay_calculations_Rprocess/GUAM_RCP85_RProcess/Guam_RCP85_2080-2099_05-10_dryseasonmean.tif"))
  pd_dry <- raster(paste("D:/Zhang_Data/Guam_calculations/PresentDay_calculations_Rprocess/Guam_present_05-10_dryseasonmean.tif"))
  
  # absolute change = future - historic    **DOESN'T NEED SCALING!!!
  dry_absch <- future_dry - pd_dry
  dryabsch_name <- paste(RCP85_absch_od, paste("Guam_RCP85_05-10_dryseasonmean_AbsoluteChange"),sep = "/") 
  writeRaster(dry_absch, dryabsch_name, overwrite = T, format = "GTiff" )
  
  
  
  
  
  
############ FPC ############
  
  ## ANNUAL ##
  
  
  RCP85_fpc_od = "D:/Zhang_Data/Guam_calculations/PresentDay_calculations_Rprocess/GUAM_RCP85_RProcess/Guam_RCP85_FPC"
  
  pd_annual <- raster(paste("D:/Zhang_Data/Guam_calculations/PresentDay_calculations_Rprocess/Guam_1990-2009_present_annualmean.tif"))
  
  absch_annual <- raster(paste("D:/Zhang_Data/Guam_calculations/PresentDay_calculations_Rprocess/GUAM_RCP85_RProcess/Guam_RCP85_Absch/Guam_RCP85_annual_AbsoluteChange.tif"))
  
  # FPC = (future / absch)*100
  annual_fpc_unscaled  = absch_annual/pd_annual
  annual_fpc = annual_fpc_unscaled*100
  fpc_name <- paste(RCP85_fpc_od, paste("Guam_RCP85_annual_FPC"),sep = "/") 
  writeRaster(annual_fpc, fpc_name, overwrite = T, format = "GTiff" )
  
  
  
  ## WET SEASON ##
  
  wetpd_annual <- raster(paste("D:/Zhang_Data/Guam_calculations/PresentDay_calculations_Rprocess/Guam_present_11-04_wetseasonmean.tif"))
  wetseason_absch <- raster(paste("D:/Zhang_Data/Guam_calculations/PresentDay_calculations_Rprocess/GUAM_RCP85_RProcess/Guam_RCP85_Absch/Guam_RCP85_11-04_wetseasonmean_AbsoluteChange.tif"))
  
  # FPC = (future / absch)*100
  wetseason_fpc_unscaled = wetseason_absch/wetpd_annual
  wetseason_fpc = wetseason_fpc_unscaled*100
  wet_fpc_name <- paste(RCP85_fpc_od, paste("Guam_RCP85_11-04_wetseason_FPC"),sep = "/")
  writeRaster(wetseason_fpc, wet_fpc_name, overwrite = T, format = "GTiff" )
  
  
  
  ## DRY SEASON ##
  
  drypd_annual <- raster(paste("D:/Zhang_Data/Guam_calculations/PresentDay_calculations_Rprocess/Guam_present_05-10_dryseasonmean.tif"))
  dryseason_absch <- raster(paste("D:/Zhang_Data/Guam_calculations/PresentDay_calculations_Rprocess/GUAM_RCP85_RProcess/Guam_RCP85_Absch/Guam_RCP85_05-10_dryseasonmean_AbsoluteChange.tif"))
  
  # FPC = (future / absch)*100
  dryseason_fpc_unscaled = dryseason_absch/drypd_annual
  dryseason_fpc = dryseason_fpc_unscaled*100
  dry_fpc_name <- paste(RCP85_fpc_od, paste("Guam_RCP85_05-10_dryseason_FPC"),sep = "/")
  writeRaster(dryseason_fpc, dry_fpc_name, overwrite = T, format = "GTiff" )
  

  
  
  
  
  
  
  
  
  
  
  
  
  



#timeperiod_list = 

#for (i in annual_list) {
  #creating a raster stack so they'll be able to be summed
  #annual_stack <- stack(annual_list)
  
  #annual_mean <- calc(annual_stack, fun = sum())  #using calc and sum() functions to calculate the sum of the pixels within the raster stack
#   annual_mean <- sum(annual_stack)
#   raster_names <- paste(output_dir, paste0(substr(i, 1, 33),"_annualmean"), sep = "/")
#   writeRaster(annual_mean, filename = raster_names, overwrite = TRUE, format = "GTiff")
# }

