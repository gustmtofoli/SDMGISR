######## resize/resample data- change spatial resolution
require(raster)
setwd("F:\\SDM_in R\\Data\\1_Raster data")

land=raster("landuse1.tif")
land

plot(land)

alt

landC=resample(land, asp, method="bilinear")

## first arguement is the raster whose spatial resolution we want to change
## second raster is the one whose resolution we want to apply on 1

plot(landC)

landC

asp

writeRaster(landC,"F:\\SDM_in R\\Data\\1_Raster data\\bioclim_land\\land.tif")