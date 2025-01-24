# this file is for the calculation of the billionaire database, which we made first
import json
import csv
import re

# for regular expressions to clean up data (which in the end wasn't nessacery)
parentheses = re.compile(r'\(.+\)')

# list of the letters for the code to loop through
letters = [
    "A",    "B",    "C",    "D",    "E",    "F",    "G",    "H",    "I",    "J",    "K",    "L",    "M",    "N",
    "O",    "P",    "Q",    "R",    "S",     "T",    "U",    "V",    "W",    "X",    "Y",    "Z"
]

# made list for our new data sets
filtered_data=[]
# parent_data = []

# start of the big for loop so it will perform all operations on all 26 letters
for letter in letters:
    with open(f"{letter}_people.json") as json_file:
        data = json.load(json_file)
    # per letter (at the time) dictionary's are stored in data, person is the dictionary with data points we want for that datapoint (name, education/alma mater, and if possible net worth)
    for dictionary in data: 
        person = {}
        # made python look through the wiki data set for entries that had a title, networth, and either education or alma mater listed
        if "ontology/networth" in dictionary and "title" in dictionary and\
            ("ontology/education_label" in dictionary or "ontology/almaMater_label" in dictionary):
            # person name was a clean version of their title (on wiki)
            person["name"] = (dictionary["title"]).replace("_", " ")
            person["name"] = parentheses.sub("", person["name"])
            # networth was networth as listed in entry, in case there were multiple the first occuring was picked
            person["networth"] = (dictionary["ontology/networth"])
            if type(person["networth"]) is list:
                person["networth"] = person["networth"][0]
            # the next part does the same for education & alma mater               
            if "ontology/education_label" in dictionary:  
                educations = (dictionary["ontology/education_label"]) # new variable to store educations
                if type(educations) is not list:
                    educations = [educations] # make not-lists a list so all educations behave the same
                # for every education in the education list a copy of the person was made, so all their educations
                #       would become their own data point 
                for education in educations: 
                    person = person.copy()
                    person["education"] = education
                    filtered_data.append(person)
            if "ontology/almaMater_label" in dictionary:
                alma_maters = (dictionary["ontology/almaMater_label"])
                if type(alma_maters) is not list:
                    alma_maters = [alma_maters]
                for alma_mater in alma_maters:
                    person = person.copy()
                    person["education"] = alma_mater
                    filtered_data.append(person)


# csv file for further coding in R and making plots, json to be able to easier look into the content of the data set (they're called check now but in different versions of 
#  the code the data would load into the results files (fe when we wanted to start in R but python wasn't done yet))

with open("check.json", "w", encoding="utf-8") as file:
    json.dump(filtered_data, file, indent=4, ensure_ascii=False)

with open("check.csv", "w", encoding="utf-8", newline='') as file:
    writer = csv.DictWriter(file, ["name", "networth", "education"])
    writer.writeheader()
    writer.writerows(filtered_data)



