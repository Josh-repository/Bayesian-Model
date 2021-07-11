# Bayesian approach:
gibbs1 = function(iters,y,alpha){
  x<-array(0,c(iters+1,3))
  beta = 0.0446
  x[1,1] = 8.625 # initial lamda value.
  x[2,2] =  (0.20 * sum(y)) # OD initial value.
  temp = c()
  
  # Posterior Distribution is gamma distribution for parameter lamda. 
  total_probability = function(lamda,X){
    a = 0
    for (i in 1:8){
      xp = (exp(-lamda)*lamda^(X[i]))/factorial(X[i])
      a = a + xp
    }
    return(mean(a))
  }
   
  for (t in 2: (iters+1)){
    
    x[t,1] = rgamma(1, (x[t,2] + (sum(y) - x[t,2]) + alpha), 8 + beta)
    z = c(9,16,6,8,15,8,2,5) # these are the units failed in a hourly basis in the sample dataset.
    # total probability of failure occurance.
    p = total_probability(x[t,1],z)
    x[t,3] = (0.20 * p) # this gives the probability of units failed beacuse of Other Defects.
    x[t,2] = rbinom(1,69,0.20 * p)
  }

  par(mfrow=c(1,2))
  plot(1:length(x[,1]),x[,1], type='l', lty=1, xlab='t', ylab='lambda')
  plot(1:length(x[,2]),x[,2], type='l', ylim=c(0,20), lty=1, xlab='t', ylab='OD')
  
  return(x)
  }
set.seed(123)
y=rpois(8, 8.625)


output = gibbs1(1000, y, 1)
output

# Lamda value.
absence<-(output[,1]) 
absent<-(absence [101:1000])
mean(absent) # posterior estimate for lambda.
var(absent) # variance associated with lamda.
# Posterior lamda distribution graph.
par(mfrow=c(1,1))
hist(absent,
     breaks=25,                              
     freq=F,                                 
     main="Total Defects",
     xlab="Rate parameter(Units failed)",
     ylab="Density")

# Number of Other Defects caused.
OD <- (output[,2]) 
mean(OD) # mean number of Other defect occurance.

# Probibility sample of Other Defects occurance.
other_defect <- (output[,3]) 
other_defect_mean <- mean(other_defect) # mean probability of Other Defects Occurance. 




