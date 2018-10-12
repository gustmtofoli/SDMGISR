# raster data
install.packages('raster')
install.packages('rgdal')
install.packages('maptools')

# for classical SDM mapping
install.packages('dismo')

# species occurence data
install.packages("data.table")
install.packages('rgbif')
install.packages('spocc')

# machine learning models
install.packages('caret')
install.packages('pROC')
install.packages('ModelMetrics')

# maps
install.packages('mapr')
install.packages('ggmap')

# java and R
# download maxent from https://biodiversityinformatics.amnh.org/open_source/maxent/
# copy .jar to java directory from dismo package
install.packages('rJava')
Sys.setenv(JAVA_HOME='/usr/lib/jvm/java-8-oracle/jre')
