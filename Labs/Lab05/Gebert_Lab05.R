# Computational Biology: Lab 05 - Loops and Conditionals 
# 14 February 2020
# Gebert, Matthew


# Part I: Simple Conditionals

#1. Creating variable x and assigning numeric value

x <- 5 # assigning numeric value to variable x

if (x > 5) {
print ("The value is greater than 5")     # print statment if value is greater than 5
} else {            
print ("The value is less than 5")        # print statement if value is less than 5
}

#2. Transferring ExampleData.csv

Example_data <- read.csv('~/Desktop/EBIO5420/CompBioLabsAndHomework/Labs/Lab05/ExampleData.csv') #importing as data frame
data_vec <- as.vector(Example_data$x)

# 2a. Changing negative values to NA using a loop
for (i in 1:length(data_vec)){
  if (data_vec[i] >= 0 ){
    print (data_vec[i])
  } else{ 
    data_vec[i] <- NA
  }
}
print(data_vec)

# 2b.
data_vec[is.na(data_vec)] <- NaN  # In vector position NA, assign NaN

# 2c. Using which(), changing NaN to a zero value

which(is.na(data_vec))                   # finding positions of NaN
data_vec[which(is.na(data_vec))] <- 0    # assigning value of zero to NaN positions
print(data_vec)

# 2d. Determining how many values fall in the range between 50 and 100

low_range <- 50      # lower end of the range of values
high_range <- 100    # upper end of the range of values

# Take length of the range of positions of values that fall between 50 and 100, inclusive of endpoints
range_value_length <- length(which(data_vec <= high_range & data_vec >= low_range))
range_values <- which(data_vec <= high_range & data_vec >= low_range)

# 2e. 

FiftyToOneHundred <- data_vec[range_values]   # Creating a vector of values, corresponding to positions in range of interest
FiftyToOneHundred

# 2f. 
setwd("~/Desktop/EBIO5420/CompBioLabsAndHomework/Labs/Lab05/")  # Setting the working directory - Lab05
write.csv(x = FiftyToOneHundred, file = "FiftyToOneHundred.csv") # writing file to .csv

# Question 3: C02 Emissions

# Importing CO2 Data
CarbonDioxideEmissions <- read.csv("~/Desktop/EBIO5420/compBioSandbox/CompBio_on_git/Labs/Lab04/CO2_data_cut_paste.csv")

# 3a. Which year 'gas' emissions were non-zero

QueryPosition <- 1 # position of vector we are interested in querying

GasNonZero <- which(CarbonDioxideEmissions$Gas > 0)   # Finding all values that are greater than 0
FirstGasNonZero <- GasNonZero[QueryPosition]    # Assigning the first non-zero position of the vector to a variable 
FirstGasNonZero

# Querying position of first non-zero gas value 
FirstYear <- CarbonDioxideEmissions$Year[FirstGasNonZero]
FirstYear

# 3b. 'Total' emissions between 200 and 300 million metric tons of carbon

# Setting parameters
LowEnd <- 200
HighEnd <- 300

CarbonDioxideVector <- c(CarbonDioxideEmissions$Total)  # Vectorizing number of years
TotalEmissions <- which(CarbonDioxideVector <= HighEnd & CarbonDioxideVector >= LowEnd) # total emissions between 200 and 300
TwoHundredToThreeHundred <- CarbonDioxideEmissions$Year[TotalEmissions]

# Part II: Loops + Conditionals - Lotka - Volterra PredatorPrey Model
# n[t] <- n[t-1] + (r * n[t-1]) - (a * n[t-1] * p[t-1])
# p[t] <- p[t-1] + (k * a * n[t-1] * p[t-1]) - (m * p[t-1])


totalGenerations <- 1000 # total number of generations 
initPrey <- 100 	# initial prey abundance at time t = 1
initPred <- 10		# initial predator abundance at time t = 1
a <- 0.01 		# attack rate
r <- 0.2 		# growth rate of prey
m <- 0.05 		# mortality rate of predators
k <- 0.1 		# conversion constant of prey into predators

n <- rep(0, totalGenerations) # creating vectors with placeholder 0 for predator and prey
p <- rep(0, totalGenerations)
time <- (1:totalGenerations)   # counting time, 1 to total number of generations

# setting initial values
n[1] <- initPrey
p[1] <- initPred

for (t in 2:length(time)) {
  n[t] <- ifelse(n[t-1] + (r * n[t-1]) - (a * n[t-1] * p[t-1]) < 0, 0, n[t-1] + (r * n[t-1]) - (a * n[t-1] * p[t-1]))
  p[t] <- ifelse(p[t-1] + (k * a * n[t-1] * p[t-1]) - (m * p[t-1]) < 0, 0, p[t-1] + (k * a * n[t-1] * p[t-1] - (m * p[t-1])))
}

#printing values of n and p
print( n )
print( p )

plot(x = time, y = n, col = 'red', xlab = 'Generation', ylab = 'Abundance', type = 'l')
lines(x = time, y = p, col = 'blue', type = 'l')

# Creating a data frame of Predator/Prey Data at varying timepoints

PredPreyDataFrame <- data.frame(TimeStep = time, PreyAbundance = n, PredatorAbundance = p)

# writing to .csv
setwd("~/Desktop/EBIO5420/CompBioLabsAndHomework/Labs/Lab05/")
write.csv(x = PredPreyDataFrame, file = 'PredPreyResults.csv')   # writing data frame to .csv
      
