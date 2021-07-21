# From chapter 16 (Dates and times) https://r4ds.had.co.nz/dates-and-times.html

library(tidyverse)

library(lubridate)
search()
library(nycflights13)
#################

make_datetime_100 <- function(year, month, day, time) {
  make_datetime(year, month, day, time %/% 100, time %% 100)
}

flights_dt <- flights %>% 
  filter(!is.na(dep_time), !is.na(arr_time)) %>% 
  mutate(
    dep_time = make_datetime_100(year, month, day, dep_time),
    arr_time = make_datetime_100(year, month, day, arr_time),
    sched_dep_time = make_datetime_100(year, month, day, sched_dep_time),
    sched_arr_time = make_datetime_100(year, month, day, sched_arr_time)
  ) %>% 
  select(origin, dest, ends_with("delay"), ends_with("time"))

typeof(flights$sched_dep_time[1])

#################

# 16.2.4 Exercises
#-----
# 1. 

Q1 <- ymd(c("2010-10-10", "bananas"))
print(Q1)
# Errors, this function take 1 parameters only
# The second element is NA.

#---
# 2.
?today()
# tzone is a character vector to determine which time zone you want to return today's date depend on it.

#---
# 3.
d1 <- mdy("January 1, 2010")
d1
d2 <- ymd("2015-Mar-07")
d2
d3 <- dmy("06-Jun-2017")
d3
d4 <- mdy(c("August 19 (2015)", "July 1 (2015)"))
d4
d5 <- mdy("12/30/14") # Dec 30, 2014
d5


######
# 16.3.4 Exercises

#----
# 1.
# The distribution of flight times within
# a day change over the course of the year?
flights_dt %>%
  filter(!is.na(dep_time)) %>% # Non-Null values
  mutate(dep_hour = update(dep_time, yday = 1)) %>% #day's hour
  mutate(month = factor(month(dep_time))) %>% # extract month from dep_time
  ggplot(aes(dep_hour, color = month)) + # colored legend by month
  geom_freqpoly(binwidth = 60 * 60) 

#---
# 2.
# Q: Compare dep_time, sched_dep_time and dep_delay. 
#     Are they consistent? Explain your findings.

# A: To be consistent, should dep_time = sched_dep_time + dep_delay

flights_dt %>%
  mutate(dep_time2 = sched_dep_time + dep_delay * 60) %>% 
  filter(dep_time2 != dep_time) %>% # that's mean dep_time, sched_dep_time and dep_delay not consistent
  select(dep_time2, dep_time, sched_dep_time, dep_delay)

#---
# 3.
# Q: Compare air_time with the duration between the 
#    departure and arrival. Explain your findings.

# A:

flights_dt %>%
  mutate(
    flight_duration = arr_time - dep_time, # calculate flight duration
    diff = flight_duration - air_time # calculate the differance between flight duration and air time
  ) %>%
  select(origin, dest, flight_duration, air_time, diff)




#---
# 4.
# Q: How does the average delay time change over the course
#    of a day? Should you use dep_time or sched_dep_time? Why?

# A: I think should use sched_dep_time, 
#    because it's more fixed rether than dep_time.
flights_dt %>%
  mutate(sched_dep_hour = hour(sched_dep_time)) %>% # return hour on sched_dep_time
  group_by(sched_dep_hour) %>% 
  summarise(dep_delay = mean(dep_delay)) %>% # calculate average
  ggplot(aes(y=dep_delay , x=sched_dep_hour )) + # plot graph with dep_delay and sched_dep_hour
  geom_point()+ # draw points
  geom_smooth() # shows a line 
  


#---
# 5.
# On what day of the week should 
# you leave if you want to minimize the chance of a delay?

# Answer: Saturday has lowest arr_delay average
flights_dt %>%
  mutate(day_of_week = wday(sched_dep_time)) %>% # return week day from sched_dep_time
  group_by(day_of_week) %>%
  summarise(
    dep_delay = mean(dep_delay), # calculate the average dep_delay 
    arr_delay = mean(arr_delay, na.rm = TRUE) # calculate the average arr_delay 
  ) %>%
  print(n = Inf)


#---
# 6.
# Q: What makes the distribution of diamonds$carat 
#    and flights$sched_dep_time similar?


#---
# 7.
# Q:




####
# 16.4.5 Exercises


#---
# 1. Why is there months() but no dmonths()?
# Because, each months have differant number of days.
# Not all the same 

#---
# 2.
# Q: Explain days(overnight * 1) to someone who has just started learning R. How does it work?
flights_dt <- flights_dt %>% 
  mutate(
    overnight = arr_time < dep_time,
    arr_time = arr_time + days(overnight * 1),
    sched_arr_time = sched_arr_time + days(overnight * 1)
  )

# Answer: The "overnight" variable is a boolean, content either FALSE or TRUE
#         if FALSE, then return 0s
#         if TRUE, then return 1d


#---
# 3.
# Q: Create a vector of dates giving the first day of every 
#     month in 2015. Create a vector of dates giving the first
#     day of every month in the current year.
ymd("2015-01-01") + months(0:11)

?floor_date
# floor_date akes a date-time object and rounds it down to 
#            the nearest boundary of the specified time unit.
floor_date(today(), unit = "year") + months(0:11)

#---
# 4.
# Q: Write a function that given your birthday (as a date), returns how old you are in years.


Age <- function(birthday) {
  (birthday %--% today()) %/% years(1)
}
Age(ymd("1999-10-01"))

#---
# 5.
# Q: Why can’t (today() %--% (today() + years(1)) / months(1) work?

# There is missing bracket in this line 
# (today() %--% (today() + years(1)) / months(1)


# This is correct code
(today() %--% (today() + years(1))) / months(1)
  