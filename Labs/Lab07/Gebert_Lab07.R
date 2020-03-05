### EBIO 5420 - CompBio Lab07 - Functions

# Problem #1 - Calculating the area of a triangle

# Assigning values to base and height variables
base <- 10
height <- 9 

# Function to calculate area of the triangle
triangleArea <- function(base, height) {
  area <- ( base * height * 0.5 )  # equation for area of a triangle 
  return ( area ) 
}
triangleArea(base,height)

# Problem #2 - Absolute Value Function

# 2a. Absolute value of a single number
myAbs <- function(x){
  absVal <- (x)^2              # squaring the function, then taking the square root
  square <- sqrt(absVal)
  return( square )
}
myAbs(5)
myAbs(-2.3)

# 2b. Absolute value of a vector

myVec <- c(1.1, 2, 0, -4.3, 9, -12) # creating a vector of values

# Creating a function that looks at each scalar in vector and calculates the absolute value
myVecAbs <- function( defaultVector ){
  absVal <- ( defaultVector )^2
  square <- sqrt(absVal)
  return ( square )
}
myVecAbs(myVec)   # assessing myVec in function

# Problem #3 - Fibonacci Sequence Function
# user input: n (number of positions in the Fibinacci seq)
# Starting value for the Fibonacci Seq (0 or 1)

FibonacciSeq <- function(startingVal, n){
  fibSeq <- rep(startingVal, n)
  for (i in 3:n) {
    fibSeq[i] <- fibSeq[i - 1] + fibSeq[i - 2]
  }
  if (startingVal == 1)                     # if starting with 1
    return(fibSeq)
 else {                                     # if starting with 0, second position in vector needs to be 1
  fibSeq <-rep(startingVal, n)
  fibSeq[2] <- 1
  for (i in 3:n){
    fibSeq[i] <- fibSeq[i - 1] + fibSeq[i - 2]  
  }
  return( fibSeq )
 }
}  

FibonacciSeq(0, 4)  # starting with zero, evaluated to 4 positions
FibonacciSeq(1, 4)  # starting with one, evaluating to 4 positions
  
# Problem #4 - Custom functions
  
# a. Two arguments - returns the square of the differences
diffsquare <- function(x, y){
  z <- ( x - y )^2                   # taking the difference between x and y and then squaring the value
  return(z)
}
diffsquare(3, 5) # diffsquare function with 2 arugments 

vector_1 <- c(2, 4, 6) # diff square function on a vector
diffsquare(vector_1, 4)


# b. Function to calculate the arithmetic mean

arithmeticMean <- function(x){
  a_mean <- ( sum(x) /length(x) )
  return(a_mean)
}

# evaluating function for vector 5, 15, 10
vector_2 <- c(5, 15, 10)
arithmeticMean(vector_2)

# calculating the arithmetic mean

#reading in data for Lab 07
LabSevenData <- read.csv('~/Desktop/EBIO5420/compBioSandbox/CompBio_on_git/Labs/Lab07/DataForLab07.csv')
 
LabSevenDataVec <- c(LabSevenData$x)   # turning column x into a vector

arithmeticMean(LabSevenDataVec)
  
# Calculating the total sum of squares - sum of the squared deviations from the median

SumSquares <- function(x){
  meanVal <- arithmeticMean(x)                       # calculating the mean value to be used
  squareDiff <- diffsquare(x, meanVal)               # taking the difference between the vector positions and the mean
  sumValue <- sum(squareDiff)                        # summing all the means
  return(sumValue)
}
SumSquares(LabSevenDataVec)
  