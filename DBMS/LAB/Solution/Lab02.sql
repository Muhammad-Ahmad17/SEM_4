--task--
create database lab2
use lab2

--task
CREATE TABLE Employees (
    Emp_ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

INSERT INTO Employees VALUES 
(1, 'Alice', 'HR', 50000), 
(2, 'Bob', 'IT', 60000), 
(3, 'Charlie', 'Finance', 55000), 
(4, 'David', 'IT', 65000), 
(5, 'Emma', 'HR', 52000);


--task2
SELECT Name, 
       UPPER(Name) AS UpperCaseName, 
       LEN(Name) AS NameLength 
FROM Employees;

--task3
SELECT COUNT(*) AS TotalEmployees FROM Employees;

SELECT AVG(Salary) AS AverageSalary FROM Employees;

SELECT MAX(Salary) AS HighestSalary, MIN(Salary) AS LowestSalary FROM Employees;


--task4
SELECT SUM(Salary) AS TotalITSalary 
FROM Employees 
WHERE Department = 'IT';

--task++
select * from Employees
SELECT GETDATE();