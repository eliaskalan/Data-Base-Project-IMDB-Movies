/* create Room  */
create table "Room" as (
select distinct "Listings2".id,"Listings2".accommodates,
"Listings2".bathrooms,"Listings2".bedrooms,"Listings2".beds,
"Listings2".bed_type,"Listings2".amenities,"Listings2".square_feet,
"Listings2".price,"Listings2".weekly_price,"Listings2".monthly_price,
"Listings2".security_deposit from "Listings2" )
/* rename columns */
ALTER TABLE "Room" RENAME COLUMN id TO listing_id ;
/*delete columns from Listings2 */
ALTER TABLE "Listings2"
DROP COLUMN accommodates,DROP COLUMN bathrooms,
DROP COLUMN bedrooms,DROP COLUMN beds,
DROP COLUMN bed_type,DROP COLUMN amenities,
DROP COLUMN square_feet,DROP COLUMN price,
DROP COLUMN weekly_price,
DROP COLUMN monthly_price,
DROP COLUMN security_deposit;
/* add pk */
ALTER TABLE "Room"
ADD PRIMARY KEY (ID);
/*add fk */
Alter table "Room"
add FOREIGN KEY (id) REFERENCES "Listings2"
