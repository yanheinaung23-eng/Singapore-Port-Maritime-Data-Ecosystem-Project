/*
---------------------------------------------------------------
Creating table singapore_cleaned.
---------------------------------------------------------------
Script purpose :
1. Created layer to drop table which enable to re-run the script without error.
2. Created table with same number of columns as an original data source.

---------------------------------------------------------------
Author - Yan
*/

IF OBJECT_ID('singapore_cleaned','U') IS NOT NULL
DROP TABLE singapore_cleaned;
CREATE TABLE singapore_cleaned(
callsign VARCHAR(50),
eta_day INT,
eta_hour INT,
eta_min INT,
eta_month INT,
imo_number VARCHAR(50),
maximum_draught DECIMAL(10,2),
ship_type VARCHAR(50),
mmsi VARCHAR(50),
ship_name VARCHAR(50),
geom VARCHAR(200),
ship_data_id VARCHAR(50),
[date] DATE,
cog VARCHAR(20),
latitude VARCHAR(50),
longitude VARCHAR(50),
navigational_status_code VARCHAR(20),
rate_of_turn VARCHAR(50),
speed DECIMAL(10,2),
true_heading VARCHAR(50)
);