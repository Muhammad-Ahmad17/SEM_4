CREATE DATABASE Lab4;
USE Lab4

--Task 1: Creating Tables with Constraints 
--1: Departments table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,         
    DepartmentName VARCHAR(100) UNIQUE NOT NULL  
)
--2:Employees table
CREATE TABLE Employees ( 
EmployeeID INT PRIMARY KEY, 
Name VARCHAR(50) NOT NULL, 
Age INT CHECK (Age >= 18), 
Email VARCHAR(100) UNIQUE, 
DepartmentID INT, 
Salary DECIMAL(10,2) DEFAULT 3000.00, 
FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID) 
);

-- Task 2: Testing Constraints 

-- Insert departments
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'HR'),
(2, 'Engineering'),
(3, 'Medical');

-- Insert employees
--1 Attempt to insert an employee without providing a name
INSERT INTO Employees (EmployeeID, Age, Email, DepartmentID, Salary) VALUES
(1, 30, 'Ahmad@example.com', 1, 5000.00);
--2 Try inserting two employees with the same email
INSERT INTO Employees (EmployeeID, Name, Age, Email, DepartmentID, Salary) VALUES
(2, 'Ahmad', 30, 'Ahmad@example.com', 1, 5000.00);
INSERT INTO Employees (EmployeeID, Name, Age, Email, DepartmentID, Salary) VALUES
(3, 'Ahsan ', 22, 'Ahmad@example.com', 3, 4500.00);
--3 Insert an employee under the age of 18
INSERT INTO Employees (EmployeeID, Name, Age, Email, DepartmentID, Salary) VALUES
(4, 'Zexu', 17, 'Zexu@example.com', 2, 4500.00)
--4 Add an employee without specifying a salary 
INSERT INTO Employees (EmployeeID, Name, Age, Email, DepartmentID) VALUES
(5, 'Ali', 29, 'Ali@example.com', 2)

-- Task 3: Foreign Key Integrity Check 
INSERT INTO Employees 
VALUES (6, 'Mr 1',19,'Mr1@example.com', 4, 4500.00);

