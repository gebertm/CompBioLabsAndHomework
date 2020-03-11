# **README file for _Logistic Growth Model_ Function** 

## [Lab08: EBIO5420: Computational Biology](https://github.com/flaxmans/CompBio_on_git/blob/master/Labs/Lab08/Lab08_documentation_and_metadata.md)

### Updated: 11 March 2020


The function, _LogisticGrowthModel_, in this scenario is used to model the growth of a given 
population based on a number of factors:

	* Intrinsic growth rate of the population
	* Environmental carrying capacity for the population
	* Total number of generations
	* Initial population size
	

and uses the following equation:

**GrowModel[t] = GrowModel[t-1] + ( r * GrowModel[t-1] * (K - GrowModel[t-1])/K )**

where:

* t = abundance of population at time t
* GrowthModel[t - 1] abundance of the population in the previous step
* r = intrinsic growth rate of the population
* K = environmental carrying capacity for the population
* g = total number of generations
* i = initial population size


## **Logistical Growth Model Function**

```
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
```

### **User Input:**

The function allows for **user input**: 

_note: the user must specify the **initial** population size (for example, 2500 individuals)_  

* r = intrinsic growth rate of the population
* K = environmental carrying capacity for the population
* g = total number of generations
* i = initial population size


### **Output:**

Function output is the abundance at a certain specified time or total generations (t)

The function will also output: 

* a simple graph of **abundance** vs. **time**
* a table of values for generation and the corresponding abundance.



**Example output** - based on user input:

```
> LogisticGrowthModel(0.8, 10000, 12, 2500)
 [1] 2500.000 4000.000 5920.000 7852.288 9201.444 9789.274 9954.302 9990.693 9998.132 9999.626 9999.925
[12] 9999.985
```

**Example graphical output** - based on user input:

![Graph Example](Rplot_GrwthFunction_AbundVsTime_EBIO5420_03112020.png)