CREATE DATABASE LAB10;
GO
USE LAB10;

CREATE TABLE Employees
(
    EMPLOYEE_ID INT PRIMARY KEY,
    FIRST_NAME NVARCHAR(50),
    LAST_NAME NVARCHAR(50),
    SALARY INT,
    JOINING_DATE DATETIME,
    DEPARTMENT NVARCHAR(50)
);

CREATE TABLE Incentives
(
    Employee_Ref_ID INT,
    Incentive_Date DATETIME,
    Incentive_Amount INT
);

ALTER TABLE Incentives
ADD CONSTRAINT FK_Employee_Incentives
FOREIGN KEY (Employee_Ref_ID) REFERENCES Employees(EMPLOYEE_ID);



INSERT INTO Employees
    (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT)
VALUES
    (1, 'John', 'Abraham', 1000000, '2016-01-01 00:00:00', 'Banking'),
    (2, 'Michael', 'Clarke', 800000, '2016-01-01 00:00:00', 'Insurance'),
    (3, 'Roy', 'Thomas', 700000, '2016-01-01 00:00:00', 'Banking'),
    (4, 'Tom', 'Jose', 600000, '2016-01-01 00:00:00', 'Insurance'),
    (5, 'Jerry', 'Pinto', 650000, '2016-01-01 00:00:00', 'Insurance'),
    (6, 'Philip', 'Mathew', 750000, '2016-01-01 00:00:00', 'Services'),
    (7, 'TestName1', '123', 650000, '2016-01-01 00:00:00', 'Services'),
    (8, 'TestName2', 'Lname%', 600000, '2016-01-01 00:00:00', 'Insurance');

INSERT INTO Incentives
    (Employee_Ref_ID, Incentive_Date, Incentive_Amount)
VALUES
    (1, '01-FEB-16 00:00:00', 5000),
    (2, '01-FEB-16 00:00:00', 3000),
    (3, '01-FEB-16 00:00:00', 4000),
    (1, '01-FEB-16 00:00:00', 4500),
    (2, '01-JAN-16 00:00:00', 3500);


-- Task 1: Get all employee details from the employee table
SELECT *
FROM Employees;

-- Task 2: Get First_Name, Last_Name from employee table
SELECT FIRST_NAME, LAST_NAME
FROM Employees;

-- Task 3: Get First_Name from employee table using alias name "Employee Name"
SELECT FIRST_NAME AS "Employee Name"
FROM Employees;

-- Task 4: Get First_Name from employee table in upper case
SELECT UPPER(FIRST_NAME) AS "Employee Name"
FROM Employees;

-- Task 5: Get First_Name from employee table in lower case
SELECT LOWER(FIRST_NAME) AS "Employee Name"
FROM Employees;

-- Task 6: Get unique DEPARTMENT from employee table
SELECT DISTINCT DEPARTMENT
FROM Employees;

-- Task 7: Select first 3 characters of FIRST_NAME from EMPLOYEE
SELECT SUBSTRING(FIRST_NAME, 1, 3)  First3Chars
FROM Employees;
--
SELECT LEFT(FIRST_NAME, 3) AS First3Chars
FROM Employees;

-- Task 8: Get position of 'o' in name 'John' from employee table
SELECT CHARINDEX('o', 'John') AS Position;

-- Task 9: Get FIRST_NAME from employee table after removing white spaces from right side
SELECT RTRIM(FIRST_NAME)
FROM Employees;

-- Task 10: Get FIRST_NAME from employee table after removing white spaces from left side
SELECT LTRIM(FIRST_NAME)
FROM Employees;

-- Task 11: Get length of FIRST_NAME from employee table
SELECT LEN(FIRST_NAME)
FROM Employees;

-- Task 12: Get First_Name from employee table after replacing 'o' with '$'
SELECT REPLACE(FIRST_NAME, 'o', '$')
FROM Employees;

-- Task 13: Get First_Name and Last_Name as single column from employee table separated by a '_'
SELECT (FIRST_NAME + '_' + LAST_NAME) AS FullName
FROM Employees;

-- Task 14: Get FIRST_NAME, Joining year, Joining Month and Joining Date from employee table
SELECT
    FIRST_NAME,
    YEAR(JOINING_DATE) AS Joining_Year,
    MONTH(JOINING_DATE) AS Joining_Month,
    DAY(JOINING_DATE) AS Joining_Day
FROM Employees;

-- Default method to get current date and time in SQL Server
SELECT month(GETDATE()) AS CurrentDateTime;

-- Task 15: Get all employee details from the employee table ordered by First_Name Ascending
SELECT *
FROM Employees
ORDER BY FIRST_NAME ASC;

-- Task 16: Get all employee details from the employee table ordered by First_Name descending
SELECT *
FROM Employees
ORDER BY FIRST_NAME DESC;

-- Task 17: Get all employee details from the employee table ordered by First_Name Ascending and Salary descending
SELECT *
FROM Employees
ORDER BY FIRST_NAME ASC, SALARY DESC;

-- Task 18: Get employee details from employee table whose employee name is �John�
SELECT *
FROM Employees
WHERE FIRST_NAME = 'John';

-- Task 19: Get employee details from employee table whose employee names are �John� and �Roy�
SELECT *
FROM Employees
WHERE FIRST_NAME IN ('John', 'Roy');

-- Task 20: Get employee details from employee table whose employee names are not �John� and �Roy�
SELECT *
FROM Employees
WHERE FIRST_NAME NOT IN ('John', 'Roy');

-- Task 21: Get employee details from employee table whose first name starts with 'J'
SELECT *
FROM Employees
WHERE FIRST_NAME LIKE 'J%';

-- Task 22: Get employee details from employee table whose first name contains 'o'
SELECT *
FROM Employees
WHERE FIRST_NAME LIKE '%o%';

-- Task 23: Get employee details from employee table whose first name ends with 'n'
SELECT *
FROM Employees
WHERE FIRST_NAME LIKE '%n';

-- Task 24: Get employee details from employee table whose first name ends with 'n' and contains letters
SELECT *
FROM Employees
WHERE FIRST_NAME LIKE '%n' AND FIRST_NAME LIKE '%[A-Za-z]%';

-- Task 25: Get employee details from employee table whose first name starts with 'J' and contains letters
SELECT *
FROM Employees
WHERE FIRST_NAME LIKE 'J%' AND FIRST_NAME LIKE '%[A-Za-z]%';

-- Task 26: Get employee details from employee table whose Salary is greater than 600000
SELECT *
FROM Employees
WHERE SALARY > 600000;

-- Task 27: Get employee details from employee table whose Salary is less than 800000
SELECT *
FROM Employees
WHERE SALARY < 800000;

-- Task 28: Get employee details from employee table whose Salary is between 500000 and 800000
SELECT *
FROM Employees
WHERE SALARY BETWEEN 500000 AND 800000;

-- Task 29: Get employee details from employee table whose names are 'John' and 'Michael'
SELECT *
FROM Employees
WHERE FIRST_NAME IN ('John', 'Michael');

-- Task 30: Get employee details from employee table whose joining year is �2016�
SELECT *
FROM Employees
WHERE YEAR(CONVERT(DATETIME, JOINING_DATE, 120)) = 2016;

-- Task 31: Get employee details from employee table whose joining month is �January�
SELECT *
FROM Employees
WHERE MONTH(CONVERT(DATETIME, JOINING_DATE, 120)) = 1;

-- Task 32: Get employee details from employee table who joined before January 1st, 2016
SELECT *
FROM Employees
WHERE CONVERT(DATETIME, JOINING_DATE, 120) < '2016-01-01';

-- Task 33: Get employee details from employee table who joined after January 31st, 2016
SELECT *
FROM Employees
WHERE CONVERT(DATETIME, JOINING_DATE, 120) > '2016-01-31';

-- Task 34: Get Joining Date and Time from employee table
SELECT CONVERT(DATETIME, JOINING_DATE, 120) AS Joining_DateTime
FROM Employees;

-- Task 35: Get Joining Date, Time including milliseconds from employee table
SELECT FORMAT(CONVERT(DATETIME, JOINING_DATE, 120), 'yyyy-MM-dd HH:mm:ss.fff') AS Joining_DateTime_Milli
FROM Employees;

-- Task 36: Get difference between JOINING_DATE and INCENTIVE_DATE from employee and incentives table
SELECT e.EMPLOYEE_ID,
    DATEDIFF(DAY, CONVERT(DATETIME, e.JOINING_DATE, 120), CONVERT(DATETIME, i.Incentive_Date, 120)) AS DateDifference
FROM Employees e
    INNER JOIN Incentives i ON e.EMPLOYEE_ID = i.Employee_Ref_ID;

-- Task 37: Get database date
SELECT GETDATE() AS DatabaseDate;

-- Task 38: Get names of employees from employee table who have '%' in Last_Name
SELECT FIRST_NAME, LAST_NAME
FROM Employees
WHERE LAST_NAME LIKE '%[%]%';

-- Task 39: Get Last Name from employee table after replacing special characters with white space
SELECT REPLACE(LAST_NAME, '%', ' ') AS Modified_LastName
FROM Employees;

-- Task 40: Get department, total salary with respect to a department from employee table
SELECT DEPARTMENT, SUM(SALARY) AS Total_Salary
FROM Employees
GROUP BY DEPARTMENT;

-- Task 41: Get department, total salary with respect to a department ordered by total salary descending
SELECT DEPARTMENT, SUM(SALARY) AS Total_Salary
FROM Employees
GROUP BY DEPARTMENT
ORDER BY Total_Salary DESC;

-- Task 42: Get department, number of employees in a department, total salary with respect to a department ordered by total salary descending
SELECT DEPARTMENT, COUNT(*) AS Number_Of_Employees, SUM(SALARY) AS Total_Salary
FROM Employees
GROUP BY DEPARTMENT
ORDER BY Total_Salary DESC;

-- Task 43: Get department-wise average salary from employee table ordered by salary ascending
SELECT DEPARTMENT, AVG(SALARY) AS Average_Salary
FROM Employees
GROUP BY DEPARTMENT
ORDER BY Average_Salary ASC;

-- Task 44: Get department-wise maximum salary from employee table ordered by salary ascending
SELECT DEPARTMENT, MAX(SALARY) AS Max_Salary
FROM Employees
GROUP BY DEPARTMENT
ORDER BY Max_Salary ASC;

-- Task 45: Get department-wise minimum salary from employee table ordered by salary ascending
SELECT DEPARTMENT, MIN(SALARY) AS Min_Salary
FROM Employees
GROUP BY DEPARTMENT
ORDER BY Min_Salary ASC;

-- Task 46: Select number of employees joined with respect to year and month from employee table
SELECT YEAR(CONVERT(DATETIME, JOINING_DATE, 120)) AS Joining_Year,
    MONTH(CONVERT(DATETIME, JOINING_DATE, 120)) AS Joining_Month,
    COUNT(*) AS Number_Of_Employees
FROM Employees
GROUP BY YEAR(CONVERT(DATETIME, JOINING_DATE, 120)), MONTH(CONVERT(DATETIME, JOINING_DATE, 120));

-- Task 47: Select department, total salary with respect to a department where total salary greater than 800000 ordered by Total_Salary descending
SELECT DEPARTMENT, SUM(SALARY) AS Total_Salary
FROM Employees
GROUP BY DEPARTMENT
HAVING SUM(SALARY) > 800000
ORDER BY Total_Salary DESC;

-- Task 48: Select first_name, incentive amount from employee and incentive table for those employees who have incentives
SELECT e.FIRST_NAME, i.Incentive_Amount
FROM Employees e
    INNER JOIN Incentives i ON e.EMPLOYEE_ID = i.Employee_Ref_ID;

-- Task 49: Select first_name, incentive amount from employee and incentive table for those employees who have incentives and incentive amount greater than 3000
SELECT e.FIRST_NAME, i.Incentive_Amount
FROM Employees e
    INNER JOIN Incentives i ON e.EMPLOYEE_ID = i.Employee_Ref_ID
WHERE i.Incentive_Amount > 3000;

-- Task 50: Select first_name, incentive amount from employee and incentive table for all employees even if they didn't get incentives
SELECT e.FIRST_NAME, ISNULL(i.Incentive_Amount, 0) AS Incentive_Amount
FROM Employees e
    LEFT JOIN Incentives i ON e.EMPLOYEE_ID = i.Employee_Ref_ID;

-- Task 51: Select first_name, incentive amount from employee and incentive table for all employees who got incentives using LEFT JOIN
SELECT e.FIRST_NAME, i.Incentive_Amount
FROM Employees e
    LEFT JOIN Incentives i ON e.EMPLOYEE_ID = i.Employee_Ref_ID
WHERE i.Incentive_Amount IS NOT NULL;

-- Task 52: Select max incentive with respect to employee from employee and incentive table using subquery
SELECT EMPLOYEE_ID,
    (SELECT MAX(Incentive_Amount)
    FROM Incentives
    WHERE Employee_Ref_ID = e.EMPLOYEE_ID) AS Max_Incentive
FROM Employees e;

-- Task 53: Select TOP 2 salary from employee table
SELECT TOP 2
    SALARY
FROM Employees
ORDER BY SALARY DESC;

-- Task 54: Select TOP N salary from employee table (Replace 'N' with desired value)
DECLARE @N INT = 90;
-- Example: N = 3
SELECT TOP (@N)
    SALARY
FROM Employees
ORDER BY SALARY DESC;

-- Task 55: Select 2nd Highest salary from employee table
SELECT MAX(SALARY) AS Second_Highest_Salary
FROM Employees
WHERE SALARY < (SELECT MAX(SALARY)
FROM Employees);

-- Task 56: Select Nth Highest salary from employee table
DECLARE @N INT = 3;
-- Example: N = 3
SELECT DISTINCT SALARY
FROM Employees e1
WHERE @N = (SELECT COUNT(DISTINCT SALARY)
FROM Employees e2
WHERE e1.SALARY <= e2.SALARY);

-- Task 57: Select First_Name, LAST_NAME from employee table as separate rows
    SELECT FIRST_NAME AS Name
    FROM Employees
UNION ALL
    SELECT LAST_NAME AS Name
    FROM Employees;

-- Task 58: What is the difference between UNION and UNION ALL?
-- UNION removes duplicate records between queries.
-- UNION ALL includes all records, including duplicates.

-- Task 59: Select employee details from employee table if data exists in incentive table
SELECT e.*
FROM Employees e
WHERE EXISTS (SELECT 1
FROM Incentives i
WHERE e.EMPLOYEE_ID = i.Employee_Ref_ID);

-- Task 60: How to fetch data that are common in two query results?
-- Use INTERSECT to fetch common data.
    SELECT FIRST_NAME
    FROM Employees
INTERSECT
    SELECT FIRST_NAME
    FROM Incentives;

-- Task 61: Get Employee IDs of those employees who didn't receive incentives without using subquery
SELECT e.EMPLOYEE_ID
FROM Employees e
    LEFT JOIN Incentives i ON e.EMPLOYEE_ID = i.Employee_Ref_ID
WHERE i.Employee_Ref_ID IS NULL;

-- Task 62: Select 20% of salary from John, 10% of Salary for Roy and for others 15% of salary from employee table
SELECT FIRST_NAME,
    CASE 
           WHEN FIRST_NAME = 'John' THEN SALARY * 0.2
           WHEN FIRST_NAME = 'Roy' THEN SALARY * 0.1
           ELSE SALARY * 0.15
       END AS Adjusted_Salary
FROM Employees;

-- Task 63: Delete employee data from employee table who got incentives in incentive table
DELETE FROM Employees 
WHERE EMPLOYEE_ID IN (SELECT Employee_Ref_ID
FROM Incentives);

---- Task 64: Insert into employee table Last Name with a single quote (Special Character)
--INSERT INTO Employees (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT)
--VALUES (9, 'Special', 'O\'Connor', 500000, '01-MAR-16 12.00.00 AM', 'Banking');


-- Task 65: Select Last Name from employee table which contains only numbers
SELECT LAST_NAME
FROM Employees
WHERE ISNUMERIC(LAST_NAME) = 1;

-- Task 66: Write a query to rank employees based on their incentives for a month
SELECT e.EMPLOYEE_ID, e.FIRST_NAME, i.Incentive_Amount,
    RANK() OVER (ORDER BY i.Incentive_Amount DESC) AS Rank
FROM Employees e
    INNER JOIN Incentives i ON e.EMPLOYEE_ID = i.Employee_Ref_ID;

-- Task 67: Update incentive table where employee name is 'John'
UPDATE Incentives
SET Incentive_Amount = 6000
WHERE Employee_Ref_ID = (SELECT EMPLOYEE_ID
FROM Employees
WHERE FIRST_NAME = 'John');

-- Task 68: Write CREATE TABLE query for employee table
CREATE TABLE Employees
(
    EMPLOYEE_ID INT PRIMARY KEY,
    FIRST_NAME NVARCHAR(50),
    LAST_NAME NVARCHAR(50),
    SALARY INT,
    JOINING_DATE VARCHAR(100),
    DEPARTMENT NVARCHAR(50)
);

-- Task 69: Write CREATE TABLE query for incentives table
CREATE TABLE Incentives
(
    Employee_Ref_ID INT,
    Incentive_Date VARCHAR(100),
    Incentive_Amount INT
);