require(tidyr)
require(dplyr)
require(ggplot2)

df %>% mutate(husby_percent = cume_dist(KIDS618)) %>% filter(husby_percent <= .20 | husby_percent >= .80) %>% ggplot(aes(x = KIDS618, y = WHRSWK)) + facet_grid(.~REGION, labeller=label_both)+labs(title="")+labs(x="Number of kids 6–18 years old")+ geom_point()
