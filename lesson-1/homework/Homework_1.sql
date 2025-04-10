1. Data is raw material which not inform anything. 
Database is organized structured data which can inform smth.
Relational database is data structered in form of tables that connected each other 
Table is data which is structured in rows and columns;
2.The 5 key features of SQL server includes 
-Security
-High avaibility
-Robust integration services (SSIS)
-Powerful reporting capabilities (SSRS)
-In-database machine learning 
3.SQL authontication modes: 
-Windows Authentication
-Mixed Mode

4. Create database SchoolDB
5. Create table Students (StudentID int primary key, [Name] varchar(50), Age int)

6.SQL server is Relational database mangement system while SQL is the language used to interact with it, and SQL Server management Studio is tool for managing and interacting with SQL server

7. 
1. DDL (Data Definition Language) 
Defines and modifies the structure of database objects like tables, views, indexes, etc.
Common Commands: CREATE, ALTER, DROP, TRUNCATE
2. DML (Data Manipulation Language)
Manipulates data within the database tables (inserting, updating, deleting).
Common Commands: SELECT, INSERT, UPDATE, DELETE
3.DQL (Data Query Language):
Primarily used for retrieving data from the database
Common Command: SELECT
4.DCL (Data Control Language):
Controls access to database data and manages user permissions.
Common Commands: GRANT, REVOKE
5.TCL (Transaction Control Language):
Manages transactions within the database to ensure data consistency and integrity.
Common Commands: COMMIT, ROLLBACK, SAVEPOINT

8. 

Insert into Students values 
(1, 'Alisher',25), 
(2, 'Aziza', 24), 
(3, 'Yusuf', 24);
Select * from Students 

9.Backup the SchoolDB Database
Open SQL Server Management Studio (SSMS) and connect to your database instance.
In Object Explorer, expand Databases and right-click on SchoolDB.
Select Tasks → Back Up....
In the Back Up Database window:
Database: Ensure SchoolDB is selected.
Backup Type: Select Full.
Destination: Choose Disk, and click Add to specify the backup file location (e.g., C:\Backups\SchoolDB.bak).
Click OK to start the backup process.
Once completed, a confirmation message will appear.

Restore the SchoolDB Database
In SSMS, right-click on Databases and select Restore Database....
In the Restore Database window:
Choose Device, then click … (browse) and select the backup file (C:\Backups\SchoolDB.bak).
Click OK to add the backup file.
Under Restore Options, check Overwrite the existing database (WITH REPLACE) if needed.
Click OK to start the restoration process.
A success message will confirm the restore.