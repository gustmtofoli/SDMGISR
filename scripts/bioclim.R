###################################################################
############# Bioclim- Climate envelope model
##### uses presence only data 

## Climate change is creating new challenges for biodiversity conservation.
##Climate envelope models describe the climate where a species 
#currently lives (its climate "envelope")
## map the geographic shift of that envelope under climate change

library(dismo)
library(rgeos)

# setwd("F:\\SDM_in R\\Data\\1_Raster data\\bioclim")

horn=read.csv("C:/Users/kelle/Documents/Pintuxo/Desenvolvimento/resources_SDMGISR/2_SDM Data/hornbill_my1.csv")
head(horn)
horn1= horn[,-1]#first column not needed

ext = extent(99, 105, 1.2, 6.7) #geographic extent of Peninsular M'Sia
# longitude 1, longitude 2, latitude 1, latitude 2

library(rgdal)

all.worldclim = raster::getData("worldclim", res = 10, var = 'bio')
msia.worldclim = crop(all.worldclim, extent(99, 105, 1.2, 6.7))

## set up the bounding box of your map
h.extent = extent(min(horn1$long -1),
                  max(horn1$long + 1),
                  min(horn1$lat - 1),
                  max(horn1$lat + 1))

h.map = gmap(h.extent, type = 'satellite', latlon = TRUE)

plot(h.map)

points(Mercator(horn1[,c('long','lat')]), pch = 16, col = 'red')
#species geo-locations 

# leaflet map
library(leaflet)

data <- horn
leaflet() %>%
  addProviderTiles("Esri.OceanBasemap", group = "Esri.OceanBasemap") %>%
  addProviderTiles("OpenStreetMap.Mapnik", group = "OpenStreetmap") %>%
  addProviderTiles("Esri.WorldImagery", group = "Esri.WorldImagery") %>%
  addLayersControl(baseGroups = c("OpenStreetmap","Esri.OceanBasemap", 'Esri.WorldImagery'),
                   options = layersControlOptions(collapsed = TRUE, autoZIndex = F)) %>%
  setView(lng = -60.85, lat = -15.45, zoom = 3) %>%
  addCircleMarkers(
    lng = data$long,
    lat = data$lat,
    label = paste(data$species, ", lon:", data$long, ", lat:", data$lat),
    radius = 7,
    color = "blue",
    stroke = FALSE, fillOpacity = 0.3
  )

# end leaflet map


## Use the bioclim function, which takes your climate layers and the long and lat columns (in that order)
h.bc = bioclim(msia.worldclim, horn1[,c('long','lat')])

par(mfrow = c(4,4))
# par(mfrow = c(2,4))
response(h.bc)
par(mfrow = c(1,1))

horn.d <- bioclim(msia.worldclim, horn1[,c('long','lat')])
par(mfrow = c(4,4))
response(horn.d)
par(mfrow = c(1,1))

horn.d.pred <- predict(object = horn.d, msia.worldclim)
plot(horn.d.pred, main = 'sdm predictions using climate layers')
points(horn1[, c('long', 'lat')], pch = 16, cex = 0.25)
