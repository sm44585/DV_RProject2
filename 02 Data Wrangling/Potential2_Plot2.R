# This file creates the third plot of the Data Visualization Project 2
require(tidyr)
require(dplyr)
require(ggplot2)


Plot3_df <- df %>% mutate(EXPERIENCE_PERCENT = cume_dist(EXPERIENCE)) %>% filter(EXPERIENCE_PERCENT  <= .1 | EXPERIENCE_PERCENT  >= .9)

# plot of how education and husbands income influences number of kids
ggplot() +
  coord_cartesian() + 
  scale_x_continuous() +
  scale_y_continuous() +
  #facet_grid(.~EDUCATION, labeller=label_both) + 
  labs(title='Comparision of top 20 and bottom 20 husband incomes on years of wifes potential work experience in different region') +
  labs(x="Experience", y=paste("Husband Income")) +
  layer(data=Plot3_df, 
        mapping=aes(x=as.numeric(EXPERIENCE), y=as.numeric(HUSBY), color=as.character(HHI2)), 
        stat="identity", 
        stat_params=list(), 
        geom="point",
        geom_params=list(), 
        #position=position_identity()
        position=position_jitter(width=0.3, height=0)
  )
