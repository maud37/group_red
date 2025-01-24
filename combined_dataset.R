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