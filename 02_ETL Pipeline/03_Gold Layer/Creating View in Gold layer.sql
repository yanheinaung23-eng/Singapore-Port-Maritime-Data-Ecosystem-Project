/*
-------------------------------------------------------------------
Create Views for business ready usage : singapore_view
-------------------------------------------------------------------
Script purpose :
1. This script create views business use cases.
2. Created columns : 
    vessel_type         -> Converted AIS code to type of vessels. For eg, General Cargo Vessel.
    week_number         -> Extracted week number from date column.
    direction           -> Converted from COG into directions. For eg, N,NE,...
    navigational_status -> Converted AIS code to navigational status.


Usage : These views can be directly queried in -> AIS > Views
-------------------------------------------------------------------
Author: Yan
*/

IF OBJECT_ID('singapore_view','V') IS NOT NULL
	DROP VIEW singapore_view;

GO
CREATE VIEW singapore_view AS

    SELECT
       [callsign]
      ,[eta_day]
      ,[eta_hour]
      ,[eta_min]
      ,[eta_month]
      ,[imo_number]
      ,[maximum_draught]
      ,[ship_type] AS vessel_code
      , CASE
           WHEN ship_type = 70 THEN 'General Cargo Vessel' 
           WHEN ship_type = 71 THEN 'Cargo Vessel (Hazard A)'
           WHEN ship_type = 72 THEN 'Cargo Vessel (Hazard B)'
           WHEN ship_type = 73 THEN 'Cargo Vessel (Hazard C)'
           WHEN ship_type = 74 THEN 'Cargo Vessel (Hazard D)'
           WHEN ship_type = 75 OR
                ship_type = 76 OR 
                ship_type = 77 OR 
                ship_type = 78 THEN 'Cargo Vessel (Reserved)'
           WHEN ship_type = 79 THEN 'Cargo Vessel (No info)'
           WHEN ship_type = 80 THEN 'General Tanker'
           WHEN ship_type = 81 THEN 'Tanker (Hazard A)'
           WHEN ship_type = 82 THEN 'Tanker (Hazard B)'
           WHEN ship_type = 83 THEN 'Tanker (Hazard C)'
           WHEN ship_type = 84 THEN 'Tanker (Hazard D)'
           WHEN ship_type = 85 OR
                ship_type = 86 OR 
                ship_type = 87 OR 
                ship_type = 88 THEN 'Tanker (Reserved)'
           WHEN ship_type = 89 THEN 'Tanker (No info)'
           ELSE NULL
         END AS vessel_type
      ,[mmsi]
      ,[ship_name]
      ,[geom]
      ,[ship_data_id]
      ,[date]
      ,DATEPART(WEEK , [date]) AS week_number
      ,[cog]
      ,CASE
            WHEN CAST(cog AS DECIMAL(10,2)) >= 337.5 OR CAST(cog AS DECIMAL(10,2)) < 22.5 THEN 'N'
            WHEN CAST(cog AS DECIMAL(10,2)) >= 22.5 AND CAST(cog AS DECIMAL(10,2)) < 67.5 THEN 'NE'
            WHEN CAST(cog AS DECIMAL(10,2)) >= 67.5 AND CAST(cog AS DECIMAL(10,2)) < 112.5 THEN 'E'
            WHEN CAST(cog AS DECIMAL(10,2)) >= 112.5 AND CAST(cog AS DECIMAL(10,2)) < 157.5 THEN 'SE'
            WHEN CAST(cog AS DECIMAL(10,2)) >= 157.5 AND CAST(cog AS DECIMAL(10,2)) < 202.5 THEN 'S'
            WHEN CAST(cog AS DECIMAL(10,2)) >= 202.5 AND CAST(cog AS DECIMAL(10,2)) < 247.5 THEN 'SW'
            WHEN CAST(cog AS DECIMAL(10,2)) >= 247.5 AND CAST(cog AS DECIMAL(10,2)) < 292.5 THEN 'W'
            WHEN CAST(cog AS DECIMAL(10,2)) >= 292.5 AND CAST(cog AS DECIMAL(10,2)) < 337.5 THEN 'NW'
            ELSE NULL
        END AS direction
      ,[latitude]
      ,[longitude]
      ,[navigational_status_code]
      ,CASE 
            WHEN navigational_status_code = 0 THEN 'Under way using engine'
            WHEN navigational_status_code = 1 THEN 'At anchor'
            WHEN navigational_status_code = 2 THEN 'Not under command'
            WHEN navigational_status_code = 3 THEN 'Restricted manoeuvrability'
            WHEN navigational_status_code = 4 THEN 'Constrained by her draught'
            WHEN navigational_status_code = 5 THEN 'Moored'
            WHEN navigational_status_code = 6 THEN 'Aground'
            WHEN navigational_status_code = 7 THEN 'Engaged in fishing'
            WHEN navigational_status_code = 8 THEN 'Under way sailing'
            WHEN navigational_status_code = 9 THEN 'Reserved for future use (HSC)'
            WHEN navigational_status_code = 10 THEN 'Reserved for future use (WIG)'
            WHEN navigational_status_code = 11 THEN 'Power-driven vessel pushing ahead or towing alongside'
            WHEN navigational_status_code = 12 THEN 'Power-driven vessel towing astern'
            WHEN navigational_status_code = 13 THEN 'Reserved for future use'
            WHEN navigational_status_code = 14 THEN 'AIS-SART'
            WHEN navigational_status_code = 15 THEN 'Undefined (default)'
            ELSE 'Unknown Code'
       END AS navigational_status
      ,[rate_of_turn]
      ,[speed]
      ,[true_heading]
    FROM singapore_cleaned;
    GO