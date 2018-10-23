#######################################################################
############### GBM

setwd("/home/gustavo/Documentos/SDMGISR-files/2_SDM Data/bioclim")

pa=read.csv("/home/gustavo/Documentos/SDMGISR-files/2_SDM Data/Pres_abs.csv")

#pa=na.omit(pa)

head(pa)

summary(pa)

pb=as.factor(training$pb) #1 stands for presence and 0 for absence
land=as.factor(training$land) #land use categories are categorical

head(pa)
library(caret)

set.seed(1) #pseudo-repeatability
trainIndex = createDataPartition(pa$pb, p = .75, 
                                 list = FALSE, 
                                 times = 1) #y as basis of splitting

training = pa[ trainIndex,] #75% data for model training
testing= pa[-trainIndex,] #25% for model testing

head(training)


## caret
# define training control--> 10fold cv
train_control = trainControl(method="cv", number=10)

#svm with rbf kernel
mod_fit1=train(pb~altitude+aspect1+preciptn+roughness1+slope+tempAvg+tempMin,
               data=training,trControl=train_control,method="rf", importance=TRUE)

summary(mod_fit1)

### for polynomial kernel specify method="svmPoly"

## importance of the different predictors
varImp(mod_fit1)

## test the model
p1=predict(mod_fit1, newdata=testing) #predict on the test data

#test model fit-auc
library(pROC)

roc = pROC::roc(testing[,"pb"], p1) #compare testing data
#with predicted responses

auc= pROC::auc(roc)
auc

plot(roc.glmModel)
text(0.5,0.5,paste("AUC = ",format(auc, digits=5, scientific=FALSE)))

## read in all predictors

datafiles = Sys.glob("*.tif") #Or whatever identifies your files

datafiles #list of predictors
stck = stack() #empty raster stack for storing raster layers
for(i in 1:NROW(datafiles)){
  tempraster = raster(datafiles[i])
  stck = stack(stck,tempraster)
}

df_test <- data.frame(n = c(1, 2), predictors = c("altitude", "aspect1"))
x = substring(datafiles[1], 1, (nchar(datafiles)-4))
subset(df_test, predictors = datafiles[1])


p1 = predict(stck, mod_fit1) #use predict to implement the SVM model stored
#in mod_fit on the raster stack of our predictors
plot(p1,main="RF Predictive Map")

#### with the contributing predictors and use all data

names(stck)

s=dropLayer(stck,3)


mod_fit2=train(pb~altitude+aspect1+roughness1+slope+tempAvg+tempMin,
               data=pa,trControl=train_control,method="gbm")

p2 = predict(s, mod_fit2) #use predict to implement the SVM model stored
#in mod_fit on the raster stack of our predictors
plot(p2,main="RBF Kernel GBM Predictive Map")
