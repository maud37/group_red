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

filtered_names=[]


for letter in letters:
    with open(f'{letter}_people.json') as json_file:
        data = json.load(json_file)

    for dictionary in data: 
        person = {}
        if "ontology/networth" in dictionary and "ontology/education_label" in dictionary:
            person["networth"] = (dictionary["ontology/networth"])
            if type(person["networth"]) is list:
                person["networth"] = person["networth"][0]
            person["education"] = (dictionary["ontology/education_label"])
            if "ontology/occupation_label" in dictionary:
                person["occupation"] = (dictionary["ontology/occupation_label"])
            person1={}
            person2={}
            if type(person["education"]) is list:
                if(len(person["education"])) == 2:
                    person1["networth"] = person["networth"][0]
                    person1["education"] = person["education"][0]
                    if "occupation" in person: 
                        person1["occupation"] = person["occupation"]
                    person2["networth"] = person["networth"][0]
                    person2["education"] = person["education"][1]
                    if "occupation" in person:
                        person2["occupation"] = person2["occupation"]
        filtered_names.append(person, person1, person2)

with open("results.json", "w", encoding="utf-8") as file:
    json.dump(filtered_names, file, indent=4, ensure_ascii=False)

with open("results.csv", "w", encoding="utf-8", newline='') as file:
    writer = csv.DictWriter(file, ["networth", "education"])
    writer.writeheader()
    writer.writerows(filtered_names)