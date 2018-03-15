# Species-Range-Maps-in-R

### In this repository, script can be used for the following task:
1. Downloading the species occurrence data from GBIF 
2. Displaying this data on the world map
3. Making convex hull polygon around the occurrence data point 
4. Clipping the convex hull polygon that is on land

### SpcRngMap.R
It contains code for the above written task.

#### Libraries Used
```library(rgbif)
library(spocc)
library(ggplot2)
library(maps)
library(spoccutils)
library(sp)
library(rgeos)
library(maptools)
library(raster)
library(dismo)
```

#### Downloading and exploring the data 
```
occ.data <- occ(query = 'Accipiter striatus', from = 'gbif')
occ.data$gbif						
Species [Accipiter striatus (500)] 
First 10 rows of [Accipiter_striatus]

# A tibble: 500 x 97
                 name  longitude latitude  prov         issues        key                           datasetKey                     publishingOrgKey publishingCountry
                <chr>      <dbl>    <dbl> <chr>          <chr>      <int>                                <chr>                                <chr>             <chr>
 1 Accipiter striatus -122.31411 37.98893  gbif cdround,gass84 1802760979 50c9509d-22c7-4a22-a47d-8c48425ef4a7 28eb1a3f-1c15-4a95-931a-4af90ecb574d                US
 2 Accipiter striatus  -74.05970 40.09627  gbif cdround,gass84 1806363338 50c9509d-22c7-4a22-a47d-8c48425ef4a7 28eb1a3f-1c15-4a95-931a-4af90ecb574d                US
 3 Accipiter striatus  -98.56255 33.81266  gbif cdround,gass84 1806341314 50c9509d-22c7-4a22-a47d-8c48425ef4a7 28eb1a3f-1c15-4a95-931a-4af90ecb574d                US
 4 Accipiter striatus -122.36031 37.02475  gbif cdround,gass84 1802763269 50c9509d-22c7-4a22-a47d-8c48425ef4a7 28eb1a3f-1c15-4a95-931a-4af90ecb574d                US
 5 Accipiter striatus -121.50013 37.17425  gbif cdround,gass84 1806339729 50c9509d-22c7-4a22-a47d-8c48425ef4a7 28eb1a3f-1c15-4a95-931a-4af90ecb574d                US
 6 Accipiter striatus -123.97605 49.18567  gbif cdround,gass84 1802771195 50c9509d-22c7-4a22-a47d-8c48425ef4a7 28eb1a3f-1c15-4a95-931a-4af90ecb574d                US
 7 Accipiter striatus -103.46419 50.07486  gbif cdround,gass84 1802777994 50c9509d-22c7-4a22-a47d-8c48425ef4a7 28eb1a3f-1c15-4a95-931a-4af90ecb574d                US
 8 Accipiter striatus -115.09784 36.15690  gbif cdround,gass84 1806356037 50c9509d-22c7-4a22-a47d-8c48425ef4a7 28eb1a3f-1c15-4a95-931a-4af90ecb574d                US
 9 Accipiter striatus -122.26754 37.08367  gbif cdround,gass84 1807330165 50c9509d-22c7-4a22-a47d-8c48425ef4a7 28eb1a3f-1c15-4a95-931a-4af90ecb574d                US
10 Accipiter striatus -121.91616 37.96679  gbif cdround,gass84 1802790830 50c9509d-22c7-4a22-a47d-8c48425ef4a7 28eb1a3f-1c15-4a95-931a-4af90ecb574d                US
# ... with 490 more rows, and 88 more variables: protocol <chr>, lastCrawled <chr>, lastParsed <chr>, crawlId <int>, basisOfRecord <chr>, taxonKey <int>,
#   kingdomKey <int>, phylumKey <int>, classKey <int>, orderKey <int>, familyKey <int>, genusKey <int>, scientificName <chr>, kingdom <chr>, phylum <chr>,
#   order <chr>, family <chr>, genus <chr>, genericName <chr>, specificEpithet <chr>, taxonRank <chr>, dateIdentified <chr>, coordinateUncertaintyInMeters <dbl>,
#   year <int>, month <int>, day <int>, eventDate <date>, modified <chr>, lastInterpreted <chr>, references <chr>, license <chr>, geodeticDatum <chr>, class <chr>,
#   countryCode <chr>, country <chr>, rightsHolder <chr>, identifier <chr>, informationWithheld <chr>, verbatimEventDate <chr>, datasetName <chr>,
#   collectionCode <chr>, gbifID <chr>, verbatimLocality <chr>, occurrenceID <chr>, taxonID <chr>, catalogNumber <chr>, recordedBy <chr>,
#   `http://unknown.org/occurrenceDetails` <chr>, institutionCode <chr>, rights <chr>, eventTime <chr>, identificationID <chr>, occurrenceRemarks <chr>,
#   identificationRemarks <chr>, individualCount <int>, elevation <dbl>, elevationAccuracy <dbl>, continent <chr>, stateProvince <chr>, institutionID <chr>,
#   county <chr>, identificationVerificationStatus <chr>, language <chr>, type <chr>, preparations <chr>, locationAccordingTo <chr>, identifiedBy <chr>,
#   georeferencedDate <chr>, nomenclaturalCode <chr>, higherGeography <chr>, georeferencedBy <chr>, georeferenceProtocol <chr>, endDayOfYear <chr>,
#   georeferenceVerificationStatus <chr>, verbatimCoordinateSystem <chr>, locality <chr>, otherCatalogNumbers <chr>, organismID <chr>, previousIdentifications <chr>,
#   identificationQualifier <chr>, samplingProtocol <chr>, accessRights <chr>, higherClassification <chr>, georeferenceSources <chr>, sex <chr>, lifeStage <chr>,
#   dynamicProperties <chr>, infraspecificEpithet <chr>

```
```
df.occ.data <- occ2df(occ.data)			
head(df.occ.data)							
# A tibble: 6 x 6
                name  longitude latitude  prov       date        key
               <chr>      <dbl>    <dbl> <chr>     <date>      <int>
1 Accipiter striatus -122.31411 37.98893  gbif 2018-01-01 1802760979
2 Accipiter striatus  -74.05970 40.09627  gbif 2018-01-26 1806363338
3 Accipiter striatus  -98.56255 33.81266  gbif 2018-01-21 1806341314
4 Accipiter striatus -122.36031 37.02475  gbif 2018-01-01 1802763269
5 Accipiter striatus -121.50013 37.17425  gbif 2018-01-20 1806339729
6 Accipiter striatus -123.97605 49.18567  gbif 2018-01-02 1802771195
```

#### Displyaing data on map
```
map_ggplot(occ.data)
```
![DataPointOnMap](https://github.com/Neetu111/Species-Range-Maps-in-R/blob/master/DataPointOnMap.png)

##### Making convex hull polygon around the occurrence data point
convHull() function is used to make a convex hull polygon
```
df.occ.hull.data <- cbind.data.frame(longitude = df.occ.data$longitude, latitude = df.occ.data$latitude)
df.occ.hull.data <- na.omit(df.occ.hull.data)	
mat.occ.hull.data <- as.matrix.data.frame(df.occ.hull.data, rownames.force = NA)
occ.hull.data <- convHull(mat.occ.hull.data)
```
Ploting the convex hull polygon
```
plot(wrld_simpl,col="light yellow")				
points(mat.occ.hull.data[,1], mat.occ.hull.data[,2],col="red",cex=0.5)				
plot(occ.hull.data,col=rgb(0, 0, 125, max = 255, alpha = 20*255/100),add=T)	
```
![ConvexHullPolygon](https://github.com/Neetu111/Species-Range-Maps-in-R/blob/master/ConvexHullPolygon.png)

#### Clipping the convex hull polygon that is on land
Convex hull polygon is changed to Spatial Polygon to complete this task.
```
ch <- chull(mat.occ.hull.data[,1], mat.occ.hull.data[,2])
coords <- mat.occ.hull.data[c(ch, ch[1]), ]
sp_poly <- SpatialPolygons(list(Polygons(list(Polygon(coords)), ID=1)))
sp_poly_df <- SpatialPolygonsDataFrame(sp_poly, data=data.frame(ID=1))
```
Intersection of world map and convex hull polygon is taken in order to get the polygon which is on land.
```
land.hull <- gIntersection(wrld_simpl, sp_poly_df, byid=TRUE)
```

Plotting the clipped convex hull polygon
```
plot(wrld_simpl,col="light yellow")
points(mat.occ.hull.data[,1], mat.occ.hull.data[,2],col="red",cex=0.5)
plot(land.hull, col=rgb(0, 0, 125, max = 255, alpha = 20*255/100),add=T)
```
![ClippedConvexHullPolygon](https://github.com/Neetu111/Species-Range-Maps-in-R/blob/master/ClippedConvexHullPolygon.png)

#### Zoomed Clipped Convex Hull Polygon
This is the zoomed visualization of clipped convex hull polygon
![ClippedConvexHullPolygon](https://github.com/Neetu111/Species-Range-Maps-in-R/blob/master/ZoomedClippedConvexHullPolygon.png)


### FunSpcRngMap.R
This script contains function to apply the above code on any kind of species except for clipping the convex hull polygon. 


