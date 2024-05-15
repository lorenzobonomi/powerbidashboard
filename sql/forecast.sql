DROP TABLE forecast;

CREATE TABLE forecast (
	
	quarter VARCHAR,
	valueQuantity INTEGER,
	valueRevenue INTEGER,
	valueUnitPrice FLOAT

);


INSERT INTO forecast (quarter, valueQuantity, valueRevenue, valueUnitPrice) VALUES

('Q4 2022', 320000, 5000000, 2.5), 
('Q1 2023', 1080000, 7000000, 2.8),
('Q2 2023', 1200000, 8000000, 4.5),
('Q3 2023', 1300000, 5500000, 3.5),
('Q4 2023', 1600000, 5500000, 4.2)