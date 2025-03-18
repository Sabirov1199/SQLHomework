Create database Class2
--1
Create table Employees (EmpID int,name varchar(50),salary decimal(10,2))
select * from employees
--2
insert into Employees values(1,'Ali',1000)
insert into Employees values (2,'VAli',1100),(3,'Bek',1200)

insert into Employees (EmpID,name,salary)
select 4,'Bekzod',2200 union all
Select 5,'sherBek',3200 union all
select 6,'Bek',4200
--3
Update  Employees
SET Salary = 3000  
WHERE EmpID = 1;
--4
Delete Employees
where EmpID=2
--5
Delete Employees
where EmpID=3

Truncate table employees --delete informations in the table

Drop table Employees --delete table itself
--6
alter table employees
Alter column name varchar (100)
--7
alter table employees
add Department varchar (50)
--8
alter table employees
alter column Salary Float
--9
create table departments (DepartmentID INT PRIMARY KEY, DepartmentName VARCHAR(50))
--10
Truncate table employees
Drop table departments
--11
select * from employees

Select * into Departments from employees
select * from Departments
--12
update Departments
set department='Management'
where Salary>500
--13
Truncate table Departments
--14
Alter table employees
drop column Department
--15

--16
Drop table Departments
--17
create table Product(ProductID int Primary Key,ProductName Varchar (50),Category varchar(30),Price Decimal)
--18

ALTER TABLE Product
ADD CONSTRAINT Check_Price Check (Price>0)

select * from Product
--19
Alter table Product
add StockQuantity int default 50
--20
Alter table product

--21
INSERT INTO Product (ProductID, ProductName,Category, Price, StockQuantity)  
VALUES  
  (101, 'Laptop', 'Electronics', 1200, 10),  
  (102, 'Smartphone', 'Electronics', 800, 20),  
  (103, 'Headphones', 'Accessories', 150, 30),  
  (104, 'Desk Chair', 'Furniture', 250, 15),  
  (105, 'Backpack', 'Travel', 70, 50);
  --22
select * into Products_Backup  
from Product
--23 i did it in Object explorer

--24
Alter table  Inventory
alter column price Float
