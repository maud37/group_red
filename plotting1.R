library(tidyverse)

people_results <- read_csv('results3.csv') |>
  group_by(education) |>
  summarise(education_count = n()) |>
  filter(education_count>2)
                              
print(people_results)

# Barplot showing the n.o. of ppl attending the unis
ggplot(data = people_results)+
  aes(x = education, y = education_count, fill = education)+
  geom_col()+
  xlab("University")+
  ylab("Number of Individuals Who Attended")+
  scale_x_discrete(labels=NULL)+
  theme_minimal()
ggsave('no_individuals_attended.pdf')
