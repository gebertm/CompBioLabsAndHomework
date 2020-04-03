### EBIO5420 Computational Biology  
### Lab 11: More data filtering, subsetting, summarizing, and plotting

### Data accessed from the Dryad Digital Reposititory: 3 April 2020
### Citationi: 

# Reading in the data as a .csv file
GlobalWoodDensityData <- read.csv('~/Desktop/EBIO5420/CompBioLabsAndHomework/Labs/Lab11/GlobalWoodDensityDatabase.csv', stringsAsFactors = FALSE)

# Checking structure of the dataframe
str(GlobalWoodDensityData)

### Removing rows with missing (NA) data 
# Finding row and column with NA value
which(is.na(GlobalWoodDensityData), arr.ind = TRUE) # output will be row col

# Removing row with NA value - found to be in row 12150, col 4
GlobalWoodDensity_cleaned <- GlobalWoodDensityData[-c(12150), ]

# Dealing with pseudoreplication
# Condensing identical species into one point and taking the mean density measurement
WoodDensityGrouped <- GlobalWoodDensity_cleaned %>% group_by(Family, Binomial)

# checking mean of each grouping and creating a table of Family, Binomial and Mean Density
mean_summary <- WoodDensityGrouped %>% summarise(dens = mean(Wood.density..g.cm.3...oven.dry.mass.fresh.volume))
WoodDensityMeanSum <-mean_summary

# Confirming row count is equal to number of individual species
nrow(mean_summary)

### Contrasting most and least dense families

# Collapsing dataframe to Family and mean density
FamilyDensity <- GlobalWoodDensity_cleaned %>% group_by(Family)
FamDensity_Mean <- FamilyDensity %>% summarise(dens2 = mean(Wood.density..g.cm.3...oven.dry.mass.fresh.volume))

# Sorting mean dataframe by density, highest density to lowest density
FamDensityMeanSorted <- arrange(FamDensity_Mean, desc(dens2))

# Confirming correct count of FamilyIDs (191)
nrow(FamDensityMeanSorted)

# Printing top 8 highest and lowest density families in data frame
HighestFamDensity <- FamDensityMeanSorted %>% top_n(8) # top 8 highest density
LowestFamDensity <- FamDensityMeanSorted %>% top_n(-8) # top 8 lowest density    




