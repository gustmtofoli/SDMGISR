library(raster)
library(rgdal)

el1=raster("/home/gustavo/Desenvolvimento/SDMGISR/resources/srtm_59_12.tif")
plot(el1)

el2=raster("/home/gustavo/Desenvolvimento/SDMGISR/resources/srtm_60_11.tif")
plot(el2)

par(mfrow=c(1,2))
plot(el1)
plot(el2)

mosee = mosaic(el1, el2, fun=mean)
plot(mosee)

writeRaster(mosee,"join_59_60.tif")
