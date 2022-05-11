#Supplementary Material
#Using similarity measures to identify non-random co-occurrences between intermittent behaviors: a case study with primate scent-marking
#Thiago Cavalcante, Anamélia de Souza Jesus and Adrian A. Barnett
########### R script for bootstrapping procedure ###########


#Installing and loading the packages
install.packages("jaccard")
library(jaccard)

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("qvalue")


##### Creating two random behavioral vectors of 0x1 with a sample size of 
#100 days #####
behav1 <- sample(c(0,1), 100, replace=TRUE)
behav2 <- sample(c(0,1), 100, replace=TRUE)

jaccard.test.bootstrap(behav1, behav2, B=1000)#bootstrap with 1000 iterations 

##### Simulations to identify the type I error rate #####

#Example with N= 15 days
#Note that you can use your own sample size (number of days) to test the feasibility of this test for your study
p = NA

set.seed(1234)

for(i in 1:100){
  x1 <- sample(c(0,1), 15, replace=TRUE)
  x2 <- sample(c(0,1), 15, replace=TRUE)
  test = jaccard.test.bootstrap(x1,x2,B=1000)
  p[i] = test$pvalue
}

mean(p < 0.05)
table(p < 0.05)/100

