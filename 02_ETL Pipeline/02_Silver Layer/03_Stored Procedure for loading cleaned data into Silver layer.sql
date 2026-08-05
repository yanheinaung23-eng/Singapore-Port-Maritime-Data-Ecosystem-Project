/*
---------------------------------------------------------------
Creating stored procedure for loading cleaned data : load_singapore_cleaned

To run : EXEC load_singapore_cleaned
---------------------------------------------------------------
Script purpose :
1. Created layer to truncate the table for dropping old data automatically.
2. Load cleaned data from singapore table.
3. Created CATCH for handling errors while loading.

---------------------------------------------------------------
Author - Yan
*/


CREATE OR ALTER PROCEDURE load_singapore_cleaned AS
BEGIN
	BEGIN TRY
	PRINT '------------------------';
	PRINT '>> Truncating singapore_cleaned table';
	PRINT '------------------------';
	TRUNCATE TABLE singapore_cleaned;
	PRINT '>> Inserting cleaned data into table';
	PRINT '------------------------';
	INSERT INTO singapore_cleaned(
	callsign,
	eta_day,
	eta_hour,
	eta_min,
	eta_month,
	imo_number,
	maximum_draught,
	ship_type,
	mmsi,
	ship_name,
	geom,
	ship_data_id,
	[date],
	cog,
	latitude,
	longitude,
	navigational_status_code,
	rate_of_turn,
	speed,
	true_heading
	)

	SELECT
		callsign,
		eta_day,
		CASE
			WHEN eta_hour >= 24 THEN NULL
			ELSE eta_hour 
		END AS eta_hour,
		CASE 
			WHEN eta_min >= 60 THEN NULL
			ELSE eta_min
		END AS eta_min,
		eta_month,
		imo_number,
		maximum_draught,
		ship_type,
		mmsi,
		ship_name,
		geom,
		ship_data_id,
		[date],
		cog,
		latitude,
		longitude,
		navigational_status_code,
		rate_of_turn,
		CASE 
			WHEN speed > 60 THEN NULL
			ELSE speed
		END AS speed,
		CASE 
			WHEN true_heading > 360 THEN NULL
			ELSE true_heading 
		END AS true_heading
	FROM singapore
	WHERE eta_day < 32 AND eta_month < 13;
	
	END TRY
	BEGIN CATCH
		PRINT '----------------------------';
		PRINT 'Error while loading cleaned data into singapore_cleaned : ' + ERROR_MESSAGE();
		PRINT '----------------------------';
	END CATCH
END












