#####################################################################
################## maxent

library(raster)
library(rgdal)
library(dismo)
library(rJava)

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
plot(stck,2)
plot(stck,3)
plot(stck,4)
plot(stck,5)
plot(stck,6)
plot(stck,7)

### presence data

horn=read.csv("/home/gustavo/Documentos/SDMGISR-files/2_SDM Data/hornbill_my1.csv")
head(horn)
horn1= horn[,-1]#first column not needed

points(horn1, col='blue') 

group = kfold(horn1, 5) #split the data into 5 portions 
#build and test models on all 5 data splits
pres_train = horn1[group != 1, ]
pres_test = horn1[group == 1, ]

####

xm = maxent(stck, pres_train) #implement maxent on the presence-only data
plot(xm) ## variable importance

ext = extent(99, 105, 1.2, 6.7) #peninsular malaysia
# 1000 background data points
backg = randomPoints(stck, n=1000,ext=ext, extf = 1.25)
colnames(backg) = c('lon', 'lat')
group = kfold(backg, 5)

#pseudo-absences for training model performances
backg_train = backg[group != 1, ]
backg_test = backg[group == 1, ]

e = evaluate(pres_test, backg_test, xm, stck)
e

p= predict(stck, xm, ext=ext, progress='')
#01 scale where 1 indicates the most suitable habitat 
#and 0 least suitable habitat 

par(mfrow=c(1,2))

plot(p, main='Maxent, raw values')
