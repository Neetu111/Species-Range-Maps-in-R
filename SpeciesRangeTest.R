library(rgbif)
library(spocc)
library(ggplot2)
library(spoccutils)
library(sp)
library(rgeos)
library(maptools)
library(raster)
library(dismo)

# To Visualize the Data
occ.data <- occ(query = 'Accipiter striatus', from = 'gbif')			# getting occurance data of Accipiter striatus species from GBIF
occ.data$gbif						# to see the data
occ.data$gbif$metadata				# to see the parameters, query, time the call executed
df.occ.data <- occ2df(occ.data)			# Creating a Data Frame of data
head(df.occ.data)							# to see the data
tail(df.occ.data)							# to see the data

# Plotting Data on Map 
map_ggplot(occ.data)

# Convex Hull Polygon
mat.occ.data <- data.matrix(df.occ.data, rownames.force = NA)	# converting to matrix 
mat.occ.hull.data <- mat.occ.data[,c("longitude","latitude")]  	# taking longitude and latitude of the data
data(wrld_simpl)								# getting data of world map
plot(wrld_simpl,col="light yellow")				# plot world map
points(mat.occ.hull.data[,1],mat.occ.hull.data[,2],col="red",cex=0.5)		# plot data points on map
occ.hull.data <- convHull(mat.occ.hull.data)			# making convex hull around points
plot(occ.hull.data,col=rgb(0, 0, 125, max = 255, alpha = 20*255/100),add=T)		# plot convex hull polygon around data points
