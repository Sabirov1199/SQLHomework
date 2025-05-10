--Creating database for practice_16

Create database practice_16
Use practice_16

-- Puzzle 1
-- inserting table
CREATE TABLE Grouped
(
  Product  VARCHAR(100) PRIMARY KEY,
  Quantity INTEGER NOT NULL
);
Select * from Grouped;

INSERT INTO Grouped (Product, Quantity) VALUES
('Pencil',3),('Eraser',4),('Notebook',2);

Select * from Grouped;

-- Answer: 
With degroup as
(Select Product, Quantity as qty from Grouped
Union all
Select Product, qty - 1 from degroup where qty - 1 > 0)
Select product, 1 Quantity from degroup
Order by product desc;

-- Puzzle 2
-- Inserting table
CREATE TABLE #RegionSales
(
  Region      VARCHAR(100),
  Distributor VARCHAR(100),
  Sales       INTEGER NOT NULL,
  PRIMARY KEY (Region, Distributor)
);
Select * from #RegionSales

INSERT INTO #RegionSales (Region, Distributor, Sales) VALUES
('North','ACE',10),
('South','ACE',67),
('East','ACE',54),
('North','ACME',65),
('South','ACME',9),
('East','ACME',1),
('West','ACME',7),
('North','Direct Parts',8),
('South','Direct Parts',7),
('West','Direct Parts',12);

Select * from #RegionSales;

-- Answer: 
With allregions as
(Select distinct region from #RegionSales),
Alldistributors as 
(Select distinct distributor from #RegionSales)
Select allregions.region, Alldistributors.distributor, isnull(sales, 0) Sales from allregions 
Cross join alldistributors 
Left join #RegionSales on allregions.region = #RegionSales.region and Alldistributors.distributor = #RegionSales.distributor

-- Puzzle 3
-- Inserting table

CREATE TABLE Employee (
  id INT,
  name VARCHAR(255),
  department VARCHAR(255),
  managerId INT
);

Select * from Employee

INSERT INTO Employee VALUES
(101, 'John', 'A', NULL),
(102, 'Dan', 'A', 101),
(103, 'James', 'A', 101),
(104, 'Amy', 'A', 101),
(105, 'Anne', 'A', 101),
(106, 'Ron', 'B', 101);

Select * from Employee

-- Answer:
Select e1.name from Employee e1
Join Employee e2 on e1.id = e2.managerid
Group by e1.id, e1.name
Having count(e2.managerid) >= 5;

-- Puzzle 4
-- Inserting table

CREATE TABLE Products (
  product_id INT,
  product_name VARCHAR(40),
  product_category VARCHAR(40)
);
Select * from Products

CREATE TABLE Orders (
  product_id INT,
  order_date DATE,
  unit INT
);
Select * from Orders

INSERT INTO Products VALUES
(1, 'Leetcode Solutions', 'Book'),
(2, 'Jewels of Stringology', 'Book'),
(3, 'HP', 'Laptop'),
(4, 'Lenovo', 'Laptop'),
(5, 'Leetcode Kit', 'T-shirt');
Select * from Products

INSERT INTO Orders VALUES
(1, '2020-02-05', 60),
(1, '2020-02-10', 70),
(2, '2020-01-18', 30),
(2, '2020-02-11', 80),
(3, '2020-02-17', 2),
(3, '2020-02-24', 3),
(4, '2020-03-01', 20),
(4, '2020-03-04', 30),
(4, '2020-03-04', 60),
(5, '2020-02-25', 50),
(5, '2020-02-27', 50),
(5, '2020-03-01', 50);
Select * from Orders

Select * from Products
Select * from Orders

-- Answer:
Select product_name, sum(unit) unit from Products p
Join Orders o on p.product_id = o.product_id
Where month(order_date) = '02' and year(order_date) = '2020'
Group by product_name
Having sum(unit) >= 100;

-- Puzzle 5
-- Inserting table
--DROP TABLE IF EXISTS Orders;
DROP TABLE Orders

CREATE TABLE Orders (
  OrderID     INT PRIMARY KEY,
  CustomerID  INT NOT NULL,
  [Count]     MONEY NOT NULL,
  Vendor      VARCHAR(100) NOT NULL
);
Select * from Orders

INSERT INTO Orders VALUES
(1, 1001, 12, 'Direct Parts'),
(2, 1001, 54, 'Direct Parts'),
(3, 1001, 32, 'ACME'),
(4, 2002, 7, 'ACME'),
(5, 2002, 16, 'ACME'),
(6, 2002, 5, 'Direct Parts');

Select * from Orders

-- Answer:
Select top 2 customerid, vendor from Orders
Group by customerid, vendor
Order by count(vendor) desc

-- Puzzle 6

-- Puzzle 7
CREATE TABLE Device (
  Device_id INT,
  Locations VARCHAR(25)
);
Select * from Device

INSERT INTO Device VALUES
(12, 'Bangalore'),
(12, 'Bangalore'),
(12, 'Bangalore'),
(12, 'Bangalore'),
(12, 'Hosur'),
(12, 'Hosur'),
(13, 'Hyderabad'),
(13, 'Hyderabad'),
(13, 'Secunderabad'),
(13, 'Secunderabad'),
(13, 'Secunderabad');

Select * from Device

-- Answer:
Select d.Device_id, count(distinct d.locations) no_of_location,
(Select top 1 Locations from Device 
Where Device_id = d.Device_id 
Group by Locations 
Order by count(locations) desc) max_signal_location, count(locations) no_of_signals from Device d 
Group by d.Device_id;

-- Puzzle 8
-- Inserting table
--DROP TABLE IF EXISTS Employee;
DROP TABLE Employee;

CREATE TABLE Employee (
  EmpID INT,
  EmpName VARCHAR(30),
  Salary FLOAT,
  DeptID INT
);
Select * from Employee

INSERT INTO Employee VALUES
(1001, 'Mark', 60000, 2),
(1002, 'Antony', 40000, 2),
(1003, 'Andrew', 15000, 1),
(1004, 'Peter', 35000, 1),
(1005, 'John', 55000, 1),
(1006, 'Albert', 25000, 3),
(1007, 'Donald', 35000, 3);

Select * from Employee

-- Answer: 
Select EmpID, EmpName, Salary from Employee e1
Where Salary > (Select avg(Salary) from Employee e2
Where e1.DeptID = e2.DeptID);

-- Puzzle 9
-- Inserting table 

-- Winning Numbers
CREATE TABLE WinningNumbers (Number INT);
INSERT INTO WinningNumbers VALUES (25), (45), (78);
 Select * from WinningNumbers

-- Tickets
CREATE TABLE Tickets (TicketID VARCHAR(10), Number INT);
INSERT INTO Tickets VALUES
('A23423', 25),
('A23423', 45),
('A23423', 78),
('B35643', 25),
('B35643', 45),
('B35643', 98),
('C98787', 67),
('C98787', 86),
('C98787', 91);
  Select * from Tickets


 Select * from WinningNumbers
 Select * from Tickets;

 -- Answer: 

With won as
(Select ticketid, count(t.number) NoWon from tickets t join  WinningNumbers w on t.number = w.number
Group by ticketid),
Prize as
(Select ticketid,
Case
When NoWon = 3 then 100
When NoWon > 0 then 10
Else 0
End Prizes From won)
Select sum(prizes) TotalWinning from prize

-- Puzzle 10

