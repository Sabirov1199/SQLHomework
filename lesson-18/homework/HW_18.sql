create database class18_homework
use class18_homework

CREATE TABLE Products_Current (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100),
    Price DECIMAL(10,2)
);

CREATE TABLE Products_New (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100),
    Price DECIMAL(10,2)
);

INSERT INTO Products_Current VALUES
(1, 'Laptop', 1200),
(2, 'Tablet', 600),
(3, 'Smartphone', 800);

INSERT INTO Products_New VALUES
(2, 'Tablet Pro', 700),
(3, 'Smartphone', 850),
(4, 'Smartwatch', 300);


CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Department NVARCHAR(50),
    Salary DECIMAL(10,2)
);

CREATE TABLE DepartmentBonus (
    Department NVARCHAR(50) PRIMARY KEY,
    BonusPercentage DECIMAL(5,2)
);

INSERT INTO Employees VALUES
(1, 'John', 'Doe', 'Sales', 5000),
(2, 'Jane', 'Smith', 'Sales', 5200),
(3, 'Mike', 'Brown', 'IT', 6000),
(4, 'Anna', 'Taylor', 'HR', 4500);

INSERT INTO DepartmentBonus VALUES
('Sales', 10),
('IT', 15),
('HR', 8);
--1. Create a stored procedure that : Creates a temp table #EmployeeBonus
Select * from Employees
Select * from DepartmentBonus


create proc spGetEmployeeBonus 
as 
begin 
create table #TempEmployeeBonus (Employeeid int, FullName varchar(100), Department varchar(10), salary decimal(10,2) , BonusAmount decimal (10,2));

insert into #TempEmployeeBonus (EmployeeID, FullName, Department, Salary, BonusAmount)

Select e.Employeeid, concat(e.firstname, ' ', e.lastname) as FullName, e.Department, e.Salary, 
(e.salary*d.BonusPercentage)/100 as BonusAmount
from Employees e
join DepartmentBonus d
on e.Department=d.Department

Select * from #TempEmployeeBonus
End
 Exec spGetEmployeeBonus

 --2. Create a stored procedure that:
--Accepts a department name and an increase percentage as parameters
--Increases salary of all employees in the given department by the given percentage
--Returns updated employees from that department.

create proc spincreasesalarybydep
@Departmentname varchar(100),
@increasepercentage decimal(5,2)
as 
begin 
Update Employees
Set Salary= Salary+(Salary*@increasepercentage/100)
Where Department=@Departmentname;

Select Employeeid,firstname,lastname,Department,Salary
from Employees
where Department=@Departmentname
End 

EXEC  spincreasesalarybydep 'IT', 10;

--3. Perform a MERGE operation that:
--Updates ProductName and Price if ProductID matches
--Inserts new products if ProductID does not exist
--Deletes products from Products_Current if they are missing in Products_New
--Return the final state of Products_Current after the MERGE.

Select * from Products_Current
Select * from Products_New

create proc spmergeproducts
as 
begin 
Merge into Products_Current as target
using Products_New as Source
on target.productid = Source.productid
when matched then
	update set target.productname = source.productname,
	target.Price=source.price
when not matched by Source then
	delete
when not matched by Target then
	insert (ProductID, ProductName, Price) values 
	(source.productid, source.productname,
	source.price);
	Select * from Products_Current
	end
Exec spmergeproducts
--4. Write a solution to report the type of each node in the tree.
Select id,
case
when p_id is null then 'Root'
when id in 
(Select distinct p_id from tree where p_id is not null) then 'Inner'
Else 'Leaf'
end as Type
from Tree

--5. Find the confirmation rate for each user. If a user has no confirmation requests, the rate should be 0.
SELECT 
    s.user_id,
    ROUND(
        CASE 
            WHEN COUNT(c.action) = 0 THEN 0
            ELSE SUM(CASE WHEN c.action = 'confirmed' THEN 1 ELSE 0 END) * 1.0 / COUNT(c.action)
        END
    , 2) AS confirmation_rate
FROM 
    Signups s
LEFT JOIN 
    Confirmations c
ON 
    s.user_id = c.user_id
GROUP BY 
    s.user_id;

--6. Find employees with the lowest salary
CREATE TABLE employees1 (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10,2)
);

INSERT INTO employees1(id, name, salary) VALUES
(1, 'Alice', 50000),
(2, 'Bob', 60000),
(3, 'Charlie', 50000);

Select id, name, salary 
from employees1
where salary=(Select min(salary)from employees1)
--7.

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100),
    Category NVARCHAR(50),
    Price DECIMAL(10,2)
);

-- Sales Table
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    Quantity INT,
    SaleDate DATE
);

INSERT INTO Products (ProductID, ProductName, Category, Price) VALUES
(1, 'Laptop Model A', 'Electronics', 1200),
(2, 'Laptop Model B', 'Electronics', 1500),
(3, 'Tablet Model X', 'Electronics', 600),
(4, 'Tablet Model Y', 'Electronics', 700),
(5, 'Smartphone Alpha', 'Electronics', 800),
(6, 'Smartphone Beta', 'Electronics', 850),
(7, 'Smartwatch Series 1', 'Wearables', 300),
(8, 'Smartwatch Series 2', 'Wearables', 350),
(9, 'Headphones Basic', 'Accessories', 150),
(10, 'Headphones Pro', 'Accessories', 250),
(11, 'Wireless Mouse', 'Accessories', 50),
(12, 'Wireless Keyboard', 'Accessories', 80),
(13, 'Desktop PC Standard', 'Computers', 1000),
(14, 'Desktop PC Gaming', 'Computers', 2000),
(15, 'Monitor 24 inch', 'Displays', 200),
(16, 'Monitor 27 inch', 'Displays', 300),
(17, 'Printer Basic', 'Office', 120),
(18, 'Printer Pro', 'Office', 400),
(19, 'Router Basic', 'Networking', 70),
(20, 'Router Pro', 'Networking', 150);

INSERT INTO Sales (SaleID, ProductID, Quantity, SaleDate) VALUES
(1, 1, 2, '2024-01-15'),
(2, 1, 1, '2024-02-10'),
(3, 1, 3, '2024-03-08'),
(4, 2, 1, '2024-01-22'),
(5, 3, 5, '2024-01-20'),
(6, 5, 2, '2024-02-18'),
(7, 5, 1, '2024-03-25'),
(8, 6, 4, '2024-04-02'),
(9, 7, 2, '2024-01-30'),
(10, 7, 1, '2024-02-25'),
(11, 7, 1, '2024-03-15'),
(12, 9, 8, '2024-01-18'),
(13, 9, 5, '2024-02-20'),
(14, 10, 3, '2024-03-22'),
(15, 11, 2, '2024-02-14'),
(16, 13, 1, '2024-03-10'),
(17, 14, 2, '2024-03-22'),
(18, 15, 5, '2024-02-01'),
(19, 15, 3, '2024-03-11'),
(20, 19, 4, '2024-04-01');

CREATE PROCEDURE GetProductSalesSummary
    @ProductID INT
AS
BEGIN
    SELECT 
        p.ProductName,
        SUM(s.Quantity) AS TotalQuantitySold,
        SUM(s.Quantity * s.Price) AS TotalSalesAmount,
        MIN(s.SaleDate) AS FirstSaleDate,
        MAX(s.SaleDate) AS LastSaleDate
    FROM 
        Products p
    LEFT JOIN 
        Sales s
    ON 
        p.ProductID = s.ProductID
    WHERE 
        p.ProductID = @ProductID
    GROUP BY 
        p.ProductName;
END

Select * from GetProductSalesSummary

