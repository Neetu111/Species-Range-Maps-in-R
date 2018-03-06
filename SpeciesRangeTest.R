library(rgbif)
library(spocc)
library(ggplot2)
library(spoccutils)

# To Visualize the Data
occ.data <- occ(query = 'Accipiter striatus', from = 'gbif')			# getting occurance data of Accipiter striatus species from GBIF
occ.data$gbif						# to see the data
occ.data$gbif$metadata				# to see the parameters, query, time the call executed
df.occ.data <- occ2df(occ.data)			# Creating a Data Frame of data
head(df.occ.data)							# to see the data
tail(df.occ.data)							# to see the data

# Plotting Data on Map 
map_ggplot(occ.data)