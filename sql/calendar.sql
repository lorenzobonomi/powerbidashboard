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
		-- Filed to adjust for the old data in the sales dataset
		DateSelected - 4383 AS DateSelectedForJoin,
		DATE_PART('dow', DateSelected) AS DayOfWeekNumber,
		DAYNAME(DateSelected) AS DayOfWeekName,
		DATE_PART('week', DateSelected) AS WeekNumber,
		DATE_PART('month', DateSelected) AS Month,
		LEFT(MONTHNAME(DateSelected), 3) AS MonthName,
		DATE_PART('quarter', DateSelected) AS Quarter,
		DATE_PART('year', DateSelected) AS Year,
		CONCAT(LEFT(MONTHNAME(DateSelected), 3), ' ' , DATE_PART('year', DateSelected)) AS MonthYear,
		CONCAT('Q', DATE_PART('quarter', DateSelected), ' ' , DATE_PART('year', DateSelected)) AS QuarterYear,
		DATE_TRUNC('month', DateSelected) AS FirstDayOfMonth,
		DATE_TRUNC('quarter', DateSelected) AS FirstDayOfQuarter,
		DateSelected - CURRENT_DATE AS RelativeDate,
		DATE_DIFF('week', CURRENT_DATE, DateSelected) AS RelativeWeek,
		DATE_DIFF('month', CURRENT_DATE, DateSelected) AS RelativeMonth,
	  	DATE_DIFF('quarter', CURRENT_DATE, DateSelected) AS RelativeQuarter
	  	
	FROM
		datesSelection

)

SELECT * FROM  dateSelectionCalendar




