# install packages

install.packages("ggmap")
install.packages("tmaptools")
install.packages("RCurl")
install.packages("jsonlite")
install.packages("tidyverse")
install.packages("leaflet")

# load packages

library(ggmap)
library(tmaptools)
library(RCurl)
library(jsonlite)
library(tidyverse)
library(leaflet)

############## Google Map: Rev-Geocoding API ############################################
# replace "api_key" with your API key

register_google(key = "AIzaSyC9fAn4S-7mcBUf2gWfXB9EQaaRKncL6wM")

# create a list of samples from herbarium string search's 

tri.herb <- c("X")

tri.herb.df <- data.frame(tri.herb = tri.herb, stringsAsFactors = FALSE)

# run the geocode function from ggmap package # Can add below output parameters
#####latlon - latitude and longitude;
#####latlona - all of the above plus address;
####more - all of the above plus place’s type and geographical boundaries;
####all - all of the above plus some additional information.

tri.herb.ggmap <- geocode(location = locallity, output = "latlon", source = "google")
tri.herb.ggmap <- cbind(tri.herb.df, tri.herb.ggmap)

# print the results

# extract the coordinates of London pubs

tri.herb.ggmap.crd <- list()

for (i in 1:dim(tri.herb.ggmap)[1]) {
  
  lon <- tri.herb.ggmap$lon[i]
  lat <- tri.herb.ggmap$lat[i]
  tri.herb.ggmap.crd[[i]] <- c(lon, lat)
  
}

# reverse geocode the coordinates and save them to the list

tri.herb.ggmap.latlon <- list()

# print the details of the first pub

pubs.ggmap.address[[1]]
###############END##################################################################

##################Nomitatum API#####################################################
####################################################################################
# modifying some search requests

pubs_m <- pubs
pubs_m[pubs_m=="The Crown and Sugar Loaf, Fleet Street"] <- "The Crown and Sugar Loaf"
pubs_m[pubs_m=="Ye Olde Mitre, Hatton Garden"] <- "Ye Olde Mitre"
pubs_m_df <- data.frame(Pubs = pubs_m, stringsAsFactors = FALSE)

# geocoding the London pubs
# "bar" is special phrase added to limit the search

pubs_tmaptools <- geocode_OSM(paste(pubs_m, "bar", sep = " "),
                              details = TRUE, as.data.frame = TRUE)

# extracting from the result only coordinates and address

pubs_tmaptools <- pubs_tmaptools[, c("lat", "lon", "display_name")]
pubs_tmaptools <- cbind(Pubs = pubs_m_df[-10, ], pubs_tmaptools)

# print the results

pubs_tmaptools
pubs_ggmap[, 1:6]


#####################################################################################