library(tidyverse)

####################################################################################
# 12.2.1. Exercise 2
# Compute the rate for table2, and table 4a + table4b. You will need
# to perform four operations:
#   1. Extract the number of TB cases per country per year.
#   2. Extract the matching population per country per year.
#   3. Divide cases by population, and multiply by 10000.
#   4. Store back in the appropriate place.

#table2
rate_table2 <- table2 %>% 
pivot_wider(names_from = type, values_from = count) %>%
mutate(rate = cases/population) 
print(rate_table2)

#table4a + table4b
rate_table4a <- table4a %>%
pivot_longer(cols = c(`1999`, `2000`), names_to = "years", values_to = "cases") 
rate_table4b <- table4b %>%
pivot_longer(cols = c(`1999`, `2000`), names_to = "years", values_to = "population") 
rate_table4 <- left_join(rate_table4a, rate_table4b) %>%
mutate(rate = cases/population) 
print(rate_table4)

# Which representation is easiest to work with? Which is hardest? Why?
# Add your answer as a comment.
#Table 2 is easier to work with and Table 4a + 4b is harder because in Table 2 you go to type case and type population but with 4a and 4b you have to grab the years from both cases and population and do a join. 

####################################################################################
# 12.3.3 Exercise 1
# 1. Why are pivot_longer() and pivot_wider() not perfectly symmetrical?
# Carefully consider the following example:
stocks <- tibble(
  year   = c(2015, 2015, 2016, 2016),
  half  = c(   1,    2,     1,    2),
  return = c(1.88, 0.59, 0.92, 0.17)
)
stocks %>% 
  pivot_wider(names_from = year, values_from = return) %>% 
  pivot_longer(`2015`:`2016`, names_to = "year", values_to = "return")

# (Hint: look at the variable types and think about column names.)
# pivot_wider all the var types are <dbl> but for pivot_longer the year is type <chr>

# pivot_longer() has a names_ptypes argument, e.g.  names_ptypes = list(year = double()). 
# What does it do? Add your answer as a comment.
# It's not symmetrical because the type has changed. If I'm understanding correctly, it's not transforming the data values but rather it's making sure that the resulting col names match data type expectations. 

####################################################################################
# 12.3.3 Exercise 3
# What would happen if you widen this table? Why? 
# Phillip Woods has age listed twice, so it'll get confused because each cell can only hold 1 value.

# How could you add a new column to uniquely identify each value?
# Look into mutate() and row_number(). 

#  Add your answers as a comment.
people <- tribble(
  ~name,             ~names,  ~values,
  #-----------------|--------|------
  "Phillip Woods",   "age",       45,
  "Phillip Woods",   "height",   186,
  "Phillip Woods",   "age",       50,
  "Jessica Cordero", "age",       37,
  "Jessica Cordero", "height",   156
)