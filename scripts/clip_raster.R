####################################################################
######### Clip raster data to a given extent

# setwd("F:\\SDM_in R\\Data\\worldclim")

library(raster)
library(rgdal)

tmean=raster("tmean1_29.tif")
tmean

tmin=raster("tmin1_29.tif")
tmin

precip=raster("prec1_29.tif")
precip

alt=raster("alt_29.tif")
alt

plot(alt)

#read in a shapefile

setwd("C:/Users/kelle/Documents/Pintuxo/Desenvolvimento/resources_SDMGISR/P_malaysia")

library(rgdal)

pm=readOGR(".", "P_malaysia")
plot(pm, add=T)

altc = crop(precip, pm)

plot(altc)

setwd("F:\\SDM_in R\\Data\\2_Raster data process")

lulc1=raster("GLOBCOVER_L4_200901_200912_V2.3.tif")

plot(lulc1)

lulcc = crop(lulc1, pm)
plot(lulcc)

writeRaster(altc,"F:\\SDM_in R\\Data\\1_Raster data\\preciptn.tif")