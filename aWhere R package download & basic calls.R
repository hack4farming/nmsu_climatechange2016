#########################################################################
#########################################################################

###One-time aWhere R package install
##Run all three of the below commands once to install the package
##Consult aWhere team if errors occur
##FMI on the aWhere R package, visit https://github.com/aWhereAPI/aWhere-R-Library/blob/master/documentation/complete-documentation.md

#########################################################################
#########################################################################

install.packages('devtools')
install.packages(c('chron', 'magrittr', 'btcops', 'DBI', 'assertthat', 'Rcpp', 'tibble'))
devtools::install_github("aWhereAPI/aWhere-R-Library")

#########################################################################
#########################################################################

##Basic Commands in the aWhere R Package
#You may run these as many times as you would like, and update as needed

#########################################################################
#########################################################################

library(aWhereAPI)

##Get Token - key and secret
#update the fields "key" and "secret" with your personal key and secret accessed via the aWhere Developer Portal - http://developer.awhere.com/user/login

get_token("key", "secret")


###Create Field
#This will create a field in your aWhere account at the following location.  Update location and ID to create additional fields.

create_field(field_id = "DF", latitude = "19.328489", longitude = "-99.145681", farm_id = "Mexico City")


###Get Fields List
#This will provide a list of all the fields currently stored in your aWhere account.

get_fields()

####Weather data - change name/id of field or latitude/longitude points, & customize start and end dates if desired.
#This pulls the data and creates a dataset in R titled "obs" that can be viewed later.
#The two lines below will perform an identical function - one calls location by field ID/name and the other by coordinates.

obs1 <- data.table(daily_observed_fields("DF", day_start = "2016-06-01", day_end = "2016-07-01"))
obs2 <- data.table(daily_observed_latlng(19.328489, -99.145681, day_start = "2016-06-01", day_end = "2016-07-01"))


View(obs1)

###Forecast data - customize call as needed
#This pulls the data and creates a dataset in R titled "fcst" that can be viewed later.
#The two lines below will perform an identical function - one calls location by field ID/name and the other by coordinates.
#Note: Update day_start to be a day in the near future or today.

fcst1 <- data.table(forecasts_fields("DF", day_start = "2016-12-01"))
fcst2 <- data.table(forecasts_latlng(19.328489, -99.145681, day_start = "2016-12-01"))

View(fcst1)

###Long-term norm data - norms determined based on month-day (MM-DD) spans, with default as 10-year norms. Can customize years and exclude years.
#This pulls the data and creates a dataset in R titled "ltn" that can be viewed later.

  ##default 10-year norms
  ltn1 <- data.table(weather_norms_fields("DF", monthday_start = "06-01", monthday_end = "09-01"))

  ##custom-year norms
  ltn2 <- data.table(weather_norms_fields("DF", monthday_start = "01-01", monthday_end = "03-29", year_start = "2008", year_end = "2015"))
 
  View(ltn1)
  View(ltn2)

###Agronomic data
#This pulls the data and creates a dataset in R titled "ag" or "ag_ltn" that can be viewed later.

ag1 <- data.table(agronomic_values_fields("DF", "2016-03-15"))
ag2 <- data.table(agronomic_values_fields("DF", "2016-03-15", "2016-04-01"))
ag_ltn1 <- data.table(agronomic_norms_fields("DF", month_day_start = "03-15", month_day_end = "04-01"))
ag_ltn2 <- data.table(agronomic_norms_fields("DF", month_day_start = "03-15", month_day_end = "04-01",
                      year_start = "2010", year_end = "2015"))

View(ag2)
View(ag_ltn2)

###Set Working Directory
##update this to use the file path on your computer where you would like to save your data.
setwd("C:/Users/...")

###Save & export data into .csv file
#You can change which dataset you want to export - here we're exporting "ag_ltn2" and "obs1" into two separate files.
write.csv(ag_ltn2, file = "Agronomic Long Term Norms.csv")
write.csv(obs1, file = "Observations.csv")
