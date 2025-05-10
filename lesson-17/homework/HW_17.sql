create database class17_home
use class17_home
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    SaleDate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Products (ProductID, ProductName, Category, Price)
VALUES
(1, 'Samsung Galaxy S23', 'Electronics', 899.99),
(2, 'Apple iPhone 14', 'Electronics', 999.99),
(3, 'Sony WH-1000XM5 Headphones', 'Electronics', 349.99),
(4, 'Dell XPS 13 Laptop', 'Electronics', 1249.99),
(5, 'Organic Eggs (12 pack)', 'Groceries', 3.49),
(6, 'Whole Milk (1 gallon)', 'Groceries', 2.99),
(7, 'Alpen Cereal (500g)', 'Groceries', 4.75),
(8, 'Extra Virgin Olive Oil (1L)', 'Groceries', 8.99),
(9, 'Mens Cotton T-Shirt', 'Clothing', 12.99),
(10, 'Womens Jeans - Blue', 'Clothing', 39.99),
(11, 'Unisex Hoodie - Grey', 'Clothing', 29.99),
(12, 'Running Shoes - Black', 'Clothing', 59.95),
(13, 'Ceramic Dinner Plate Set (6 pcs)', 'Home & Kitchen', 24.99),
(14, 'Electric Kettle - 1.7L', 'Home & Kitchen', 34.90),
(15, 'Non-stick Frying Pan - 28cm', 'Home & Kitchen', 18.50),
(16, 'Atomic Habits - James Clear', 'Books', 15.20),
(17, 'Deep Work - Cal Newport', 'Books', 14.35),
(18, 'Rich Dad Poor Dad - Robert Kiyosaki', 'Books', 11.99),
(19, 'LEGO City Police Set', 'Toys', 49.99),
(20, 'Rubiks Cube 3x3', 'Toys', 7.99);

INSERT INTO Sales (SaleID, ProductID, Quantity, SaleDate)
VALUES
(1, 1, 2, '2025-04-01'),
(2, 1, 1, '2025-04-05'),
(3, 2, 1, '2025-04-10'),
(4, 2, 2, '2025-04-15'),
(5, 3, 3, '2025-04-18'),
(6, 3, 1, '2025-04-20'),
(7, 4, 2, '2025-04-21'),
(8, 5, 10, '2025-04-22'),
(9, 6, 5, '2025-04-01'),
(10, 6, 3, '2025-04-11'),
(11, 10, 2, '2025-04-08'),
(12, 12, 1, '2025-04-12'),
(13, 12, 3, '2025-04-14'),
(14, 19, 2, '2025-04-05'),
(15, 20, 4, '2025-04-19'),
(16, 1, 1, '2025-03-15'),
(17, 2, 1, '2025-03-10'),
(18, 5, 5, '2025-02-20'),
(19, 6, 6, '2025-01-18'),
(20, 10, 1, '2024-12-25'),
(21, 1, 1, '2024-04-20');

Select * from Products
Select * from Sales
--1. Create a temporary table named MonthlySales to store the total quantity sold and total revenue for each product in the current month.
--Return: ProductID, TotalQuantity, TotalRevenue
Select p.ProductID, Sum(Quantity) as TotalQuantity, Sum(price) as TotalRevenue
into #MonthlySales
from Sales s
join Products p 
on p.ProductID=s.productid
where Month(Saledate)=4
group by p.ProductID
 Select * from #MonthlySales
 --2. Create a view named vw_ProductSalesSummary that returns product info along with total sales quantity across all time.
--Return: ProductID, ProductName, Category, TotalQuantitySold
create view  vw_ProductSalesSummary as
Select s.productid,p.ProductName,p.category, Sum(Quantity) as TotalQuantitySold 
from Sales s
join Products p 
on p.productid=s.productid
group by s.ProductID, p.ProductName,p.category

Select * from vw_ProductSalesSummary;
--3.Create a function named fn_GetTotalRevenueForProduct(@ProductID INT)
--Return: total revenue for the given product ID;
create function fn_GetTotalRevenueForProduct (@ProductID INT)
returns table
as 
return
(
Select p.productid, Sum(s.quantity*p.price) TotalRevenue
from sales s
join Products p
on s.ProductID=p.ProductID
where s.ProductID=@ProductID
group by p.productid
)
Select * from fn_GetTotalRevenueForProduct (3)
Select * from Products
--4. Create an function fn_GetSalesByCategory(@Category VARCHAR(50))
--Return: ProductName, TotalQuantity, TotalRevenue for all products in that category.
Create function fn_GetSalesByCategory (@Category VARCHAR(50))
Returns table
as
Return (Select p.ProductName, sum(quantity) TotalQuantity, sum(quantity*price) TotalRevenue from Sales s
Join Products p on s.productID = p.productId
Where category = @category
Group by p.ProductName)
Select * from fn_GetSalesByCategory(Electronics)

--5. 