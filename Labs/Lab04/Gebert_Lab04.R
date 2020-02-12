# EBIO 5420: Computational Biology
# Gebert, Matthew 
# 6 February 2020
# Lab 04: For Loops


### Part 1: Practice writing "for loops"

# 1: For loop to print a define number of 'hi' to the console
print_range <- 1:10         # range of iterations
for(i in print_range) {
  print ('hi')
}

# 2: Calculating money saved per week with a for loop, for 8 weeks

num_of_weeks <- 1:8 # vector length
intial_saved <- 10 # initial amount of money saved in dollars
allowance <- 5 # weekly allowance in dollars
gum_price <- 1.34 *2  # price of two packs of gum + tax

# calculating savings per week
for (i in num_of_weeks){
  savings <- ((allowance - gum_price) * num_of_weeks) + intial_saved   # loop through i
}
print(savings)

# 3: Yearly expected population size - shrinks by 5% each year
num_of_years <- 1:7 # number of years of study, vector length
population_size_initial <- 2000 # initial population size 
percentage_remaining <- 0.95 # percent of population remaining each year

# calculating population reduction over 7 years
population_size <- population_size_initial
print (population_size_initial) # printing intial population size
for (i in num_of_years) {
  population_size <- population_size * percentage_remaining   
  print (as.integer(population_size))   # converting population size into an integer
}


# 4: The discrete - time logistic growth equation 
# n[t] = n[t-1] + ( r * n[t-1] * (K - n[t-1])/K )
# t = abundance of population at time t
# n[t - 1] abundance of the population in the previous step
# r = intrinsic growth rate of the population
# K = environmental carrying capacity for the population

K <- 10000      # environmnetal carrying capacity for the population
r <- 0.8        # intrinsic growth rate of the population
t <- 1          # abundance of population at time t
end_time <- 12  # number of generations           
n <- rep(2500, 12)    # establishing vector as placeholders for data. Starting at 2500

for (t in 2:end_time) {
  n[t] = n[t-1] + ( r * n[t-1] * (K - n[t-1])/K ) # calculating abundance of population
}
print(n)


### Part 2: Practice writing 'for loops' AND practice storing the output in arrays

# 5a: rep command - genearting 18 zeros
n <- 18   # assigning value to n
data_rep_1 <- rep(0, n)
print(data_rep)


# 5b.
start_rep <- rep(0,18)     # ending value
end <- 18                  # defining vector

for (i in seq(1, end) ) {
  start_rep[i] <- i * 3
}
print(start_rep)


# 5c.
n <- 18              # assigning value to n
x <- 1               # assigning value to x, value to replace 1

for (i in 1:18) {
data_rep <- rep(0, n)    # vector of 0s - 18 'placeholders'
data_rep[1] <- x         # replacing the first position with 1
}
print(data_rep)

# 5d. 
# using placeholder vector from 5c.
# starting at position 2 in vector, previous index position in equation
# assigning to new position in vector

vector_length <- 18 # defining vector length

for (i in seq(2, vector_length)) {
  data_rep[i] <- 1 + (2 * data_rep[i - 1])   # index position - 1, * 2
}

print(data_rep)

# 6: Fibonacci Sequence
# creating a placeholder 0 vector of 20 positions. Assigning the value of 1 to position 2. 
# for i between 3 - 20, previous index - the previous previous index, assigning to the current position.

vector_length <- 20 # vector length

data_rep_1 <- rep(0, vector_length)
data_rep_1[2] <- 1   # assigning value 1 to position 2 in vector

for(i in seq(3,vector_length)) {
  data_rep_1[i] <- data_rep_1[i-1] + data_rep_1[i-2]
}
print (data_rep_1)

# 7: Plotting abundance in response to time

K <- 10000              # environmnetal carrying capacity for the population
r <- 0.8                # intrinsic growth rate of the population
t <- 1                  # abundance of population at time t
end_time <- 12          # number of generations, vector length
n <- rep(2500, 12)

for (t in 2:end_time) {
  n[t] = n[t-1] + ( r * n[t-1] * (K - n[t-1])/K )   # calculating abundance of population
}

abundance <- (n)   # assigning vector to a vector, abundance
time <- c(1:end_time) # generating a vector of time

plot(time, abundance)