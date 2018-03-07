# Libraries needed to use this function
# library(spocc)
# library(ggplot2)
# library(spoccutils)
# library(sp)
# library(rgeos)
# library(maptools)
# library(raster)
# library(dismo)

SpeciesRangeMap <- function(SpeciesName, SourceName, DataOnMap = TRUE, ConvexHullOfData = FALSE){
	if(missing(SpeciesName)) stop("Because you did not specify species Name")
	if(missing(SourceName)) stop("Because you did not specify source name")
	occ.data <- occ(query = SpeciesName, from = SourceName)
	df.occ.data <- occ2df(occ.data)
	if(!nrow(df.occ.data)) stop("Because this species has no data on chosen source")
	#mat.occ.data <- data.matrix(df.occ.data, rownames.force = NA)	# converting to matrix
	mat.occ.data <- as.matrix.data.frame(df.occ.data, rownames.force = NA)	# converting to matrix 
	mat.occ.hull.data <- mat.occ.data[,c("longitude","latitude")]  	# taking longitude and latitude of the data
	data(wrld_simpl)								# getting data of world map
	if(DataOnMap){
		plot(wrld_simpl,col="light yellow")				# plot world map
		points(mat.occ.hull.data[,1],mat.occ.hull.data[,2],col="red",cex=0.5)		# plot data points on map
	}
	if(ConvexHullOfData){
		plot(wrld_simpl,col="light yellow")				# plot world map
		points(mat.occ.hull.data[,1],mat.occ.hull.data[,2],col="red",cex=0.5)		# plot data points on map
		occ.hull.data <- convHull(mat.occ.hull.data)			# making convex hull around points
		plot(occ.hull.data,col=rgb(0, 0, 125, max = 255, alpha = 20*255/100),add=T)		# plot convex hull polygon around data points
	}
}

SpeciesRangeMap(SpeciesName = 'Accipiter striatus', SourceName = 'gbif', DataOnMap = TRUE, ConvexHullOfData = FALSE)		# Test Case