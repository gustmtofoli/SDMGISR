library(rgbif)

occ_count(basisOfRecord = "OBSERVATION")

# specie: hornbill
occ_count(taxonKey = 2476004, georeferenced = TRUE)


# search by order
head(name_lookup(query = "Bucerotiformes", rank = "order", return = "data"))


# search by specie
head(name_lookup(query = "Buceros rhinoceros", rank = "species", return = "data"))


# country
my_code <- isocodes[grep("Malaysia", isocodes$name), "code"]
occ_count(country = my_code)


# data from region
dataset_suggest(query = "Amazon", type="OCCURRENCE")


## data relating to  rhinoceros hornbill 
key =name_backbone(name='Buceros rhinoceros')$speciesKey
dat <- occ_search(taxonKey=key, return='data', limit=1000)
dat
# NOT WORKING
gbifmap(dat) #removes nas and plots the geolocations


## many species
##http://www.malaysianbirds.com/bird-family/hornbill.htm
splist <- c('Anorrhinus galeritus', 'Anthracoceros albirostris',
            'Anthracoceros malayanus','Buceros bicornis','Buceros rhinoceros',
            'Rhinoplax vigil','Berenicornis comatus','Aceros corrugatus',
            'Rhyticeros subruficollis','Rhyticeros undulatus')

keys <- vapply(splist, function(x) name_suggest(x)$key[1], numeric(1),
               USE.NAMES=FALSE)
dat <- occ_data(keys, limit = 50)

library("data.table")
dd <- rbindlist(lapply(dat, function(z) z$data), fill = TRUE,
                use.names = TRUE)
gbifmap(dd)

head(dd)
str(dd)

# site: eBird, inaturalist