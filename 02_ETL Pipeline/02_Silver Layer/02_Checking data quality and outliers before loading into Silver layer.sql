/*
---------------------------------------------------------------
Cleaning and validing data.

Please see the doc file to view detailed data cleaning log

---------------------------------------------------------------
Author - Yan
*/

SELECT *
FROM singapore;

-----------------------------------------------------
-- Checking duplicates

SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY ship_data_id, callsign, eta_day, imo_number, ship_type, mmsi, geom 
               ORDER BY ship_name
           ) AS flag_last
    FROM singapore
) t
WHERE flag_last > 1;

-----------------------------------------------------
-- Checking null values in unique identifiers

SELECT *
FROM singapore
WHERE callsign IS NULL OR 
imo_number IS NULL OR
mmsi IS NULL;

-----------------------------------------------------
-- Checking null values in ETA

SELECT COUNT(*)
FROM singapore
WHERE eta_day IS NULL 
OR eta_hour IS NULL
OR eta_min IS NULL
OR eta_month IS NULL;

------------------------------------------------------
-- Checking outliers in ETA

SELECT COUNT(*)
FROM singapore
WHERE                   
    eta_day > 31         -- Days must be 0-31
    OR eta_month > 12;   -- Month must be 0-12

SELECT COUNT(*)
FROM singapore
WHERE                   
    eta_hour >= 24      -- Hours must be 0-23
    OR eta_min >= 60;   -- Minutes must be 0-59

------------------------------------------------------
-- Checking outliers in maximum_draught

SELECT MAX(maximum_draught), MIN(maximum_draught)
FROM singapore;

SELECT COUNT(*)
FROM singapore
WHERE maximum_draught > 23;

------------------------------------------------------
-- Checking for null values and outliers in ship type

SELECT DISTINCT ship_type
FROM singapore;

------------------------------------------------------
-- Checking nulls for ship names

SELECT *
FROM singapore
WHERE ship_name IS NULL;

------------------------------------------------------
-- Checking date column.

SELECT MAX([date]), MIN([date])
FROM singapore;

SELECT *
FROM singapore
WHERE [date] IS NULL;

------------------------------------------------------
-- Checking COG nulls and outliers greater than 360 degree.

SELECT *
FROM singapore 
WHERE CAST(cog AS DECIMAL(10,2)) > 360 OR cog IS NULL;

------------------------------------------------------
-- Checking lat, long

SELECT *
FROM singapore
WHERE ROUND(latitude,0) > 2 OR ROUND(longitude,0) > 110 OR latitude IS NULL OR longitude IS NULL;

------------------------------------------------------
-- Checking ROT

SELECT MAX(CAST(rate_of_turn AS DECIMAL(10,2))), MIN(CAST(rate_of_turn AS DECIMAL(10,2)))
FROM singapore;

SELECT rate_of_turn
FROM singapore 
WHERE rate_of_turn IS NULL;

------------------------------------------------------
-- Checking true heading.

SELECT COUNT(*)
FROM singapore
WHERE CAST(true_heading AS DECIMAL(10,2)) > 360;

------------------------------------------------------
-- Checking speed

SELECT MAX(speed), MIN(speed)
FROM singapore;

SELECT *
FROM singapore 
WHERE speed > 60;

SELECT *
FROM singapore 
WHERE speed IS NULL;