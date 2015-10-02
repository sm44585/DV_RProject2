# This file creates the third plot of the Data Visualization Project 2
require(tidyr)
require(dplyr)
require(ggplot2)

Plot3_df <- df %>% select(HHI, KIDSLT6, KIDS618, WHRSWK) %>% filter(HHI == "no") %>% mutate(TOTAL_KIDS = KIDSLT6 + KIDS618)

# plot of how number of kids and no health insurance from husband affects hours worked by wives
ggplot() +
  coord_cartesian() + 
  scale_x_continuous() +
  scale_y_continuous() +
  facet_grid(.~TOTAL_KIDS, labeller = label_both) +
  labs(title='Effect of Number of Kids and No Insurance from Husband on Hours Worked by Wives') +
  labs(x="Hours Worked per Week by Wife", y=paste("Number of Kids")) +
  layer(data=Plot3_df, 
        mapping=aes(x=as.numeric(WHRSWK), y=as.numeric(TOTAL_KIDS)), 
        stat="identity", 
        stat_params=list(), 
        geom="point",
        geom_params=list(), 
        position=position_jitter(width=0.3, height=0)
  )
