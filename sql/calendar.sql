-- Calendar view
DROP VIEW IF EXISTS calendar;

CREATE VIEW calendar AS 
	
WITH RECURSIVE datesSelection AS (

	SELECT
		'2022-12-01'::DATE AS DateSelected
		
	UNION ALL
	
	SELECT
		DateSelected + 1 FROM datesSelection
		
	WHERE 
		DateSelected + 1 <= '2024-12-31'
),

dateSelectionCalendar AS (

	SELECT
		DateSelected,
		DateSelected - 373 AS DateSelectedForJoin,
		DATE_PART('dow', DateSelected) AS DayOfWeekNumber,
		DAYNAME(DateSelected) AS DayOfWeekName,
		DATE_PART('week', DateSelected) AS WeekNumber,
		DATE_PART('month', DateSelected) AS Month,
		LEFT(MONTHNAME(DateSelected), 3) AS MonthName,
		DATE_PART('quarter', DateSelected) AS Quarter,
		DATE_PART('year', DateSelected) AS Year,
		CONCAT('Q', DATE_PART('quarter', DateSelected), ' ' , DATE_PART('year', DateSelected)) AS QuarterYear,
		DateSelected - CURRENT_DATE AS RelativeDate,
		
		CASE 
	    	WHEN DATE_PART('week', DateSelected) = DATE_PART('week', CURRENT_DATE) AND DATE_PART('year', DateSelected) = DATE_PART('year', CURRENT_DATE) THEN 0
	        ELSE (DATE_PART('week', DateSelected) - DATE_PART('week', CURRENT_DATE)) + (DATE_PART('year', DateSelected) - DATE_PART('year', CURRENT_DATE)) * 52
	  	END AS RelativeWeek,
		
		CASE 
	    	WHEN DATE_PART('month', DateSelected) = DATE_PART('month', CURRENT_DATE) AND DATE_PART('year', DateSelected) = DATE_PART('year', CURRENT_DATE) THEN 0
	        ELSE (DATE_PART('month', DateSelected) - DATE_PART('month', CURRENT_DATE)) + (DATE_PART('year', DateSelected) - DATE_PART('year', CURRENT_DATE)) * 12
	  	END AS RelativeMonth,

	    CASE 
	    	WHEN DATE_PART('quarter', DateSelected) = DATE_PART('quarter', CURRENT_DATE) AND DATE_PART('year', DateSelected) = DATE_PART('year', CURRENT_DATE) THEN 0
	        ELSE (DATE_PART('quarter', DateSelected) - DATE_PART('quarter', CURRENT_DATE)) + (DATE_PART('year', DateSelected) - DATE_PART('year', CURRENT_DATE)) * 4 
	  	END AS RelativeQuarter
	  	
	  	
		
		
	FROM
		datesSelection

)


SELECT * FROM  dateSelectionCalendar

