import psycopg2
import numpy as np
from getpass import getpass
import matplotlib.pyplot as plt


host = "db-studentserver2021-3190013-3190068.postgres.database.azure.com"
dbname = "Project"
user = "examiner"+"@db-studentserver2021-3190013-3190068"
password="examinersPassword"
sslmode = "require"


conn_string = "host={0} user={1} dbname={2} password={3} sslmode={4}".format(host, user, dbname, password, sslmode)

print("Connection established User:examiner")
def graph(result,ylable,xlable,title,typeA=int,typeB=int):
    
    fig = plt.figure()
    ax = fig.add_subplot(111)
    data = []
    xTickMarks = []
    for row in result:
        data.append(typeA(row[1]))
        xTickMarks.append(typeB(row[0]))

    ind = np.arange(len(data))              
    width = 0.8                  
    rects1 = ax.bar(ind, data, width,
                    color='blue',)

    ax.set_xlim(-width,len(ind)+width)
    ax.set_ylabel(ylable)
    ax.set_xlabel(xlable)
    ax.set_title(title)
    ax.set_xticks(ind)
    xtickNames = ax.set_xticklabels(xTickMarks)
    plt.setp(xtickNames, rotation=90, fontsize=7)

    plt.show()


def scem(result,xlable,ylable,title,typeA,typeB):
    data = []
    xTickMarks = []
    s=1
    ind=False
    fig = plt.figure()
    ax = fig.add_subplot(111)
    for row in result:
        data.append(typeB(row[1]))
        xTickMarks.append(typeA(row[0]))
            
    
    ax.set_ylabel(ylable)
    ax.set_xlabel(xlable)
    ax.set_title(title)
    
    
  
    plt.scatter(data, xTickMarks,s=s)
    plt.show()
conn = psycopg2.connect(conn_string)
cursor = conn.cursor()

print("Average rating per User id")
cursor.execute('Select user_id, average_rating from "ViewTable"')
result = cursor.fetchall()
scem(result,'Aveage rating','User id','Average rating per User id',typeA=int,typeB=float)

print("Number of movies per genres and year")
cursor.execute(' select json_array_elements(genres) ->> \'name\' as data_genres,EXTRACT(YEAR from release_date),Count(id) from "MoviesMetadata" where EXTRACT(YEAR from release_date) is not null group by EXTRACT(YEAR from release_date),json_array_elements(genres) ->> \'name\' order by data_genres ')
result = cursor.fetchall()
scem(result,'Year','Genres','Number of movies per genres and year',typeA=str,typeB=int)

print("Number of ratings per User id")
cursor.execute('Select user_id, count_ratings from "ViewTable"')
result = cursor.fetchall()
scem(result,'number of ratings',"Users_id","Number of ratings per User id",typeA=int,typeB=float)

print("Number of movies per genre")
cursor.execute('select json_array_elements(genres) ->> \'name\' as data_genres, Count(id) from "MoviesMetadata" group by json_array_elements(genres) ->> \'name\'')
result = cursor.fetchall()
graph(result,'Number of movies','genre','Number of movies per genre',typeB=str)

print('Average rating per genres')
cursor.execute('Select json_array_elements(genres) ->> \'name\' as data_genres, ROUND(AVG(rating ),2) FROM "MoviesMetadata" inner join "Rating_small" on id="Rating_small".movie_id group by data_genres')
result = cursor.fetchall()
graph(result,'Genres','Average rating','Average rating per genres',typeA=float,typeB=str)
print('Number of movies per year')
cursor.execute('Select EXTRACT(YEAR from release_date), COUNT(id) FROM "MoviesMetadata" where release_date is not null group by EXTRACT(YEAR from release_date)order by EXTRACT(YEAR from release_date)')
result = cursor.fetchall()
graph(result,'Number of movies','Years','Number of movies per year',typeB=int)

print("Scatter plot of number of ratings and average rating")
cursor.execute('Select count_ratings, average_rating from "ViewTable";')
result = cursor.fetchall()
scem(result,'average_rating',"count_ratings","Number of ratings and average rating",typeA=int,typeB=float)
