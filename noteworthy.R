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