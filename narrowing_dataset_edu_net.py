# code to create data set for all people on wikipedia with their education and/or alma mater listed
# same as the trying.py file, difference is that listing networth is optional now
#       it's a different file because at the start i wasn't sure how much changes would need to be made and it seemed clearer to leave it seperate
import json
import csv
import re

parentheses = re.compile(r'\(.+\)')

letters = [
    "A",    "B",    "C",    "D",    "E",    "F",    "G",    "H",    "I",    "J",    "K",    "L",    "M",    "N",
    "O",    "P",    "Q",    "R",    "S",     "T",    "U",    "V",    "W",    "X",    "Y",    "Z"
]

filtered_data=[]

for letter in letters:
    with open(f"{letter}_people.json") as json_file:
        data = json.load(json_file)

    for dictionary in data: 
        person = {}
        # networth no longer mandotory to be selected
        if "title" in dictionary and\
        ("ontology/education_label" in dictionary or "ontology/almaMater_label" in dictionary):
            person["name"] = (dictionary["title"]).replace("_", " ")
            person["name"] = parentheses.sub("", person["name"])
            # networth is only listed if it's there
            if "ontology/networth" in dictionary:
                person["networth"] = (dictionary["ontology/networth"])
                if type(person["networth"]) is list:
                    person["networth"] = person["networth"][0]                
            if "ontology/education_label" in dictionary:  
                educations = (dictionary["ontology/education_label"])
                if type(educations) is not list:
                    educations = [educations]
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


with open("all.json", "w", encoding="utf-8") as file:
    json.dump(filtered_data, file, indent=4, ensure_ascii=False)

with open("all_real_check.csv", "w", encoding="utf-8", newline='') as file:
    writer = csv.DictWriter(file, ["name", "networth", "education"])
    writer.writeheader()
    writer.writerows(filtered_data)



