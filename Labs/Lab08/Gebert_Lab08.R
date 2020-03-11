### EBIO 5420 Computational Biology - Lab08
### Documentation and Metadata

# Problem 7 from week 4's lab

# 4: The discrete - time logistic growth equation 
# n[t] = n[t-1] + ( r * n[t-1] * (K - n[t-1])/K )
# t = abundance of population at time t
# GrowthModel[t - 1] abundance of the population in the previous step
# r = intrinsic growth rate of the population
# K = environmental carrying capacity for the population
# g = total number of generations
# i = initial population size

# Function for Logistic Growth Model

LogisticGrowthModel <- function(r, K, g, i){
  GrowModel <- rep(i, g)
  for (t in 2:g) {
    GrowModel[t] = GrowModel[t-1] + ( r * GrowModel[t-1] * (K - GrowModel[t-1])/K ) # calculating abundance of population
  }
  Abundance <- ( GrowModel )   # assigning vector to a vector, abundance
  Time <- c(1:g)             # generating a vector of time
  Generations <- c(1:g)      # generating a vector of generations
  plot( Time, Abundance )    # plottinga abundance vs. time
  GrowthTable <- cbind( Generations, Abundance )   # creating a table of abundance vs. number of generations
  write.csv(GrowthTable, '~/Desktop/EBIO5420/CompBioLabsAndHomework/Labs/Lab08/LogisticGrowthModel.csv')   # writing table to a .csv file
return( GrowModel )
}

LogisticGrowthModel(0.8, 10000, 3, 2500)   # Testing function with user specified input
