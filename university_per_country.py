import csv
with open('university_count.csv', newline='') as csvfile:
    university_per_country = csv.DictReader(csvfile)