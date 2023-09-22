/*1a*/

/*I delete procedure */

/* the above is done */
CREATE OR REPLACE FUNCTION increase_listings_count_by_one()
  RETURNS trigger AS
$$
BEGIN       
 	Update "Host" 
	set  listings_count = listings_count + 1, 
	total_listings_count = total_listings_count + 1, 
	calculated_listingsl_count = calculated_listingsl_count + 1
	where New.host_id = "Host".id;
	RETURN null;
END;
$$
LANGUAGE 'plpgsql';

CREATE TRIGGER update_host_listings_count_insert 
AFTER 
INSERT ON "Listing"
FOR ROW
EXECUTE FUNCTION increase_listings_count_by_one();

CREATE OR REPLACE FUNCTION dicrease_listings_count_by_one()
  RETURNS trigger AS
$$
BEGIN       
 	Update "Host" 
	set  listings_count = listings_count - 1, 
	total_listings_count = total_listings_count - 1, 
	calculated_listingsl_count = calculated_listingsl_count - 1
	where New.host_id = "Host".id;
	RETURN null;
END;
$$
LANGUAGE 'plpgsql';

CREATE TRIGGER update_host_listings_count_delete 
BEFORE  
DELETE ON "Listing"
FOR ROW
EXECUTE FUNCTION dicrease_listings_count_by_one();


/*1b (ours)*/
CREATE OR REPLACE FUNCTION update_avg_price()
  RETURNS trigger AS
$$
BEGIN       
 	Update "Price" 
	set  price = (Select AVG (price) from "Calendar2"
	where old.listing_id= "Calendar2".listing_id)::numeric(10,0);
	RETURN null;
END;
$$
LANGUAGE 'plpgsql';

CREATE TRIGGER update_price 
AFTER 
UPDATE OF price ON "Calendar2" 
FOR EACH ROW
EXECUTE FUNCTION update_avg_price();


