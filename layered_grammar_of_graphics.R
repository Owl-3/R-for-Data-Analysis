#LAYERED GRAMMAR OF GRAPHICS
#putting positonal adjustments, stats, coordinate systems and faceting in one code template
ggplot(data = <DATASET>) +
    <GEOM_FUNCTIONS> (
        mapping = aes(<MAPPINGS>),
        stat = <STATS>,
        position = <POSITION>
    ) +
    <COORDINATE_FUNCTIONS> (
        
    ) +
    <FACET_FUNCTION> ()