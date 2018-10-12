##########################

library(red)
library(raster)
library(rgdal)
library(dismo)

setwd("/home/gustavo/Documentos/SDMGISR-files/2_SDM Data/bioclim")

datafiles = Sys.glob("*.tif") #Or whatever identifies your files

datafiles #list of predictors
stck = stack() #empty raster stack for storing raster layers
for(i in 1:NROW(datafiles)){
  tempraster = raster(datafiles[i])
  stck = stack(stck,tempraster)
}


stck #raster predictors as a stackplot

plot(stck,1)

### presence data

horn=read.csv("/home/gustavo/Documentos/SDMGISR-files/2_SDM Data/hornbill_my1.csv")
head(horn)
horn1= horn[,-1]#first column not needed

points(horn1, col='blue') 
head(horn1)

plot(stck)

## learn more about your data
map.easy(horn, layers = stck, habitat = NULL, zone = NULL,
         thin = TRUE, error = NULL, move = TRUE, dem = alt, pca = 0,
         filename = NULL, mapoption = NULL, testpercentage = 20, mintest = 20,
         runs = 0, subset = 0)

##maxent 
# TODO 1h was not enough... test this later...
map.sdm(horn1, stck, error = NULL, categorical = NULL, thres = 0,
        testpercentage = 20, mcp = TRUE, eval = TRUE, runs = 0, subset = 0)
