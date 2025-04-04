create database [delete_kar_:)];
use  [delete_kar_:)]


-- Create Employee Table
CREATE TABLE Employee (
    Fname VARCHAR(50),
    Lname VARCHAR(50),
    SSN CHAR(9) PRIMARY KEY,
    DNo INT
);

-- Create Department Table
CREATE TABLE Department (
    DName VARCHAR(50),
    DNum INT PRIMARY KEY,
    Mgr_SSN CHAR(9),
    FOREIGN KEY (Mgr_SSN) REFERENCES Employee(SSN)
);

-- Create Department Location Table
CREATE TABLE Dept_Location (
    DNo INT,
    Location VARCHAR(50),
    FOREIGN KEY (DNo) REFERENCES Department(DNum)
);

-- Create Project Table
CREATE TABLE Project (
    PName VARCHAR(50),
    PNo INT PRIMARY KEY,
    DNo INT,
    P_Loc VARCHAR(50),
    FOREIGN KEY (DNo) REFERENCES Department(DNum)
);

-- Create Works_On Table
CREATE TABLE Works_On (
    ESSN CHAR(9),
    PNo INT,
    Hours FLOAT,
    FOREIGN KEY (ESSN) REFERENCES Employee(SSN),
    FOREIGN KEY (PNo) REFERENCES Project(PNo)
);

-- Insert Data into Employee
INSERT INTO Employee (Fname, Lname, SSN, DNo) VALUES
('Josh', 'Smith', '123456789', 3),
('Alice', 'Brown', '889852162', 3),
('Jeremy', 'Jones', '665698745', 2),
('Olivia', 'Williams', '996788211', 3);

-- Insert Data into Department
INSERT INTO Department (DName, DNum, Mgr_SSN) VALUES
('Research', 3, '996788211'),
('Headquarters', 2, '665698745');

-- Insert Data into Department Location
INSERT INTO Dept_Location (DNo, Location) VALUES
(3, 'Houston'),
(2, 'Stafford'),
(2, 'Sugarland');

-- Insert Data into Project
INSERT INTO Project (PName, PNo, DNo, P_Loc) VALUES
('ProductX', 10, 3, 'Houston'),
('ProductY', 20, 3, 'Houston'),
('ProductZ', 30, 2, 'Stafford');

-- Insert Data into Works_On
INSERT INTO Works_On (ESSN, PNo, Hours) VALUES
('123456789', 10, 32.5),
('665698745', 30, 40.0),
('889852162', 20, 35.0),
('996788211', 10, 30.5);




-------------------------------------------
select E.Fname,E.Lname 
from Employee E
join Department D on E.DNo = D.DNum
where Dname LIKE 'Headquarters';

---------------------------------------------
select P.PNo , D.DName , E.Fname + ' ' + E.Lname manager_name
from Project P
join Department D on D.DNum = P.DNo
join Employee E on E.SSN = D.Mgr_SSN
where P.P_Loc LIKE 'Stafford';

---------------------------------------------
select E.Fname + ' ' + E.Lname Emp_name
from Employee E
join Works_On W on W.ESSN = E.SSN
join Project P on P.PNo = W.PNo 
where P.DNo = 3;

---------------------------------------------
-- Projects where Smith is a worker
SELECT DISTINCT W.PNo
FROM Works_On W
JOIN Employee E ON W.ESSN = E.SSN
WHERE E.Lname = 'Smith'

UNION

-- Projects where Smith is a manager of the department controlling the project
SELECT DISTINCT P.PNo
FROM Project P
JOIN Department D ON P.DNo = D.DNum
JOIN Employee E ON D.Mgr_SSN = E.SSN
WHERE E.Lname = 'Smith';

-------------------------------
-- Employees who are working on projects as a worker
SELECT DISTINCT E.Fname, E.Lname, P.PNo, P.PName, P.P_Loc
FROM Employee E
JOIN Works_On W ON E.SSN = W.ESSN
JOIN Project P ON W.PNo = P.PNo

INTERSECT

-- Employees who are managing the department that controls the project
SELECT DISTINCT E.Fname, E.Lname, P.PNo, P.PName, P.P_Loc
FROM Employee E
JOIN Department D ON E.SSN = D.Mgr_SSN
JOIN Project P ON D.DNum = P.DNo;

---------------------------------------------
SELECT DISTINCT E.Fname, E.Lname, P.PNo, P.PName, P.P_Loc
FROM Employee E
JOIN Department D ON E.SSN = D.Mgr_SSN
JOIN Project P ON D.DNum = P.DNo
WHERE E.SSN NOT IN (SELECT ESSN FROM Works_On);