import json
import csv
import re

parentheses = re.compile(r'\(.+\)')

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
parent_data = []

for letter in letters:
    with open("A_people.json") as json_file:
        data = json.load(json_file)

    for dictionary in data: 
        person = {}
        if "title" in dictionary and ("ontology/education_label" in dictionary or "ontology/almaMater_label" in dictionary):
            person["name"] = (dictionary["title"]).replace("_", " ")
            person["name"] = parentheses.sub("", person["name"])
            # if "ontology/parent" in dictionary:
            #     person["parent1"] = (dictionary["ontology/parent_label"])
                # if type(person["parent1"]) is list:
                #     person["parent2"] = person["parent1"][1]
                #     person["parent1"] = person["parent1"][0]
                    # parent_data.append(person["parent1"])
                    # parent_data.append(person["parent2"])                 
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


print(len(filtered_data))


with open("all.json", "w", encoding="utf-8") as file:
    json.dump(filtered_data, file, indent=4, ensure_ascii=False)

with open("all.csv", "w", encoding="utf-8", newline='') as file:
    writer = csv.DictWriter(file, ["name", "education"])
    writer.writeheader()
    writer.writerows(filtered_data)



# for person in filtered_data:
#     wiki_parent = {}
    




# print(filtered_data)

# remove_doubles = set()

# for person in filtered_data:
#     remove_doubles.add(person["education"])

# print(remove_doubles)
# print(len(remove_doubles))