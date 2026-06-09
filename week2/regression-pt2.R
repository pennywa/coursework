#################################################################################
# Reproduce this table in ISRS 5.29 using the original dataset in body.dat.txt
# Coefficients:
#               Estimate  Std. Error  t value  Pr(>|t|)
# (Intercept)  -105.0113      7.5394   -13.93    0.0000
# height          1.0176      0.0440    23.13    0.0000
body <- read.table("body.dat.txt", header = FALSE) 
# header originally TRUE; I wanted to see what happens if i changed it to false
head(body)
nrow(body)
summary(body)

# lin_model <- lm(weight ~ height, data = body) 
# summary(lin_model) 

# Error: object 'model' not found
# Ah so the df doesnt have named cols

summary(lm(V23 ~ V24, data = body)) 

###################################################################################
# ISRS Exercise 6.1
#  The Child Health and Development Studies investigate a range of
# topics. One study considered all pregnancies between 1960 and 1967 among women in the Kaiser
# Foundation Health Plan in the San Francisco East Bay area. Here, we study the relationship
# between smoking and weight of the baby. The variable smoke is coded 1 if the mother is a
# smoker, and 0 if not. The summary table below shows the results of a linear regression model for
# predicting the average birth weight of babies, measured in ounces, based on the smoking status of
# the mother.
# Coefficients:
#               Estimate  Std. Error  t value  Pr(>|t|)
# (Intercept)    123.05        0.65   189.60    0.0000
# smoke           -8.94        1.03    -8.65    0.0000

# The variability within the smokers and non-smokers are about equal and the distributions are
# symmetric. With these conditions satisfied, it is reasonable to apply the model. (Note that we
# don’t need to check linearity since the predictor has only two levels.)
babyweights <- read.table("babyweights.txt", header = TRUE)

# a. Write the equation of the regression line.
babyweight_hat = -8.94 * smoke + 123.05 

# b. Interpret the slope in this context, and calculate the predicted birth weight of babies born to
# smoker and non-smoker mothers.
# slope: For 1 unit increase in smoking status (from non-smoker to smoker),
# we expect the baby's average birth weight to decrease by approximately 8.94 ounces

# intercept: this model predicts that a baby born to a mother with a smoking status of 0
# (a non-smoker) would weigh 123.05 ounces on average

# c. Is there a statistically significant relationship between the average birth weight and smoking?
# Yes, the p-value is 0, which means the probability of observing a weight difference is zero.
# reject null hypothesis that smoking has no effect on birth weight
# smoking is associated with lower birth weights.

###################################################################################
# ISRS Exercise 6.2
# Exercise 6.1 introduces a data set on birth weight of babies.
#Another variable we consider is parity, which is 0 if the child is the first born, and 1 otherwise.
#The summary table below shows the results of a linear regression model for predicting the average
# birth weight of babies, measured in ounces, from parity
# Coefficients:
#               Estimate  Std. Error  t value  Pr(>|t|)
# (Intercept)    120.07        0.60   199.94    0.0000
# parity          -1.93        1.19    -1.62    0.1052
#
# a. Write the equation of the regression line.
babyweight_hat = -1.93 * parity + 120.07

# b. Interpret the slope in this context, and calculate the predicted birth weight of first borns and
#    others.
# slope: babies who are not first-born are expected to weigh 1.93 ounces less
# intercept: this model predicts that a baby born with a parity status of 0
# (a first-born child) would weigh 120.07 ounces on average

# c. Is there a statistically significant relationship between the average birth weight and parity?
# No, because the p-value is 0.1052 which is greater than 0.05
# fail to reject null hypotesis
# could just be random sampling variation
###################################################################################
# ISRS Exercise 6.3
# We considered the variables smoke and parity, one at a time, in
# modeling birth weights of babies in Exercises 6.1 and 6.2. A more realistic approach to modeling
# infant weights is to consider all possibly related variables at once. Other variables of interest
# include length of pregnancy in days (gestation), mother’s age in years (age), mother’s height in
# inches (height), and mother’s pregnancy weight in pounds (weight). Below are three observations
# from this data set.

# Data set observations (n = 1,236):
#        bwt  gestation  parity  age  height  weight  smoke
# 1      120        284       0   27      62     100      0
# 2      113        282       0   33      64     135      0
# ...
# 1236   117        297       0   38      65     129      0

# Coefficients:
#               Estimate  Std. Error  t value  Pr(>|t|)
# (Intercept)    -80.41       14.35    -5.60    0.0000
# gestation        0.44        0.03    15.26    0.0000
# parity          -3.33        1.13    -2.95    0.0033
# age             -0.01        0.09    -0.10    0.9170
# height           1.15        0.21     5.63    0.0000
# weight           0.05        0.03     1.99    0.0471
# smoke           -8.40        0.95    -8.81    0.0000
#
# a. Write the equation of the regression line that includes all variables:
babyweight_hat = 0.44 * gestation - 3.33 * parity - 0.01 * age + 1.15 * height + 0.05 * weight - 8.40 * smoke - 80.41 

# b. Interpret the slopes of gestation and age in this context:
#gestation_slope: 
# Hold all other variables constant, each additional day of pregnancy 
# is associated with an expected average increase of 0.44 oz in birthweight

#age_slope:
# Holding all other variables constant, each additional year in the mother's age 
# is associated with an expected average decrease of -0.01 oz in birthweight

# c. The coefficient for parity is different than in the linear model shown in Exercise 6.2. Why
#    might there be a difference?
# previously it was a linear regression in isolation
# here, it's a multiple linear regression
# colinearity might be present 
# this complicates the model

# d. Calculate the residual for the first observation in the dataset.
babyweight = 120.58

e = y - y_hat
e = 120 - 120.58 = -0.58

# e. The variance of the residuals is 249.28, and the variance of the birth weights of all babies
#    in the data set is 332.57. Calculate the R^2 and the adjusted R^2. Note that there are 1,236
#    observations in the data set.

n <- 1236 
k <- 6  # this is num of predictors aka degrees of freedom              
var_residuals <- 249.28  
var_total <- 332.57 

r_squared <- 1 - (var_residuals / var_total)
adjusted_r_squared <- 1 - (1 - r_squared) * ((n - 1) / (n - k - 1))

print(r_squared)
# 0.2504435

print(adjusted_r_squared)
# 0.2467842