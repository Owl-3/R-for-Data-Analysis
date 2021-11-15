#quality + L.quantity questions = EDA

#Loading libraries
library(tidyverse)
library(nycflights13)
library(ggplot2)

#== NOTES ===>
#Basic questions to ask
#what type of variation occurs witin my variable.
#what type of covariation occurs between my variables
#ariation is the tendency of the values of a variable to change from
#measurement to measurement.


#Visualizing Distributions
#use bar chart to examine categorical data
ggplot(data = diamonds, mapping = aes(cut)) +
    geom_bar() 

ggplot(data = diamonds, mapping = aes(color)) +
    geom_bar(fill = 'blue')

#counting the values manually
diamonds %>%
    filter(!is.na(cut), !is.na(color))
    group_by(cut, color) %>%
    tally()

diamonds %>%
    count(cut)

#To examine distribution of continuous data, use histogram

diamonds
ggplot(data = diamonds, mapping = aes(carat)) +
    geom_histogram(binwidth = .5) +
    geom_freqpoly(binwidth = .5, color = "red")

#count data points manually for the variable
#use cut_with() to calculate groups with equal range
#adding a binwidth to control the range

diamonds %>%
    count(cut_width(carat, 0.5)) #0.5 is the binwidth



#we can explore further for carats < 2 and use smaller binwidth
#this reveals much information from the data

diamonds %>%
    filter(carat < 3) %>%
    ggplot(mapping = aes(carat)) +
    geom_histogram(binwidth = 0.01) 


#manual calculation of the ranges
diamonds %>%
    count(cut_width(carat, 0.1))



#the manual calculation reveals that carat of 0.25-0.35 had the highest count.
#you can use smaller values to reveal much about the dataset

#we can add a frequency polygon to understand the overlapping lines
diamonds %>%
    filter(carat < 3) %>%
    ggplot(mapping = aes(carat, colour = cut)) +
    geom_freqpoly(binwidth = .01)

    
#Outliers or unusual observations
#we use the instances where the diamond length and width are equal
diamonds %>%
   ggplot(mapping = aes(x = y)) +
    geom_histogram(binwidth = .5)

#to make it easy to see unusual values, zoom small values of the y-axis
#with coord_cartesian().    coord_cartesian() takes ylim and xlim
ggplot(data = diamonds, mapping = aes(x = y)) +
    geom_histogram(binwidth = .5) +
    coord_cartesian(ylim = c(0, 50))

(outliers <- diamonds %>%
    filter(y < 3 | y > 20) %>% #first outliers < 3. other outliers > 20
    arrange(y)) %>%
    ggplot(mapping = aes(y)) +
    geom_point()
view(outliers)

#checking carats bigger than 3

bigger <- diamonds %>%
    filter(carat > 3, !is.na(price), !is.na(cut)) %>%
    group_by(cut, price) %>%
    summarize(price_ave = mean(price))
    

view(bigger)


#=========Exercises ====================
#1. Explore the distribution of each of the x, y, and z variables in
#diamonds. What do you learn? Think about a diamond and how
#you might decide which dimension is the length, width, and
#depth.

#selecting x, y, z variables 
sel <- diamonds %>%
    select(x, y, z)
view(sel)

summary(select(diamonds, x, y, z))


#plotting x, y, variables
#the plots will show univariate outliers
ggplot(data = diamonds) +
    geom_histogram(mapping = aes(x = x), binwidth = 0.01)


ggplot(diamonds) +
    geom_histogram(mapping = aes(x = y), binwidth = 0.01)

ggplot(diamonds, mapping = aes(x = z)) +
    geom_histogram(binwidth = 0.01)



#multivariate outliers
# x and y variables
ggplot(data = diamonds, mapping = aes(x = x, y = y)) +
    geom_point()


#x and z varaibles
ggplot(data = diamonds, mapping = aes(x = x, y = z)) +
    geom_point()

#y and z variables
ggplot(data = diamonds, mapping = aes(x = y, y = z)) +
    geom_point()


#2. Explore the distribution of price. Do you discover anything
#unusual or surprising? (Hint: carefully think about the bin
#width and make sure you try a wide range of values.)

ggplot(data = diamonds, mapping = aes(price)) +
    geom_histogram(binwidth = 10)

diamonds %>%
    filter(price < 2500) %>%
    ggplot(mapping = aes(price)) +
    geom_histogram(binwidth = 10, center = 0) 


#3. How many diamonds are 0.99 carat? How many are 1 carat?
#What do you think is the cause of the difference?

#comparing x sizes
diamonds %>%
    filter(carat == 0.99 | carat == 1) %>%
    group_by(carat) %>%
    summarize(ave_x = mean(x, na.rm = TRUE))

#comparing y sizes
diamonds %>%
    filter(carat == 0.99 | carat == 1) %>%
    group_by(carat) %>%
    summarize(ave_y = mean(y, na.rm = TRUE))

#comparing z sizes
diamonds %>%
    filter(carat == 0.99 | carat == 1) %>%
    group_by(carat) %>%
    summarize(ave_z = mean(z, na.rm = TRUE))

#possible reasons:
#1 carat has larger average length and width than 0.99 carat thus more sales/demand


#MISSING VALUES
#to replace unusual values of a variable with NA, use ifelse()
diamonds2 <- diamonds %>%
    mutate(y = ifelse(y < 3 | y > 20, NA, y)) 

#plotting diamonds2
ggplot(data = diamonds2, mapping = aes(x = x, y = y)) +
    geom_point()

#you can suppress the warning by removing the missing values
ggplot(data = diamonds2, mapping = aes(x = x, y = y)) +
    geom_point(na.rm = TRUE)


