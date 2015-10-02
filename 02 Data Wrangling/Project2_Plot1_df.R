# This file creates the first plot of the Data Visualization Project 2
require(tidyr)
require(dplyr)
require(ggplot2)

# Move data into new data frame for Plot 1
Plot1_df <- df  

# Need to rearrange and relabel the data in the Education column
Plot1_df$EDUCATION <- factor(df$EDUCATION, levels=c("<9years", "9-11years", "12years", "13-15years","16years", ">16years"), labels = c("No High School", "Some High School", "High School Graduate", "Some College", "College Graduate", "Beyond Bachelors")) 

# Now we can use this R workflow to find the average number of kids given a wifes education level and husbands incoem
Plot1_df <- Plot1_df %>% group_by (EDUCATION, HUSBY) %>% summarise(mean_kids = mean(KIDSLT6 + KIDS618))

# plot of how education and husbands income influences number of kids
ggplot() +
  coord_cartesian() + 
  scale_x_continuous() +
  scale_y_continuous() +
  facet_grid(.~EDUCATION) + 
  labs(title="Average Number of Children per Wife's Education Level and Husband's Income") +
  labs(x="Average Number of Kids", y=paste("Husband's Income (thousands of dollars)"), color="Level of Education") +
  layer(data=Plot1_df, 
        mapping=aes(x=as.numeric(mean_kids), y=as.numeric(as.character(HUSBY)), color = as.character(EDUCATION)),
        stat="identity", 
        stat_params=list(), 
        geom="point",
        geom_params=list(), 
        position=position_jitter(width=0.3, height=0)
  ) +
  layer(data=Plot1_df,
        mapping=aes(x=as.numeric(mean_kids), y=as.numeric(as.character(HUSBY)), color = as.character(EDUCATION)),
        stat="boxplot",
        stat_params=list(),
        geom="boxplot",
        geom_params=list(color="red",fill="red", alpha=.4),
        posiion=position_identity()
  )
