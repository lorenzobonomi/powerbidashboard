DROP VIEW IF EXISTS salesDataforPrediction;
CREATE VIEW salesDataforPrediction AS     
    
SELECT 
        DateSelected AS ds, 
        SUM(Quantity) AS y
    FROM 
        main.salesData 
    LEFT JOIN 
        main.calendar 
    ON 
        main.salesData.InvoiceDate = main.calendar.DateSelectedForJoin 
    GROUP BY 
        calendar.DateSelected
        
 
       