library(tidyverse)

people_results2 <- read_csv('results3.csv') |>
  mutate(networth = as.numeric(networth)) |>
  group_by(education) |>
  summarise(
    education_count = n(),
    networth = mean(networth, na.rm=TRUE)
  ) |>
  filter(education_count>1)
  
print(people_results2)

# Average networth per uni
ggplot(data = people_results2)+
  aes(x = education, y = networth, fill = education)+
  geom_col()+
  xlab("University")+
  ylab("Mean Networth")+
  scale_x_discrete(labels=NULL)+
  theme_minimal()
ggsave('no_individuals_attended.pdf')

