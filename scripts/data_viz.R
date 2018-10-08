#####################################################################
############ More data visualizations


library(spocc)

## get data for multiple species from multiple DBs
spp= c("Rhinoplax vigil", "Buceros rhinoceros", "Anthracoceros malayanus")

dat = occ(query = spp, from ='gbif', gbifopts = list(hasCoordinate=TRUE))
dat

library(mapr)

map_leaflet(dat) #leaflet based interactive map

library(ggplot2)
library(ggmap)

map_ggmap(dat) ##ggmap version
