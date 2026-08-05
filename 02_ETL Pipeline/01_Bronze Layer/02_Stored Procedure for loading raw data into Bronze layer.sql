/*
-----------------------------------------------------
Stored Procedure : Inserting data into singapre

To run : EXEC load_singapore
-----------------------------------------------------
Script purpose :
1. Created layer to truncate the table for dropping old data automatically.
2. Used BULK INSERT Method to load fresh data into singapore table.
3. Used TABLOCK to lock on the entire table rather than locking individual rows for better performance.
4. Created CATCH for handling errors while loading.

-----------------------------------------------------
Author - Yan
*/

CREATE OR ALTER PROCEDURE load_singapore AS
BEGIN

	BEGIN TRY
		PRINT '------------------------';
		PRINT '>> Truncating and Inserting data from source';
		PRINT '------------------------';

		TRUNCATE TABLE singapore;
		BULK INSERT singapore
		FROM 'E:\Projects\Singapore port project\Singapore.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
	END TRY
	BEGIN CATCH
		PRINT '------------------------';
		PRINT 'Error occurred while loading data into singapore : ' + ERROR_MESSAGE();
		PRINT '------------------------';
	END CATCH;
END
