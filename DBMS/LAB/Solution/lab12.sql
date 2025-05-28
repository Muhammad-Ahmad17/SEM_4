-- A. Create database and tables
CREATE DATABASE students;
GO
USE students;
GO

CREATE TABLE StudentDetails (
    rollno INT PRIMARY KEY,
    s_name VARCHAR(100) NOT NULL,
    semester INT NOT NULL,
    age INT NOT NULL,
    dob DATETIME NOT NULL
);

CREATE TABLE ContactDetails (
    rollno INT,
    c_type VARCHAR(50) NOT NULL,
    c_number VARCHAR(20) NOT NULL,
    PRIMARY KEY (rollno, c_type),
    FOREIGN KEY (rollno) REFERENCES StudentDetails(rollno) ON DELETE NO ACTION
);

CREATE TABLE Address (
    rollno INT,
    houseno INT NOT NULL,
    streetno INT NOT NULL,
    block VARCHAR(10) NOT NULL,
    city VARCHAR(50) NOT NULL,
    PRIMARY KEY (rollno, houseno, streetno, block, city),
    FOREIGN KEY (rollno) REFERENCES StudentDetails(rollno) ON DELETE NO ACTION
);

-- B. OperationLog table
CREATE TABLE OperationLog (
    log_id INT IDENTITY(1,1) PRIMARY KEY,
    operation_type VARCHAR(50) NOT NULL,
    rollno INT NOT NULL,
    operation_time DATETIME NOT NULL,
    user_name VARCHAR(100) NOT NULL
);

-- C. Insert trigger with validation and logging
CREATE TRIGGER trg_StudentDetails_Insert
ON StudentDetails
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1 FROM inserted WHERE age > 20 OR semester != 1
    )
    BEGIN
        RAISERROR('Student must be 20 or younger and in 1st semester', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    INSERT INTO StudentDetails (rollno, s_name, semester, age, dob)
    SELECT rollno, s_name, semester, age, dob FROM inserted;

    INSERT INTO OperationLog (operation_type, rollno, operation_time, user_name)
    SELECT 'INSERT', rollno, GETDATE(), SYSTEM_USER FROM inserted;
END
GO

-- D. Backup tables
CREATE TABLE StudentDetailsBackup (
    backup_id INT IDENTITY(1,1) PRIMARY KEY,
    rollno INT NOT NULL,
    s_name VARCHAR(100) NOT NULL,
    semester INT NOT NULL,
    age INT NOT NULL,
    dob DATETIME NOT NULL,
    deleted_by VARCHAR(100) NOT NULL,
    deletion_time DATETIME NOT NULL
);

CREATE TABLE ContactDetailsBackup (
    backup_id INT IDENTITY(1,1) PRIMARY KEY,
    rollno INT NOT NULL,
    c_type VARCHAR(50) NOT NULL,
    c_number VARCHAR(20) NOT NULL,
    deleted_by VARCHAR(100) NOT NULL,
    deletion_time DATETIME NOT NULL
);

CREATE TABLE AddressBackup (
    backup_id INT IDENTITY(1,1) PRIMARY KEY,
    rollno INT NOT NULL,
    houseno INT NOT NULL,
    streetno INT NOT NULL,
    block VARCHAR(10) NOT NULL,
    city VARCHAR(50) NOT NULL,
    deleted_by VARCHAR(100) NOT NULL,
    deletion_time DATETIME NOT NULL
);

-- D. Delete trigger with backup and cascade
CREATE TRIGGER trg_StudentDetails_Delete
ON StudentDetails
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Backup StudentDetails
    INSERT INTO StudentDetailsBackup (rollno, s_name, semester, age, dob, deleted_by, deletion_time)
    SELECT rollno, s_name, semester, age, dob, SYSTEM_USER, GETDATE()
    FROM deleted;

    -- Backup ContactDetails
    INSERT INTO ContactDetailsBackup (rollno, c_type, c_number, deleted_by, deletion_time)
    SELECT c.rollno, c.c_type, c.c_number, SYSTEM_USER, GETDATE()
    FROM ContactDetails c
    INNER JOIN deleted d ON c.rollno = d.rollno;

    -- Backup Address
    INSERT INTO AddressBackup (rollno, houseno, streetno, block, city, deleted_by, deletion_time)
    SELECT a.rollno, a.houseno, a.streetno, a.block, a.city, SYSTEM_USER, GETDATE()
    FROM Address a
    INNER JOIN deleted d ON a.rollno = d.rollno;

    -- Delete related records
    DELETE FROM ContactDetails WHERE rollno IN (SELECT rollno FROM deleted);
    DELETE FROM Address WHERE rollno IN (SELECT rollno FROM deleted);
    DELETE FROM StudentDetails WHERE rollno IN (SELECT rollno FROM deleted);
END
GO

-- E. Changelog table
CREATE TABLE StudentChangeLog (
    change_id INT IDENTITY(1,1) PRIMARY KEY,
    rollno INT NOT NULL,
    column_name VARCHAR(50) NOT NULL,
    old_value VARCHAR(255),
    new_value VARCHAR(255),
    changed_by VARCHAR(100) NOT NULL,
    change_time DATETIME NOT NULL
);

-- E. Update trigger for changelog
CREATE TRIGGER trg_StudentDetails_Update
ON StudentDetails
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- s_name
    INSERT INTO StudentChangeLog (rollno, column_name, old_value, new_value, changed_by, change_time)
    SELECT d.rollno, 's_name', d.s_name, i.s_name, SYSTEM_USER, GETDATE()
    FROM deleted d INNER JOIN inserted i ON d.rollno = i.rollno
    WHERE ISNULL(d.s_name, '') <> ISNULL(i.s_name, '');

    -- semester
    INSERT INTO StudentChangeLog (rollno, column_name, old_value, new_value, changed_by, change_time)
    SELECT d.rollno, 'semester', CAST(d.semester AS VARCHAR), CAST(i.semester AS VARCHAR), SYSTEM_USER, GETDATE()
    FROM deleted d INNER JOIN inserted i ON d.rollno = i.rollno
    WHERE d.semester <> i.semester;

    -- age
    INSERT INTO StudentChangeLog (rollno, column_name, old_value, new_value, changed_by, change_time)
    SELECT d.rollno, 'age', CAST(d.age AS VARCHAR), CAST(i.age AS VARCHAR), SYSTEM_USER, GETDATE()
    FROM deleted d INNER JOIN inserted i ON d.rollno = i.rollno
    WHERE d.age <> i.age;

    -- dob
    INSERT INTO StudentChangeLog (rollno, column_name, old_value, new_value, changed_by, change_time)
    SELECT d.rollno, 'dob', CONVERT(VARCHAR, d.dob, 120), CONVERT(VARCHAR, i.dob, 120), SYSTEM_USER, GETDATE()
    FROM deleted d INNER JOIN inserted i ON d.rollno = i.rollno
    WHERE d.dob <> i.dob;
END
GO

-- F. Restrict DROP and ALTER on this database
CREATE TRIGGER tr_Prevent_Drop_Alter
ON DATABASE
FOR DROP_TABLE, ALTER_TABLE
AS
BEGIN
    ROLLBACK;
    RAISERROR('DROP and ALTER commands are not allowed on this database.', 16, 1);
END
GO



-- Test 1: Insert a valid student (should succeed and log the operation)
INSERT INTO StudentDetails (rollno, s_name, semester, age, dob)
VALUES (1, 'Ali', 1, 19, '2005-01-01');

SELECT * FROM StudentDetails;
SELECT * FROM OperationLog;

-- Test 2: Insert an invalid student (should fail and not insert)
-- Age > 20 (should fail)
BEGIN TRY
    INSERT INTO StudentDetails (rollno, s_name, semester, age, dob)
    VALUES (2, 'Sara', 1, 21, '2003-01-01');
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH

-- Semester != 1 (should fail)
BEGIN TRY
    INSERT INTO StudentDetails (rollno, s_name, semester, age, dob)
    VALUES (3, 'Ahmed', 2, 19, '2005-01-01');
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH

SELECT * FROM StudentDetails;
SELECT * FROM OperationLog;

-- Test 3: Add contact/address, then delete student (should backup and cascade)
INSERT INTO ContactDetails VALUES (1, 'Mobile', '03001234567');
INSERT INTO Address VALUES (1, 10, 5, 'A', 'Lahore');

DELETE FROM StudentDetails WHERE rollno = 1;

SELECT * FROM StudentDetailsBackup;
SELECT * FROM ContactDetailsBackup;
SELECT * FROM AddressBackup;

-- Test 4: Update a student (should log changes)
INSERT INTO StudentDetails (rollno, s_name, semester, age, dob)
VALUES (4, 'Bilal', 1, 18, '2006-01-01');

UPDATE StudentDetails SET s_name = 'Bilal Khan', age = 19 WHERE rollno = 4;

SELECT * FROM StudentChangeLog WHERE rollno = 4;

-- Test 5: Try to DROP or ALTER a table (should fail)
BEGIN TRY
    DROP TABLE StudentDetails;
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH

BEGIN TRY
    ALTER TABLE StudentDetails ADD testcol INT;
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH

-- task6
DROP TABLE StudentDetails; -- Should fail
    ALTER TABLE StudentDetails ADD testcol INT; -- Should fail