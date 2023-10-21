# IMDB Movies Database Project

This project was part of a Databases course with the following details:

- **Project Deadline:** 14/6/2021

## Purpose

In this project, we worked on setting up a database consisting of movie data and conducted a small analysis and visualization of the data.

## Groups

To complete the project, we formed teams of 2 or 3 people with no more or less members per group.

## Part A

### Data

The data can be found [here](data_link). According to this data, we needed to:

- Create the structure of the database, define the relationships between the tables, and enter the data.
- Define the correct data types for all attributes.
- Data preprocessing: Remove duplicates from the tables (except for "ratings") and delete movie data that does not exist in the tables. Specifically, we needed to delete movie data that does not exist in the "movies_metadata" table but does exist in one of the other tables.

The data preprocessing was done in an automated way using a programming language of our choice.

### Deliverable Part A

For part A, we delivered within a folder named "partA":

- A SQL file containing the table creation commands, key generation commands, and constraints.
- A file containing the data preprocessing commands in the language or system we chose.
- A short report (.pdf file) describing the steps taken in processing the data and saving it into the database.
- An Entity-Relationship (ER) chart in an image file.

### Bonus

We also added data from an external source to our database. This additional data included movie pictures, summaries, and more.

## Part B

In part B, we calculated and visualized the following statistics using SQL and Python (via connection 1 to our database):

- Number of movies per year.
- Number of films per genre.
- Number of films per genre and per year.
- Average rating per genre (film).
- Number of ratings per user.
- Average rating per user.

We also created a view table that saved, for each user, the number of ratings and visualized it using a scatter plot. We aimed to discover insights from this relationship.

### Deliverable Part B

For part B, we delivered within a folder named "partB":

- A SQL file containing the commands used to calculate the statistics mentioned above and the command to create the view_table.
- A Python file that establishes a connection to our database and visualizes the data.
- Image files with the visualizations inside the folder.

### Dahboard
![image](https://github.com/eliaskalan/IMDB-Database-and-Dashboard-Analytics/assets/57637832/0a4c0d91-0406-4b1a-a815-2b178b859689)

## Final Deliverables

- Created a .txt file in which the Azure endpoint was listed, including the server name in the Overview tab of Azure, the name of our database, and the username and password of a user with read-only permissions. This allowed for viewing the tables in our database. The .txt file had the following format:

