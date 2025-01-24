#creates 2 graphs: one showing the number of enrollments per university and percentage of enrollments per university in the billionaire sample

library(tidyverse)
library("RColorBrewer")
#billionaire_count

billionaires_count <- all_combined|>
  filter(networth>=1000000000)|>
  group_by(university)|>
  summarise(university_count=n())|>
  filter(university_count>=5, university != "Bachelor of Arts", university != "Bachelor of Science", university!= "Master of Science") |>
  left_join(university_country) |>
  mutate(country_group = ifelse(country == "USA", "USA", "Others"))

ggplot(data=billionaires_count)+
  aes(x=university, y=university_count, fill=country_group)+
  geom_col()+
  ylab('Number of Enrollments')+
  xlab('University')+
  labs(fill='Country of University')+
  theme_minimal()+
  coord_flip()

ggsave('billionaire_count.png')
ggsave('billionaire_count.pdf')

#billionaire_percentage
billionares_percentage <- all_combined|>
  filter(networth>=1000000000)|>
  group_by(university)|>
  summarise(university_count=n())|>
  mutate(percentage=university_count/sum(university_count)) |>
  filter(university_count>=5, university != "Bachelor of Arts", university != "Bachelor of Science", university != "Master of Science") |>
  left_join(university_country)|>
  mutate(country_group = ifelse(country == "USA", "USA", "Others"))

ggplot(data=billionares_percentage)+
  aes(x=university, y=percentage, fill=country_group)+
  geom_col()+
  scale_y_continuous(labels = scales::percent, limits=c(0,0.1))+
  ylab('Percentage of Enrollments')+
  xlab("University")+
  labs(fill='Country of University')+
  theme_minimal()+
  coord_flip()

ggsave('billionaire_percentage.png')
ggsave('billionaire_percentage.pdf')