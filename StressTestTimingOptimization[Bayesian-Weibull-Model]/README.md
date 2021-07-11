# Bayesian-Weibull based model to optimize environmental stress testing:

## Abstract:
The main objective of this research work was to identify those units which failed in Environmental Stress Testing (EST) were caused due to defects other than Latent Defects (LD). Later, this information was used in defining the Weibull distribution model to evaluate the total cost incorporating failure information from both field and testing environments. The initial treatment of the solution proposed here is purely Bayesian in nature. We perform extensive simulation experiments to study the contribution made by other defects towards failure in EST and finally analyze one real dataset for illustrative purposes. The results obtained were highlighted and discussions were made at the end.

## Problem Statement:
Creating an environmental testing model for measuring the units which are not part of Latent Defect (LD) nor Stress testing (SS), but have failed due to arbitrary reasons, units that are not identified as Latent Defect nor Stress testing are denoted as “X” units. The below Venn diagram illustrates an overview of the hypothesis of our research. 
The hypothesis of this model aims to find what percentage or amount of units is not considered to be a latent defect but fails from stress testing, this may result in lesser stress time while eliminating those units and optimizing cost. 

Let $\Omega$ be the set of all manufactured units,
Let LD be the Latent Defect,
Let SS be the number of units that failed in stress testing, and
Let SS’ be the number of units that are not considered as Latent failure, but fail in the stress testing.

## Workflow:
Diagram:


## Bayesian-approach:
### Likelihood:
Let us assume that the number of units that failed in EST on an hourly basis follows Poisson Distribution with parameter ‘𝝀’. We also consider the failure are caused by two reasons,

Due to Latent Defect 
Due to defects other than Latent Defect (LD) that is Other Defects (OD)
Here, it is also believed that Other Defects contribute towards 20$\%$ of the total defect observed.

From this, we can calculate the total number of failures that occurred in 8 hours is 69. Therefore, the rate parameter '𝜆' for one hour is given by (Total units failed / Total Hours) which is ‘8.625’, and several estimations ‘N’ is 8. From this, we can generate a random Poisson distribution using the “rpois” function in R.

### Prior:
Prior distributions play a very important role in Bayesian statistics. They are essentially the basis of Bayesian analysis. Different types of prior distributions exist, namely, informative and non-informative. Non-informative prior distributions (a.k.a. vague, flat, and diffuse) are distributions that have no population basis, and play a minimal role in the posterior distribution. The idea behind the use of non-informative prior distributions is to make inferences that are not greatly affected by external information, or when external information is not available. Jeffreys prior was initially considered, since it does not add any valuable information in posterior, we decided to stick with informative prior.  
On the other hand, informative priors have a stronger influence on the posterior distribution. The influence of the prior distribution on the posterior is related to the sample size of the data and the form of the prior. We assume that the prior distribution of ‘$/lambda$’ has an exponential with 80$\%$ of values are less than 5.  On substitution, we got ‘$/beta$’ as 0.0446. 

### Posterior:
The posterior distribution form of Poisson likelihood and gamma prior follows a gamma distribution. The exponential distribution is a special form of gamma distribution with an alpha value of 1 and a beta value
Here 𝛼 = 1 and ꞵ = 0.0446. n = 8 and ∑xi = OD + LD comes from likelihood distribution that we got from rpois with '𝜆' value of 8.625
Since we don’t know how much OD is present in  ∑xi, but we initially assumed 20$\%$ of ∑xi are OD. With this information, we kick-started the execution. Now we arrived at the posterior distribution with a new value for '𝜆'. With this new '𝜆' , we calculated the Poisson probability of failures occurring for each hour in the given sample dataset. So we arrived at a probability value (p) which attributes towards 69 failures occurring in 8 hours. And we also knew the probability of getting OD is 0.20.  Now if we multiply ‘p’ with 0.20 we get the probability value for getting OD in 69 observations. On feeding this probability value in r binomial distribution we can find out the exact number of OD failures occurring among 69 total failures.

### Results and Discussion:
After a thousand iterations, the mean OD value we got was 7.49 which is rounded off to 8. This signifies there were a total of 8 failures that were caused due to OD in the sample dataset considered. The mean rate parameter $\lambda$ was found to be 9.57 per hour. In addition, we also figured out the mean probability of failure caused due to OD which is 0.107727. Now with the help of this probability value, we built a binomial distribution of 1 and 0. Where 1 specifies the occurrence of OD and 0 specifies the occurrence of LD for 69 observations. Now, we will remove the defects from Fig 4 whose index value coincides with the index value of binomial distribution where ‘1’ occurred. Therefore, now we are left with the failures dataset that contains failures that are caused only by LD. This new failure dataset that we arrived at satisfies all the assumptions made by Honari et al. So that we can implement the cost evaluation method specified by Honari et al and do stress testing optimization which leads to a new optimized Environmental Stress test duration of 6 hours which is less than of Honari et al’ finding of 6.5 hrs which is way less than that of 8 hrs of initial testing duration. We successfully reduced test duration 20-25% and cost involved by 10%. 
