# This function displays the species occurrence data on the map and can create convex hull a around this data
# For using this script following argument required
# spc <- Species Name
# src <- Which source you are using to get the data, i.e. GBIF
# Map <- if one want to displays the data on map set TRUE, otherwise FALSE
# cnvxHullMap <- if one want to displays the convex hull polygon around the data on map set TRUE, otherwise FALSE



##########################################################################################################
# Libraries needed to use this function
library(spocc)
library(ggplot2)
library(spoccutils)
library(sp)
library(rgeos)
library(maptools)
library(raster)
library(dismo)


SpcRngMap <- function(spc, src, Map = TRUE, cnvxHullMap = FALSE){

	#conditions to run the function
	if(missing(spc)) stop("Because you did not specify species Name")
	if(missing(src)) stop("Because you did not specify source name")
	occ.data <- occ(query = spc, from = src)
	df.occ.data <- occ2df(occ.data)
	if(!nrow(df.occ.data)) stop("Because this species has no data on chosen source")
	
	
	df.occ.hull.data <- cbind.data.frame(df.occ.data$longitude, df.occ.data$latitude)	
	mat.occ.hull.data <- as.matrix.data.frame(df.occ.hull.data, rownames.force = NA)
	data(wrld_simpl)								
	
	# plot data points on map on world map
	if((Map | !cnvxHullMap | missing(cnvxHullMap)) & !missing(Map)){
		plot(wrld_simpl,col="light yellow")				
		points(mat.occ.hull.data[,1],mat.occ.hull.data[,2],col="red",cex=0.5)		
	}
	
	# plot convex hull around the data points on world map
	if((cnvxHullMap| !Map | missing(Map)) & !missing(cnvxHullMap)){
		plot(wrld_simpl,col="light yellow")				
		points(mat.occ.hull.data[,1],mat.occ.hull.data[,2],col="red",cex=0.5)		
		occ.hull.data <- convHull(mat.occ.hull.data)			
		plot(occ.hull.data,col=rgb(0, 0, 125, max = 255, alpha = 20*255/100),add=T)	
	}
}

#############################################################################################################
# Test Case
SpcRngMap(spc = 'Accipiter striatus', src = 'gbif', Map = TRUE, cnvxHullMap = FALSE)		