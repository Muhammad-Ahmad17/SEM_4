-- Step 1: Create a single database to store both tables
CREATE DATABASE Company;
GO

-- Step 2: Use CompanyDB
USE Company;
GO


-- Step 3: Create Departments table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,  -- Unique ID for each department
    DepartmentName VARCHAR(50) NOT NULL -- Name of the department
);
GO

-- Step 4: Insert sample departments
INSERT INTO Departments (DepartmentID, DepartmentName) 
VALUES (1, 'HR'), (2, 'IT'), (3, 'Finance');
GO


-- Step 5: Create Employees table with a foreign key reference to Departments
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY, -- Unique Employee ID
    Name VARCHAR(100) NOT NULL, -- Employee Name
    DepartmentID INT, -- Foreign Key references Departments table
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID) -- Foreign key within the same database
);
GO

-- Step 6: Insert sample employees
INSERT INTO Employees (EmployeeID, Name, DepartmentID)
VALUES (101, 'Alice', 1),  -- Alice works in HR
       (102, 'Bob', 2),    -- Bob works in IT
       (103, 'Charlie', NULL); -- Charlie has no assigned department
GO

select * from Departments
select * from Employees

-- Step 7: Try deleting a department without CASCADE (Should Fail)
PRINT 'Attempting to delete Department 1 (HR) - Expected to fail';
DELETE FROM Departments WHERE DepartmentID = 1;
-- ❌ This will fail because Employee Alice (ID 101) is still linked to HR.

-- Step 8: Modify the Foreign Key to ON DELETE CASCADE (Auto-delete employees)
PRINT 'Updating foreign key to ON DELETE CASCADE';
ALTER TABLE Employees DROP CONSTRAINT Employees_DepartmentID_FK;
ALTER TABLE Employees
ADD CONSTRAINT Employees_DepartmentID_FK
FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
ON DELETE CASCADE;
GO

-- Step 9: Test CASCADE delete (Deleting IT Department should delete Bob)
PRINT 'Deleting Department 2 (IT) - Employee Bob should be deleted';
DELETE FROM Departments WHERE DepartmentID = 2;
GO

-- Step 10: Modify the Foreign Key to ON DELETE SET NULL (Keep employees but remove reference)
PRINT 'Updating foreign key to ON DELETE SET NULL';
ALTER TABLE Employees DROP CONSTRAINT Employees_DepartmentID_FK;
ALTER TABLE Employees
ADD CONSTRAINT Employees_DepartmentID_FK
FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
ON DELETE SET NULL;
GO

-- Step 11: Test SET NULL delete (Deleting HR Department should set Alice's DepartmentID to NULL)
PRINT 'Deleting Department 1 (HR) - Alice should remain but have NULL DepartmentID';
DELETE FROM Departments WHERE DepartmentID = 1;
GO

-- Step 12: View final Employees table
PRINT 'Final Employees Table:';
SELECT * FROM Employees;
GO






