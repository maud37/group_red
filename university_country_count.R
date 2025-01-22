university_count <- read_csv('results3.csv') |>
  group_by (education)|>
  summarise(education_count = n())

university_country_count <- read_csv('countries2.csv') |>
  mutate(university_count)

write_csv(university_country_count, 'university_country_count.csv')