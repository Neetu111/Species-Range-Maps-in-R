# This script can be used for the following task
# 1. Downloading the species occurrence data from GBIF 
# 2. Displaying this data on the world map
# 3. Clipping the convex hull polygon around the occurrence data point 

############################################################################################################
#libraries required for this script
library(rgbif)
library(spocc)
library(ggplot2)
library(spoccutils)
library(sp)
library(rgeos)
library(maptools)
library(raster)
library(dismo)

#############################################################################################################
# Visualize the Data
occ.data <- occ(query = 'Accipiter striatus', from = 'gbif')
occ.data$gbif						
occ.data$gbif$metadata				# to see the parameters, query, time the call executed
df.occ.data <- occ2df(occ.data)			
head(df.occ.data)							

# Plot Occurrence Data on World Map 
map_ggplot(occ.data)

# Clip Convex Hull Polygon Around the Data Point
df.occ.hull.data <- cbind.data.frame(df.occ.data$longitude, df.occ.data$latitude)	
mat.occ.hull.data <- as.matrix.data.frame(df.occ.hull.data, rownames.force = NA)
data(wrld_simpl)								
plot(wrld_simpl,col="light yellow")				
points(mat.occ.hull.data[,1],mat.occ.hull.data[,2],col="red",cex=0.5)		
occ.hull.data <- convHull(mat.occ.hull.data)			
plot(occ.hull.data,col=rgb(0, 0, 125, max = 255, alpha = 20*255/100),add=T)	
