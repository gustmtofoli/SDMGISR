library(raster)
library(rgdal)

# estourou mem�ria - 6GB RAM
# 8GB RAM foi o suficiente 
mosee #lat long
mosee = raster("C:/Users/kelle/Documents/Pintuxo/Desenvolvimento/resources_SDMGISR/join_59_60.tif")

## advisable to convert lat-long rasters to planar units such as UTM
## in meters

#utm projection for north borneo 
ref = "+proj=utm +zone=50 +ellps=GRS80 +datum=NAD83 +units=m +no_defs" 

library(raster)

# travou computador - 8GB
projected_raster = projectRaster(mosee, crs = ref)

projected_raster

slp=terrain(projected_raster, opt='slope', unit='radians', neighbors=8, filename='slp2.tif')

plot(slp)

aspect=terrain(projected_raster, opt='aspect')

## hillshade- obtained from both slope & aspect

hills = hillShade(slp, aspect, angle=40, direction=270)

plot(hills)