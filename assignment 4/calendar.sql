/*make exact copy of "Calendar"*/
CREATE TABLE "Calendar2"(LIKE "Calendar" INCLUDING ALL);
INSERT INTO "Calendar2" SELECT * FROM "Calendar";

/*change columns price,adjusted_price type to decimal */
ALTER TABLE "Calendar2" ALTER COLUMN price TYPE decimal
ALTER TABLE "Calendar2" ALTER COLUMN adjusted_price TYPE decimal 
/* Column available is already boolean from 2nd assignment */
