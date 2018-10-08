####################################################################
######### CRS of the raster data

setwd("F:\\SDM_in R\\Data\\elev")
library(raster)
library(rgdal)

j=raster("join_59_60.tif")

plot(j)

j

#utm projection for north borneo 
ref = "+proj=utm +zone=50 +ellps=GRS80 +datum=NAD83 +units=m +no_defs" 

# trava computador
projectedU = projectRaster(j, crs = ref)

projectedU

s=raster("slp2.tif")

plot(s)

s

## utm to lat-long

ref= "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"

# trava computador
projectedL = projectRaster(s, crs = ref)

projectedL