library(raster)
library(rgdal)

el1=raster("C:/Users/kelle/Documents/Pintuxo/Desenvolvimento/resources_SDMGISR/srtm_59_12.tif")
plot(el1)

el2=raster("C:/Users/kelle/Documents/Pintuxo/Desenvolvimento/resources_SDMGISR/srtm_60_11.tif")
plot(el2)

par(mfrow=c(1,2))
plot(el1)
plot(el2)

# estourou a memória
mosee = mosaic(el1, el2, fun=mean)
plot(mosee)

writeRaster(mosee,"join_59_60.tif")
