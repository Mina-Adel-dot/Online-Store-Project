-- Online Store Database SQL Script

-- Drop tables if they exist (for clean reinstall)
DROP TABLE IF EXISTS Shipping;
DROP TABLE IF EXISTS Payments;
DROP TABLE IF EXISTS Order_Items;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Customers;

-- Create Customers table
CREATE TABLE Customers (
    Customer_ID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Address VARCHAR(255),
    Phone VARCHAR(20)
);

-- Create Products table
CREATE TABLE Products (
    Product_ID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Description TEXT,
    Size VARCHAR(20),
    Color VARCHAR(30),
    Price DECIMAL(10, 2) NOT NULL,
    Quantity INT DEFAULT 0
);

-- Create Orders table
CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY,
    Customer_ID INT NOT NULL,
    Order_Date DATETIME DEFAULT CURRENT_TIMESTAMP,
    Status VARCHAR(50) DEFAULT 'Pending',
    Total_Price DECIMAL(10, 2) DEFAULT 0.00,
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);

-- Create Order_Items table (junction table between Orders and Products)
CREATE TABLE Order_Items (
    Order_ID INT,
    Product_ID INT,
    Quantity INT DEFAULT 1,
    Subtotal DECIMAL(10, 2),
    PRIMARY KEY (Order_ID, Product_ID),
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID)
);

-- Create Payments table
CREATE TABLE Payments (
    Payment_ID INT PRIMARY KEY,
    Order_ID INT UNIQUE,
    Payment_Method VARCHAR(50) NOT NULL,
    Payment_Status VARCHAR(50) DEFAULT 'Pending',
    Transaction_Details VARCHAR(255),
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID)
);

-- Create Shipping table
CREATE TABLE Shipping (
    Shipping_ID INT PRIMARY KEY,
    Order_ID INT UNIQUE,
    Shipping_Company VARCHAR(100),
    Estimated_Delivery DATE,
    Shipping_Status VARCHAR(50) DEFAULT 'Processing',
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID)
);

-- Insert data into Customers table
INSERT INTO Customers VALUES
(1, 'أحمد محمد', 'ahmed@example.com', 'القاهرة، مصر', '01012345678'),
(2, 'سارة علي', 'sara@example.com', 'الإسكندرية، مصر', '01123456789'),
(3, 'محمود خالد', 'mahmoud@example.com', 'الجيزة، مصر', '01234567890'),
(4, 'فاطمة أحمد', 'fatima@example.com', 'المنصورة، مصر', '01145678901'),
(5, 'خالد علي', 'khaled@example.com', 'أسيوط، مصر', '01056789012'),
(6, 'نور محمد', 'nour@example.com', 'طنطا، مصر', '01167890123'),
(7, 'حسن إبراهيم', 'hassan@example.com', 'الغردقة، مصر', '01278901234'),
(8, 'مريم سامي', 'mariam@example.com', 'شرم الشيخ، مصر', '01389012345'),
(9, 'عمر عادل', 'omar@example.com', 'بورسعيد، مصر', '01490123456'),
(10, 'ياسمين كريم', 'yasmin@example.com', 'الفيوم، مصر', '01501234567');

-- Insert data into Products table
INSERT INTO Products VALUES
(1, 'قميص قطني', 'قميص قطني بأكمام طويلة', 'L', 'أزرق', 299.99, 50),
(2, 'بنطلون جينز', 'بنطلون جينز كلاسيكي', 'M', 'أسود', 349.99, 30),
(3, 'حذاء رياضي', 'حذاء رياضي مريح للجري', '42', 'أبيض', 499.99, 25),
(4, 'ساعة يد', 'ساعة يد أنيقة مقاومة للماء', 'واحد', 'فضي', 799.99, 15),
(5, 'حقيبة ظهر', 'حقيبة ظهر عملية للرحلات', 'كبير', 'أخضر', 249.99, 20),
(6, 'سماعات لاسلكية', 'سماعات بلوتوث عالية الجودة', 'واحد', 'أسود', 599.99, 10),
(7, 'تيشيرت قطني', 'تيشيرت قطني بتصميم بسيط', 'XL', 'رمادي', 199.99, 40),
(8, 'شنطة يد نسائية', 'شنطة يد نسائية أنيقة', 'متوسط', 'بني', 449.99, 12),
(9, 'عطر رجالي', 'عطر رجالي فاخر', '100ml', 'N/A', 899.99, 8),
(10, 'نظارة شمسية', 'نظارة شمسية بإطار معدني', 'واحد', 'ذهبي', 399.99, 18);

-- Insert data into Orders table
INSERT INTO Orders VALUES
(1, 1, '2025-01-15 10:30:00', 'Delivered', 899.98),
(2, 3, '2025-01-20 14:45:00', 'Shipped', 499.99),
(3, 2, '2025-01-25 09:15:00', 'Processing', 649.98),
(4, 5, '2025-02-01 16:20:00', 'Delivered', 1199.98),
(5, 4, '2025-02-10 11:05:00', 'Pending', 449.99),
(6, 7, '2025-02-15 13:30:00', 'Shipped', 799.99),
(7, 6, '2025-02-20 15:45:00', 'Processing', 599.99),
(8, 9, '2025-03-01 10:10:00', 'Delivered', 899.99),
(9, 8, '2025-03-05 12:25:00', 'Pending', 649.98),
(10, 10, '2025-03-10 14:50:00', 'Processing', 349.99);

-- Insert data into Order_Items table
INSERT INTO Order_Items VALUES
(1, 1, 2, 599.98),
(1, 5, 1, 249.99),
(2, 3, 1, 499.99),
(3, 2, 1, 349.99),
(3, 7, 1, 199.99),
(4, 4, 1, 799.99),
(4, 10, 1, 399.99),
(5, 8, 1, 449.99),
(6, 4, 1, 799.99),
(7, 6, 1, 599.99),
(8, 9, 1, 899.99),
(9, 2, 1, 349.99),
(9, 5, 1, 249.99),
(10, 2, 1, 349.99);

-- Insert data into Payments table
INSERT INTO Payments VALUES
(1, 1, 'Credit Card', 'Completed', 'Transaction #TRX12345'),
(2, 2, 'PayPal', 'Completed', 'Transaction #PP67890'),
(3, 3, 'Cash on Delivery', 'Pending', NULL),
(4, 4, 'Credit Card', 'Completed', 'Transaction #TRX23456'),
(5, 5, 'Fawry', 'Pending', NULL),
(6, 6, 'Credit Card', 'Completed', 'Transaction #TRX34567'),
(7, 7, 'PayPal', 'Processing', 'Transaction #PP78901'),
(8, 8, 'Credit Card', 'Completed', 'Transaction #TRX45678'),
(9, 9, 'Cash on Delivery', 'Pending', NULL),
(10, 10, 'Fawry', 'Processing', 'Transaction #FW12345');

-- Insert data into Shipping table
INSERT INTO Shipping VALUES
(1, 1, 'Express Delivery', '2025-01-18', 'Delivered'),
(2, 2, 'Standard Shipping', '2025-01-27', 'In Transit'),
(3, 3, 'Express Delivery', '2025-01-30', 'Preparing'),
(4, 4, 'Standard Shipping', '2025-02-08', 'Delivered'),
(5, 5, 'Express Delivery', '2025-02-15', 'Pending'),
(6, 6, 'Standard Shipping', '2025-02-25', 'In Transit'),
(7, 7, 'Express Delivery', '2025-02-23', 'Preparing'),
(8, 8, 'Standard Shipping', '2025-03-10', 'Delivered'),
(9, 9, 'Express Delivery', '2025-03-10', 'Pending'),
(10, 10, 'Standard Shipping', '2025-03-20', 'Preparing');

-- Create Users with appropriate permissions
-- Admin user with full privileges
CREATE USER IF NOT EXISTS 'store_admin'@'localhost' IDENTIFIED BY 'admin_password';
GRANT ALL PRIVILEGES ON online_store.* TO 'store_admin'@'localhost';

-- Customer service user with limited privileges
CREATE USER IF NOT EXISTS 'customer_service'@'localhost' IDENTIFIED BY 'cs_password';
GRANT SELECT ON online_store.Customers TO 'customer_service'@'localhost';
GRANT SELECT ON online_store.Orders TO 'customer_service'@'localhost';
GRANT SELECT ON online_store.Shipping TO 'customer_service'@'localhost';

-- Inventory manager with product management privileges
CREATE USER IF NOT EXISTS 'inventory_manager'@'localhost' IDENTIFIED BY 'inv_password';
GRANT SELECT, INSERT, UPDATE ON online_store.Products TO 'inventory_manager'@'localhost';

FLUSH PRIVILEGES;

-- ------------------------------------
-- Important Queries for the Website
-- ------------------------------------

-- 1. Search products by name or description (contains text search)
SELECT * FROM Products 
WHERE Name LIKE '%قطني%' OR Description LIKE '%قطني%';

-- 2. Get customer order history with total spent (aggregate function)
SELECT c.Customer_ID, c.Name, COUNT(o.Order_ID) AS Total_Orders, 
       SUM(o.Total_Price) AS Total_Spent
FROM Customers c
JOIN Orders o ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Name
ORDER BY Total_Spent DESC;

-- 3. Get products sorted by quantity available (ascending order)
SELECT Product_ID, Name, Price, Quantity
FROM Products
ORDER BY Quantity ASC;

-- 4. Get order details with product information
SELECT o.Order_ID, o.Order_Date, p.Name AS Product_Name, 
       oi.Quantity, oi.Subtotal
FROM Orders o
JOIN Order_Items oi ON o.Order_ID = oi.Order_ID
JOIN Products p ON oi.Product_ID = p.Product_ID
WHERE o.Order_ID = 1;

-- 5. Get shipping status with customer and order information
SELECT c.Name AS Customer_Name, o.Order_ID, o.Order_Date, 
       o.Total_Price, s.Shipping_Company, s.Estimated_Delivery, 
       s.Shipping_Status
FROM Customers c
JOIN Orders o ON c.Customer_ID = o.Customer_ID
JOIN Shipping s ON o.Order_ID = s.Order_ID
WHERE s.Shipping_Status != 'Delivered'
ORDER BY s.Estimated_Delivery ASC;

-- 6. Extra: Find most popular products (based on order quantity)
SELECT p.Product_ID, p.Name, SUM(oi.Quantity) AS Total_Ordered
FROM Products p
JOIN Order_Items oi ON p.Product_ID = oi.Product_ID
GROUP BY p.Product_ID, p.Name
ORDER BY Total_Ordered DESC
LIMIT 5;

-- 7. Extra: Get payment status distribution
SELECT Payment_Status, COUNT(*) AS Count
FROM Payments
GROUP BY Payment_Status
ORDER BY Count DESC;
