#coordinate system functions.
#coord_flip() => flips x and y coordinates
#coord_quickmap() => sets aspect ratio correctly for matpoints()
#important in spatial data
#coord_polar() => uses polar coordinates.
#reveals connection between bargraph and Coxcomb chart

#coord_flip()
#notice class lies on y-axis and hwy on x-axis after flip
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
    geom_boxplot() +
    coord_flip()

#coord_polar()
#used coord_flip() to see relation with coxcomb chat
bgraph <- ggplot(data = diamonds, mapping = aes(
    cut, fill = cut
)) +
    geom_bar(show.legend = FALSE, width = 1) +
    theme(aspect.ratio = 1) +
    labs(x = NULL, y = NULL)

plt1 <- bgraph + coord_polar()
plt2 <- bgraph + coord_flip()

#loading cowplot library to use plot_grid
library(cowplot)

#plotting grids
plot_grid(plt1, plt2, labels = c('flipped_bar_graph', 'Coxcomb'))


#Exercise
#1. Turn a stacked bar chart into a pie chart using coord_polar()

#(i) stacked bar graph
ggplot(data = diamonds, mapping = aes(cut, fill = clarity), width = 1) +
    geom_bar(position = 'dodge', show.legend = FALSE)

#(ii) Coxcomb chart using coord_polar()
ggplot(data = diamonds, mapping = aes(cut, fill = cut)) +
    geom_bar(show.legend = FALSE, width = 1) +
    theme(aspect.ratio = 1) +
    labs(x = 'Cut', y = 'Count') +
    coord_polar()
#or
ggplot(data = diamonds, mapping = aes(cut, fill = clarity)) +
    geom_bar(show.legend = TRUE, width = 1, position = 'dodge') +
    coord_polar()


#2. What does labs() do? Read the documentation
#ans: labels the axes

    
