# This script can be used for the following task
# 1. Downloading the species occurrence data from GBIF 
# 2. Displaying this data on the world map
# 3. Making convex hull polygon around the occurrence data point 
# 4. Clipping the convex hull 

############################################################################################################
#libraries required for this script
library(rgbif)
library(spocc)
library(ggplot2)
library(maps)
library(spoccutils)
library(sp)
library(rgeos)
library(maptools)
library(raster)
library(dismo)
library(alphahull)

#############################################################################################################
# Visualize the Data
occ.data <- occ(query = 'Accipiter striatus', from = 'gbif')
occ.data$gbif						
occ.data$gbif$metadata				# to see the parameters, query, time the call executed
df.occ.data <- occ2df(occ.data)			
head(df.occ.data)							

# Plot Occurrence Data on World Map 
map_ggplot(occ.data)

# Convex Hull Polygon Around the Data Point
df.occ.hull.data <- cbind.data.frame(longitude = df.occ.data$longitude, latitude = df.occ.data$latitude)	
mat.occ.hull.data <- as.matrix.data.frame(df.occ.hull.data, rownames.force = NA)
data(wrld_simpl)								
plot(wrld_simpl,col="light yellow")				
points(mat.occ.hull.data[,1], mat.occ.hull.data[,2],col="red",cex=0.5)		
occ.hull.data <- convHull(mat.occ.hull.data)			
plot(occ.hull.data,col=rgb(0, 0, 125, max = 255, alpha = 20*255/100),add=T)	

# Clip the polygon to world map
df.occ.hull.data <- cbind.data.frame(longitude = df.occ.data$longitude, latitude = df.occ.data$latitude)	
df.hull.land.data = subset(df.occ.hull.data, !is.na(longitude))
df.hull.land.data = df.hull.land.data[!duplicated(paste(df.hull.land.data$longitude, df.hull.land.data$latitude)), ]
mat.hull.land.data <- as.matrix.data.frame(df.hull.land.data, rownames.force = NA)
hull.land.data = ashape(mat.hull.land.data, alpha = 5.5)
plot(wrld_simpl, xlim=c( -135.3431, -49.60951), ylim=c(-30.94649, 58.36106), axes=TRUE, col="light yellow")
points(mat.occ.hull.data[,1], mat.occ.hull.data[,2],col="red",cex=0.5)		
plot(hull.land.data,col=rgb(0, 0, 125, max = 255, alpha = 80*255/100),add=T)	