-- SQL Queries Documentation for Web Project

-- Select All Products
SELECT * FROM Products;

-- Insert New Product
INSERT INTO Products (Product_ID, Name, Description, Price, Quantity)
VALUES (101, 'New Product', 'This is a new product.', 100.00, 50);

-- Update Existing Product
UPDATE Products
SET Name = 'Updated Product', Description = 'Updated description.', Price = 150.00, Quantity = 40
WHERE Product_ID = 101;

-- Delete a Product
DELETE FROM Products WHERE Product_ID = 101;

-- Search Products by Name
SELECT * FROM Products WHERE Name LIKE '%Product%';

-- Get Total Sales Per Customer
SELECT c.Customer_ID, c.Name, COUNT(o.Order_ID) AS Total_Orders, SUM(o.Total_Price) AS Total_Spent
FROM Customers c
JOIN Orders o ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Name
ORDER BY Total_Spent DESC;

-- Get Product List Sorted by Quantity
SELECT Product_ID, Name, Price, Quantity
FROM Products
ORDER BY Quantity ASC;

-- Get Shipping Status with Customer Info
SELECT c.Name AS Customer_Name, o.Order_ID, o.Order_Date, o.Total_Price, s.Shipping_Company, s.Estimated_Delivery, s.Shipping_Status
FROM Customers c
JOIN Orders o ON c.Customer_ID = o.Customer_ID
JOIN Shipping s ON o.Order_ID = s.Order_ID
WHERE s.Shipping_Status != 'Delivered'
ORDER BY s.Estimated_Delivery ASC;

-- Get Most Popular Products
SELECT p.Product_ID, p.Name, SUM(oi.Quantity) AS Total_Ordered
FROM Products p
JOIN Order_Items oi ON p.Product_ID = oi.Product_ID
GROUP BY p.Product_ID, p.Name
ORDER BY Total_Ordered DESC LIMIT 5;

-- Payment Status Distribution
SELECT Payment_Status, COUNT(*) AS Count
FROM Payments
GROUP BY Payment_Status
ORDER BY Count DESC;
