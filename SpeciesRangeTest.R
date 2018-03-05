library(geoaxe)
library(oai)
library(httr)
library(xml2)
library(whisker)
library(rgbif)
library(crul)
library(triebeard)
library(urltools)
library(rebird)
library(rbison)
library(ridigbio)
library(rvertnet)
library(spocc)
library(RColorBrewer)
library(stats)
library(gistr)
library(brew)
library(methods)
library(leafletR)
library(sp)
library(dotCall64)
library(base)
library(spam)
library(maps)
library(fields)
library(rworldmap)
library(spoccutils)
install.packages("spoccutils_0.1.0.zip", repos = NULL)

dat <- occ(query = 'Accipiter striatus', from = c('gbif', 'ecoengine'), gbifopts = gopts, ecoengineopts = eopts)
map_ggplot(dat)
trying.dat <- occ(query = 'Hepatica nobilis', from = c('gbif', 'ecoengine'))

main.data <- occ(query = 'Accipiter striatus', from = 'gbif')			# occurance data of Hepatica nobilis species
main.data$gbif						# to see the data
main.data$ebird$data				# an empty data
main.data$gbif$metadata				# to see the parameters, query, time the call executed
out <- occ(query = 'Accipiter striatus', from = c('gbif', 'ebird'))
df <- occ2df(out)
head(df)							# to see the data
tail(df)							# to see the data
#gopts <- list(country = 'US')
#eopts <- list(county = county.fips)

dat <- occ(query = 'Accipiter striatus', from = c('gbif', 'ecoengine'))
map_ggplot(dat)
