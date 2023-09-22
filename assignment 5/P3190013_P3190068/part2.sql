/*1
Posa spitia yparxoyna ana geitonia kai sto shmeio geometry_coordinates_0_0_24_1 den eiani null
*/
Select Count(listing_id) from "Location" 
inner join "Geolocation" 
on properties_neighbourhood = neighbourhood_cleansed 
group by properties_neighbourhood 
having geometry_coordinates_0_0_24_1 is not null;

/*2
Posoi idiokthtes yparxoyn analoga me to response_time kai ayto den einai agnosto 
*/
Select Count("Host".id), response_time from "Host" 
inner join "ListingSummary" 
on "Host".id = host_id 
group by response_time  having response_time <> 'N/A';

/*3
Mesh timh, megisth timh , elaxisth timh , mesh elaxisth diamonh 
kai arithmos domation se kathe perioxh 
*/
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

/*4
ta spitia opoy prosferoyn 24oro check_in 
*/
Select "RoomCopy".listing_id from "RoomCopy" 
inner join "RoomAmenities" 
on "RoomAmenities".listing_id = "RoomCopy".listing_id 
and "RoomAmenities".amenity_id = 2; 
 
 /*5
Spitia sthn athina me pano apo 2 mpania kathgoropoihmena symfona me thn timh 
*/
SELECT "Location".neighbourhood,"Room".bedrooms,"Room".price
from "Location"
FULL OUTER JOIN "Room"
on "Location".LISTING_ID="Room".listing_id
where "Location".city='Athens'
group by "Room".price,"Location".neighbourhood,"Room".bedrooms
Having cast ("Room".bedrooms as float)>2.0 
ORDER BY "Room".price;
