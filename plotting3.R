#filtering for billionaires only
library(tidyverse)

billionaires_results <- read_csv('results5.csv') |>
  filter(networth>=1000000000) |>
  group_by(education)|>
  summarise(education_count = n())|>
  filter(education_count>=15)

print(billionaires_results)

# Graph looking at billionaires & the unis attended
ggplot(data=billionaires_results)+
  aes(x=education, y=education_count)+
  geom_col()+
  xlab("University")+
  ylab("Number of Billionaires Who Attended")+
  theme_minimal()
ggsave('billionaires_per_uni.pdf')

billionaires_results2 <- read_csv('results5.csv') |>
  filter(networth>=1000000000) |>
  group_by(education, country)|>
  summarise(education_count = n()) |>
  na.omit() |>
  #filter(education_count>=5) |>
  mutate(country_group = ifelse(country == "USA", "USA", "Others"))

#print(billionaires_results2)

ggplot(data=billionaires_results2)+
  aes(x=country_group, y=education_count)+
  geom_col()+
  xlab("Country of University")+
  ylab("Number of Billionaires Who Attended")+
  theme_minimal()

# USA vs others
USA_billionaires <- read_csv('results5.csv') |>
  filter(networth>=1000000000) |>
  filter(country=='USA') 
#print(USA_billionaires)
#529 ppl => 53.6% of the billionaires listed on Wikipedia went to a University in the USA

other_billionaires <- read_csv('results5.csv') |>
  filter(networth>=1000000000) 
print(other_billionaires)
#987 ppl in total