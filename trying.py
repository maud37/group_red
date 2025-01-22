import json
import csv

letters = { 
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S", 
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z"
}

filtered_data=[]


for letter in letters:
    with open(f'{letter}_people.json') as json_file:
        data = json.load(json_file)

    for dictionary in data: 
        person = {}
        if "ontology/networth" in dictionary and "title" in dictionary and\
            ("ontology/education_label" in dictionary or "ontology/almaMater_label" in dictionary):

            person["name"] = (dictionary["title"])
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


with open("results2.json", "w", encoding="utf-8") as file:
    json.dump(filtered_data, file, indent=4, ensure_ascii=False)

with open("results3.csv", "w", encoding="utf-8", newline='') as file:
    writer = csv.DictWriter(file, ["name", "networth", "education"])
    writer.writeheader()
    writer.writerows(filtered_data)

