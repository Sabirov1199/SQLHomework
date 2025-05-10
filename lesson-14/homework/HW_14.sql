--Creating database for homework_14

Create database homework_14
Use homework_14

-- Inseting tables

-- 1st table
CREATE TABLE Employee ( Id INT, Name VARCHAR(50), Salary INT, ManagerId INT );

Select * from employee
INSERT INTO Employee (Id, Name, Salary, ManagerId) VALUES 
(1, 'Joe', 70000, 3), (2, 'Henry', 80000, 4), (3, 'Sam', 60000, NULL), (4, 'Max', 90000, NULL);
Select * from employee

-- 2nd table
CREATE TABLE weather ( Id INT, RecordDate DATE, Temperature INT );

Select * from Weather
INSERT INTO weather (Id, RecordDate, Temperature) VALUES
(1, '2015-01-01', 10), (2, '2015-01-02', 25), (3, '2015-01-03', 20), (4, '2015-01-04', 30);

Select * from Weather

-- 3rd table
CREATE TABLE Activity ( player_id INT, device_id INT, event_date DATE, games_played INT );
Select * from Activity

INSERT INTO Activity (player_id, device_id, event_date, games_played) VALUES 
(1, 2, '2016-03-01', 5), (1, 2, '2016-05-02', 6), (2, 3, '2017-06-25', 1), 
(3, 1, '2016-03-02', 0), (3, 4, '2018-07-03', 5);
Select * from Activity

-- 4th table
CREATE TABLE MultipleVals ( Id INT ,[Vals] VARCHAR(100) ) 
Select * from Multiplevals

Insert Into MultipleVals values (1,'a,b,c') ,(2,'x,y,z') 
Select * from Multiplevals

-- 5th table
CREATE TABLE fruits ( fruit_list VARCHAR(100) );
Select * from fruits

INSERT INTO fruits (fruit_list) VALUES ('apple,banana,orange,grape');
Select * from fruits

-- 6th table
CREATE TABLE RemoveLastComma ( Id INT ,Val VARCHAR(100) ) 
Select * from RemoveLastComma

INSERT INTO RemoveLastComma VALUES 
(1,'Pawan'), (2,'Pawan,Avtaar,'), (3,','), (4,'Hello,'), (5,'a,a,b,c,'), (6,NULL), (7,'') 
Select * from RemoveLastComma

-- 7th table
CREATE TABLE FindSameCharacters ( Id INT ,Vals VARCHAR(10) ) 
Select * from FindSameCharacters

INSERT INTO FindSameCharacters VALUES 
(1,'aa'), (2,'cccc'), (3,'abc'), (4,'aabc'), (5,NULL), (6,'a'), (7,'zzz'), (8,'abc') 
Select * from FindSameCharacters

-- 8th table
CREATE TABLE Splitter ( Id INT ,Vals VARCHAR(100) ) 
Select * from Splitter

INSERT INTO Splitter VALUES 
(1,'P.K'), (2,'a.b'), (3,'c.d'), (4,'e.J'), (5,'t.u.b') 
Select * from Splitter

-- 9th table
CREATE TABLE testDots ( ID INT ,Vals VARCHAR(100) ) 
Select * from testDots

INSERT INTO testDots VALUES 
(1,'0.0'), (2,'2.3.1.1'), (3,'4.1.a.3.9'), (4,'1.1.'), (5,'a.b.b.b.b.b..b..b'), (6,'6.') 
Select * from testDots

-- 10th table
CREATE TABLE GetIntegers ( Id INT ,VALS VARCHAR(100) ) 
Select * from GetIntegers

INSERT INTO GetIntegers VALUES
(1,'P1') ,(2,'1 - Hero') ,(3,'2 - Ramesh') ,(4,'3 - KrishnaKANT') ,
(5,'21 - Avtaar') ,(6,'5Laila') ,(7,'6 MMT') ,(8,'7#7#') ,(9,'#') ,(10,'8') ,(11,'98') ,(12,'111') ,(13,NULL) 
Select * from GetIntegers

-- 11th table
CREATE TABLE RemoveDuplicateIntsFromNames ( PawanName INT , Pawan_slug_name VARCHAR(1000) ) 
Select * from RemoveDuplicateIntsFromNames

INSERT INTO RemoveDuplicateIntsFromNames VALUES 
(1, 'PawanA-111' ), (2, 'PawanB-123' ), (3, 'PawanB-32' ), (4, 'PawanC-4444' ), (5, 'PawanD-3' )
Select * from RemoveDuplicateIntsFromNames

-- 12th table
CREATE TABLE TestPercent ( Strs VARCHAR(100) ) 
Select * from TestPercent

INSERT INTO TestPercent SELECT 'Pawan' UNION ALL SELECT 'Pawan%' UNION ALL SELECT 'Pawan%Kumar' UNION ALL SELECT '%'
Select * from TestPercent

-- 13th table
CREATE TABLE [dbo].[TestMultipleColumns]

([Id] [int] NULL, [Name] varchar(50) NULL)

Select * from [TestMultipleColumns]

INSERT INTO [TestMultipleColumns] VALUES

(1, 'Pawan,Kumar'),

(2, 'Sandeep,Goyal'),

(3, 'Isha,Mattoo'),

(4, 'Gopal,Ranjan'),

(5, 'Neeraj,Garg'),

(6, 'Deepak,Sharma'),

(7, ' Mayank,Tripathi')
Select * from [TestMultipleColumns]

-- 14th table
CREATE TABLE CountSpaces ( texts VARCHAR(100) ) 
Select * from CountSpaces

INSERT INTO CountSpaces VALUES 
('P Q R S '), (' L M N O 0 0 '), ('I am here only '), (' Welcome to the new world '), 
(' Hello world program'), (' Are u nuts ')
Select * from CountSpaces

-- 15th table
create table p1 (id int, code int) 
create table p2 (id int, code int) 
select * from p1
select * from p2


insert into p1 select 1,0 
insert into p1 select 2,1 
insert into p2 select 1,5 
insert into p2 select 2,5

select * from p1
select * from p2

-- 16th table
CREATE TABLE WeekPercentagePuzzle ( Area INT , [Date] DATE , SalesLocal INT , 
SalesRemote INT , [DayName] VARCHAR(4) , [DayOfWeek] SMALLINT , FinancialWeek TINYINT , 
[MonthName] VARCHAR(15) , FinancialYear INT ) 
select * from WeekPercentagePuzzle


INSERT INTO WeekPercentagePuzzle VALUES 
(1, '2015-04-01', 0, 50, 'Wed', 4, 1, 'April', 2015), (2, '2015-04-01', null, null , 'Wed', 4 , 1 , 'April', 2015), 
(3, '2015-04-01', 100 , 0 , 'Wed', 4 , 1 , 'April', 2015), (3, '2015-04-01', 50 , 100 , 'Wed', 4, 1, 'April', 2015),
(3, '2015-04-04', 50 , 50 , 'Sat', 7, 1, 'April', 2015)
select * from WeekPercentagePuzzle

-- 17th table
CREATE TABLE SeperateNumbersAndCharcters ( Value VARCHAR(100) ) 
select * from WeekPercentagePuzzle

INSERT INTO SeperateNumbersAndCharcters VALUES ('dskfsda1224'), ('123'), ('ABC'), ('23874283bsdjfhsjadkhfas09') 
select * from WeekPercentagePuzzle

-- Easy tasks
-- Task 1
--Select * from TestMultipleColumns

Select
(substring(Name, charindex(',', Name) + 1, len(Name))) Firstname,
(substring(Name, 1, charindex(',', Name) - 1)) Surname
From TestMultipleColumns;

-- Task 2
--Select * from TestPercent

Select * from Testpercent
Where strs like '%@%%' escape '@'

-- Task 3
--Select * from Splitter

Select id,
(substring(Vals, charindex('.', Vals) + 1, len(Vals))) letter1,
(substring(Vals, 1, charindex('.', Vals) - 1)) letter2
From Splitter;

-- Taks 4

Select translate('1234ABC123456XYZ1234567890ADS', '0123456789', 'XXXXXXXXXX') string;

-- Task 5
--Select * from testdots

Select * from testdots
Where Vals like '%@.%@.%' escape '@'

-- Task 6
Write a SQL query to count the occurrences of a substring within a string in a given column.(Not table) 

-- Task 7
--Select * from CountSpaces

select len(texts) from countspaces

-- Task 8
--Select * from employee

Select * from employee e1
Join employee e2 on e1.managerid = e2.id
Where e1.salary > e2.salary


-- Medium tasks
-- Task 1
Select * from SeperateNumbersAndCharcters
1.Write a SQL query to separate the integer values and 
the character values into two different columns.(SeperateNumbersAndCharcters)


-- Task 2
--Select * from weather

Select w2.id from weather w1
Join weather w2 on datediff(day, w1.recorddate, w2.recorddate) = 1
 where w2.temperature >  w1.temperature

 -- Task 3
Select * from Activity

Select a.player_id, a.device_id, a.event_date from Activity a
Join (Select player_id, min(event_date) first_login from Activity
Group by player_id) b on a.player_id = b.player_id and a.event_date = b.first_login


-- Task 4
--Select * from Activity

Select player_id, min(event_date) first_login from Activity
Group by player_id

-- Task 5
Select * from fruits
Your task is to split the string into a list using a specific separator 
(such as a space, comma, etc.), and then return the third item from that list.(fruits)

-- Task 6 

Select substring('sdgfhsdgfhs@121313131', number, 1) character
FROM master.dbo.spt_values
WHERE type = 'P'
  AND number BETWEEN 1 AND LEN('sdgfhsdgfhs@121313131');


-- Task 7
--Select * from p1
--Select * from p2


Select p1.id,
Case 
When p1.code = 0 then p2.code
Else p1.code
End code From p1
Join p2 on p1.id = p2.id

-- Task 8
Select * from WeekPercentagePuzzle

-- Task 9
Select * from MultipleVals


