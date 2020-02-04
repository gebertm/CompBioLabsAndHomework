# EBIO5420 Computational Biology --- Lab 3 
# 31 January 2020 - Gebert, Matthew

# lab step #3: assigning food and guests to variables
chips <- 5
guests <- 8

# lab step #5: average bags of chips consumed per guest (amount of the bag)
food_eaten <- 0.4

# lab step #7: calculating leftover chips - including self
leftover <- chips - ((guests + 1) * food_eaten)

# lab step #8: creating vector of ratings per person per for each episode of Star Wars
self <- c(7, 9, 8, 1, 2, 3, 4, 6, 5)
penny <- c(5, 9, 8, 3, 1, 2, 4, 7, 6)
lenny <- c(6, 5, 4, 9, 8, 7, 3, 2, 1)
stewie <- c(1, 9, 5, 6, 8, 7, 2, 3, 4)

# lab step #9: indexing vector for episode for ratings
pennyIV <- penny[4] 
lennyIV <- lenny[4]

# lab step #10: concatenating 4 sets of rankings into a single data object (matrix) using cbind
sw_rankings <- cbind(self, penny, lenny, stewie)

# lab step #11: using str()
str(pennyIV)
str(penny)
str(sw_rankings)

# The first result you obtain using str(pennyIV) is the index at position 4. 
# The result you obtain with str(penny) is the range and a list of the entire vector with all indexes
# The result you obtain with str(sw_rankings) is telling you that you have a 9 by 4 matrix, labeled by
# a string of 4 characters (names of friends). A matrix cannot contain both numbers and characters.


# lab step #12: creating a data frame using the 4 vectors
dfStarWars <- data.frame(sw_rankings)
dfStarWars2 <- as.data.frame(sw_rankings)

# lab step #13: similarities and differences in cbind() and as.data.frame
# dim(): this function gives you the dimensions of your object. In this case it can be either a data frame
# or a matrix. The result of the fuction is the same for both commands, meaning, although one is a matrix and
# the other is a data frame, they have the same dimensions.
dim(sw_rankings)
dim(dfStarWars2)
# lab step #10 generates a matrix, which needs to be one data type only, while lab step #12 generates a data frame
# which can store multiple different data types. Since matrix does not allow you to store multiple different 
# types of data, like numbers AND characters, there is a difference in the structure command. Str(data.frame) prints
# a human readable version of the data table, and str(matrix) gives you the dimensions of the matrix, and separately tells
# you which characters are present.
str(sw_rankings)
str(dfStarWars2)


# lab step #14: creating a vector of episode names as roman numerals
episodes <- c("I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX")

# lab step #15: naming the rows of the objects as roman numeras
row.names(sw_rankings) <- episodes
row.names(dfStarWars) <- episodes

# lab step # 16: accessing third row of the matrix
sw_rankings[3,]

# lab step #17: accesing the fourth column from the dataframe
dfStarWars[,4]

# lab step #18: accessing self rankings for Episode V
dfStarWars[5,1]

# lab step #19: accessing Penny's rankings for episode II
dfStarWars[2,2]

# lab step #20: accessing everyone's ratings for episodes IV - VI (rows 4, 5, 6)
dfStarWars[ c(4,5,6), ]

# lab step #21: accessing everyone's ratings for episodes II, V, VII
dfStarWars[ c(2,5,7), ]

# lab step #22: accessing rankings for Penny and Stewie for episodes IV and VI
dfStarWars[ c(4,6), c(2,4)]

# lab step #23: switching Lenny's rankings for episodes II and V (ratings: 5 and 8)

# swapping values for episode II and episode V
lenny1 <- dfStarWars[2,3]
lenny2 <- dfStarWars[5,3]

dfStarWars[5,3] <- lenny1
dfStarWars[2,3] <- lenny2

# lab step #24: alternate methods of referencing indexes
dfStarWars["III","penny"]
sw_rankings["III", "penny"]

# lab step #25: using names rather than indexes to undo lab step #23
lenny1 <- dfStarWars["II","lenny"]
lenny2 <- dfStarWars["V", "lenny"]

dfStarWars["V", "lenny"] <- lenny1
dfStarWars["II", "lenny"] <- lenny2

# Redoing lab step #23 using the '$' operator
lenny1 <- dfStarWars$lenny[2]
lenny2 <- dfStarWars$lenny[5]

dfStarWars$lenny[2] <- lenny2
dfStarWars$lenny[5] <- lenny1
