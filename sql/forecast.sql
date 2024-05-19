DROP TABLE forecast;

CREATE TABLE forecast (
	
	quarter VARCHAR,
	valueQuantity INTEGER,
	valueRevenue INTEGER,
	valueUnitPrice FLOAT

);


INSERT INTO forecast (quarter, valueQuantity, valueRevenue, valueUnitPrice) VALUES

('Q4 2022', 320000, 1000000, 3.7), 
('Q1 2023', 1080000, 2000000, 3.6),
('Q2 2023', 1200000, 3000000, 4.1),
('Q3 2023', 1300000, 1500000, 3.8),
('Q4 2023', 1600000, 2500000, 3.9)


