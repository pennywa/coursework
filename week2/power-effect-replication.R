library(tidyverse)

####################################################################################
# IST Chapter 12, Exercise 12.1
magnets <- read_csv("http://pluto.huji.ac.il/~msby/StatThink/Datasets/magnets.csv")

#  Consider a medical condition that does not have a standard
# treatment. The recommended design of a clinical trial for a new treatment
# to such condition involves using a placebo treatment as a control. A placebo
# treatment is a treatment that externally looks identical to the actual treatment
# but, in reality, it does not have the active ingredients. The reason for using
# placebo for control is the “placebo effect”. Patients tent to react to the fact that
# they are being treated regardless of the actual beneficial effect of the treatment

# As an example, consider the trial for testing magnets as a treatment for pain
# that was described in Question 9.1. The patients that where randomly assigned
# to the control (the last 21 observations in the file “magnets.csv”) were treated
# with devises that looked like magnets but actually were not. The goal in this
# exercise is to test for the presence of a placebo effect in the case study “Magnets
# and Pain Relief” of Question 9.1 using the data in the file “magnets.csv”.

# 1. Let X be the measurement of change, the difference between the score of
#   pain before the treatment and the score after the treatment, for patients
#   that were treated with the inactive placebo. Express, in terms of the
#   expected value of X, the null hypothesis and the alternative hypothesis
#   for a statistical test to determine the presence of a placebo effect. The null
#   hypothesis should reflect the situation that the placebo effect is absent

# Null Hypothesis: Placebo effect is absent.
# H0: E[X] = 0

# Alternative hypothesis: Complement of null hypothesis.
# H1: E[X] != 0

# 2. Identify the observations that can be used in order to test the hypotheses.
# Look at the placebo effect group. Skip the 29 patients that got the real magnet. 
magnets$change[30:50]

# 3. Carry out the test and report your conclusion. (Use a significance level of
#    5%.)
placebo_data <- magnets$change[30:50]
test_result <- t.test(placebo_data, mu = 0, alternative = "two.sided")
print(test_result)

#  p-value is 0.004702 which is less than 0.05
# so we reject null hypothesis
# meaning there might be a placebo effect

####################################################################################
# IST Chapter 13, Exercise 13.1

magnets <- read_csv("http://pluto.huji.ac.il/~msby/StatThink/Datasets/magnets.csv")
#  In this exercise we would like to analyze the results of the
# trial that involves magnets as a treatment for pain. The trial is described in
# Question 9.1. The results of the trial are provided in the file “magnets.csv”

# Patients in this trail where randomly assigned to a treatment or to a control.
# The responses relevant for this analysis are either the variable “change”, which
# measures the difference in the score of pain reported by the patients before and
# after the treatment, or the variable “score1”, which measures the score of pain
# before a device is applied. The explanatory variable is the factor “active”.
# This factor has two levels, level “1” to indicate the application of an active
# magnet and level “2” to indicate the application of an inactive placebo.

# In the following questions you are required to carry out tests of hypotheses.
# All tests should conducted at the 5% significance level:
# 1. Is there a significance difference between the treatment and the control
#    groups in the expectation of the reported score of pain before the application of the device?
t.test(score1 ~ active, data = magnets)
# p-value = 0.6806 which is above 0.05
# DONT reject null hypothesis
# patients were assigned to groups randomly 
# so no prior knowledge or pre-conceived notions whether placebo or not

# 2. Is there a significance difference between the treatment and the control
#    groups in the variance of the reported score of pain before the application
#    of the device?
var.test(score1 ~ active, data = magnets)
# ratio of variances is 0.6950431 
# p-value = 0.3687
# p-val is still above 0.05
# prior to device application, 
# the 2 groups have same characteristics

# 3. Is there a significance difference between the treatment and the control
#    groups in the expectation of the change in score that resulted from the
#    application of the device?
t.test(magnets$change ~ magnets$active)
# p-value = 3.86e-07
# this is less than 0.05
# reject null hypothesis
# meaning magnets do have an effect on responses' expectation

# 4. Is there a significance difference between the treatment and the control
#    groups in the variance of the change in score that resulted from the application of the device?
var.test(magnets$change ~ magnets$active)
# p-value = 0.001535
# less than 0.05
# reject null hypothesis
# magnets also affect variance