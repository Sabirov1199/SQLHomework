create database Homework_class21
use Homework_class21

CREATE TABLE ProductSales (
    SaleID INT PRIMARY KEY,
    ProductName VARCHAR(50) NOT NULL,
    SaleDate DATE NOT NULL,
    SaleAmount DECIMAL(10, 2) NOT NULL,
    Quantity INT NOT NULL,
    CustomerID INT NOT NULL
);

INSERT INTO ProductSales (SaleID, ProductName, SaleDate, SaleAmount, Quantity, CustomerID)
VALUES 
(1, 'Product A', '2023-01-01', 150.00, 2, 101),
(2, 'Product B', '2023-01-02', 200.00, 3, 102),
(3, 'Product C', '2023-01-03', 250.00, 1, 103),
(4, 'Product A', '2023-01-04', 150.00, 4, 101),
(5, 'Product B', '2023-01-05', 200.00, 5, 104),
(6, 'Product C', '2023-01-06', 250.00, 2, 105),
(7, 'Product A', '2023-01-07', 150.00, 1, 101),
(8, 'Product B', '2023-01-08', 200.00, 8, 102),
(9, 'Product C', '2023-01-09', 250.00, 7, 106),
(10, 'Product A', '2023-01-10', 150.00, 2, 107),
(11, 'Product B', '2023-01-11', 200.00, 3, 108),
(12, 'Product C', '2023-01-12', 250.00, 1, 109),
(13, 'Product A', '2023-01-13', 150.00, 4, 110),
(14, 'Product B', '2023-01-14', 200.00, 5, 111),
(15, 'Product C', '2023-01-15', 250.00, 2, 112),
(16, 'Product A', '2023-01-16', 150.00, 1, 113),
(17, 'Product B', '2023-01-17', 200.00, 8, 114),
(18, 'Product C', '2023-01-18', 250.00, 7, 115),
(19, 'Product A', '2023-01-19', 150.00, 3, 116),
(20, 'Product B', '2023-01-20', 200.00, 4, 117),
(21, 'Product C', '2023-01-21', 250.00, 2, 118),
(22, 'Product A', '2023-01-22', 150.00, 5, 119),
(23, 'Product B', '2023-01-23', 200.00, 3, 120),
(24, 'Product C', '2023-01-24', 250.00, 1, 121),
(25, 'Product A', '2023-01-25', 150.00, 6, 122),
(26, 'Product B', '2023-01-26', 200.00, 7, 123),
(27, 'Product C', '2023-01-27', 250.00, 3, 124),
(28, 'Product A', '2023-01-28', 150.00, 4, 125),
(29, 'Product B', '2023-01-29', 200.00, 5, 126),
(30, 'Product C', '2023-01-30', 250.00, 2, 127);

Select * from ProductSales

--1. Write a query to assign a row number to each sale based on the SaleDate.
Select *, ROW_NUMBER () over (order by saledate) from ProductSales

--2. Write a query to rank products based on the total quantity sold (use DENSE_RANK())
Select *, DENSE_RANK () over ( order by TotalQuantity desc)as product_rank from 
(
   Select productname, sum(quantity) as TotalQuantity from ProductSales
   group by ProductName
) dr
order by product_rank asc

--3. Write a query to identify the top sale for each customer based on the SaleAmount.
 with Topcustomers as  (
 Select CustomerID, SaleID,SaleAmount, row_number() over (partition by customerid order by saleamount desc) rn  from ProductSales
 ) 
 Select CustomerID, SaleID,SaleAmount from Topcustomers
 where rn=1

 --4.Write a query to display each sale's amount along with the next sale amount in the order of SaleDate using the LEAD() function
Select *, lead(saleamount) over (order by saledate) nextsale from ProductSales

--5.Write a query to display each sale's amount along with the previous sale amount in the order of SaleDate using the LAG() function
Select *, lag(saleamount) over (order by saledate) nextsale from ProductSales
--6.Write a query to rank each sale amount within each product category.
Select saleid,productname, saleamount, rank() over (partition by productname order by saleamount desc) as Salerank from ProductSales
order by ProductName, SaleAmount

--7. Write a query to identify sales amounts that are greater than the previous sale's amount
with cte as (
Select SaleID, SaleDate, SaleAmount, lag(saleamount) over (order by saledate) Prevsale from ProductSales
)
Select * from cte 
where SaleAmount>Prevsale

--8. Write a query to calculate the difference in sale amount from the previous sale for every product
 with cte as (
 Select saleid, productname, saledate, saleamount, lag(saleamount,1,0) over (partition by productname order by saledate) Prevsale 
 from ProductSales
 ), 
 cte1 as ( 
 Select saleid, productname, saledate,prevsale, (SaleAmount-prevsale) as Salesdifference from cte
 )
 Select productname,SaleDate, prevsale, Salesdifference from cte1
order by ProductName

--9.Write a query to compare the current sale amount with the next sale amount in terms of percentage change.
with cte as (
Select saleid, productname, saledate, saleamount, lead(saleamount) over (order by saledate)Nextsale from ProductSales
), cte1 as (
Select saleid, productname, saledate, saleamount,nextsale, (((Nextsale-SaleAmount)*100/SaleAmount)) as Salesdifference from cte 
)
 Select * from cte1
 order by SaleDate

 --10. Write a query to calculate the ratio of the current sale amount to the previous sale amount within the same product.
WITH LaggedSales AS (
    SELECT
        ProductName,
        SaleDate,
        SaleAmount,
        LAG(SaleAmount) OVER (PARTITION BY productname ORDER BY SaleDate) AS PreviousSaleAmount
    FROM
        ProductSales
)
SELECT
    ProductName,
    SaleDate,
    SaleAmount,
    PreviousSaleAmount,
    CASE
        WHEN PreviousSaleAmount = 0 THEN NULL
        ELSE CAST(SaleAmount AS FLOAT) / PreviousSaleAmount
    END AS SaleAmountRatio
FROM
    LaggedSales
ORDER BY
    ProductName,
    SaleDate;

--11.Write a query to calculate the difference in sale amount from the very first sale of that product.
with Productssales as (
Select saleid, productname, saledate, saleamount, rank() over (partition by productname order by saledate)Salerank
from ProductSales
)
, Firstday as (
Select ProductName,
        SaleDate AS FirstSaleDate,
        SaleAmount AS FirstSaleAmount
from Productssales
where Salerank=1
)
, Comparison as (
Select ps.ProductName,
        ps.SaleDate,
        ps.SaleAmount,
        f.FirstSaleAmount,
        ps.SaleAmount - f.FirstSaleAmount AS PriceDifference 
		from Productssales ps join
		Firstday f on ps.ProductName=f.ProductName
)
 Select * from Comparison;

 --12. Write a query to find sales that have been increasing continuously for a product (i.e., each sale amount is greater than the previous sale amount for that product).
with cte as (
Select productname, saledate, saleamount , 
lag(saleamount) over (order by saledate)PreviousSale from ProductSales
)
Select * from cte 
where SaleAmount>PreviousSale

--13.Write a query to calculate a "closing balance" for sales amounts which adds the current sale amount to a running total of previous sales.
with cte as (
Select productname, saledate, saleamount, 
Sum(saleamount) over (order by saledate) Runningtotal
from ProductSales
)
Select productname, saledate, saleamount, (Runningtotal+SaleAmount) as Closingbalance
from cte
--14.Write a query to calculate the moving average of sales amounts over the last 3 sales.

Select *, Avg(saleamount) over (order by saledate rows between 2 preceding and current row)as moving_avg from ProductSales;
--15.Write a query to show the difference between each sale amount and the average sale amount.

with cte as (
Select productname, saledate, saleamount, Avg(saleamount) over (order by saledate) Moving_Average from ProductSales
) 
Select productname, saledate,saleamount, (Moving_Average-Saleamount) Difference_off from cte 
--15. Find Employees Who Have the Same Salary Rank
CREATE TABLE Employees1 (
    EmployeeID   INT PRIMARY KEY,
    Name         VARCHAR(50),
    Department   VARCHAR(50),
    Salary       DECIMAL(10,2),
    HireDate     DATE
);

INSERT INTO Employees1 (EmployeeID, Name, Department, Salary, HireDate) VALUES
(1, 'John Smith', 'IT', 60000.00, '2020-03-15'),
(2, 'Emma Johnson', 'HR', 50000.00, '2019-07-22'),
(3, 'Michael Brown', 'Finance', 75000.00, '2018-11-10'),
(4, 'Olivia Davis', 'Marketing', 55000.00, '2021-01-05'),
(5, 'William Wilson', 'IT', 62000.00, '2022-06-12'),
(6, 'Sophia Martinez', 'Finance', 77000.00, '2017-09-30'),
(7, 'James Anderson', 'HR', 52000.00, '2020-04-18'),
(8, 'Isabella Thomas', 'Marketing', 58000.00, '2019-08-25'),
(9, 'Benjamin Taylor', 'IT', 64000.00, '2021-11-17'),
(10, 'Charlotte Lee', 'Finance', 80000.00, '2016-05-09'),
(11, 'Ethan Harris', 'IT', 63000.00, '2023-02-14'),
(12, 'Mia Clark', 'HR', 53000.00, '2022-09-05'),
(13, 'Alexander Lewis', 'Finance', 78000.00, '2015-12-20'),
(14, 'Amelia Walker', 'Marketing', 57000.00, '2020-07-28'),
(15, 'Daniel Hall', 'IT', 61000.00, '2018-10-13'),
(16, 'Harper Allen', 'Finance', 79000.00, '2017-03-22'),
(17, 'Matthew Young', 'HR', 54000.00, '2021-06-30'),
(18, 'Ava King', 'Marketing', 56000.00, '2019-04-16'),
(19, 'Lucas Wright', 'IT', 65000.00, '2022-12-01'),
(20, 'Evelyn Scott', 'Finance', 81000.00, '2016-08-07');

Select * from Employees1;

--15. Find Employees Who Have the Same Salary Rank
 with cte as (
 Select EmployeeID,Name, Department, Salary, Hiredate, rank() over (order by salary desc) as  SalaryRank from Employees1
 ) 
 Select * from cte c 
 join Employees1 e 
 on e.EmployeeID=c.EmployeeID
 join cte c2 
 on c.SalaryRank=c2.SalaryRank and c.EmployeeID<c2.EmployeeID
 join Employees1 e2 on c2.EmployeeID=e2.EmployeeID

 --16. Identify the Top 2 Highest Salaries in Each Department 
 with cte as (
 Select *, dense_rank() over (partition by department order by salary desc) as Salaryrank
 from Employees1
 )
 Select * from cte 
 where Salaryrank=1 or Salaryrank=2
 --17. Find the Lowest-Paid Employee in Each Department
 with cte as (
 Select *, dense_rank() over (partition by department order by salary asc) as Salaryrank
 from Employees1
 )
 Select * from cte 
 where Salaryrank=1
 --18. Calculate the Running Total of Salaries in Each Department

 Select *, sum(salary) over (partition by department order by salary)TotalSalary 
 from Employees1
 --19. Find the Total Salary of Each Department Without GROUP BY

 Select *, sum(salary) over (partition by department) as Total_Salary
 from Employees1

 --20.Calculate the Average Salary in Each Department Without GROUP BY

 Select *, Avg(salary) over (partition by department) as Average_Salary
 from Employees1;
--21. Find the Difference Between an Employee’s Salary and Their Department’s Average
With cte as (
Select employeeid, Name, Department, Salary, Hiredate, Avg(salary) over (partition by department) as Average_Salary
 from Employees1
 )
 Select employeeid, Name, Department,Hiredate, Salary,Average_Salary , (Salary-Average_Salary) as Difference_
 from cte

 --22. Calculate the Moving Average Salary Over 3 Employees (Including Current, Previous, and Next)
 Select *, Avg(salary) over (order by hiredate rows between 2 preceding and current row)as moving_avg from Employees1;

 --23.Find the Sum of Salaries for the Last 3 Hired Employees

 Select *, Sum(salary) over (order by hiredate desc rows between current row and 2 following) as Sum_Salary
 from Employees1
 order by HireDate desc



