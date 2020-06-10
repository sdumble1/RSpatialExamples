#need some libraries - sp for creating spatial objects
library(sp)

#read in station list with names and coordinates
stations<-read.csv("stations.csv")
#i just made these points up


#tell R the data is coordinates
coordinates(stations)<- ~ Long+Lat

summary(stations)


#(Assuming standard long lat decimal degrees notation) Then tell R that it is
#standard long/lat AKA WGS84
proj4string(stations)<-CRS("+proj=longlat +datum=WGS84")


#spTransform for converting coordinates

#Assume most logical transformation is to local UTM system for Bolivia
#Easiest way to re-project is to find the ESPG number for the coordinate system

#First need the Zone:
#https://earth-info.nga.mil/GandG/coordsys/grids/utm.html
#Bolivia is in Zone 20S
#Then need the ESPG Code for WGS 84 / Zone 20S
#https://epsg.io/?q=WGS+84+%2F+Zone+20S
#ESPG Code is: 32720

#Now can create a re-projected version of data with the UTM coordinates

stations_utm<-spTransform(stations,CRS("+init=epsg:32720"))

summary(stations_utm)

