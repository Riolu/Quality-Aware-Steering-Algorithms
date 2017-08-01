import csv

count=0

with open('trip_data_4.csv') as f:
    reader = csv.reader(f)
    for row in reader:
        print row

