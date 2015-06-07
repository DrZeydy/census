# R Script to get the median income and median age by counties from the
# 2013 American Community Survey 5 Year Data (Estimates)
# Created by Zeydy Ortiz, Ph. D. - June 6, 2015
# For more information and to use the script request a key here: 
# http://www.census.gov/data/developers/data-sets/acs-survey-5-year-data.html
# Substitute <YOUR CENSUS API KEY HERE> below with your key
library(jsonlite)
# Variable B19013_001E is the median income (estimate)
# Variable B01002_001E is the median age (estimate)
# Found a good summary of the variables in the CitySDK:
# https://github.com/uscensusbureau/citysdk/blob/master/js/citysdk.census.js
censusData <- fromJSON("http://api.census.gov/data/2013/acs5?get=NAME,
                       B19013_001E,B01002_001E&for=county:*&key=
                       <YOUR CENSUS API KEY HERE>")
# First column returned is the county and state names in a single cell
# Separate labels into two different columns
counties <- censusData[,1]
counties[1] <- "county, state"
counties <- matrix(unlist(strsplit(counties,", ")), ncol=2, byrow=TRUE)
# Get income and age columns
incomeAge <- censusData[,2:3]
incomeAge[1,1] <- "income"
incomeAge[1,2] <- "age"
census <- cbind(counties, incomeAge)
# Create comma-separated file
write.table(census,file="acs5-county-income-age.csv", sep=",",row.names=FALSE,col.names=FALSE)
