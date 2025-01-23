library(tidyverse)

all_edu <- read_csv('all_real.csv') |>
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
  mutate(Yale_total = `Yale College` +   `Yale Divinity School` + `Yale Graduate School of Arts and Sciences` +`Yale Law School` +  `Yale School of Architecture` +
         `Yale School of Art` + `Yale School of Drama` + `Yale School of Forestry & Environmental Studies` + `Yale School of Management` + `Yale School of Medicine` + 
         `Yale School of Music` + `Yale School of Public Health` + `Yale University` + `Yale_University_(PhD)`
      ) |>
  mutate(Chicago_total = `University of Chicago` + `University of Chicago Divinity School` + 
         `University of Chicago Laboratory Schools` + `University of Chicago Law School`
    ) |>
  mutate(
    `University of Edinburgh` + `University of Edinburgh Law School` + `University of Edinburgh Medical School`
  ) |>
  mutate(
    `University of Glasgow` + `University of Glasgow Medical School` + `University of Glasgow School of Veterinary Medicine`
  )|>
  mutate( Maryland_total =
    `University of Maryland Baltimore` + `University of Maryland Baltimore County` + `University of Maryland Eastern Shore` + 
      `University of Maryland University College` + `University of Maryland School of Law` + `University of Maryland School of Dentistry` +
      `University of Maryland College Park` + `University of Maryland College of Agriculture and Natural Resources`
  ) |> 
  mutate(Melbourne_total = 
    `University of Melbourne` + `University of Melbourne Faculty of VCA and MCM` + `St Joseph's College Melbourne` + `Trinity College (University of Melbourne)` + `Queen's College (University of Melbourne)`
  ) |>
  mutate(Michigan_total = 
        `University of Michigan College of Literature Science and the Arts` + `University of Michigan School of Public Health` + `University of Michigan School of Music Theatre & Dance` + `University of Michigan School of Education` + 
        `University of Michigan School of Dentistry` + `University of Michigan Law School` + `University of Michigan Health System` + `University of Michigan College of Pharmacy` 
  ) |>
  mutate(Minnesota_total =
    `University of Minnesota` + `University of Minnesota Law School` + `University of Minnesota Medical School`
  ) |>
  mutate(Virginia_total =
           `University of Virginia` + `University of Virginia Darden School of Business` + `University of Virginia School of Law` + 
         `University of Virginia School of Medicine` + `University of Virginia School of Nursing`
    ) |>
  mutate(Pennsylvania_total =
           `Pennsylvania State University` + `Pennsylvania State University - Dickinson Law`
    ) |>
  mutate(Pennsylvania_Ivy =
        `University of Pennsylvania` + `University of Pennsylvania Economics Department` + `University of Pennsylvania Law School` + `University of Pennsylvania School of Dental Medicine` +
         `University of Pennsylvania School of Engineering and Applied Science` + `University of Pennsylvania School of Nursing` + `Perelman School of Medicine at the University of Pennsylvania`
  ) |> 
  pivot_longer(cols = everything()) |>
  rename(education = name, education_count = value) |>
  filter(education_count > 249)

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
