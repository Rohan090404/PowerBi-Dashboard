create database sales;
use sales;
CREATE TABLE Sales_Transactions (
    Transaction_ID INT PRIMARY KEY,
    Transaction_Date DATE,
    Customer_ID INT,
    Product_ID INT,
    Store_ID INT,
    Quantity INT,
    Unit_Price DECIMAL(10,2),
    Discount_Percent DECIMAL(5,2),
    Payment_Method VARCHAR(20),
    Salesperson_ID INT,
    Region VARCHAR(50)
);

INSERT INTO Sales_Transactions VALUES
(1001, '2025-10-01', 201, 501, 301, 3, 250.00, 5.00, 'Credit Card', 101, 'North'),
(1002, '2025-10-02', 202, 502, 302, 1, 1200.00, 0.00, 'Cash', 102, 'South'),
(1003, '2025-10-02', 203, 501, 301, 2, 250.00, 10.00, 'UPI', 101, 'North'),
(1004, '2025-10-03', 204, 503, 303, 5, 150.00, 0.00, 'Credit Card', 103, 'East'),
(1005, '2025-10-04', 205, 504, 304, 1, 500.00, 5.00, 'Cash', 104, 'West'),
(1006, '2025-10-04', 201, 502, 302, 2, 1200.00, 0.00, 'UPI', 102, 'South'),
(1007, '2025-10-05', 206, 505, 303, 4, 180.00, 0.00, 'Credit Card', 103, 'East'),
(1008, '2025-10-05', 207, 504, 304, 3, 500.00, 10.00, 'UPI', 104, 'West');


# 1] Display all records from the table.
select * from Sales_Transactions;

# 2] List all transactions made using payment method 'UPI'
select * from sales_transactions
where payment_method = 'UPI';

# 3] Show distinct regions where sales have been made
select distinct region from sales_transactions;

# 4] Find transactions that have a discount greater than 5%
select * from sales_transactions
where discount_percent > 5;

# 5] Display Transaction_ID, Quantity, Unit_Price, and Total_Sale_Amount (Quantity × Unit_Price)
select transaction_id,quantity,unit_price,(quantity*unit_price) as total_sales
from sales_transactions;

# 6] Find all transactions done by salesperson with ID 101
select * from sales_transactions
where salesperson_id = 101;

# 7] Show transactions where Quantity ≥ 3
select * from sales_transactions
where quantity > 3;

# 8] Find transactions where the Unit Price is greater than the average Unit Price
select * from sales_transactions
where unit_price > (select avg(unit_price) from sales_transactions);

# 9] Find customers_id who made more than one purchase
SELECT Customer_ID 
FROM Sales_Transactions
GROUP BY Customer_ID
HAVING COUNT(*) > 1;

# 10] Find the total quantity sold for each product.
select product_id,sum(quantity) from sales_transactions
group by product_id;

# 11] Delete transactions that happened before ‘2025-10-02’.
delete from sales_transactions
where transaction_date < ‘2025-10-02’;

# ------------------------ Joins -------------------------------

-- Create Customers table
CREATE TABLE Customers (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100),
    City VARCHAR(50),
    Region VARCHAR(50),
    Contact_Number VARCHAR(15)
);

INSERT INTO Customers VALUES
(1, 'Rohan Sharma', 'Delhi', 'North', '9876543210'),
(2, 'Priya Patel', 'Mumbai', 'West', '9898989898'),
(3, 'Amit Verma', 'Bangalore', 'South', '9789789789'),
(4, 'Neha Singh', 'Kolkata', 'East', '9765432109'),
(5, 'Vikram Rao', 'Pune', 'West', '9988776655');


-- Create Products table
CREATE TABLE Products (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(100),
    Category VARCHAR(50),
    Unit_Price DECIMAL(10,2),
    Stock INT
);

INSERT INTO Products VALUES
(501, 'Laptop', 'North', 55000.00, 20),
(502, 'Mobile', 'West', 30000.00, 50),
(503, 'Tablet', 'South', 20000.00, 30),
(504, 'Smartwatch', 'West', 15000.00, 25),
(505, 'Headphones', 'East', 5000.00, 100);

# 1] List customer names along with product names where region and category match.
select c.customer_name,c.region,p.product_name,p.category from customers c
inner join products p on c.region = p.category;

# 2] Show all customers, even if there’s no matching product category.
SELECT c.Customer_Name,c.Region,p.Product_Name FROM Customers c
LEFT JOIN Products p ON c.Region = p.Category;

#3] Find customers and products from the same region, and show only top 3 by price.
SELECT c.Customer_Name,p.Product_Name,p.Unit_Price FROM Customers c
JOIN Products p ON c.Region = p.Category
ORDER BY p.Unit_Price DESC
LIMIT 3;

#4] Show all customer–product combinations sorted by product price (highest to lowest).
SELECT c.Customer_Name,p.Product_Name,p.Unit_Price FROM Customers c
cross join Products p
ORDER BY p.Unit_Price DESC;




