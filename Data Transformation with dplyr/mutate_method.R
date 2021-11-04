#mutate() used to select existing columns
#used to add new columns that are functions of the existing columns

#creating new variables: minutes gained during the flight, speed, hours spent, gain_per_hour

 flights_speed_gain <- select(flights, year: day, ends_with('delay'), 
                              distance, air_time)
 mut <- mutate(flights_speed_gain, 
               gain = arr_delay - dep_delay, 
               hours = air_time / 60,
               speed_mh = distance / hours, gain_per_hour = gain / hour )
 view(mut)
 
#to keep the new variables, use transmute()
 trans <- transmute(flights_speed_gain, 
                    gain = arr_delay - dep_delay, 
                    hours = air_time / 60, 
                    speed_mh = distance / hours,
                    gain_ph = gain / hours)
 
 view(trans)
 
 #check fastest speed by a flight 
 fastest_flight <- arrange(trans, desc(speed_mh))
 view(fastest_flight)
 
 #check lowest speed by a flight 
 slowest <- arrange(trans, speed_mh)
 view(slowest)
 
 #useful creation functions:
#1. arithmetic operators [+ , - , /, ^]
 
#2. modular arithmetic [%/% = integer/floor division, %% = remainer]
 
 #example:
 trans2 <- transmute(flights,
           hours = dep_time %/% 100,
           minutes = dep_time %% 100,
           seconds = minutes * 60)
 view(trans2)
 
 #cummulative and rolling aggregates
 #functions:
  #cumsum(), cummean(), cumprod(), cummin(), cummax()
 
 x <- 1:10
 cummean(x)
 #output:  [1] 1.0 1.5 2.0 2.5 3.0 3.5 4.0 4.5 5.0 5.5
 
 cumsum(x)
 #output: [1]  1  3  6 10 15 21 28 36 45 55
 
 #  Ranking
 #min_rank() => ranks in ascending by default. similar to arrange()
 x <- c(NA, 1:10, NA)
 min_rank(x)
 
 #output:[1] NA  1  2  3  4  5  6  7  8  9 10 NA
 
 #descending
 min_rank(desc(x))
 
 #output: [1] NA 10  9  8  7  6  5  4  3  2  1 NA
 

 #======== Exercise ========>
 #1. Currently dep_time and sched_dep_time are convenient to look
 #at, but hard to compute with because they’re not really continuous
 #numbers. Convert them to a more convenient representation
 #of number of minutes since midnight.
 
 #midnight = 24hrs = 1440 mins
tran <- transmute(flights, 
           hours_dep = dep_time %/% 100,
           minutes_dep = dep_time %% 100,
           min_dep_time = (hours_dep * 60 + minutes_dep) %% 1440,
           hour_sched_dep = sched_dep_time %/% 100,
           minutes_sched_dep = sched_dep_time %% 100,
           min_sched_dep = (hour_sched_dep * 60 + minutes_sched_dep) %% 1440
           )
 view(tran)
 
 
 #2. Compare air_time with arr_time - dep_time. What do you
 #expect to see? What do you see? What do you need to do to fix
 #it?
 air_time = arr_time - dep_time 
 air_time != arr_time - dep_time if it crosses the midnight where
 arr_time < dep_time or the flight flew in different time zones
 
 
 # 3.Compare dep_time, sched_dep_time, and dep_delay. How
 #would you expect those three numbers to be related?
    dep_delay = dep_time - sched_dep_time. 
    
    dep_delay != dep_time - sched_dep_time if it's delayed to midnight'
 
#4. Find the 10 most delayed flights using a ranking function. How
    #do you want to handle ties? Carefully read the documentation
    #for min_rank().
    
    #introduce new variables
 data2 <- mutate(flights, 
                    dep_delay_min = min_rank(desc(dep_delay)),
                    dep_delay_dense = dense_rank(desc(dep_delay)),
                    dep_delay_row = row_number(desc(dep_delay)))
 
 view(data2)

 #filter first 10 
 data2 <- filter(data2, !(dep_delay_min > 10 | dep_delay_dense > 10 | dep_delay_row > 10))
 view(data2)
 
 #arrange first 10
 data2 <- arrange(data2, dep_delay_min)
 view(data2)
 
 #or use slice()
 data2 <- arrange(flights, desc(dep_delay))
 data2 <- slice(data2, 1:10)
 sel <- select(data2, month:dep_delay)
 view(sel)
 
 #or use top_n()
 data3 <- top_n(flights, 10, dep_delay)
 data3 <- arrange(data3, desc(dep_delay))
 view(data3)
 
 

 
 
 #5. What does 1:3 + 1:10 return? Why?
 x <- 1:3 + 1:10
 x
# R recycles a shorter vector's values to create a vector of equal length to the longer one.
  

    
    
 