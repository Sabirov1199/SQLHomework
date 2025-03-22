--1
BULK INSERT is a command in SQL Server that allows you to efficiently import large volumes of data from a file (such as a .csv or .txt) into a table. It is faster than multiple INSERT statements because it processes data in bulk.
--2
CSV (Comma-Separated Values)
TXT (Text File)
XML (Extensible Markup Language
Excel (XLS/XLSX)
--3
CREATE TABLE Products (
    ProductID INT PRIMARY KEY, 
    ProductName VARCHAR(50) NOT NULL, 
    Price DECIMAL(10,2) NOT NULL
);
--4
INSERT INTO Products VALUES 
    (1, 'Laptop', 799.99), 
    (2, 'Smartphone', 499.50), 
    (3, 'Headphones', 99.99);

--5
NULL means "unknown" (not empty or zero).

NOT NULL ensures data integrity (mandatory field).

Use IS NULL or IS NOT NULL to filter NULL values.

Aggregate functions like COUNT(*) count NULL, but COUNT(column_name) ignores them.
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY, 
    Name VARCHAR(50) NOT NULL,  -- Cannot be NULL
    Email VARCHAR(100) NULL  -- Can be NULL (optional field)
);
--6

ALTER TABLE Products  
ADD CONSTRAINT UQ_ProductName UNIQUE (ProductName);
--7
ALTER TABLE Products → Modifies the existing Products table.

ADD CONSTRAINT UQ_ProductName UNIQUE (ProductName) →

Prevents duplicate product names in the table.

If you try to insert a duplicate ProductName, SQL Server will throw an error.
--8
CREATE TABLE Categories (CategoryID INT PRIMARY KEY,CategoryName VARCHAR(100) UNIQUE)
--9
The IDENTITY column in SQL Server is used to generate auto-incrementing numeric values for a column, usually for primary keys.
--10
BULK INSERT Products  
FROM 'C:\Data\products.txt'  -- Change path as needed
WITH (
    FORMAT = 'CSV',  -- Specifies the format
    FIELDTERMINATOR = ',',  -- Columns are separated by commas
    ROWTERMINATOR = '\n',  -- Each row is a new line
    FIRSTROW = 1,  -- Start from the first row
    TABLOCK  -- Improves performance by locking the table
);
--11
ALTER TABLE Products  
ADD CONSTRAINT FK_Products_Categories  
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID);

--12
PRIMARY KEY = Always unique, cannot be NULL, only one per table.

UNIQUE KEY = Ensures uniqueness, but allows NULL, multiple per table.

PRIMARY KEY is best for identifying records, while UNIQUE KEY is best for enforcing data integrity (like unique emails)
CREATE TABLE Users (
    UserID INT PRIMARY KEY,      -- Must be unique, cannot be NULL
    Email VARCHAR(100) UNIQUE,   -- Must be unique, but can be NULL
    Username VARCHAR(50) UNIQUE  -- Must be unique, but can be NULL
);
--13
ALTER TABLE Products  
ADD CONSTRAINT CHK_Price CHECK (Price > 0);
--14

ALTER TABLE Products  
ADD Stock INT NOT NULL DEFAULT 0;

--15
SELECT ProductID, ProductName,  
       ISNULL(Stock, 0) AS StockValue  
FROM Products;
--16
A FOREIGN KEY constraint is used to enforce referential integrity between two tables. It ensures that a value in a column (child table) must exist in another column (parent table). This prevents orphan records and maintains data consistency.
--17
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    Age INT NOT NULL,
    Email VARCHAR(255) UNIQUE,
    CONSTRAINT CHK_Customers_Age CHECK (Age >= 18)
);
--18
Create table test(id int identity (100,10),name varchar(20),surname varchar(20))
--19
CREATE TABLE OrderDetails (OrderID INT,ProductID INT,Quantity INT,Price DECIMAL(10,2),CONSTRAINT PK_OrderDetails PRIMARY KEY (OrderID, ProductID))
--20
ISNULL() – Replaces NULL with a Single Value
SELECT CustomerID, CustomerName, ISNULL(Email, 'noemail@example.com') AS Email  
FROM Customers;
 COALESCE() – Returns the First Non-NULL Value
 SELECT EmployeeID, COALESCE(FirstName, LastName, 'Unknown') AS FullName  
FROM Employees;
--21
CREATE TABLE Employees ( EmpID INT PRIMARY KEY, Email VARCHAR(100) UNIQUE)

--22
CREATE TABLE Orders ( OrderID INT PRIMARY KEY, CustomerID INT,
    OrderDate DATE,
    CONSTRAINT FK_Customer FOREIGN KEY (CustomerID)
    REFERENCES Customers(CustomerID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
















Write a script to create a Customers table with a CHECK constraint ensuring Age >= 18.
Create a table with an IDENTITY column starting at 100 and incrementing by 10.
Write a query to create a composite PRIMARY KEY in a new table OrderDetails.
Explain with examples the use of COALESCE and ISNULL functions for handling NULL values.
Create a table Employees with both PRIMARY KEY on EmpID and UNIQUE KEY on Email.
Write a query to create a FOREIGN KEY with ON DELETE CASCADE and ON UPDATE CASCADE options.