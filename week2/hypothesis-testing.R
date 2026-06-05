library(tidyverse)

####################################################################################
# IST Chapter 9, Exercise 9.1
magnets <- read_csv("http://pluto.huji.ac.il/~msby/StatThink/Datasets/magnets.csv")

# 1. What is the sample average of the change in score between the
#    patient's rating before the application of the device and the
#    rating after the application?
summary(magnets)
mean(magnets$change)
# 3.5

# 2. Is the variable "active" a factor or a numeric variable?
# the variable "active" is a factor; because it's labeling the group that patients belong. 

# 3. Compute the average value of the variable "change" for the patients that
#    received an active magnet and average value for those that received an
#    inactive placebo. (Hint: Notice that the first 29 patients received an
#    active magnet and the last 21 patients received an inactive placebo. The
#    subsequence of the first 29 values can be obtained via "change[1:29]" and
#    the last 21 values via "change[30:50]".)
mean(magnets$change[1:29])
# 5.241379
mean(magnets$change[30:50])
# 1.095238

# 4. Compute the sample standard deviation of the variable "change" for the
#    patients that received an active magnet and the sample standard deviation
#    for those that received an inactive placebo.
sd(magnets$change[1:29])
# 3.236568
sd(magnets$change[30:50])
# 1.578124

# 5. Produce a boxplot of the variable "change" for the patients that received
#    an active magnet and for patients that received an inactive placebo. What
#    is the number of outliers in each subsequence?
boxplot(magnets$change[1:29])
# 0 outliers
boxplot(magnets$change[30:50])
# 3 outliers

####################################################################################
# IST Chapter 10, Exercise 10.1
#
# In Subsection 10.3.2 we compare the average against the midrange as estimators
# of the expectation of the measurement. The goal of this exercise is to repeat
# the analysis, but this time compare the average to the median as estimators of
# the expectation in symmetric distributions.
#
# 1. Simulate the sampling distribution of average and the median of a sample
#    of size n = 100 from the Normal(3, 2) distribution. Compute the expectation
#    and the variance of the sample average and of the sample median. Which of
#    the two estimators has a smaller mean square error?
n <- 100
num_sim <- 10000

true_mean_norm <- 3
sd_norm <- sqrt(2)

avgs_norm <- replicate(num_sim, mean(rnorm(n, mean = true_mean_norm, sd = sd_norm)))
meds_norm  <- replicate(num_sim, median(rnorm(n, mean = true_mean_norm, sd = sd_norm)))

exp_avg_norm <- mean(avgs_norm)
exp_med_norm <- mean(meds_norm)
exp_avg_norm
#  2.999346
exp_med_norm
# 3.000689

var_avg_norm <- var(avgs_norm)
var_med_norm <- var(meds_norm)
var_avg_norm
# 0.01984406
var_med_norm
# 0.0306657

mse_avg_norm <- mean((avgs_norm - true_mean_norm)^2)
mse_med_norm <- mean((meds_norm - true_mean_norm)^2)
mse_avg_norm
# 0.0198425
mse_med_norm
# 0.03066311

#mse_avg_norm has smaller MSE

# 2. Simulate the sampling distribution of average and the median of a sample
#    of size n = 100 from the Uniform(0.5, 5.5) distribution. Compute the
#    expectation and the variance of the sample average and of the sample
#    median. Which of the two estimators has a smaller mean square error?
n <- 100
num_sim <- 10000

true_mean_unif <- 3.0
low_unif <- 0.5
high_unif <- 5.5

avgs_unif <- replicate(num_sim, mean(runif(n, min = low_unif, max = high_unif)))
meds_unif <- replicate(num_sim, median(runif(n, min = low_unif, max = high_unif)))

exp_avg_unif <- mean(avgs_unif)
exp_med_unif <- mean(meds_unif)
exp_avg_unif
# 3.000515
exp_med_unif
# 3.003739

var_avg_unif <- var(avgs_unif)
var_med_unif <- var(meds_unif)
var_avg_unif
# 0.0204646
var_med_unif
# 0.06153803

mse_avg_unif <- mean((avgs_unif - true_mean_unif)^2)
mse_med_unif <- mean((meds_unif - true_mean_unif)^2)
mse_avg_unif
# 0.02046282
mse_med_unif
# 0.06154585

#mse_avg_unif has smaller MSE

####################################################################################
# IST Chapter 10, Exercise 10.2
#
# The goal in this exercise is to assess estimation of a proportion in a
# population on the basis of the proportion in the sample.
#
# The file "pop2.csv" was introduced in Exercise 7.1 of Chapter 7. This file
# contains information associated to the blood pressure of an imaginary
# population of size 100,000. One of the variables in the file is a factor by
# the name "group" that identifies levels of blood pressure. The levels of this
# variable are "HIGH", "LOW", and "NORMAL".
#
# The file "ex2.csv" contains a sample of size n = 150 taken from the given
# population. The file "ex2.csv" corresponds to the observed sample and the file
# "pop2.csv" corresponds to the unobserved population.

pop2 <- read_csv("http://pluto.huji.ac.il/~msby/StatThink/Datasets/pop2.csv")
ex2 <- read_csv("http://pluto.huji.ac.il/~msby/StatThink/Datasets/ex2.csv")

# 1. Compute the proportion in the sample of those with a high level of blood
#    pressure.
summary(ex2)
table(factor(ex2$group))

# bad way ... "static"
samp_high_bp_prop = 37/150
print(high_bp_prop)

# better way, now this is more "dynamic"
mean(ex2$group == "HIGH")

# 2. Compute the proportion in the population of those with a high level of
#    blood pressure.
summary(pop2)
table(factor(pop2$group))

mean(pop2$group == "HIGH")

# 3. Simulate the sampling distribution of the sample proportion and compute
#    its expectation.
n <- 150 
num_sim <- 10000 

props_sim <- replicate(num_sim, mean(sample(pop2$group, size = n, replace = TRUE) == "HIGH")) 

exp_prop <- mean(props_sim) 
exp_prop 

# 4. Compute the variance of the sample proportion.
var(props_sim)

# 5. It is proposed in Section 10.5 that the variance of the sample proportion
#    is Var(P_hat) = p(1 - p)/n, where p is the probability of the event (having
#    a high blood pressure in our case) and n is the sample size (n = 150 in our
#    case). Examine this proposal in the current setting.
p_true <- mean(pop2$group == "HIGH")
p_true

var_theo <- (p_true * (1 - p_true)) / n
var_theo

var_emp <- var(props_sim)
var_emp

var_diff <- abs(var_theo - var_emp)
var_diff

# theoretical and empirical are pretty close so the formula for var(p_hat) should be correct

####################################################################################
# ISRS Exercise 2.2 - Heart transplants, Part II
#
# Exercise 1.50 introduces the Stanford Heart Transplant Study. Of the 34
# patients in the control group, 4 were alive at the end of the study. Of the 69
# patients in the treatment group, 24 were alive.
#
# Contingency table:
#                                    Group
#                       --------------------------
#                        Control  Treatment  Total
#          ---------------------------------------
#                Alive      4        24       28
#          ---------------------------------------
#  Outcome       Dead       30       45       75
#          ---------------------------------------
#                Total      34       69      103
#          ---------------------------------------
#
# (a) What proportion of patients in the treatment group and what proportion
#     of patients in the control group died?
control_died_prop <- 30/34
control_died_prop
# 0.8823529
treat_died_prop <- 45/69
treat_died_prop
# 0.6521739

# (b) One approach for investigating whether or not the treatment is effective
#     is to use a randomization technique.
#     i. What are the claims being tested? Use the same null and alternative
#          hypothesis notation used in the section.

# Null Hypothesis: p_treat - p_control = 0 
# No difference meaning the treatment has no effect

# Alternative Hypothesis: p_treat - p_control < 0 
# If treatment works, expect fewer deaths so difference would be less than zero

#     ii. The paragraph below describes the set up for such approach, if we were
#     to do it without using statistical software. Fill in the blanks with a
#     number or phrase, whichever is appropriate. 
#          We write alive on "28" cards representing patients who were
#          alive at the end of the study, and dead on "75" cards representing
#          patients who were not. Then, we shuffle these cards and split them
#          into two groups: one group of size "69" representing treatment, and
#          another group of size "34" representing control. We calculate the
#          difference between the proportion of dead cards in the treatment and
#          control groups (treatment - control) and record this value. We repeat
#          this many times to build a distribution centered at "0." Lastly, we
#          calculate the fraction of simulations where the simulated differences
#          in proportions are "less than or equal to observed difference". If this fraction is low, we conclude that it is
#          unlikely to have observed such an outcome by chance and that the null
#          hypothesis should be rejected in favor of the alternative.

#     iii. What do the simulation results suggest about the effectiveness of
#          the transplant program? (See textbook for figure.)
# The treatment is effective.

####################################################################################
# ISRS Exercise 2.6 
# An experiment conducted by the MythBusters, a science entertainment TV program
# on the Discovery Channel, tested if a person can be subconsciously influenced
# into yawning if another person near them yawns. 50 people were randomly
# assigned to two groups: 34 to a group where a person near them yawned
# (treatment) and 16 to a group where there wasn't a person yawning near them
# (control). The following table shows the results of this experiment.
#
# Contingency table:
#                         --------------------------
#                         Control  Treatment  Total
#          ---------------------------------------
#               Yawn         10       4        14
#  Result       Not Yawn     24       12       36
#          ---------------------------------------
#                Total       34       16       50
#          ---------------------------------------
#
# A simulation was conducted to understand the distribution of the test
# statistic under the assumption of independence: having someone yawn near
# another person has no influence on if the other person will yawn. In order to
# conduct the simulation, a researcher wrote yawn on 14 index cards and not yawn
# on 36 index cards to indicate whether or not a person yawned. Then he shuffled
# the cards and dealt them into two groups of size 34 and 16 for treatment and
# control, respectively. He counted how many participants in each simulated
# group yawned in an apparent response to a nearby yawning person, and
# calculated the difference between the simulated proportions of yawning as
# ˆptrtmt,sim − pˆctrl,sim. This simulation was repeated 10,000 times using
# software to obtain 10,000 differences that are due to chance alone. The
# histogram shows the distribution of the simulated differences.
#
# (a) What are the hypotheses?
# (b) Calculate the observed difference between the yawning rates under the
#     two scenarios.
# (c) Estimate the p-value using the figure and determine the conclusion of
#     the hypothesis test.

####################################################################################
# IST Exercise 9.2 
# In Chapter 13 we will present a statistical test for testing
# if there is a difference between the patients that received the active magnets
# and the patients that received the inactive placebo in terms of the expected
# value of the variable that measures the change. The test statist for this
# problem is taken to be
#  T = (X_bar_1 - X_bar_2) / sqrt(S_1^2/29 + S_2^2/21)
#
# where X_bar_1 and X_bar_2 are the sample averages for the 29 patients that 
# receive active magnets and for the 21 patients that receive inactive placebo, 
# respectively. The quantities S_1^2 and S_^2 are the sample variances for each
# of the two samples. Our goal is to investigate the sampling distribution 
# of this statistic in a case where both expectations are equal to each other 
# and to compare this distribution to the observed value of the statistic.
#
# 1. Assume that the expectation of the measurement is equal to 3.5, regardless
#    of what the type of treatment that the patient received. We take the
#    standard deviation of the measurement for patients the receives an active
#    magnet to be equal to 3 and for those that received the inactive placebo we
#    take it to be equal to 1.5. Assume that the distribution of the
#    measurements is Normal and there are 29 patients in the first group and 21
#    in the second. Find the interval that contains 95% of the sampling
#    distribution of the statistic.
# 2. Does the observed value of T (computed from the "magnets" data) fall
#    inside or outside the interval computed in 1?
