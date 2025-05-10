create database homework_class23
use homework_class23

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    Product VARCHAR(50),
    Category VARCHAR(50),
    QuantitySold INT,
    UnitPrice DECIMAL(10,2),
    SaleDate DATE,
    Region VARCHAR(50),
    CustomerID INT
);

INSERT INTO Sales (Product, Category, QuantitySold, UnitPrice, SaleDate, Region, CustomerID)
VALUES
('Laptop', 'Electronics', 10, 800.00, '2024-01-01', 'North', 1),
('Smartphone', 'Electronics', 15, 500.00, '2024-01-02', 'North', 2),
('Tablet', 'Electronics', 8, 300.00, '2024-01-03', 'East', 3),
('Headphones', 'Electronics', 25, 100.00, '2024-01-04', 'West', 4),
('TV', 'Electronics', 5, 1200.00, '2024-01-05', 'South', 5),
('Refrigerator', 'Appliances', 3, 1500.00, '2024-01-06', 'South', 6),
('Microwave', 'Appliances', 7, 200.00, '2024-01-07', 'East', 7),
('Washing Machine', 'Appliances', 4, 1000.00, '2024-01-08', 'North', 8),
('Oven', 'Appliances', 6, 700.00, '2024-01-09', 'West', 9),
('Smartwatch', 'Electronics', 12, 250.00, '2024-01-10', 'East', 10),
('Vacuum Cleaner', 'Appliances', 5, 400.00, '2024-01-11', 'South', 1),
('Gaming Console', 'Electronics', 9, 450.00, '2024-01-12', 'North', 2),
('Monitor', 'Electronics', 14, 300.00, '2024-01-13', 'West', 3),
('Keyboard', 'Electronics', 20, 50.00, '2024-01-14', 'South', 4),
('Mouse', 'Electronics', 30, 25.00, '2024-01-15', 'East', 5),
('Blender', 'Appliances', 10, 150.00, '2024-01-16', 'North', 6),
('Fan', 'Appliances', 12, 75.00, '2024-01-17', 'South', 7),
('Heater', 'Appliances', 8, 120.00, '2024-01-18', 'East', 8),
('Air Conditioner', 'Appliances', 2, 2000.00, '2024-01-19', 'West', 9),
('Camera', 'Electronics', 7, 900.00, '2024-01-20', 'North', 10);

--7.What is the total revenue generated from all sales?
Select Sum(unitprice*quantitysold) Totalrevenue from Sales
--8.What is the average unit price of products?
Select * from Sales
Select avg(unitprice) from sales 
--9. How many sales transactions were recorded?
Select count(*) from sales 
--10.What is the highest number of units sold in a single transaction?
Select max(unitprice) from sales 
--11.How many products were sold in each category?
Select category, count (product) #of_products from sales 
group by Category
--12. What is the total revenue for each region?
Select region, Sum(unitprice* QuantitySold) TotalRevenue from sales 
group by Region
--13.Which product generated the highest total revenue?

Select distinct top 1 product, sum(unitprice*quantitysold)totalrevenue from Sales
group by Product
order by totalrevenue desc
--14. Compute the running total of revenue ordered by sale date.
Select quantitysold, unitprice, (quantitysold*unitprice) totalrevenue,
sum(quantitysold*unitprice) over (order by saledate) as Runningtotal
from sales 
--15. How much does each category contribute to total sales revenue?
Select quantitysold, unitprice,category, (quantitysold*unitprice) totalrevenue,
sum(quantitysold*unitprice) over (partition by category order by saledate) as Runningtotal
from sales 

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName VARCHAR(100),
    Region VARCHAR(50),
    JoinDate DATE
);
INSERT INTO Customers (CustomerName, Region, JoinDate)
VALUES
('John Doe', 'North', '2022-03-01'),
('Jane Smith', 'West', '2023-06-15'),
('Emily Davis', 'East', '2021-11-20'),
('Michael Brown', 'South', '2023-01-10'),
('Sarah Wilson', 'North', '2022-07-25'),
('David Martinez', 'East', '2023-04-30'),
('Laura Johnson', 'West', '2022-09-14'),
('Kevin Anderson', 'South', '2021-12-05'),
('Sophia Moore', 'North', '2023-02-17'),
('Daniel Garcia', 'East', '2022-08-22');

Select * from Customers
--17. Show all sales along with the corresponding customer names
    Select c.CustomerName, s.QuantitySold, s.UnitPrice from sales s
	join Customers c
	on c.CustomerID=s.CustomerID
--18. List customers who have not made any purchases
Select * from Customers c 
left join  sales s 
on s.CustomerID=c.CustomerID
where saleid is null 
--19. Compute total revenue generated from each customer
Select c.CustomerName, SUM(unitprice*quantitysold)Totalrevenue from sales s
join Customers c
on s.CustomerID=c.CustomerID
group by c.CustomerName
order by Totalrevenue desc
--20.Find the customer who has contributed the most revenue

Select top 1 c.CustomerName, SUM(unitprice*quantitysold)Totalrevenue from sales s
join Customers c
on s.CustomerID=c.CustomerID
group by c.CustomerName
order by Totalrevenue desc
--21. Calculate the total sales per customer
Select c.customerid, c.customername, Sum(unitprice*quantitysold) Totalrevenue
from Customers c
join sales s 
on s.CustomerID=c.CustomerID
group by c.CustomerID, c.CustomerName
order by Totalrevenue desc ;

CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName VARCHAR(50),
    Category VARCHAR(50),
    CostPrice DECIMAL(10,2),
    SellingPrice DECIMAL(10,2)
);
INSERT INTO Products (ProductName, Category, CostPrice, SellingPrice)
VALUES
('Laptop', 'Electronics', 600.00, 800.00),
('Smartphone', 'Electronics', 350.00, 500.00),
('Tablet', 'Electronics', 200.00, 300.00),
('Headphones', 'Electronics', 50.00, 100.00),
('TV', 'Electronics', 900.00, 1200.00),
('Refrigerator', 'Appliances', 1100.00, 1500.00),
('Microwave', 'Appliances', 120.00, 200.00),
('Washing Machine', 'Appliances', 700.00, 1000.00),
('Oven', 'Appliances', 500.00, 700.00),
('Gaming Console', 'Electronics', 320.00, 450.00);

Select * from Products
--22. List all products that have been sold at least once
Select ProductName from Products
group by ProductName
having count(productname)>1
--23. Find the most expensive product in the Products table
Select top 1 productname, max(costprice) from Products
group by ProductName
--24. Find all products where the selling price is higher than the average selling price in their category
 Select * from Products;

 with cte as (
 Select productid, productname, category, sellingprice, Avg(sellingprice) over (partition by category) Average_price
 from Products
 )
 Select * from cte
 where sellingprice > Average_price 

