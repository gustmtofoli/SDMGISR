########### DOMAIN- presence only data based modelling

library(sp)
library(raster)
library(dismo)     # package to run the model
library(maptools)

datafiles = Sys.glob("*.tif") #Or whatever identifies your files
resultingStack = stack() #empty stack for raster
for(i in 1:NROW(datafiles)){
  tempraster = raster(datafiles[i])
  stck = stack(stck,tempraster)
}

stck #raster predictors as a stackplot

plot(stck,2)

### presence data

horn=read.csv("hornbill_my1.csv")
head(horn)
horn1= horn[,-1]#first column not needed

ext = extent(99, 105, 1.2, 6.7)

points(horn1, col='blue') 

group = kfold(horn1, 5)
pres_train = horn1[group != 1, ]
pres_test = horn1[group == 1, ]

backg = randomPoints(stck, n=1000,ext=ext, extf = 1.25)
colnames(backg) = c('lon', 'lat')
group = kfold(backg, 5)

backg_train = backg[group != 1, ]
backg_test = backg[group == 1, ]

r = raster(stck, 1)
plot(!is.na(r), col=c('white', 'light grey'), legend=FALSE)
plot(ext, add=TRUE, col='red', lwd=2)
points(backg_train, pch='-', cex=0.5, col='yellow')
points(backg_test, pch='-',  cex=0.5, col='black')
points(pres_train, pch= '+', col='green')
points(pres_test, pch='+', col='blue')

require(dismo)
dm =domain(stck, pres_train) #domain model- presence data only 
e = evaluate(pres_test, backg_test, dm, stck)
e

#### predictive mapping

pd = predict(stck, dm, ext=ext, progress='') #predict for p mapping
par(mfrow=c(1,2))
plot(pd, main='Domain, raw values')