### EBIO 5420: Computational Biology - Lab09
### Parsing Dates and Times from Real Data

# Importing libraries
library(tidyverse)
library(lubridate)
library(dplyr)

# Setting working directory for import of data
setwd(dir = '~/Desktop/EBIO5420/compBioSandbox/CompBio_on_git/Datasets/Cusack_et_al/')

# Importing .csv file
camData <- read.csv("Cusack_et_al_random_versus_trail_camera_trap_data_Ruaha_2013_14.csv", stringsAsFactors = F)

# Testing subset of data for time/date reformatting - first 5 columns
dateTime_subSample <- camData$DateTime[ 1:5 ]

# reformatting so that date and time are human readable
dateTime_subSample <- dmy_hm( dateTime_subSample )

dateTime_subSample <- camData$DateTime[ 1:999 ]
dateTime_subSample <- dmy_hm( dateTime_subSample )
dateTime_subSample

### Checking entire column - seems to be working
dateTime_subSample <- camData$DateTime
dateTime_subSample <- dmy_hm( dateTime_subSample )
dateTime_subSample

if (dmy_hm( dateTime_subSample) == TRUE){
  dateTime_subSample <- dmy_hm( dateTime_subSample )
}
dateTime_subSample
  

# Checking one where reformatting was required
camData$DateTime[520]
dateTime_subSample[520]

# Problematic - swapping month and day around when formating is off...






  
  
  
