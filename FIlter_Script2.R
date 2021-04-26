#This is an R script to gather Lat long Data from herbarium data 
##Install appropriate packages
install.packages("dplyr")
install.packages("tidyverse")
install.packages("ggmap")
install.packages("ggplot2")

#Load in Packages
library("dplyr")
library("ggmap")
library("ggplot2")


# Get and print current working directory.
print(getwd())

#Read data in and make data object
data <- read.csv("occurrences.csv")
print(data)

#Check Data out
print(is.data.frame(data))
print(ncol(data))
print(nrow(data))


#Select columns out of Data Frame
data_filter <- select(data, id,	family, scientificName, specificEpithet,
                      year,	month,	day,	country,	stateProvince,	county,	municipality,	
                      locality,	decimalLatitude,	decimalLongitude)

data_filter2 <- select(data_filter, scientificName, year,	month,	day, country,	stateProvince,	county,	
                       decimalLatitude,	decimalLongitude)

#Removing samples without a timestamp for anlalysis.
RemoveNA <-data_filter2[!is.na(data_filter2$year)&!is.na(data_filter2$month)&!is.na(data_filter2$day),]




#To check the seleciton of NA lat and Long
#data_filter3 <- select(data_filter2,	decimalLatitude,	decimalLongitude)

#Trying on multiple columns# All data complete and only missing Lat long is seperated
new_data <- RemoveNA%>% filter_all(any_vars(is.na(.))) 

#Other Potential filter for NA data
#new_DF <- data_filter2[rowSums(is.na(data_filter2)) > 0,]

print(new_data)
write.csv(new_data,'cleaned_Sernac_Data_Geocode.csv')


# Geocoding a csv column of "addresses" in R


# Select the file from the file chooser
#fileToLoad <- file.choose(new = TRUE)

# Read in the CSV data and store it in a variable 
origLocation <- read.csv(cleaned_Sernac_Data_Geocode.csv, stringsAsFactors = FALSE)

# Initialize the data frame
geocoded <- data.frame(stringsAsFactors = FALSE)

# Loop through the addresses to get the latitude and longitude of each address and add it to the
# origAddress data frame in new columns lat and lon
for(i in 1:nrow(origLocation))
{
  # Print("Working...")
  result <- geocode(origLocation$county[i], output = "latlona", source = "google")
  origLocation$lon[i] <- as.numeric(result[1])
  origLocation$lat[i] <- as.numeric(result[2])
  origLocation$geoAddress[i] <- as.character(result[3])
}
# Write a CSV file containing origLocation to the working directory
write.csv(origLocation, "geocoded.csv", row.names=FALSE)


