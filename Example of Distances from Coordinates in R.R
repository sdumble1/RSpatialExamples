#need some libraries - sp for creating spatial objects
library(sp)
#geosphere for super easy distance function (could do it long hand but this way is simpler)
library(geosphere)
#leaflet to do some quick mapping
library(leaflet)


#read in station list with names and coordinates
stations<-read.csv("C:/Users/sdumb/Dropbox (SSD)/Packages/Distance To Point/stations.csv")
#i just made these points up


#tell R the data is coordinates
coordinates(stations)<- ~ Long+Lat

summary(stations)


#(Assuming standard long lat decimal degrees notation) Then tell R that it is
#standard long/lat AKA WGS84
proj4string(stations)<-CRS("+proj=longlat +datum=WGS84")



#do a quick map
leaflet() %>%
  addProviderTiles("OpenStreetMap.HOT" ) %>%
  addMarkers(data = stations,label = stations$Station)







#get coordinates from mouse click
#If using leaflet within Shiny can get this from "input$MAPID_click"
#For now I am going to assume that we have just entered some coordinates

Click<-data.frame(Long=-66.54,Lat=-20)

#same process of projecting coordinates for click
coordinates(Click)<-~Long+Lat
proj4string(Click)<-CRS("+proj=longlat +datum=WGS84")



#just do another map
leaflet() %>%
  addProviderTiles("OpenStreetMap.HOT" ) %>%
  addMarkers(data = stations,label = stations$Station) %>%
  addCircleMarkers(data = Click,label = "Click")









#distm from geosphere then gives me the distance in metres from click to the stations
distances<-distm(stations,Click)
distances


#identify which is minimum distance bu using which()
which(distances==min(distances))

#3rd entry is minimum
#So 3rd station is the closests:

#Use square brackets to get the name of the nearest station
stations$Station[which(distances==min(distances))]



#do a little message to say whats going ong
paste0(stations$Station[which(distances==min(distances))],
       " is the nearest station and is ",
      round(min(distances)/1000,2),"km from the clicked point")

