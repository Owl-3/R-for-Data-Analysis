#summarize() collapses data frame to single row

#Loading libraries
library(ggplot2)
library(nycflights13)
library(tidyverse)


my_data <- summarise(flights, airtime = mean(air_time, na.rm = TRUE))
my_data

#better used together with group_by()
my_data <- group_by(flights, year, month, day)
my_data <- summarise(my_data, airtime = mean(air_time, na.rm = TRUE))
view(my_data)

my_data2 <- group_by(flights, dest, air_time)
my_data2 <- summarise(my_data2, 
                      count = n(),
                      dist = mean(distance, na.rm = TRUE),
                      delay = mean(arr_delay, na.rm = TRUE),
                      airtime = mean(air_time, na.rm = TRUE))

my_data2 <- filter(my_data2, count > 20, dest != 'HNL')

view(my_data2)

#the above code can be written using a pipe
my_data2 <- flights %>% 
    group_by(dest, air_time) %>%
    summarise(count = n(), dist = mean(distance, na.rm = TRUE)) %>%
    filter(count > 20, dest != 'HNL')

view(my_data2)  


#plotting dist against delay

ggplot(my_data2, aes(dist, delay)) +
    geom_point(aes(size = count), alpha = 1/3) +
    geom_smooth(se = FALSE)



#MISSING VALUES
#use na.rm = TRUE to remove the missing values

miss_val <- flights %>% 
    group_by(year, month, day) %>%
    summarise(delay = mean(dep_delay, na.rm = TRUE))

view(miss_val)

#or
not_cancelled_flights <- flights %>%
    filter(!is.na(dep_delay), !is.na(arr_delay)) %>%
    group_by(year, month, day) %>%
    summarize(dep_delay_mean = mean(dep_delay),
              arr_delay_mean = mean(arr_delay))

view(not_cancelled_flights)


#COUNTS
#getting un-cancelled flights
not_cancelled <- flights %>%
    filter(!is.na(dep_delay), !is.na(arr_delay), !is.na(tailnum))

#finding dep_delay means
not_cancelled %>% 
    group_by(year, month, day, tailnum) %>%
    summarize(dep_delay_mean = mean(dep_delay)
              )



delays <- not_cancelled %>%
    group_by(tailnum) %>%
    summarize(arr_delay_mean = mean(arr_delay))


#plotting delay against count
ggplot(data = delays, mapping = aes(arr_delay_mean)) +
    geom_freqpoly(binwidth = 13)


#scatterplot  of number of flights versus average delay
delays <- not_cancelled %>%
    group_by(tailnum) %>%
    summarize(delay = mean(arr_delay), counts = n())
   

ggplot(data = delays, mapping = aes(x = counts, y = delay)) +
    geom_point(alpha = 1/10)


#plotting when counts > 25
delays %>%
    filter(counts > 25) %>%
    ggplot(mapping = aes(counts, delay)) +
    
    geom_point(alpha = .1, position = 'jitter')
   

#loading Lahman package
install.packages('Lahman')
library(Lahman)

#creating a simple data frame with tibble
batting <- tibble::as_tibble(Lahman::Batting)
View(batting)

#or
batting_data <- as_tibble(Lahman::Batting)

#Finding the best player i.e one with highest batting average.
players <- batting_data %>%
    group_by(playerID) %>%
    summarize(batt_av = sum(H, na.rm = TRUE) / sum(AB, na.rm = TRUE),
              sum_bats = sum(AB, na.rm = TRUE))
view(players)
players %>% filter(sum_bats > 100) %>%
    ggplot(mapping = aes(sum_bats, batt_av)) +
    geom_point() +
    geom_smooth(se = FALSE, position = 'jitter')


#ranking players
players %>%
    arrange(desc(batt_av))

#Other useful functions
median() 
sd() for standard deviation
IQR() for interquartile range
mad() for median absolute deviation
quantile(x, .25) for quantiles
min() and max()
measures of positions: fisrt(x), nth(x, 4), last(x)

#counts
#to count the number of missing values:
miss_val <- flights %>%
    group_by(year, month, day, tailnum) %>%
    summarize(miss = sum(is.na(dep_delay)))

view(miss_val)

#to count unique values with n_distinct()
unique_vals <- flights %>%
    group_by(year, month, day, tailnum, carrier) %>%
    summarize(unique = n_distinct(carrier))

view(unique_vals)

#counting destinations
not_cancelled %>%
    count(dest)

#count number of January flights per day made by each plane
daily <- group_by(flights, year, month, day)
(daily_flights <- summarize(daily, daily_flights = n()))
    

view(daily_flights)

(month <- summarize(daily_flights, monthly_flights = sum(flights)))



#flights made per month

monthly_flights <- summarize(daily_flights, monthly_flights = sum(daily_flights))
view(monthly_flights)

#flights made per year
annual_flights <- summarize(monthly_flights, annual_flights = sum(monthly_flights))
view(annual_flights)




#=========== Exercise ====================

#2. Come up with another approach that will give you the same
#output as not_cancelled %>% count(dest) and not_cancel
#led %>% count(tailnum, wt = distance) (without using
#count()).

not_cancelled1 <- flights %>%
    filter(!is.na(dep_delay), !is.na(arr_delay))

not_cancelled1 %>% group_by(dest) %>%
    summarize(destinations = length(dest))


#or
not_cancelled1 %>%
    count(dest)

#or
not_cancelled1 %>%
    group_by(dest) %>%
    summarize(destinations = n())

#or use tally() and group_by() together
not_cancelled1 %>%
    group_by(dest) %>%
    tally()

#or one with wt arg
not_cancelled1 %>%
    count(tailnum, wt = distance)
   

   #or, easier
not_cancelled1 %>%
    group_by(tailnum) %>%
    summarize(dist_covered = sum(distance))

#Look at the number of cancelled flights per day. 
#Is there a pattern? Is the proportion of cancelled flights related to the average delay?
flights %>%
    mutate(cancelled = is.na(dep_time)) %>%
    group_by(year, month, day) %>%
    summarize(flights_num = n(), cancelled_num = sum(cancelled)) %>%
    ggplot(mapping = aes(flights_num, cancelled_num)) +
    geom_point() 
    
#relationship between the proportion of flights cancelled and the average departure delay.

flights %>%
    mutate(cancelled = is.na(dep_time)) %>%
    group_by(year, month, day) %>%
    summarize(cancelled_prop = mean(cancelled),
              dep_delay = mean(dep_delay, na.rm = TRUE)) %>%
    ggplot(mapping = aes(dep_delay, cancelled_prop)) +
    geom_point()

#Which carrier has the worst delays?
#Challenge: can you disentangle the effects of bad airports vs. bad carriers? 
#Why/why not?

flights %>%
    group_by(carrier) %>%
    summarize(arr_delay = mean(arr_delay, na.rm = TRUE)) %>%
    arrange(desc(arr_delay))

#find worst carrier
filter(airlines, carrier == 'F9')

#count and sort at the same time

flights %>%
    count(dest, sort = TRUE)

        
   






