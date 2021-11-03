#loading nycflights13 and tidyverse packages
library(nycflights13)
library(tidyverse)

#viewing full dataset
view(flights)

#dplyr functions for data manipulation
#filter() => pick observations by their values
#arrange() => reorder the rows
#select() => pick variables by names
#mutate() => create new variables with functions of existing variables
#summarise() => collapse many values down to a single summary

#======= filter() =======>>
jan1 <- filter(flights, month == 1, day == 1)
view(fil)

#To save and print the output, wrap the assignment in parenthesis
(jan1 <- filter(flights, month == 1, day == 1))

#logical operators
delay <- filter(flights, !(arr_time > 120 | dep_time > 120))
view(delay)

#selecting 2 or more variables using %in%
nov_dec <- filter(flights, month %in% c(11, 12))
View(nov_dec)

#or
nov_dec <- filter(flights, month == 11 | month == 12)
view(nov_dec)


#====== Exercise ======>>
#1. Find all flights that:
   # a. Had an arrival delay of two or more hours
arr_del <- filter(flights, arr_delay >= 120)
view(arr_del)

#b. Flew to Houston (IAH or HOU)
hous <- filter(flights, dest == 'IAH' | dest == 'HOU')
view(hous)

#or
hous <- filter(flights, dest %in% c('IAH', 'HOU'))
view(hous)


#c. Were operated by United, American, or Delta
opp <- filter(flights, carrier %in% c('DL', 'UA', 'AA'))
view(opp)

#or
opp <- filter(flights, carrier == 'AA' | carrier == 'UA' | carrier == 'DL')
view(opp)

#d. Departed in summer (July, August, and September
dept <- filter(flights, month %in% c(7, 8, 9))
dept

#e. Arrived more than two hours late, but didn’t leave late
arr_del <- filter(flights, dep_delay <= 0 & arr_delay > 120)
view(arr_del)

#f. Were delayed by at least an hour, but made up over 30
#minutes in flight
dept_delay <- filter(flights, dep_delay >= 60 & dep_delay - arr_delay > 30)
view(dept_delay)

#g. Departed between midnight and 6 a.m. (inclusive)
dpt <- filter(flights, dep_time <= 600 | dep_time == 2400)
view(dpt)

#use of between()
dpt <- filter(flights, dep_time >= 1 $ dep_time <= 600 | dep_time == 2400)
view(dpt)

#use of between for quiz d.
dept <- filter(flights, month >= 7 & month <= 9)
view(dept)

#or
dept <- filter(flights, between(month, 7, 9))
view(dept)

#3. How many flights have a missing dep_time? What other vari‐
#ables are missing? What might these rows represent?

miss_dep_time <- filter(flights, is.na(dep_time)) 
view(miss_dep_time)

#======== Arrange Rows with arrange() ======>>


