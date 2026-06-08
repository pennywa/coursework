##################################################################################
# ISRS Exercise 5.20
# Part III. Exercise 5.13 introduces data on shoulder girth and
# height of a group of individuals. The mean shoulder girth is 
# 108.20 cm with a standard deviation of 10.37 cm. The mean height 
# is 171.14 cm with a standard deviation of 9.41 cm. The correlation
# between height and shoulder girth is 0.67
# See textbook for image

# a. Write the equation of the regression line for predicting height.
# y_hat_height = 0.608 * (x_shoulder_girth) + 105.354

# b. Intepret the slope and the intercept in this context.
# slope: For each cm increase in an individual's shoulder girth, 
# we expect their height to increase (on average) by approximately 0.608 cm

# intercept: this model predicts that a person with a shoulder girth of 0 cm 
# would be 105.354 cm tall

# c. Calculate R^2 of the regression line for predicting height from 
#    shoulder girth, and interpret in the context of the application. 
# (0.67)^2
# 0.4489

# d. A randomly selected student from your class has a shoulder girth 
#    of 100 cm. Predict the height of this student using the model.
# y_hat_height = 0.608 * (100) + 105.354
# 166.154 cm

# e. The student from part (d) is 160 cm tall. Calculate the residual, 
#    and explain what this residual means.
# y = 160 cm
# y_hat = 166.154 cm
# e = y - y_hat = -6.154 cm

# This residual means the model overestimated the student's actual height by 6.154 cm

# f. A one year old has a shoulder girth of 56 cm. Would it be 
#    appropriate to use this linear model to predict the height of this child?
# y_hat = 139.402 cm

# No, this linear model is NOT appropriate
# The data likely came from students or adults 
# and human growth patterns are non-linear across a lifespan
# can't assume the same for adults would apply to toddlers

##################################################################################
# ISRS Exercise 5.29
# The scatterplot and least squares summary below show the relationship
# between weight measured in kilograms and height measured in centimeters
# of 507 physically active individuals
# See textbook for scatterplot.

# Coefficients:
#               Estimate  Std. Error  t value  Pr(>|t|)
# (Intercept)  -105.0113      7.5394   -13.93    0.0000
# height          1.0176      0.0440    23.13    0.0000

# a. Describe the relationship between height and weight.
# There seems to be a strong, positive, linear relationship between height and weight. 
# As height increases, weight increases

# b. Write the equation of the regression line. Interpret the slope
#    and intercept in context.
# y_hat_weight = 1.0176 * (x_height) - 105.0113 

# slope: For each cm increase in an individual's height, 
# expect their weight to increase by approx 1.0176 kg, on average

# intercept: model predicts that an individual with a height of 0 cm would weigh -105.0113 kg
# I think of this as the "anchor" point 
# because in reality, why is weight negative if height is zero? doesn't make sense

# c.Do the data provide strong evidence that an increase in height 
#   is associated with an increase in weight? State the null and 
#   alternative hypotheses, report the p-value, and state your conclusion.

# Null Hypothesis
# H0: b_zero = 0
# no linear relationship between height and weight
# Alternative Hypothesis
# H1: b_zero != 0
# complement of H0

n <- 507 
t_val_height <- 23.13   

df <- n - 2 # degrees of freedom for lin reg

abs_t <- abs(t_val_height)
lower_tail <- pt(abs_t, df)
upper_tail <- 1-pt(abs_t, df)

p_value <- 2 * (1 - pt(abs(t_val_height), df))
print(p_value)
# 0
# p-value is 0 so reject null hypothesis
# meaning there is evidence here that an increase in height is associated with an increase in weight

# d. The correlation coefficient for height and weight is 0.72. 
#    Calculate R^2 and interpret it in context.

# (0.72)^2 = 0.5184
# Approx 51.84% of the variation in the weights of physically active ppl
# can be explained by the linear relationship with their height. 
# The remaining 48.16% of the variability is due to other individual factors 
# could be muscle mass, bone density, etc. that arent captured by this model