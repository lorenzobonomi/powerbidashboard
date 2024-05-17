-- Quarter calendar view for retention
DROP VIEW IF EXISTS quartersForRetention;
CREATE VIEW quartersForRetention AS 

WITH quarters AS (

	SELECT
		DISTINCT(FirstDayOfQuarter) AS Quarter,
		ROW_NUMBER() OVER (ORDER BY FirstDayOfQuarter ASC) AS RankQuarter
	
	FROM
		main.calendar
		
	WHERE
		DateSelected <= DATE_TRUNC('quarter', CURRENT_DATE)
	
	GROUP BY
		FirstDayOfQuarter 
),

quartersForRetention AS (

	SELECT
		quarters.Quarter,
		quarters1.quarter AS QuarterMinus1,
		quarters2.quarter AS QuarterMinus2,
		quarters3.quarter AS QuarterMinus3,
		quarters.RankQuarter
	
	FROM
		quarters
		
	LEFT JOIN
		quarters AS quarters1
	ON
		quarters.RankQuarter = quarters1.RankQuarter + 1
	
	LEFT JOIN
		quarters AS quarters2
	ON
		quarters.RankQuarter = quarters2.RankQuarter + 2
		
	LEFT JOIN
		quarters AS quarters3
	ON
		quarters.RankQuarter = quarters3.RankQuarter + 3
		

)

SELECT * 

FROM 
	quartersForRetention
	
ORDER BY 
	rankQuarter
