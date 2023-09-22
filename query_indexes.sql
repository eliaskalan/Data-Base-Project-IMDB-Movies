/*2*/
VACUUM ANALYZE "RoomCopy","RoomAmenities","Amenity","Calendar","Calendar2","Host","Listing","ListingSummary",
"Listings","Listings2","ListingsSummary","Location","Neighbourhood","Neighbourhoods","Price","Review","ReviewSummary"
,"Reviews","ReviewsSummary","Room","RoomAmenities","RoomCopy";
/*2a*/
/* Query 1: with out index: 3.47 ms; with index: 1.81 ms */
/* Comment Το default index είναι το pk του Host, αλλά καθώς το  listing έχει πολλές
περισσότερες σειρές βάζουμε να αναζητεί βάση του Listin id και όχι του Host*/
VACUUM ANALYZE "Listing","Host";
set enable_seqscan = off

EXPLAIN ANALYZE SELECT "Host".id, COUNT(*) FROM "Listing", 
"Host" WHERE "Host".id="Listing".id 
GROUP BY "Host".id;

CREATE INDEX idx_id 
ON "Listing"(id);

EXPLAIN ANALYZE SELECT "Host".id, COUNT(*) FROM "Listing", 
"Host" WHERE "Host".id="Listing".id 
GROUP BY "Host".id;


/*2b*/
/*1 case*/
/* Query 2: with out index: 396 ms; with index: 412 ms */
/* Comment Με το index μας, δημιουργήθηκε βάση του Price, αλλά καθώς το price
έχει λιγότερους αριθμούς από το default του αργεί περισσότερο.*/
VACUUM ANALYZE "Listing","Price";
set enable_seqscan = off

EXPLAIN ANALYZE SELECT id,price FROM "Listing", "Price"
WHERE guests_included > 5 AND price > 40;

CREATE INDEX idx_id
ON "Price"(listing_id);

VACUUM ANALYZE "Listing","Price";
set enable_seqscan = off

EXPLAIN ANALYZE SELECT id,price FROM "Listing", "Price"
WHERE guests_included> 5 AND price > 40;

/*2 case*/
/* Query 3: with out index: 386 ms; with index: 422 ms */
/* Comment ίδιος λόγος με το 2.*/
VACUUM ANALYZE "Listing","Price";
set enable_seqscan = off

EXPLAIN ANALYZE 
SELECT id,price FROM "Listing", "Price"
WHERE guests_included > 5 AND price > 40;

CREATE INDEX idx_id_price_only
ON "Price"(price);

VACUUM ANALYZE "Listing","Price";
set enable_seqscan = off

EXPLAIN ANALYZE 
SELECT id,price FROM "Listing", "Price"
WHERE guests_included > 5 AND price > 40;


/*----------------------------------------------------------------------------------*/
/*4*/
/* Query 4: with out index: 25 ms; with index: 20 ms */
/* comment: Εδώ το default index είναι το listing_id από το location, αλλά εμείς δεν ψάχνουμε βάση
του listing_id, οπότε αφού το αλλαζουμε με αυτό που ψάχνουμε γίνεται πιο γρήγορο.*/
VACUUM ANALYZE "Location","Geolocation";
set enable_seqscan = off

EXPLAIN ANALYZE 
Select Count(listing_id) from "Location" 
inner join "Geolocation" 
on properties_neighbourhood = neighbourhood_cleansed 
group by properties_neighbourhood 
having geometry_coordinates_0_0_24_1 is not null;



CREATE INDEX first1
ON "Geolocation"(properties_neighbourhood)


VACUUM ANALYZE "Location","Geolocation";
set enable_seqscan = off

EXPLAIN ANALYZE 
Select Count(listing_id) from "Location" 
inner join "Geolocation" 
on properties_neighbourhood = neighbourhood_cleansed 
group by properties_neighbourhood 
having geometry_coordinates_0_0_24_1 is not null;

/*----------------------------------------------------------------------------------*/
/*5
Posoi idiokthtes yparxoyn analoga me to response_time kai ayto den einai agnosto 
*/
/* Query 5: with out index: 13 ms; with index: 20 ms */
/*comment  Από εκεί που έψαχνε με το Host.id η postgres εμεις, ψάχναμε με το listing
το οποίο έχει περισσότερα στοιχεία για την ίδια διεργασία.*/
/*----------------------------------------------------------------------------------*/
VACUUM ANALYZE "Host","ListingSummary";
set enable_seqscan = off

EXPLAIN ANALYZE
Select Count("Host".id), response_time from "Host" 
inner join "ListingSummary" 
on "Host".id = host_id 
group by response_time  having response_time <> 'N/A';

CREATE INDEX second
ON "ListingSummary"(id)

VACUUM ANALYZE "Host","ListingSummary";
set enable_seqscan = off

EXPLAIN ANALYZE
Select Count("Host".id), response_time from "Host" 
inner join "ListingSummary" 
on "Host".id = host_id 
group by response_time  having response_time <> 'N/A';

/*----------------------------------------------------------------------------------*/
/*6
Mesh timh, megisth timh , elaxisth timh , mesh elaxisth diamonh 
kai arithmos domation se kathe perioxh 
*/
/* Query 6: with out index: 18 ms; with index: 14 ms */
/*comment Από εκεί που έψαχνε βάση του Location το οποίο έχει λίγα στοιχεία
και δεν βοηθάνε στην σύγκριση μας, βάζουμε index στο price το οποίο είναι κύριο στην σύγκριση 
(πχ με το Max & Min) και είναι πιο γρήγορο.*/
VACUUM ANALYZE "Location","Price";
set enable_seqscan = off

EXPLAIN ANALYZE
SELECT "Location".neighbourhood,
       ROUND(AVG("Price".price), 2) AS "average_price",
       MAX("Price".price) AS "max_price",
       MIN("Price".price) AS "min_price",
       FLOOR(AVG("Price".minimum_nights)) AS "average_minimum_nights",
       COUNT("Price".listing_id) AS "listings_in_location"
FROM "Location"
LEFT OUTER JOIN "Price" 
ON "Location".listing_id = "Price".listing_id
GROUP BY "Location".neighbourhood
ORDER BY "Location".neighbourhood;

Create index third
On  "Price"(listing_id)

VACUUM ANALYZE "Location","Price";
set enable_seqscan = off

EXPLAIN ANALYZE
SELECT "Location".neighbourhood,
       ROUND(AVG("Price".price), 2) AS "average_price",
       MAX("/* Query 3: with out index: x ms; with index: x ms */Price".price) AS "max_price",
       MIN("Price".price) AS "min_price",
       FLOOR(AVG("Price".minimum_nights)) AS "average_minimum_nights",
       COUNT("Price".listing_id) AS "listings_in_location"
FROM "Location"
LEFT OUTER JOIN "Price" 
ON "Location".listing_id = "Price".listing_id
GROUP BY "Location".neighbourhood
ORDER BY "Location".neighbourhood;

/*----------------------------------------------------------------------------------*/
/*7
ta spitia opoy prosferoyn 24oro check_in 
*/
/* Query 7: with out index: 207 ms; with index: 30 ms */
/*Απλά ψάχνουμε βάση του RoomAmenities που περιέχει τα στοιχεία που θέλουμε
και όχι από το Room Copy*/
VACUUM ANALYZE "RoomCopy","RoomAmenities";
set enable_seqscan = off

EXPLAIN ANALYZE
Select "RoomCopy".listing_id from "RoomCopy" 
inner join "RoomAmenities" 
on "RoomAmenities".listing_id = "RoomCopy".listing_id 
and "RoomAmenities".amenity_id = 2; 

create index fourth
on "RoomAmenities"(listing_id)

VACUUM ANALYZE "RoomCopy","RoomAmenities";
set enable_seqscan = off

EXPLAIN ANALYZE
Select "RoomCopy".listing_id from "RoomCopy" 
inner join "RoomAmenities" 
on "RoomAmenities".listing_id = "RoomCopy".listing_id 
and "RoomAmenities".amenity_id = 2; 
/*----------------------------------------------------------------------------------*/
 /*8
Spitia sthn athina me pano apo 2 mpania kathgoropoihmena symfona me thn timh 
*/
/* Query 8: with out index: 66 ms; with index: 35 ms */
/* Comment: Ψάχνουμε κάτι ιδιαίτερα εξιζητημένο που μόνο το Id του location δεν μπορούν 
να βοηθήσουν σε αυτά. Οπότε το index που φτιάχνουμε ταξινομεί τα στοιχεία βάση πολλών παραμέτρων που χρησιμοποιούμε
*/
VACUUM ANALYZE "Room","Location";
set enable_seqscan = off

EXPLAIN ANALYZE
SELECT "Location".neighbourhood,"Room".bedrooms,"Room".price
from "Location"
FULL OUTER JOIN "Room"
on "Location".LISTING_ID="Room".listing_id
where "Location".city='Athens'
group by "Room".price,"Location".neighbourhood,"Room".bedrooms
Having cast ("Room".bedrooms as float)>2.0 
ORDER BY "Room".price;

create index fifth
on "Location"(listing_id)
include(price, city, neighourhood)
where "Location".city = 'Athens'

VACUUM ANALYZE "RoomCopy","RoomAmenities";
set enable_seqscan = off

EXPLAIN ANALYZE
SELECT "Location".neighbourhood,"Room".bedrooms,"Room".price
from "Location"
FULL OUTER JOIN "Room"
on "Location".LISTING_ID="Room".listing_id
where "Location".city='Athens'
group by "Room".price,"Location".neighbourhood,"Room".bedrooms
Having cast ("Room".bedrooms as float)>2.0 
ORDER BY "Room".price;