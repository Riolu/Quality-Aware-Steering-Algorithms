import csv

def del_cvs_col(fname, newfname, idxs, delimiter=' '):
    with open(fname) as csvin, open(newfname, 'w') as csvout:
        reader = csv.reader(csvin, delimiter=delimiter)
        writer = csv.writer(csvout, delimiter=delimiter)
        rows = (tuple(item for idx, item in enumerate(row) if idx not in idxs) for row in reader)
        writer.writerows(rows)

del_cvs_col('trip_data_11_origin.csv', 'trip_data_11.csv', [0],',')
