/* 1st bullet */
SELECT id, price, weekly_price, monthly_price, security_deposit, cleaning_fee, guests_included, extra_people, 
minimum_nights, maximum_nights, minimum_minimum_nights, maximum_minimum_nights, minimum_maximum_nights, 
maximum_maximum_nights, minimum_nights_avg_ntm, maximum_nights_avg_ntm INTO "Price" FROM "Listings2";

ALTER TABLE "Price" RENAME COLUMN id TO listing_id;

/* 2nd bullet */
ALTER TABLE "Price" ALTER COLUMN price TYPE decimal
ALTER TABLE "Price" ALTER COLUMN weekly_price TYPE decimal
ALTER TABLE "Price" ALTER COLUMN monthly_price TYPE decimal

UPDATE "Price" SET security_deposit = REPLACE(security_deposit, '$', '');
UPDATE "Price" SET security_deposit = REPLACE(security_deposit, ',', '');
ALTER TABLE "Price" ALTER COLUMN security_deposit type decimal USING security_deposit::numeric

UPDATE "Price" SET cleaning_fee = REPLACE(cleaning_fee, '$', '');
UPDATE "Price" SET cleaning_fee = REPLACE(cleaning_fee, ',', '');
ALTER TABLE "Price" ALTER COLUMN cleaning_fee type decimal USING cleaning_fee::numeric;

UPDATE "Price" SET extra_people = REPLACE(extra_people, '$', '');
UPDATE "Price" SET extra_people = REPLACE(extra_people, ',', '');
ALTER TABLE "Price" ALTER COLUMN extra_people type decimal USING extra_people::numeric;

/*3rd bullet*/


/* 4rd bullet */
ALTER TABLE "Price" ADD FOREIGN KEY (listing_id) REFERENCES "Listings2"(id);
ALTER TABLE "Price" ADD PRIMARY KEY (listing_id);

/*3 and 5 bullet*/
/*NOTE: Columns price,weekly_price,monthly_price,security_deposit have been already dropped from room table.sql commands but there are here for completion purposes*/
ALTER TABLE "Listings2" DROP price, 
ALTER TABLE "Listings2" DROP weekly_price;
ALTER TABLE "Listings2" DROP monthly_price;
ALTER TABLE "Listings2" DROP security_deposit;
ALTER TABLE "Listings2" DROP cleaning_fee;
ALTER TABLE "Listings2" DROP guests_included;
ALTER TABLE "Listings2" DROP extra_people;
ALTER TABLE "Listings2" DROP minimum_nights;
ALTER TABLE "Listings2" DROP maximum_nights;
ALTER TABLE "Listings2" DROP minimum_minimum_nights;
ALTER TABLE "Listings2" DROP maximum_minimum_nights;
ALTER TABLE "Listings2" DROP minimum_nights_avg_ntm;
ALTER TABLE "Listings2" DROP maximum_nights_avg_ntm;

