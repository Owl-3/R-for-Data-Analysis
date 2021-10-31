devtools::session_info(c('tidyverse'))
ggplot2::mpg

#load ggplot2 package
library(ggplot2)

#plot data points using ggplot2
ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy))

#Aesthetics: coloring different variables
#mapping class to color
ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy, color = class))

#mapping class to size
#note: mapping unordered variable(class) to ordered aesthetics
#is not very appropriate
ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy, size = class))

#mapping class to shape
#note: ggplot2 only use six shapes at a time.
#unplots additional groups
ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy, shape = class))

#manually coloring the scatter plots
#put color/size/shape outside the aes() method
ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

#coloring specific plots
ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy, color = hwy < 20))


#=== FACETS =======>>
#splitting plots into subplots each displaying
#one subset of the categorical variables
#use facet_wrap() method
ggplot(data = mpg) +
    geom_point(mapping = aes(displ, hwy)) +
    facet_wrap(~ class, nrow = 2)

#faceting 2 variable
#use facet_grid() method
ggplot(data = mpg) +
    geom_point(mapping = aes(displ, hwy, color = class)) +
    facet_grid(drv ~ cyl)

#======quiz=====>
#1. What happens if you facet on a continuous variable?
#ans: each facet contains each variable value

#2. What do the empty cells in a plot with facet_grid(drv ~ cyl)
#mean? How do they relate to this plot?
ggplot(data = mpg) +
    geom_point(mapping = aes(drv, cyl))

#Ans: empty because there is no data available according to combination.
#that is, data for drv 4 and cyl 5;  drv r and cyl 4 & 5 are missing
#cyl 7 has no drv data thus missing in the facet_grid(drv ~ cyl) entirely

#3. What plots does the following code make? What does . do?
ggplot(data = mpg) + 
    geom_point(mapping = aes(displ, hwy)) +
    facet_grid(drv ~ .) 
#facet_grid(drv ~ .) plots the variable groups row-wise

ggplot(data = mpg) +
    geom_point(mapping = aes(displ, hwy)) +
    facet_grid(. ~ cyl)
#facet_grid(. ~ cyl) plots the variable groups row-wise

#4.Take the first faceted plot in this section:
ggplot(data = mpg) +
    geom_point(mapping = aes(displ, hwy)) +
    facet_wrap(~ class, nrow = 2)

#What are the advantages to using faceting instead of the color
#aesthetic? What are the disadvantages? How might the balance
#change if you had a larger dataset?

#Ans: With faceting, it is easier to evaluate individual classes.
#without faceting,it is easier to analyse the general clustering and observe outliers
#with big data, it is more likely to use the general clustering.