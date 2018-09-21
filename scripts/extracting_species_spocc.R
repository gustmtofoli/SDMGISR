library(spocc)

#get data from GBIF
results = occ(query = 'Rhinoplax vigil', from = 'gbif')
results
head(results$gbif)

#get data from GBIF and ebird
results = occ(query = 'Rhinoplax vigil', from = c('ebird', 'gbif','ecoengine'))
summary(results)

## get data for multiple species from multiple DBs
spp = c("Rhinoplax vigil", "Buceros rhinoceros", "Anthracoceros malayanus")
res_set = occ(spp, from = c('gbif', 'ecoengine'))
head(res_set)

#make sure we get georef rcords only
dat = occ(query = spp, from ='gbif', gbifopts = list(hasCoordinate=TRUE))
data = occ2df(dat)#convert to data frame
head(data)
tail(data)
names(data)
