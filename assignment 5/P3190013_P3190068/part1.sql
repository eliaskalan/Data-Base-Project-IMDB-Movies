create table Amenity as(
select distinct 
regexp_split_to_table(
	replace(
		replace(
			replace(
				"Room".amenities,'}',''
			),'{',''
		),'"',''
	),','
) 
as amenity_name from "Room")

DELETE FROM Amenity
WHERE amenity_name='';

create table "RoomAmenities" as(
	select listing_id, amenity_id from "RoomCopy", "Amenity"
where amenity_name in (select unnest(string_to_array(Replace(Replace(Replace(amenities,'"',''),'{',''),'}',''),',')) 
                           FROM "RoomCopy" )
);

Alter table "RoomAmenities" ADD PRIMARY KEY (listing_id,amenity_id);
Alter table "RoomAmenities" ADD FOREIGN KEY(listing_id) REFERENCES "Room"(listing_id);
Alter table "RoomAmenities" ADD FOREIGN KEY(amenity_id) REFERENCES "Amenity"(amenity_id);
Alter table "RoomCopy" DROP COLUMN amenities;

