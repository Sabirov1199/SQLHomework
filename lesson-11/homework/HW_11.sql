--1
Select OrderID, firstname, orderdate
from Customers c
join Orders o
on c.CustomerID=o.CustomerID
And YEAR(OrderDate) > 2022
--2
Select e.name, d.departmentname 
from Employees e
join Departments d
on d.DepartmentID=e.DepartmentID
And DepartmentName='Sales' or DepartmentName='Marketing'
--3
Select distinct Departmentname, Name as TopEmployee, Max(Salary) as Maxsalary
from Employees e
join Departments d 
on e.DepartmentID=d.DepartmentID
group by DepartmentName, Name
--4
Select FirstName, orderid, orderdate 
from Customers c
join orders o 
on c.CustomerID=o.CustomerID
And c.Country ='USA' and Year(OrderDate)=2023
--5
Select firstname, Count(o.Quantity) as TotalOrders
from Orders o
left join customers c
on o.CustomerID=c.CustomerID
group by FirstName
--6
Select Productname, Suppliername 
from Products p
join Suppliers s
on p.SupplierID=s.SupplierID
And s.SupplierName='Gadget Supplies' or s.SupplierName= 'Clothing mart'
--7
SELECT c.FirstName, o1.OrderID, o1.OrderDate as MostRecentOrderDate
FROM Customers c
LEFT JOIN Orders o1 ON c.CustomerID = o1.CustomerID
LEFT JOIN Orders o2 
    ON c.CustomerID = o2.CustomerID AND o1.OrderDate < o2.OrderDate
WHERE o2.OrderID IS NULL;
--8
Select Firstname, orderid, TotalAmount as OrderTotal
from customers c
join orders o
on c.CustomerID=o.CustomerID
And TotalAmount>500 
--9
Select Productname, Saledate, Saleamount
from Products p
join Sales s
on p.ProductID=s.ProductID
And Year(saledate)=2022 or SaleAmount > '400'
--10
Select productname, Sum(SaleAmount) as TotalSalesAmount
from Products p
join Sales s
on p.ProductID=s.CustomerID
group by ProductName
--11
Select Name, Departmentname, Salary
from Employees e
join Departments d
on e.DepartmentID=d.DepartmentID
Where DepartmentName='Human Resources' and Salary> 50000
--12
Select productname, saledate, stockquantity
from Products p 
join sales s
on p.ProductID=s.ProductID
where Year(Saledate)=2023 and StockQuantity>50
--13
Select e.Name, DepartmentName, HireDate 
from Employees e
join Departments d
on e.DepartmentID=d.DepartmentID
Where DepartmentName='Sales' or Year(hiredate)>2020
--14
Select firstname, orderid, orderdate
from Customers c
join Orders o
on c.CustomerID=o.CustomerID
And Country ='USA' where Address like '4%'
--15
Select productname, category, saleamount 
from products p 
join sales s 
on p.ProductID=s.ProductID
Where Category='Electronics' or SaleAmount> 350
--16
Select categoryname, count(productname) as ProductCount
from Categories c
join Products p
on c.CategoryID=p.Category
group by CategoryName
--17
Select firstname, city, orderid, TotalAmount
from customers c
join orders o
on c.CustomerID=o.CustomerID
Where city='Los Angeles' and TotalAmount > 300
--18
Select Name, Departmentname 
from Employees e
join Departments d
on e.DepartmentID=d.DepartmentID
Where DepartmentName in ('Human Resources', 'Finance')
or name like '[aoeiu]'
--19
Select productname, StockQuantity, Price
from sales s
join Products p 
on p.ProductID=s.ProductID
where StockQuantity > 100 and price > 500
--20
Select Name, DepartmentName, Salary 
from Employees e 
join Departments d 
on e.DepartmentID=d.DepartmentID
Where DepartmentName in ('Sales', 'Marketing') and Salary >60000

















