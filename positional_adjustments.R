#coloring bar charts
#You can use color or fill in aesthetics
#but preferably fill. Easier to differentiate and visually appealing

ggplot(data = diamonds) +
    geom_bar(mapping = aes(cut, color = cut))

ggplot(data = diamonds) +
    geom_bar(mapping = aes(cut, fill = cut))

#mapping fill aesthetic to another variable
#each colored rectangle represents a combination of cut and clarity
ggplot(data = diamonds) +
    geom_bar(mapping = aes(cut, fill = clarity), alpha = .7)

#other options other than stacking bar graph
#use position with 'identity', 'fill', 'dodge'
ggplot(data = diamonds) +
    geom_bar(mapping = aes(cut, fill = clarity), alpha = .9, position = "identity")

#setting fill to NA
ggplot(data = diamonds) +
    geom_bar(mapping = aes(cut, color = clarity), fill = NA, position = "identity")

#position = "fill":makes each set of stacked bars same height
#thus easier to compare proportions across the groups
ggplot(data = diamonds, mapping = aes(cut, fill = clarity)) +
    geom_bar(position = "fill")

#position = "dodge": more like stacked column bar graph
ggplot(data = diamonds, mapping = aes(cut, fill = clarity)) +
    geom_bar(position = "dodge")


#position = "jitter": used in scaterplot to see the all the overlapp
ggplot(data = mpg, mapping = aes(displ, hwy)) +
    geom_point(position = "jitter")

#setting width and height params to different values
#for easier analysis of data point distribution
#geom_jitter() makes all the overlapping points visible
ggplot(data = mpg, mapping = aes(displ, hwy)) +
    geom_jitter(width = 40, height = 3)

