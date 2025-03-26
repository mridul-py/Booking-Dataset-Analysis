
-- Query 1: Select all records from the `omnify` table
SELECT * FROM omnify;

-- Query 2: Count total rows in the `omnify` table
SELECT COUNT(*) AS Total_Rows FROM omnify;

-- Query 2: Count distinct booking types
SELECT COUNT(DISTINCT Booking_Type) AS Unique_Booking_Types
FROM omnify;

-- Query 3: Find the earliest and latest booking dates
SELECT MIN(Booking_Date) AS Earliest_Booking, MAX(Booking_Date) AS Latest_Booking
FROM omnify;

-- Query 4: Retrieve pending bookings with Price > 100 and a specific date range
SELECT Booking_ID, Customer_Name, Price
FROM omnify
WHERE Status = 'Pending' 
  AND Price > 100 
  AND Booking_Date BETWEEN '2025-05-01' AND '2025-06-30';

-- Query 5: Calculate price including 18% tax for all bookings
SELECT Booking_ID, Customer_Name, Price, Price * 1.18 AS Price_With_Tax
FROM omnify;

-- Query 6: Rank bookings by price (highest first)
SELECT Booking_ID, Customer_Name, Price,
       RANK() OVER (ORDER BY Price DESC) AS Price_Rank
FROM omnify;

-- Query 7: Calculate average price and total bookings by booking type
SELECT Booking_Type, AVG(Price) AS Avg_Price, COUNT(*) AS Total_Bookings
FROM omnify
GROUP BY Booking_Type
ORDER BY Avg_Price DESC;

-- Query 8: Identify bookings with invalid price or missing duration
SELECT *
FROM omnify
WHERE Price <= 0 OR `Duration (mins)` IS NULL;

-- Query 9: Determine the booking type with the maximum price
SELECT Booking_Type, MAX(Price) AS Max_Price
FROM omnify
WHERE Price = (SELECT MAX(Price) FROM omnify);

-- Query 10: Calculate days remaining until booking date for future bookings
SELECT Booking_ID, Customer_Name,
       DATEDIFF(Booking_Date, NOW()) AS Days_Until_Booking
FROM omnify
WHERE DATEDIFF(Booking_Date, NOW()) > 0
LIMIT 0, 50000;

-- Query 11: Categorize bookings into price ranges
SELECT Booking_ID, Customer_Name,
       CASE 
           WHEN Price < 100 THEN 'Low'
           WHEN Price BETWEEN 100 AND 200 THEN 'Medium'
           ELSE 'High'
       END AS Price_Category
FROM omnify;
-- Query 12: View Creation
CREATE VIEW High_Value_Bookings AS
SELECT Booking_ID, Customer_Name, Price 
FROM omnify
WHERE Price > 200; 
