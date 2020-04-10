### EBIO 5420: Computational Biology - Lab 12
### Choose Your Own GGplot-Oriented Adventure
### 10 April 2020, Gebert

# Loading necessary libraries
library(ggplot2)
library(dplyr)
library(tidyverse)

# Reading in Cusack et al. dataset
# Setting working directory for import of data
setwd(dir = '~/Desktop/EBIO5420/compBioSandbox/CompBio_on_git/Datasets/Cusack_et_al/')

# Importing .csv file
camData <- read.csv("Cusack_et_al_random_versus_trail_camera_trap_data_Ruaha_2013_14.csv", stringsAsFactors = F)
#checking structure
str(camData)

# Checking quickly for NA values in dataset - printing column and row
which(is.na(camData), arr.ind = TRUE)

# Collapsing each of the animal and corresponding counts into one row (point) per species
# Dealing with pseudoreplication
camDataGrouped <- camData %>% group_by(Species) %>% tally()

# Changing header in table for clarity 
camDataGrouped <- camDataGrouped %>% rename(Counts = n)

# Graphing: Boxplot of counts per animal, grouped by each animal
ggplot(camDataGrouped) + geom_bar(aes(x=Species, y=Counts))

# Turns out generating a counts column was not necessary for geom_bar
ggplot(camData) + geom_bar(aes(Species))

# Turning axis labels 90 degrees
ggplot(camData) + geom_bar(aes(Species)) + theme(axis.text.x = element_text(angle = 90, hjust = 1))

# Swapping X and Y - axis on bar graph
ggplot(camData) + geom_bar(aes(Species)) + theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  coord_flip()

# Reordering data - testing a different way of writing the ggplot2 code
ggplot(camDataGrouped, aes(x = reorder(Species, -Counts), y = Counts)) +
  geom_bar(stat = 'identity')

# Reordering data, flipping bar graph (x and y axis), and changing to 'Counts' scale to log
ggplot(camDataGrouped, aes(x = reorder(Species, -Counts), y = Counts)) + theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  geom_bar(stat = 'identity') + scale_y_continuous(trans='log10') + coord_flip()

# Cleaning up axis labels, adding title
ggplot(camDataGrouped, aes(x = reorder(Species, -Counts), y = Counts)) + theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  geom_bar(stat = 'identity') + scale_y_continuous(trans='log10') + coord_flip() + 
  labs(y = 'Species Counts (log10)', x = 'Species')

            