########### Pre-proessing for machine learning

# write.csv(sdmdata,"Pres_abs.csv")

setwd("/home/gustavo/Documentos/SDMGISR-files/2_SDM Data/bioclim")

pa=read.csv("/home/gustavo/Documentos/SDMGISR-files/2_SDM Data/Pres_abs.csv")

#pa=na.omit(pa)

head(pa)

summary(pa)

library(caret)

set.seed(1) #pseudo-repeatability
trainIndex = createDataPartition(pa$pb, p = .75, 
                                 list = FALSE, 
                                 times = 1) #y as basis of splitting

training = pa[ trainIndex,] #75% data for model training
testing= pa[-trainIndex,] #25% for model testing

head(training)
