# This file creates the second plot of the Data Visualization Project 2
require(tidyr)
require(dplyr)
require(ggplot2)

# R workflow for plot two
Plot2_df <- df %>% mutate(EXPERIENCE_PERCENT = cume_dist(EXPERIENCE)) %>% filter(EXPERIENCE_PERCENT  <= .1 | EXPERIENCE_PERCENT  >= .9)

# plot of how Husband's work experience influences whether he has insurance and what he is paid
ggplot() +
  coord_cartesian() + 
  scale_x_continuous() +
  scale_y_continuous() +
  labs(title="Top & Bottom 10 percent of Husband's Work Experience") +
  labs(x="Work Experience", y="Husband Income", color="Does Husband Have Health Insurance?") +
  layer(data=Plot2_df, 
        mapping=aes(x=as.numeric(EXPERIENCE), y=as.numeric(HUSBY), color=as.character(HHI)), 
        stat="identity", 
        stat_params=list(), 
        geom="point",
        geom_params=list(), 
        position=position_jitter(width=0.3, height=0)
  )
