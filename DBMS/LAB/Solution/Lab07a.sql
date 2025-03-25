create database lab_07;
use lab_07;

-- creating tables
CREATE TABLE Employee (
    E_ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Salary INT,
    Dept_ID INT
);

CREATE TABLE Department (
    Dept_ID INT PRIMARY KEY,
    Name VARCHAR(50) UNIQUE
);

-- inserting records
INSERT INTO Employee (E_ID, Name, Salary, Dept_ID) VALUES
(1, 'A', 10000, 1),
(2, 'B', 20000, 1),
(3, 'C', 30000, 1),
(4, 'D', 40000, 2),
(5, 'E', 50000, 2),
(6, 'F', 60000, 1),
(7, 'G', 70000, 1),
(8, 'H', 80000, 2),
(9, 'I', 90000, 3),
(10, 'J', 25000, 1),
(11, 'A', 30000, 4),
(12, 'K', 35000, 4),
(13, 'L', 40000, 4),
(14, 'E', 45000, 4);



INSERT INTO Department (Dept_ID, Name) VALUES
(1, 'HR'),
(2, 'QA'),
(3, 'IT'),
(4, 'Sales'),
(5, 'Marketing'),
(6, 'Production');

-- froiegn key
ALTER TABLE Employee
ADD CONSTRAINT FK_Employee_Department
FOREIGN KEY (Dept_ID) REFERENCES Department(Dept_ID)



--TASK_01:Give the names of all employees who are being underpaid with respect to average salaries of the employees
SELECT name,salary from Employee
where Salary < (select avg(Salary) from Employee);
--TASK_02:Give the names of the employees who work in department with 2 or more employees.

-- department have more then two employee
Select dept_ID from employee
Group by dept_ID
Having count(*)>=2

-- name of those employees
Select name,dept_ID from employee 
where dept_ID IN 
( Select dept_ID from employee
Group by dept_ID
Having count(*)>=2 )


--TASK_03:Retrieve the details of those employees who have salary higher than the average salary of employees in the respective department
Select * from employee e1
Where salary >
(
Select avg(salary) from employee e2
Where e1.dept_ID = e2.dept_ID  -- matching the e1 employee with the employee of subquery
)

--TASK_04: Fetch details of all employees whose salary is equal to any salary in QA department (include QA emp also)

Select e.salary, e.Name from employee e 
join department d 
on e.dept_id = d.dept_id
Where d.Name='QA'

Select * from employee emp
Where emp.salary = any (Select e.salary from employee e 
join department d 
on e.dept_id = d.dept_id
Where d.Name='QA' 
)
-- AND emp.Dept_ID <> (SELECT Dept_ID FROM Department WHERE Name = 'QA');

-- hardcode the id directly so we dont need join on the bases of fk
SELECT * FROM Employee WHERE Salary = ANY (SELECT Salary FROM Employee WHERE Dept_ID = 2);

-- using in 
SELECT * 
FROM Employee 
WHERE Salary IN (
    SELECT Salary 
    FROM Employee 
    WHERE Dept_ID = (
        SELECT Dept_ID FROM Department WHERE Name = 'QA'
    )
);
--TASK_05: Fetch details of all employees whose salary is greater than the salary of all employees in ‘QA’ Department.
SELECT * 
FROM Employee 
WHERE Salary > ALL ( 
    SELECT Salary 
    FROM Employee 
    WHERE Dept_ID = (
        SELECT Dept_ID FROM Department WHERE Name = 'QA'
    )
);

--Task 6:Fetch details of all departments which have employees working in them.

Select name from department d where 
exists (select * from employee e where e.dept_ID=d .Dept_ID)


--Task 7:Retrieve the same data from task 6 using IN operator

SELECT Name 
FROM Department 
WHERE Dept_ID IN (
    SELECT DISTINCT Dept_ID FROM Employee
);

-- Task 8:Retrieve the same data from task 6 using Joins
SELECT DISTINCT d.Name
FROM Department d
JOIN Employee e ON d.Dept_ID = e.Dept_ID;


--Task 9:Retrieve the details of those departments who don’t have any employees in them using NOT EXISTS operator
--Stops execution once a match is found
SELECT * FROM Department d
WHERE NOT EXISTS (
    SELECT * FROM Employee e WHERE e.Dept_ID = d.Dept_ID
);

--Task 10:Retrieve the details of those departments who don’t have any employees in them using NOT IN operator
--Compares every value in the list
SELECT * 
FROM Department 
WHERE Dept_ID NOT IN (
    SELECT DISTINCT Dept_ID FROM Employee
);








===========================================




