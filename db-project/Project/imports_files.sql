create table "MoviesMetadata"(
   adult bool,
   belongs_to_collection text,
   budget int,
   genres text,
   homepage varchar(250),
   id int,
   imdb_id varchar(10),
   original_language varchar(10),
   original_title varchar(110),
   overview varchar(1000),
   popularity float,
   poster_path varchar(40),
   production_companies text,
   production_countries text,
   release_date date,
   revenue BIGINT,
   runtime int,
   spoken_languages text,
   status varchar(20),
   tagline varchar(300),
   title varchar(110),
   video bool,
   vote_average NUMERIC(3,1),
   vote_count int
);

 create table "Rating"(
    user_id int,
    movie_id int,
    rating Numeric(3,1),
    time_stamp int
);

create table "Rating_small"(
    user_id int,
    movie_id int,
    rating Numeric(3,1),
    time_stamp int
);

create table "Credits"(
   cast_name text,
   crew text,
   id int
);

create table "Keywords"(
    id int,
    keywords text
);

create table "Links"(
    movie_id int,
    imdb_id int,
    tmdb_id int
);

\COPY "MoviesMetadata" FROM /Users/Data2/output_movies_metadata.csv DELIMITER ',' CSV HEADER; 
\COPY "Credits" FROM /Users/Data2/output_output_credits.csv DELIMITER ',' CSV HEADER;
\COPY "Keywords" FROM /Users/Data2/output_output_keywords.csv DELIMITER ',' CSV HEADER; 
\COPY "Links" FROM /Users/Data2/output_output_links.csv DELIMITER ',' CSV HEADER; 
\COPY "Rating" FROM /Users/Data2/ratings.csv DELIMITER ',' CSV HEADER; 
\COPY "Rating_small" FROM /Users/Data2/ratings_small.csv DELIMITER ',' CSV HEADER; 

UPDATE  "MoviesMetadata" SET  genres = CAST(REGEXP_REPLACE(genres, $$[']$$, '"', 'g') AS json);
ALTER TABLE "MoviesMetadata" ALTER COLUMN genres Type json using genres::json;

Delete from "Links" where "Links".movie_id IN( 				  
Select movie_id from "Links"
where Not Exists (Select id from "MoviesMetadata"
				  where "MoviesMetadata".id="Links".tmdb_id))

Delete from "Keywords" where "Keywords".id IN(
Select id from "Keywords"
where Not Exists (
Select id from "MoviesMetadata"
where "MoviesMetadata".id="Keywords".id));


ALTER TABLE "MoviesMetadata" ADD PRIMARY KEY (id);
ALTER TABLE "Credits" ADD PRIMARY KEY (id);
ALTER TABLE "Links" ADD PRIMARY KEY (movie_id);
ALTER TABLE "Keywords" ADD PRIMARY KEY (id);

ALTER TABLE "Credits" 
ADD CONSTRAINT Cred_meta
FOREIGN KEY (id) 
REFERENCES "MoviesMetadata" (id);

ALTER TABLE "Links" 
ADD CONSTRAINT meta_Link
FOREIGN KEY (tmdb_id) 
REFERENCES "MoviesMetadata" (id);

ALTER TABLE "Keywords" 
ADD CONSTRAINT meta_keys
FOREIGN KEY (id) 
REFERENCES "MoviesMetadata" (id);

Select movie_id from "Links"
where Not Exists (Select id from "MoviesMetadata"
				  where "MoviesMetadata".id="Links".movie_id);
				  
Select id from "MoviesMetadata"
where Not Exists (Select movie_id from "Links"
				  where "MoviesMetadata".id="Links".movie_id);
				  
				  
Create table "ViewTable" 
as
with data_of_union as (Select "Rating".user_id, "Rating".rating From "Rating" union all select "Rating_small".user_id, "Rating_small".rating From "Rating_small")
Select user_id, count(user_id) "count_ratings", TRUNC(AVG(rating),2) as "average_rating" From data_of_union group by user_id order by user_id;

ALTER TABLE "ViewTable" 
ADD PRIMARY KEY (user_id);
