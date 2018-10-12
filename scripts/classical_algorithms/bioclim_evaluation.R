#### evaluate model performance
#### background data (pseudo-absences) needed for this
#### determine if the model can differentiate bw the habitat & the background

#species presence

head(horn1)

plot(msia.worldclim) #predictors

horn.d = bioclim(msia.worldclim, horn1[,c('long','lat')])
## bioclimatic model

ext = extent(99, 105, 1.2, 6.7)

backg = randomPoints(msia.worldclim, n=1000,ext=ext, extf = 1.25)
#background/pseudo-absence data

e = evaluate(horn1, backg, horn.d, msia.worldclim)
#presence, background, model, predictors

e

plot(e, 'ROC')