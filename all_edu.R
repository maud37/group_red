library(tidyverse)

all_edu <- read_csv('all.csv') |>
  group_by(education) |>
  summarise(education_count = n()) |>
    
  pivot_wider(names_from = education, 
              values_from = education_count) |>
  #  select(- `Bachelor of Arts`, -`Doctor of Philosophy`, 
  #         -`Master of Arts`)
  mutate(Harvard_total = `Harvard Business School` + `Harvard College`  + `Harvard Law School` + `Harvard University` + 
           `Harvard Graduate School of Design` + `Harvard Graduate School of Education` + `Harvard Divinity School` + 
           `Harvard T.H. Chan School of Public Health`
         ) |>
  mutate(Cambridge_total = `Christ's College Cambridge` + `Clare College Cambridge` + `Computer Laboratory University of Cambridge` +
           `Corpus Christi College Cambridge` + `Downing College Cambridge` + `Emmanuel College Cambridge` + `Fitzwilliam College Cambridge` +
           `Girton College Cambridge` + `Gonville and Caius College Cambridge` + `Hughes Hall Cambridge` +
           `Jesus College Cambridge` + `King's College Cambridge` + `Magdalene College Cambridge` + `Newnham College Cambridge` +
           `Pembroke College Cambridge` + `Peterhouse Cambridge` + `Queens' College Cambridge` + 
           `Selwyn College Cambridge`, `St Catharine's College Cambridge` + `St Edmund's College Cambridge` + 
           `St John's College Cambridge` + `Trinity College Cambridge` + `Trinity Hall Cambridge` + 
           `University of Cambridge` + `Westcott House Cambridge` + `Wolfson College Cambridge`
         ) |>
  mutate(Stanford_total = `Stanford Graduate School of Business` + `Stanford Graduate School of Business` + `Stanford University`
         ) |>
  mutate(Oxford_total = `All Souls College Oxford` + `Balliol College Oxford` + `Brasenose College Oxford` + `Campion Hall Oxford` + `Green Templeton College Oxford` +
           `Christ Church Oxford` + `Corpus Christi College Oxford` + `Exeter College Oxford` + `Gloucester College Oxford` +
           `Hertford College Oxford` + `Harris Manchester College Oxford` + `Jesus College Oxford` + `Keble College Oxford` + 
           `Lady Margaret Hall Oxford` + `Lincoln College Oxford` + `Magdalen College Oxford` + 
           `Merton College Oxford` + `New College Oxford` + `Nuffield College Oxford` + `Oriel College Oxford` + 
           `Oxford` + `Pembroke College Oxford` + `Somerville College Oxford` + `St Antony's College Oxford` + 
           `St Catherine's College Oxford` + `St Edmund Hall Oxford` + `St Hilda's College Oxford` + `St Hugh's College Oxford` + 
           `St John's College Oxford` + `St Peter's College Oxford` + `The Queen's College Oxford` + `Trinity College Oxford` +
           `University College Oxford` + `University of Oxford` + `Wadham College Oxford` + `Worcester College Oxford` + `Wycliffe Hall Oxford` +
            `Headington School Oxford` + `Mansfield College Oxford` + `Regent's Park College Oxford` + `St Anne's College Oxford` +
           `St Clare's Oxford` + `St Cross College Oxford` + `St Mary Hall Oxford` + `St Stephen's House Oxford` + `Westminster College Oxford` +
           `Wolfson College Oxford`
         )  |>
  mutate(Columbia_total = `Columbia Business School` + `Columbia College Columbia University` + `Columbia Graduate School of Architecture Planning and Preservation` + 
           `Columbia Graduate School of Arts and Sciences` + `Columbia Law School` + `Columbia University` + `Columbia School of Engineering and Applied Science` + 
           `Columbia University College of Physicians and Surgeons` + `Columbia University Graduate School of Journalism` + `Columbia University Mailman School of Public Health` + 
           `Columbia University School of General Studies` + `Columbia University School of Social Work`+ `Columbia University School of the Arts` + `Columbia_University_School_of_Library_Science` +
           `School of International and Public Affairs Columbia University` + `Teachers College Columbia University`
         ) |>
  
  pivot_longer(cols = everything()) |>
  rename(education = name, education_count = value) |>
  filter(education_count > 100)

print(all_edu)



# Barplot showing the n.o. of ppl attending the unis
ggplot(data = all_edu) +
  aes(x = education, y = education_count, fill = education) +
  geom_col() +
  xlab("University") +
  ylab("Number of Individuals Who Attended") +
  scale_x_discrete(labels=NULL) +
  theme_minimal()
# ggsave('no_individuals_attended.pdf')
