
# estoutou a memória do computador
mosee #lat long

## advisable to convert lat-long rasters to planar units such as UTM
## in meters

#utm projection for north borneo 
ref = "+proj=utm +zone=50 +ellps=GRS80 +datum=NAD83 +units=m +no_defs" 

library(raster)
projected_raster = projectRaster(mosee, crs = ref)

projected_raster

slp=terrain(projected_raster, opt='slope', unit='radians', neighbors=8, filename='slp2.tif')

plot(slp)

aspect=terrain(projected_raster, opt='aspect')

## hillshade- obtained from both slope & aspect

hills = hillShade(slp, aspect, angle=40, direction=270)

plot(hills)