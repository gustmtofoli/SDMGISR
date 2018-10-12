#################################################################
############ Preprocessing-- defining presence & absence

setwd("/home/gustavo/Documentos/SDMGISR-files/2_SDM Data/bioclim")
library(raster)

datafiles = Sys.glob("*.tif") #Or whatever identifies your files
stck = stack() #empty stack for raster
for(i in 1:NROW(datafiles)){
  tempraster = raster(datafiles[i])
  stck = stack(stck,tempraster)
}

stck #raster predictors as a stack

plot(stck,2)

### presence data

horn=read.csv("/home/gustavo/Documentos/SDMGISR-files/2_SDM Data/hornbill_my1.csv")
head(horn)
horn1= horn[,-1]#first column not needed


points(horn1, col='blue') 

# extract all stck info in horn1 coordinates
prs1= extract(stck, horn1)

set.seed(1)

backgr = randomPoints(stck, 500) #500 random points
absvals = extract(stck, backgr) #choose absence values from the background
pb = c(rep(1, nrow(prs1)), rep(0, nrow(absvals)))
sdmdata = data.frame(cbind(pb, rbind(prs1, absvals)))

head(sdmdata)

sdmdata=na.omit(sdmdata)
summary(sdmdata)

tail(sdmdata)


# ============================

# select an area of absense on ecological considerations

library(raster)

e = drawExtent()
abs = crop(stck, e)
plot(abs)

backgr = randomPoints(abs, 130)
absvals2 = extract(abs, backgr)
pb = c(rep(1, nrow(prs1)), rep(0, nrow(absvals2)))
sdmdata = data.frame(cbind(pb, rbind(prs1, absvals2)))
head(sdmdata)
