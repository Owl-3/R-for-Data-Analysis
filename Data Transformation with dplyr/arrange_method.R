#======== ARRANGE ROWS WITH ARRANGE() ======>>

#arrange() reorders the columns
arr <- arrange(flights, month, day, year)
view(arr)

#use desc() to arrange columns in descending order
descend <- arrange(flights, desc(month))
view(descend)

#missing values always sorted at the end
descend <- arrange(flights, desc(dep_time))
view((descend))

#check last 6 rows to confirm
view(tail(descend))


#=========== Exercise ==========>>>

#1. How could you use arrange() to sort all missing values to the
#start? (Hint: use is.na().)

arr <- arrange(flights, desc(is.na(dep_time)))
view(arr)

#or
arr <- arrange(flights, desc(dep_time))
view(arr)

#2. Sort flights to find the most delayed flights. Find the flights
#that left earliest.
#arrange() defaults to ascending order

#most delayed
delayed <- arrange(flights, desc(dep_delay))
view(delayed)

#earliest
earliest_flight <- arrange(flights, dep_delay)
view(earliest_flight)



#3. Sort flights to find the fastest flights.
#fastest according to air_time 
fastest_flight <- arrange(flights, air_time)
view(fastest_flight)

#4. Which flights traveled the longest? Which traveled the shortest?
#check distance 


shortest_dist <- arrange(flights, distance)
view(shortest_dist)

#longest
longest_dist <- arrange(flights, desc(distance))
view(longest_dist)




