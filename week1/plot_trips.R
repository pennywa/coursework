########################################
# load libraries
########################################

# load some packages that we'll need
library(tidyverse)
library(scales)

# be picky about white backgrounds on our plots
theme_set(theme_bw())

# load RData file output by load_trips.R
load('trips.RData')

########################################
# plot trip data
########################################

# plot the distribution of trip times across all rides (compare a histogram vs. a density plot)
#histogram
ggplot(trips, aes(x = tripduration)) +
    scale_x_log10(label = comma) +
    scale_y_continuous(label = comma) +
    geom_histogram(bins = 100)

#density
ggplot(trips, aes(x = tripduration)) +
    scale_x_log10(label = comma) +
    scale_y_continuous(label = comma) +
    geom_density(fill = "purple")

# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
#histogram
ggplot(trips, aes(x = tripduration, color = usertype, fill = usertype)) +
    scale_x_log10(label = comma) +
    geom_histogram()

#density
ggplot(trips, aes(x = tripduration, color = usertype, fill = usertype)) +
    scale_x_log10(label = comma) +
    geom_density()

# plot the total number of trips on each day in the dataset
trips_each_day <- trips %>%
    group_by(ymd) %>%
    summarize(num_trips = n())

ggplot(trips_each_day, aes(x = ymd, y = num_trips)) +
        geom_point()

nrow(trips_each_day)
#366

# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)
trips_by_age_gender <- trips %>%
    mutate(age = lubridate::year(Sys.Date()) - birth_year) %>%
    group_by(age, gender) %>%
    summarize(num_trips = n())
ggplot(trips_by_age_gender, aes(x = age, y = num_trips, color = gender, fill = gender)) +
    geom_line()

# 2 observations
# the num_trips goes to high up, also it's showing up as exponents ... make it human readable
# There’s also ages over 100

# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)
trips_by_age_gender %>%
    pivot_wider(names_from = gender, values_from = num_trips) %>%
mutate(gender_ratio = Male/Female) %>%
ggplot(aes(x = age, y = gender_ratio)) +
    geom_point()

########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)
ggplot(weather, aes(x = ymd, y = tmin)) +
    geom_line()

# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the pivot_longer() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)
weather %>%
pivot_longer(cols = c(tmin, tmax), names_to = "min_max_temp", values_to = "actual_temp") %>%
ggplot(aes(x = ymd, y = actual_temp, color = min_max_temp)) +
    geom_point()

########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this
trips_with_weather %>%
group_by(ymd, tmin) %>%
    summarize(num_trips = n()) %>%
ggplot(aes(x = tmin, y = num_trips, color = num_trips)) +
    geom_point()

# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this
trips_with_weather %>%
mutate(substantial_prcp = prcp >= 1.0) %>%
group_by(ymd, tmin, num_trips, substantial_prcp) %>%
    summarize(num_trips = n()) %>%


# add a smoothed fit on top of the previous plot, using geom_smooth

# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package

# plot the above

# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package