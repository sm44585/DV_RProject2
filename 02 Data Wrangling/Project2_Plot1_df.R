# This file creates the first plot of the Data Visualization Project 2
require(tidyr)
require(dplyr)
require(ggplot2)

Plot1_df <- df %>% group_by (EDUCATION, HUSBY) %>% summarise(mean_kids = mean(KIDSLT6 + KIDS618)) %>% arrange(desc(EDUCATION))

ggplot() +
  coord_cartesian() + 
  scale_x_continuous() +
  scale_y_continuous() +
  facet_grid(.~EDUCATION, labeller=label_both) + 
  labs(title='How Education level and Income influences number of children') +
  labs(x="Number of Kids", y=paste("Husbands Income")) +
  layer(data=Plot1_df, 
        mapping=aes(x=as.numeric(mean_kids), y=as.numeric(as.character(HUSBY))), 
        stat="identity", 
        stat_params=list(), 
        geom="point",
        geom_params=list(), 
        #position=position_identity()
        position=position_jitter(width=0.3, height=0)
  )
