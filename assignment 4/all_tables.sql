/*Copy of Listing2 */
CREATE TABLE "Listing"(LIKE "Listings2" INCLUDING ALL);
INSERT INTO "Listing" SELECT * FROM "Listings2";

/*Copy of Neighbourhoods*/
CREATE TABLE "Neighbourhood"(LIKE "Neighbourhoods" INCLUDING ALL);
INSERT INTO "Neighbourhood" SELECT * FROM "Neighbourhoods";

/*Copy of Reviews*/
CREATE TABLE "Review"(LIKE "Reviews" INCLUDING ALL);
INSERT INTO "Review" SELECT * FROM "Reviews";

/*Copy of ReviewsSummary*/
CREATE TABLE "ReviewSummary"(LIKE "ReviewsSummary" INCLUDING ALL);
INSERT INTO "ReviewSummary" SELECT * FROM "ReviewsSummary";

/*Copy of ListingsSummary*/
CREATE TABLE "ListingSummary"(LIKE "ListingsSummary" INCLUDING ALL);
INSERT INTO "ListingSummary" SELECT * FROM "ListingsSummary";
