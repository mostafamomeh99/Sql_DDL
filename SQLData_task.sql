--create schema examples

--•	Create a table named "Employees" with columns for ID (integer), Name (varchar), and Salary (decimal).

create table examples. Employees(
ID int,
Name varchar(50),
Salary decimal(8,2)
)

--•	Add a new column named "Department" to the "Employees" table with data type varchar(50).
alter table examples. Employees
add  Department varchar(50)

--•	Remove the "Salary" column from the "Employees" table.
alter table examples. Employees
drop  COLUMN Salary

--•	Rename the "Department" column in the "Employees" table to "DeptName".
EXEC sp_rename 'examples.Employees.Department', 'DeptName', 'COLUMN';

--•	Create a new table called "Projects" with columns for ProjectID (integer) and ProjectName (varchar).
create table examples. Projects(
ProjectID int,
ProjectName varchar(50)
)

--•	Add a primary key constraint to the "Employees" table for the "ID" column.
ALTER TABLE examples.Employees
ALTER COLUMN ID int not null;
ALTER TABLE examples.Employees
ADD CONSTRAINT PK_Employees_ID PRIMARY KEY (ID);

--•	Create a foreign key relationship between the "Employees" table (referencing "ID") and the "Projects" table (referencing "ProjectID").

ALTER TABLE examples.Projects
ALTER COLUMN ProjectID int not null;
ALTER TABLE examples.Projects
ADD CONSTRAINT PK_Projects_ID PRIMARY KEY (ProjectID);

--suppose relation is 1 project to m employees
ALTER TABLE examples.Employees
add proj_id int not null

ALTER TABLE examples.Employees
ADD CONSTRAINT fK_Employees_projects foreign KEY (proj_id) references examples.Projects(ProjectID);

--•	Remove the foreign key relationship between "Employees" and "Projects."
ALTER TABLE examples.Employees
drop CONSTRAINT fK_Employees_projects

--•	Add a unique constraint to the "Name" column in the "Employees" table.
ALTER TABLE examples.Employees
ADD CONSTRAINT unique_name UNIQUE(name)

--•	Create a table named "Customers" with columns for CustomerID (integer), FirstName (varchar), LastName (varchar), and Email (varchar), and Status (varchar).
create table examples.Customers(
CustomerID int not null,
 FirstName varchar(50),
 LastName varchar(50),
 Email varchar(20),
 status varchar(10),
)

--•	Add a unique constraint to the combination of "FirstName" and "LastName" columns in the "Customers" table.
alter table examples.Customers
ADD FullName AS (FirstName + ' ' + LastName);

alter table examples.Customers
ADD constraint unique_name_cust unique(FullName)

--•	Add a default value of 'Active' for the "Status" column in the "Customers" table,
--where the default value should be applied when a new record is inserted.
alter table examples.Customers
ADD constraint default_status_cust DEFAULT 'active' FOR status;

--•	Create a table named "Orders" with columns for OrderID (integer), CustomerID (integer), OrderDate (datetime), and TotalAmount (decimal).


create table examples. Orders(
OrderID int primary key,
CustomerID int,
 OrderDate date,
 TotalAmount decimal(10,2)
)

--•	Add a check constraint to the "TotalAmount" column in the "Orders" table to ensure that it is greater than zero.
alter table examples. Orders
ADD CONSTRAINT CK_TotalAmount CHECK (TotalAmount > 0);

--•	Create a schema named "Sales" and move the "Orders" table into this schema.
create schema Sales

ALTER SCHEMA Sales  
    TRANSFER object:: examples. Orders;

	--•	Rename the "Orders" table to "SalesOrders."
	exec sp_rename 'Sales.Orders' , 'SalesOrders'