-- Retention
DROP VIEW IF EXISTS customersRetention;
CREATE VIEW customersRetention AS 

WITH salesDataWithQuarter AS (

	SELECT
		CustomerID,
		DateSelected,
		FirstDayOfQuarter
	
	FROM
		main.SalesData
	
	LEFT JOIN
		main.calendar
	ON
		main.salesData.InvoiceDate = main.calendar.DateSelectedForJoin
	
	WHERE
		CustomerID IS NOT NULL
),

retention AS (

	SELECT
		DISTINCT(CustomerID) AS CustomerID,
		Quarter,
		CASE
			WHEN EndPeriod = 1 AND EndPeriodBefore = 0 THEN 1
			ELSE 0
		END AS New,
		CASE
			WHEN EndPeriod = 1 AND BeginPeriod = 0 AND EndPeriodBefore = 1 THEN 1
			ELSE 0
		END AS Returning,
		CASE
			WHEN EndPeriod = 1 AND BeginPeriod = 1 THEN 1
			ELSE 0
		END AS Retained,
		CASE
			WHEN EndPeriod = 1 THEN 1
			ELSE 0
		END Active
		
	FROM (
		
		SELECT
			CustomerID,
			Quarter,
			MAX(BeginPeriod) AS BeginPeriod,
			MAX(EndPeriod) AS EndPeriod,
			MAX(EndPeriodBefore) AS EndPeriodBefore
			
		FROM (
		
			SELECT
				CustomerID,
				DateSelected,
				Quarter,
				QuarterMinus1,
				QuarterMinus2,
				QuarterMinus3,
				CASE
					WHEN DateSelected >= QuarterMinus2 AND DateSelected < QuarterMinus1 THEN 1
					ELSE 0
				END AS BeginPeriod,
				CASE
					WHEN DateSelected >= QuarterMinus1 AND DateSelected < Quarter THEN 1
					ELSE 0
				END AS EndPeriod,
				CASE
					WHEN DateSelected < QuarterMinus1 THEN 1
					ELSE 0
				END AS EndPeriodBefore

			FROM
				salesDataWithQuarter
			
			CROSS JOIN
				main.quartersForRetention
				
		) subQuery1
		
		GROUP BY
		
			CustomerID,
			Quarter
	
	) subQuery2
	
)

SELECT * FROM retention
