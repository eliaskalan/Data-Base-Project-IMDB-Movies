import sys
import csv
import pandas as pd 
import binary_search as bs
  
def myFunc(df_meta):
  return df_meta["id"]


file_name1=sys.argv[1]
file_name2='output_movies_metadata.csv'

df_meta = pd.read_csv(file_name2)
df_other = pd.read_csv(file_name1)

#df_meta.sort_values(by=['id'])
df_meta=df_meta.drop_duplicates(['id'])
df_other=df_other.drop_duplicates(['id'])
#print(pd.merge(df_meta, df_other, how='left', on='id',indicator=True))


db=pd.merge(df_meta, df_other, how='left', on='id',indicator=True)

#print(db['id'].to_xarray())
r=[]
for index,row in db.iterrows():
    if(row['_merge']!='both'):
       
        r.append(row["id"])

db=pd.merge(df_meta, df_other, how='right', on='id',indicator=True)
for index,row in db.iterrows():
    if(row['_merge']!='both'):
        
        r.append(row["id"])

print(r)
for i in r:
    df_meta[df_meta.id != i]


for i in r:
    df_other[df_other.id != i]

df_meta.to_csv('output_'+file_name2)
df_other.to_csv('output_'+file_name1)