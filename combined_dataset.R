#This R-script creates a combined data set that contains the following
#information: title of a person, the university that they attended and their net worth(if they have any)
#Then it creates two variables to represent two of our samples - one that contains all this information for billionaires
#and one that contains information for all other people (billionaires excluded). 

library(tidyverse)

college_to_uni <- read.csv('college_to_uni.csv')

all_combined <- read.csv('all_real.csv')|>
  left_join(college_to_uni)|>
  mutate(university=ifelse(is.na(origin_uni),education, origin_uni ))|>
  select(name,networth,university)

billionaire_only<- all_combined|>
  filter(networth>=1000000000)

no_billionaire <- all_combined |>
  filter(networth<1000000000 | is.na(networth))

university_country <- read.csv('countries2.csv')

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

#creates a graph showing the percentages of enrollments per university in the noteworthy sample

#noteworthy_percentage
noteworthy_percentage <- no_billionaire|>
  group_by(university)|>
  summarise(university_count=n())|>
  mutate(percentage=university_count/sum(university_count))|>
  filter(university_count>=500, university!= 'Bachelor of Arts') |>
  left_join(university_country) |>
  mutate(country_group = ifelse(country == "USA", "USA", "Others"))

ggplot(noteworthy_percentage)+
  aes(x=university, y=percentage, fill=country_group)+
  geom_col()+
  scale_y_continuous(labels = scales::percent, limits=c(0,0.05))+
  xlab('')+
  ylab('Percentage of Enrollments')+
  labs(fill='University')+
  theme_minimal()+
  coord_flip()


ggsave('noteworthy_percentage.png')
ggsave('noteworthy_percentage.pdf')