create table "Listings2" as (select * from "Listings")
/* create "Host" with host columns */

create table "Host" as (
select distinct "Listings2".host_id,"Listings2".host_url,"Listings2".host_name,
"Listings2".host_since,"Listings2".host_location,"Listings2".host_about,"Listings2".host_response_time,"Listings2".host_response_rate,
"Listings2".host_acceptance_rate,"Listings2".host_is_superhost,"Listings2".host_thumbnail_url,
"Listings2".host_picture_url,"Listings2".host_neighbourhood,"Listings2".host_listings_count,"Listings2".host_total_listings_count,"Listings2".host_verifications,"Listings2".host_has_profile_pic,"Listings2".host_identity_verified,"Listings2".calculated_host_listings_count 
from "Listings2" )

/* rename columns */

ALTER TABLE "Host" RENAME COLUMN host_id TO id ;
ALTER TABLE "Host" RENAME COLUMN host_url TO url ;
ALTER TABLE "Host" RENAME COLUMN host_name TO name ;
ALTER TABLE "Host" RENAME COLUMN host_since TO since ;
ALTER TABLE "Host" RENAME COLUMN host_location TO location;
ALTER TABLE "Host" RENAME COLUMN host_about TO about;
ALTER TABLE "Host" RENAME COLUMN host_response_time TO response_time ;
ALTER TABLE "Host" RENAME COLUMN host_response_rate TO response_rate ;
ALTER TABLE "Host" RENAME COLUMN host_acceptance_rate TO acceptance_rate ;
ALTER TABLE "Host" RENAME COLUMN host_is_superhost TO is_superhost ;
ALTER TABLE "Host" RENAME COLUMN host_thumbnail_url TO thumbnail_url ;
ALTER TABLE "Host" RENAME COLUMN host_picture_url TO picture_url ;
ALTER TABLE "Host" RENAME COLUMN host_neighbourhood TO neighbourhood ;
ALTER TABLE "Host" RENAME COLUMN host_listings_count TO listings_count ;
ALTER TABLE "Host" RENAME COLUMN host_total_listings_count TO total_listings_count ;
ALTER TABLE "Host" RENAME COLUMN host_verifications TO verifications ;
ALTER TABLE "Host" RENAME COLUMN host_has_profile_pic TO has_profile_pic ;
ALTER TABLE "Host" RENAME COLUMN host_identity_verified TO identity_verified ;
ALTER TABLE "Host" RENAME COLUMN calculated_host_listings_count TO calculated_listingsl_count ;

/*delete columns from Listings2 */

ALTER TABLE "Listings2"
DROP COLUMN host_url,DROP COLUMN host_name,DROP COLUMN 
host_since,DROP COLUMN host_location,DROP COLUMN host_about,DROP COLUMN host_response_time,DROP COLUMN host_response_rate,DROP COLUMN 
host_acceptance_rate,DROP COLUMN host_is_superhost,DROP COLUMN host_thumbnail_url,DROP COLUMN 
host_picture_url,DROP COLUMN host_neighbourhood,DROP COLUMN host_listings_count,DROP COLUMN host_total_listings_count,DROP COLUMN host_verifications,DROP COLUMN host_has_profile_pic,DROP COLUMN host_identity_verified,DROP COLUMN 
calculated_host_listings_count;
/* add pk */
ALTER TABLE "Host"
ADD PRIMARY KEY (ID); 
/*add fk */
ALTER TABLE "Host"
ADD FOREIGN KEY (host_id) REFERENCES "Host"(id); 
