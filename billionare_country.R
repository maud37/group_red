#creates a graph showing the enrollments per country of university in the billionaire sample

library(tidyverse)
library("RColorBrewer")

billionares_country <- read_csv('results5.csv') |>
  filter(networth>=1000000000)|>
  group_by (country)|>
  summarise(country_count = n())|>
  na.omit()|>
  mutate(country_ratio=country_count/sum(country_count))|>
  mutate(country_group = ifelse(country == "USA", "USA", "Others"))

ggplot(data=billionares_country)+
  aes(x=country_group, y=country_ratio)+
  geom_col(fill="coral1")+
  xlab('Country of University')+
  ylab('Percentage of Enrollements')+
  scale_y_continuous(labels = scales::percent, limits=c(0,1))+
  scale_fill_brewer(palette = "Set3")+
  theme_minimal()
  

ggsave('billionaire_country.pdf')
ggsave('billionaire_country.png')