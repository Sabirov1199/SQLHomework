create database homework_class22
use homework_class22


CREATE TABLE sales_data (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    customer_name VARCHAR(100),
    product_category VARCHAR(50),
    product_name VARCHAR(100),
    quantity_sold INT,
    unit_price DECIMAL(10,2),
    total_amount DECIMAL(10,2),
    order_date DATE,
    region VARCHAR(50)
);

INSERT INTO sales_data VALUES
    (1, 101, 'Alice', 'Electronics', 'Laptop', 1, 1200.00, 1200.00, '2024-01-01', 'North'),
    (2, 102, 'Bob', 'Electronics', 'Phone', 2, 600.00, 1200.00, '2024-01-02', 'South'),
    (3, 103, 'Charlie', 'Clothing', 'T-Shirt', 5, 20.00, 100.00, '2024-01-03', 'East'),
    (4, 104, 'David', 'Furniture', 'Table', 1, 250.00, 250.00, '2024-01-04', 'West'),
    (5, 105, 'Eve', 'Electronics', 'Tablet', 1, 300.00, 300.00, '2024-01-05', 'North'),
    (6, 106, 'Frank', 'Clothing', 'Jacket', 2, 80.00, 160.00, '2024-01-06', 'South'),
    (7, 107, 'Grace', 'Electronics', 'Headphones', 3, 50.00, 150.00, '2024-01-07', 'East'),
    (8, 108, 'Hank', 'Furniture', 'Chair', 4, 75.00, 300.00, '2024-01-08', 'West'),
    (9, 109, 'Ivy', 'Clothing', 'Jeans', 1, 40.00, 40.00, '2024-01-09', 'North'),
    (10, 110, 'Jack', 'Electronics', 'Laptop', 2, 1200.00, 2400.00, '2024-01-10', 'South'),
    (11, 101, 'Alice', 'Electronics', 'Phone', 1, 600.00, 600.00, '2024-01-11', 'North'),
    (12, 102, 'Bob', 'Furniture', 'Sofa', 1, 500.00, 500.00, '2024-01-12', 'South'),
    (13, 103, 'Charlie', 'Electronics', 'Camera', 1, 400.00, 400.00, '2024-01-13', 'East'),
    (14, 104, 'David', 'Clothing', 'Sweater', 2, 60.00, 120.00, '2024-01-14', 'West'),
    (15, 105, 'Eve', 'Furniture', 'Bed', 1, 800.00, 800.00, '2024-01-15', 'North'),
    (16, 106, 'Frank', 'Electronics', 'Monitor', 1, 200.00, 200.00, '2024-01-16', 'South'),
    (17, 107, 'Grace', 'Clothing', 'Scarf', 3, 25.00, 75.00, '2024-01-17', 'East'),
    (18, 108, 'Hank', 'Furniture', 'Desk', 1, 350.00, 350.00, '2024-01-18', 'West'),
    (19, 109, 'Ivy', 'Electronics', 'Speaker', 2, 100.00, 200.00, '2024-01-19', 'North'),
    (20, 110, 'Jack', 'Clothing', 'Shoes', 1, 90.00, 90.00, '2024-01-20', 'South'),
    (21, 111, 'Kevin', 'Electronics', 'Mouse', 3, 25.00, 75.00, '2024-01-21', 'East'),
    (22, 112, 'Laura', 'Furniture', 'Couch', 1, 700.00, 700.00, '2024-01-22', 'West'),
    (23, 113, 'Mike', 'Clothing', 'Hat', 4, 15.00, 60.00, '2024-01-23', 'North'),
    (24, 114, 'Nancy', 'Electronics', 'Smartwatch', 1, 250.00, 250.00, '2024-01-24', 'South'),
    (25, 115, 'Oscar', 'Furniture', 'Wardrobe', 1, 1000.00, 1000.00, '2024-01-25', 'East')

Select * from sales_data

--1. Compute Running Total Sales per Customer
Select *, sum(total_amount) over (partition by customer_id order by order_date) RunningTotal
from sales_data
--2. Count the Number of Orders per Product Category
Select *, Count(*) over (partition by product_category) as CountingTotal
from sales_data
--3.Find the Maximum Total Amount per Product Category

Select *, Max(total_amount) over (partition by product_category) as Maximum
from sales_data

--4. Find the Minimum Price of Products per Product Category
Select *, Min(total_amount) over (partition by product_category) as Minimum
from sales_data
--5. Compute the Moving Average of Sales of 3 days (prev day, curr day, next day)

Select order_date, total_amount, avg(total_amount) over (order by order_date rows between 1 preceding and 1 following)
as Moving_Avg from sales_data

--6. Find the Total Sales per Region
Select *, Sum(total_amount) over (partition by region) TotalAmount_Region
from sales_data;

--7. Compute the Rank of Customers Based on Their Total Purchase Amount

with customertotalpurchase as (
Select  customer_id, sum(total_amount) as Total_purchase 
from sales_data 
group by customer_id
)
Select *, dense_rank()over (order by (Select total_purchase from customertotalpurchase ctp where 
ctp.customer_id=sd.customer_id) desc) as CustomerRankByTotalPurchase
from sales_data sd;
--8. Calculate the Difference Between Current and Previous Sale Amount per Customer

Select
    customer_id,
    order_date,
    total_amount,
    lag(total_amount, 1, 0) over (partition by customer_id order by order_date asc) as previous_sale_amount,
    total_amount - lag(total_amount, 1, 0) over (partition by customer_id order by order_date asc) as sale_difference
FROM
    sales_data;

--9. Find the Top 3 Most Expensive Products in Each Category
with cte as (
Select distinct product_category, product_name,unit_price, rank() over (partition by product_category order by unit_price desc) Maxsales from sales_data
)
Select * from cte 
where Maxsales=1

--10. Compute the Cumulative Sum of Sales Per Region by Order Date

Select *, Sum(total_amount) over (partition by region order by order_date) Cumulative_sum
from sales_data

--11. Compute Cumulative Revenue per Product Category

Select *, Sum(quantity_sold*unit_price*total_amount) over (partition by product_category order by order_date)
from sales_data

--13. Sum of Previous Values to Current Value

CREATE TABLE OneColumn (
    Value SMALLINT
);
INSERT INTO OneColumn VALUES (10), (20), (30), (40), (100);

select value,
sum(value) over (order by value rows between unbounded preceding and 1 preceding) as Sumofprevious
from OneColumn
--12. 
CREATE TABLE SmallColumn (
    id SMALLINT
);
INSERT INTO SmallColumn VALUES (1), (2), (3), (4), (5);

select id,
sum(id) over (order by id rows between unbounded preceding and 0 preceding) as Sumofprevious
from SmallColumn;

--14.
CREATE TABLE Row_Nums (
    Id INT,
    Vals VARCHAR(10)
);
INSERT INTO Row_Nums VALUES
(101,'a'), (102,'b'), (102,'c'), (103,'f'), (103,'e'), (103,'q'), (104,'r'), (105,'p');

WITH RankedData AS (
    SELECT
        Id,
        Vals,
        ROW_NUMBER() OVER (PARTITION BY Id ORDER BY Vals) AS rn
    FROM
        Row_Nums
)
SELECT
    Id,
    Vals,
    (ROW_NUMBER() OVER (PARTITION BY Id ORDER BY Vals) * 2) - (CASE WHEN MIN(rn) OVER (PARTITION BY Id) = 1 THEN 1 ELSE 0 END) AS RowNumber
FROM
    RankedData;
--15. Find customers who have purchased items from more than one product_category;
 Select * from sales_data
 Select customer_id, count(distinct product_category) Number_of_category from sales_data
 group by customer_id
 having count(distinct product_category)>1
 --16. Find Customers with Above-Average Spending in Their Region
 with cte as (
 Select customer_id, customer_name,total_amount, Avg(total_amount) over (order by region)as Avg_spending_byregion from sales_data
 )
 Select * from cte 
 where total_amount> Avg_spending_byregion
 --17. Rank customers based on their total spending (total_amount) within each region. If multiple customers have the same spending, they should receive the same rank.
 Select *, dense_rank() over (partition by region order by total_amount desc) Ranking_customer from sales_data

 --18. Calculate the running total (cumulative_sales) of total_amount for each customer_id, ordered by order_date.

 Select *, Sum(total_amount) over (partition by customer_id order by order_date)as Cumulative_sales from sales_data;

--19. Calculate the sales growth rate (growth_rate) for each month compared to the previous month.
WITH monthly_sales AS (
    SELECT 
        FORMAT(order_date, 'yyyy-MM') AS month,
        SUM(total_amount) AS total_sales
    FROM sales_data
    GROUP BY FORMAT(order_date, 'yyyy-MM')
),
sales_with_growth AS (
    SELECT 
        month,
        total_sales,
        LAG(total_sales) OVER (ORDER BY month) AS previous_month_sales,
        CASE 
            WHEN LAG(total_sales) OVER (ORDER BY month) IS NULL THEN NULL
            ELSE 
                ROUND(
                    (total_sales - LAG(total_sales) OVER (ORDER BY month)) * 100.0 / 
                    LAG(total_sales) OVER (ORDER BY month), 2
                )
        END AS growth_rate
    FROM monthly_sales
)
SELECT * FROM sales_with_growth;

--20.Identify customers whose total_amount is higher than their last order''s total_amount.(Table sales_data)
with cte as (
Select *, lag(total_amount) over (partition by customer_id order by order_date) prev_amount from sales_data
) 
Select * from cte 
where prev_amount is not null 
and total_amount>prev_amount

--21. Identify Products that prices are above the average product price
with cte AS(
Select *, avg(unit_price) over () Avg_unitprice from sales_data
)
Select distinct product_name, unit_price, Avg_unitprice from cte 
where unit_price>Avg_unitprice;