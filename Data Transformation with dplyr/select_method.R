#select() is used to select columns 
#very useful for a dataset with large number of variables

sel <- select(flights, year, month, flight, carrier)
sel

#select all columns between variables inclusive
#select year to arr_time
year_arr <- select(flights, year:arr_time)
view(year_arr)


#select all columns except specified range
all_except <- select(flights, -(hour:time_hour))
view(all_except)

#other functions to use with select()
starts_with()
ends_with()
contains()
num_range()
any_of()
all_of()
matches()

#using select() with everything() to move variables to start
move <- select(flights, dep_time, arr_time, everything())
view(move)



#========== Exercise ========>>>

#1. Brainstorm as many ways as possible to select dep_time,
#dep_delay, arr_time, and arr_delay from flights.

sel <- select(flights, dep_time, dep_delay, arr_time, arr_delay)
view(sel)

#or use string naming
sel <- select(flights, 'dep_time', 'dep_delay', 'arr_time', 'arr_delay')
view(sel)

#or use all_of() or any_of(). Results are the same.
#Note: any_of() ignores if variable name is unavailable
#all_of() raises an error if any variable name is missing

sel <- select(flights, all_of(c(dep_time, dep_delay, arr_time, arr_delay)))
view(sel)

sel <- select(flights, any_of(c(dep_time, dep_delay, arr_time, arr_delay)))
view(sel)


#2. What happens if you include the name of a variable multiple
#times in a select() call?

#Ans: select() ignores duplication and uses the first instance.


    