/* 1st bullet */
SELECT id, street, neighbourhood, neighbourhood_cleansed, city, state, zipcode, market, smart_location, country_code, country, latitude, longitude, is_location_exact INTO "Location" FROM "Listings2";

ALTER TABLE "Location" RENAME COLUMN id TO listing_id;


/* 3rd bullet*/
ALTER TABLE "Location" ADD FOREIGN KEY (listing_id) REFERENCES "Listings2"(id);
ALTER TABLE "Location" ADD PRIMARY KEY (listing_id);

/* 2st and 4 bullet */
ALTER TABLE "Listings2" DROP latitude;
ALTER TABLE "Listings2" DROP longitude;
ALTER TABLE "Listings2" DROP street;
ALTER TABLE "Listings2" DROP neighbourhood;
ALTER TABLE "Listings2" DROP neighbourhood_cleansed;
ALTER TABLE "Listings2" DROP city;
ALTER TABLE "Listings2" DROP state;
ALTER TABLE "Listings2" DROP zipcode;
ALTER TABLE "Listings2" DROP market;
ALTER TABLE "Listings2" DROP smart_location;
ALTER TABLE "Listings2" DROP country_code;
ALTER TABLE "Listings2" DROP country;
ALTER TABLE "Listings2" DROP is_location_exact;

/* 5 bullet */

/* Its in ERM and no in sql */
