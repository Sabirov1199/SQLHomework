create database homework_class19
use homework_class19

--6. Find Employees in Department with Highest Average Salary
CREATE TABLE departments (
    id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

INSERT INTO departments (id, department_name) VALUES
(1, 'IT'),
(2, 'Sales');

INSERT INTO employees (id, name, salary, department_id) VALUES
(1, 'Jack', 80000, 1),
(2, 'Karen', 70000, 1),
(3, 'Leo', 60000, 2);

Select * from employees
Select * from departments

Select e.id, e.name, e.salary, d.department_name 
from employees e 
join departments d 
on e.department_id=d.id
where e.salary>= (Select avg(salary)
                 from employees
				 where department_id=e.department_id
				 )
--7. : Retrieve employees earning more than the average salary in their department. Tables: employees (columns: id, name, salary, department_id)
drop table if exists employees 
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT
);

INSERT INTO employees (id, name, salary, department_id) VALUES
(1, 'Mike', 50000, 1),
(2, 'Nina', 75000, 1),
(3, 'Olivia', 40000, 2),
(4, 'Paul', 55000, 2);
Select * from employees e1
where e1.salary > (Select avg(salary) from employees e2 
                   where e1.department_id=e2.department_id)
--8. Retrieve students who received the highest grade in each course. Tables: students (columns: student_id, name), grades (columns: student_id, course_id, grade)

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE grades (
    student_id INT,
    course_id INT,
    grade DECIMAL(4, 2),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

INSERT INTO students (student_id, name) VALUES
(1, 'Sarah'),
(2, 'Tom'),
(3, 'Uma');

INSERT INTO grades (student_id, course_id, grade) VALUES
(1, 101, 95),
(2, 101, 85),
(3, 102, 90),
(1, 102, 80);

Select * from students 
Select * from grades

Select s.student_id, s.name, g1.grade from students s 
join grades g1 
on s.student_id=g1.student_id
where g1.grade >any (Select g2.grade from grades g2 
where g1.course_id=g2.course_id)
--9. Find Third-Highest Price per Category Task: Retrieve products with the third-highest price in each category. Tables: products (columns: id, product_name, price, category_id)
CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    category_id INT
);

INSERT INTO products (id, product_name, price, category_id) VALUES
(1, 'Phone', 800, 1),
(2, 'Laptop', 1500, 1),
(3, 'Tablet', 600, 1),
(4, 'Smartwatch', 300, 1),
(5, 'Headphones', 200, 2),
(6, 'Speakers', 300, 2),
(7, 'Earbuds', 100, 2);
Select * from products
Select * from products p1
where p1.price = ( Select  min(price) 
                  from (Select distinct top 3 price 
				  from products p2 
				  where p2.category_id=p1.category_id
				  order by price desc) as Top3prices)
--10. Retrieve employees with salaries above the company average but below the maximum in their department. Tables: employees (columns: id, name, salary, department_id)

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT
);

INSERT INTO employees (id, name, salary, department_id) VALUES
(1, 'Alex', 70000, 1),
(2, 'Blake', 90000, 1),
(3, 'Casey', 50000, 2),
(4, 'Dana', 60000, 2),
(5, 'Evan', 75000, 1);
Select * from employees
Select * from employees e3
where e3.salary <(Select max(salary) from employees e2 
where e3.department_id =e2.department_id)
and e3.salary > (Select avg(salary) from employees)


	







