/*
#1 Περιοχές που η τιμή είναι κάτω από 30$ τον Αύγουστος
Output: 44 rows
*/
SELECT DISTINCT "ListingsSummary".neighbourhood
FROM "ListingsSummary"
JOIN "Calendar"
ON "ListingsSummary".id="Calendar".listing_id
WHERE "Calendar".available=true AND "Calendar".date BETWEEN '2020-08-01' AND '2020-08-31'
AND "Calendar".price< '30$'

/*
#2 Δείξε όλα τα διαθέσιμα σπίτια για τουλάχιστον μια βραδιά 
από 2020-06-01 ημερομηνία έως 2020-06-07 στους ΑΜΠΕΛΟΚΗΠΟΥΣ έως 50$ με sort την τιμή.
Output: 65 rows
*/
Select id, neighbourhood, "ListingsSummary".price FROM "ListingsSummary" inner join "Calendar" ON "ListingsSummary".id = "Calendar".listing_id
WHERE date BETWEEN '2020-06-01' AND '2020-06-07' AND available = true AND "ListingsSummary".price::numeric < 50 AND neighbourhood = 'ΑΜΠΕΛΟΚΗΠΟΙ'
Group By id
ORDER BY "ListingsSummary".price;

 /*
 #3 Δες τον ΜΟ τιμών στα διαθέσιμά σπίτια σε κάθε περιοχή με sort τον ΜΟ
 Output: 44 rows
 */
SELECT "ListingsSummary".neighbourhood, AVG("ListingsSummary".price::numeric)::numeric(10,2) as "Average Price"
FROM "ListingsSummary" 
join "Calendar"
ON "ListingsSummary".id= "Calendar".listing_id
WHERE "Calendar".available=true
GROUP BY "ListingsSummary".neighbourhood
ORDER BY "Average Price";

/*
#4 Τα 5 πιο φθηνα σπίτια τον Μάρτη
Output: 5 rows
*/
Select distinct id, "ListingsSummary".price, available FROM "ListingsSummary" 
INNER JOIN "Calendar"
ON "ListingsSummary".id = "Calendar".listing_id 
WHERE date BETWEEN '2020-03-01' AND '2020-03-31' AND available = true ORDER BY price LIMIT 5

/*
#5 find listings near the location (37.98856,23.76537)
Output: 3 rows
*/
SELECT "Listings".id
FROM "Listings"
WHERE CAST("Listings".latitude AS VARCHAR(20)) like '37.988%'
AND CAST("Listings".longitude AS VARCHAR(20)) LIKE '23.765%';

/*
#6 Δείξε ανα περιοχή ποιο είναι το πιο φθηνό διαθέσιμο 
σπίτι για τουλάχιστον μια μέρα την πρώτη εβδομάδα του ιουλίου
Output: 43 rows
*/
SELECT neighbourhood, min("ListingsSummary".price) as "Smaller Price"
FROM "ListingsSummary" 
JOIN "Calendar"
ON "ListingsSummary".id="Calendar".listing_id
WHERE "Calendar".available=true 
AND "Calendar".date BETWEEN '2020-07-01' AND '2020-07-07'
GROUP BY neighbourhood;

/* 
#7 Σχόλια hoster 37177 για ολα του τα σπιτια
Output: 161 rows
*/
SELECT "ListingsSummary".id, "ListingsSummary".host_id, "ListingsSummary".host_name, "Reviews".comments  FROM "ListingsSummary"
INNER JOIN "Reviews" 
ON "ListingsSummary".id = "Reviews".listing_id
Where host_id = 37177;


/*
#8 Βρες τα σπίτια που δεν έχουν καμία κριτική
Output: 2559 rows
*/
Select distinct "ListingsSummary".id
from "Reviews"
right outer join "ListingsSummary"
on "Reviews".listing_id = "ListingsSummary".id
Where "Reviews".listing_id is NULL

/*
#9 Σπίτια που δεν έχουν ορίσει το calendar τους 
Output: 8667 rows
 */
Select distinct "ListingsSummary".id, "Calendar".listing_id
from "Calendar"
right outer join "ListingsSummary"
on "Calendar".listing_id = "ListingsSummary".id
Where "Calendar".listing_id is NULL


/*
#10 Δείξε τις περιοχές με βάση το ΜΟ rating, έχουν δεν εχουν κριτικές
Output: 45 rows
*/
SELECT "Listings".neighbourhood_cleansed, AVG("Listings".review_scores_rating::numeric)::numeric(10,2) as "Average Rating"
FROM "Listings" 
inner join "Neighbourhoods"
ON "Listings".neighbourhood_cleansed = "Neighbourhoods".neighbourhood
GROUP BY "Listings".neighbourhood_cleansed
ORDER BY "Average Rating" DESC;

/*
#11 Πόσα σπίτια για business travel υπάρχουν ανα περιοχή;
Output: 45 rows
*/
SELECT "Neighbourhoods".neighbourhood, Count("Listings".is_business_travel_ready)
FROM "Neighbourhoods" 
inner join "Listings"
ON "Listings".neighbourhood_cleansed = "Neighbourhoods".neighbourhood
Group by "Neighbourhoods".neighbourhood

/*
#12 Ολόκληρα διαμερίσματα ελεύθερα προς ενοικίαση την 1η Απριλίου
Output: 10109 rows
*/
select distinct "ListingsSummary".id,"ListingsSummary".name
from "ListingsSummary","Calendar"
where "ListingsSummary".room_type='Entire home/apt' 
and ("Calendar".available=true and "Calendar".date='2020-04-01')

