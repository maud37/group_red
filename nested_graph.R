#creates the nested graph chart

library(tidyverse)

nested_graph_data <- read_csv('nested_graph.csv')

ggplot(nested_graph_data)+
  aes(x=university, y=percentage, fill=group)+
  geom_col(position = "dodge")+
  theme_minimal()+
  coord_flip()+
  xlab("University")+
  scale_y_continuous(labels = scales::percent, limits=c(0,0.1))+
  ylab("Percentage of Total Enrollments Within Respective Samples")+
  labs(fill="Sample Group")

ggsave('nested_graph.pdf')
ggsave('nested_graph.png')
      

