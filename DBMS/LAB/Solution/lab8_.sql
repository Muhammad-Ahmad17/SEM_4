create database temp;
go
use temp;
use master
drop database lab8

==============================1-NF==============================
CREATE TABLE Student (
    StdSSN    VARCHAR(10),
    StdCity   VARCHAR(50),
    StdClass  VARCHAR(10),
    OfferNo   VARCHAR(10),
    OffTerm   VARCHAR(10),
    OffYear   INT,
    EnrGrade  FLOAT,
    CourseNo  VARCHAR(10),
    CrsDesc   VARCHAR(50),
    PRIMARY KEY (StdSSN, OfferNo,CourseNo)
);


SELECT * from Student;



==============================2-NF==============================

CREATE TABLE Student1 (
    StdSSN    VARCHAR(10) PRIMARY KEY,
    StdCity   VARCHAR(50),
    StdClass  VARCHAR(10)
);

CREATE TABLE Offer (
    OfferNo   VARCHAR(10) PRIMARY KEY,
    OffTerm   VARCHAR(10),
    OffYear   INT,
    CourseNo  VARCHAR(10) -- cand key dep on enrollment table so 2nf
);

CREATE TABLE Enrollment (
    StdSSN    VARCHAR(10),
    OfferNo   VARCHAR(10),
    EnrGrade  FLOAT,
    PRIMARY KEY (StdSSN, OfferNo),
    FOREIGN KEY (StdSSN) REFERENCES Student1(StdSSN),
    FOREIGN KEY (OfferNo) REFERENCES Offer(OfferNo)
);


==============================3-NF==============================
CREATE TABLE Student2 (
    StdSSN    VARCHAR(10) PRIMARY KEY,
    StdCity   VARCHAR(50),
    StdClass  VARCHAR(10)
);
CREATE TABLE Course (
    CourseNo  VARCHAR(10) PRIMARY KEY,
    CrsDesc   VARCHAR(50)
);
CREATE TABLE Offer1 (
    OfferNo   VARCHAR(10) PRIMARY KEY,
    OffTerm   VARCHAR(10),
    OffYear   INT,
    CourseNo  VARCHAR(10),
    FOREIGN KEY (CourseNo) REFERENCES Course(CourseNo)
);
CREATE TABLE Enrollment1 (
    StdSSN    VARCHAR(10),
    OfferNo   VARCHAR(10),
    EnrGrade  FLOAT,
    PRIMARY KEY (StdSSN, OfferNo),
    FOREIGN KEY (StdSSN) REFERENCES Student2(StdSSN),
    FOREIGN KEY (OfferNo) REFERENCES Offer1(OfferNo)
);
-- For Student normalization
DELETE FROM Enrollment1;
DELETE FROM Offer1;
DELETE FROM Course;
DELETE FROM Student2;

DELETE FROM Enrollment;
DELETE FROM Offer;
DELETE FROM Student1;

DELETE FROM Student;


-- Insert new data for 1NF (from your image)
INSERT INTO Student VALUES
('S1', 'SEATTLE', 'JUN', 'O1', 'FALL', 2006, 3.5, 'C1', 'DB'),
('S1', 'SEATTLE', 'JUN', 'O2', 'FALL', 2006, 3.3, 'C2', 'VB'),
('S2', 'BOTHELL', 'JUN', 'O3', 'SPRING', 2007, 3.1, 'C3', 'OO'),
('S2', 'BOTHELL', 'JUN', 'O2', 'FALL', 2006, 3.4, 'C2', 'VB');

-- Insert new data for 2NF
INSERT INTO Student1 VALUES
('S1', 'SEATTLE', 'JUN'),
('S2', 'BOTHELL', 'JUN');

INSERT INTO Offer VALUES
('O1', 'FALL', 2006, 'C1'),
('O2', 'FALL', 2006, 'C2'),
('O3', 'SPRING', 2007, 'C3');

INSERT INTO Enrollment VALUES
('S1', 'O1', 3.5),
('S1', 'O2', 3.3),
('S2', 'O3', 3.1),
('S2', 'O2', 3.4);

-- Insert new data for 3NF
INSERT INTO Student2 VALUES
('S1', 'SEATTLE', 'JUN'),
('S2', 'BOTHELL', 'JUN');

INSERT INTO Course VALUES
('C1', 'DB'),
('C2', 'VB'),
('C3', 'OO');

INSERT INTO Offer1 VALUES
('O1', 'FALL', 2006, 'C1'),
('O2', 'FALL', 2006, 'C2'),
('O3', 'SPRING', 2007, 'C3');

INSERT INTO Enrollment1 VALUES
('S1', 'O1', 3.5),
('S1', 'O2', 3.3),
('S2', 'O3', 3.1),
('S2', 'O2', 3.4);
-- Return 1NF data from 2NF tables
SELECT 
    s.StdSSN, s.StdCity, s.StdClass,
    o.OfferNo, o.OffTerm, o.OffYear,
    e.EnrGrade, o.CourseNo, 
    -- Course description not available in 2NF, so leave NULL or join with 3NF if needed
    NULL AS CrsDesc
FROM Enrollment e
JOIN Student1 s ON e.StdSSN = s.StdSSN
JOIN Offer o ON e.OfferNo = o.OfferNo;
-- Return 1NF data from 3NF tables
SELECT 
    s.StdSSN, s.StdCity, s.StdClass,
    o.OfferNo, o.OffTerm, o.OffYear,
    e.EnrGrade, o.CourseNo, c.CrsDesc
FROM Enrollment1 e
JOIN Student2 s ON e.StdSSN = s.StdSSN
JOIN Offer1 o ON e.OfferNo = o.OfferNo
JOIN Course c ON o.CourseNo = c.CourseNo;


===============================================================================

-- ============================== 1NF ==============================
CREATE TABLE StaffBranchRaw (
    staffNo       VARCHAR(10),
    name          VARCHAR(50),
    position      VARCHAR(30),
    salary        INT,
    branchNo      VARCHAR(10),
    branchAddress VARCHAR(100),
    telNo         VARCHAR(20),
    PRIMARY KEY (staffNo, branchNo)
);

-- Sample data for 1NF
INSERT INTO StaffBranchRaw VALUES
('S1500', 'Tom Daniels', 'Manager', 46000, 'B001', '8 Jefferson Way, Portland, OR 97201', '503-555-3618'),
('S0003', 'Sally Adams', 'Assistant', 30000, 'B001', '8 Jefferson Way, Portland, OR 97201', '503-555-3618'),
('S0010', 'Mary Martinez', 'Manager', 50000, 'B002', 'City Center Plaza, Seattle, WA 98122', '206-555-6756'),
('S3250', 'Robert Chin', 'Supervisor', 32000, 'B002', 'City Center Plaza, Seattle, WA 98122', '206-555-6756'),
('S2250', 'Sally Stern', 'Manager', 48000, 'B004', '16 – 14th Avenue, Seattle, WA 98128', '206-555-3131'),
('S0415', 'Art Peters', 'Manager', 41000, 'B003', '14 – 8th Avenue, New York, NY 10012', '212-371-3000');

SELECT * FROM StaffBranchRaw;

-- ============================== 2NF ==============================
CREATE TABLE Staff (
    staffNo VARCHAR(10) PRIMARY KEY,
    name    VARCHAR(50),
    position VARCHAR(30),
    salary  INT
);

CREATE TABLE Branch (
    branchNo      VARCHAR(10) PRIMARY KEY,
    branchAddress VARCHAR(100),
    telNo         VARCHAR(20)
);

CREATE TABLE StaffBranch (
    staffNo  VARCHAR(10),
    branchNo VARCHAR(10),
    PRIMARY KEY (staffNo, branchNo),
    FOREIGN KEY (staffNo) REFERENCES Staff(staffNo),
    FOREIGN KEY (branchNo) REFERENCES Branch(branchNo)
);

-- Sample data for 2NF
INSERT INTO Staff VALUES
('S1500', 'Tom Daniels', 'Manager', 46000),
('S0003', 'Sally Adams', 'Assistant', 30000),
('S0010', 'Mary Martinez', 'Manager', 50000),
('S3250', 'Robert Chin', 'Supervisor', 32000),
('S2250', 'Sally Stern', 'Manager', 48000),
('S0415', 'Art Peters', 'Manager', 41000);

INSERT INTO Branch VALUES
('B001', '8 Jefferson Way, Portland, OR 97201', '503-555-3618'),
('B002', 'City Center Plaza, Seattle, WA 98122', '206-555-6756'),
('B003', '14 – 8th Avenue, New York, NY 10012', '212-371-3000'),
('B004', '16 – 14th Avenue, Seattle, WA 98128', '206-555-3131');

INSERT INTO StaffBranch VALUES
('S1500', 'B001'),
('S0003', 'B001'),
('S0010', 'B002'),
('S3250', 'B002'),
('S2250', 'B004'),
('S0415', 'B003');

-- Query to reconstruct 1NF view from 2NF
SELECT 
    s.staffNo, s.name, s.position, s.salary,
    b.branchNo, b.branchAddress, b.telNo
FROM StaffBranch sb
JOIN Staff s ON sb.staffNo = s.staffNo
JOIN Branch b ON sb.branchNo = b.branchNo;

-- ============================== 3NF ==============================
CREATE TABLE Position (
    position VARCHAR(30) PRIMARY KEY
);

CREATE TABLE Staff3NF (
    staffNo VARCHAR(10) PRIMARY KEY,
    name    VARCHAR(50),
    position VARCHAR(30),
    salary  INT,
    FOREIGN KEY (position) REFERENCES Position(position)
);

CREATE TABLE Branch3NF (
    branchNo      VARCHAR(10) PRIMARY KEY,
    branchAddress VARCHAR(100),
    telNo         VARCHAR(20)
);

CREATE TABLE StaffBranch3NF (
    staffNo  VARCHAR(10),
    branchNo VARCHAR(10),
    PRIMARY KEY (staffNo, branchNo),
    FOREIGN KEY (staffNo) REFERENCES Staff3NF(staffNo),
    FOREIGN KEY (branchNo) REFERENCES Branch3NF(branchNo)
);

-- Sample data for 3NF
INSERT INTO Position VALUES
('Manager'),
('Assistant'),
('Supervisor');

INSERT INTO Staff3NF VALUES
('S1500', 'Tom Daniels', 'Manager', 46000),
('S0003', 'Sally Adams', 'Assistant', 30000),
('S0010', 'Mary Martinez', 'Manager', 50000),
('S3250', 'Robert Chin', 'Supervisor', 32000),
('S2250', 'Sally Stern', 'Manager', 48000),
('S0415', 'Art Peters', 'Manager', 41000);

INSERT INTO Branch3NF VALUES
('B001', '8 Jefferson Way, Portland, OR 97201', '503-555-3618'),
('B002', 'City Center Plaza, Seattle, WA 98122', '206-555-6756'),
('B003', '14 – 8th Avenue, New York, NY 10012', '212-371-3000'),
('B004', '16 – 14th Avenue, Seattle, WA 98128', '206-555-3131');

INSERT INTO StaffBranch3NF VALUES
('S1500', 'B001'),
('S0003', 'B001'),
('S0010', 'B002'),
('S3250', 'B002'),
('S2250', 'B004'),
('S0415', 'B003');

-- Query to reconstruct 1NF view from 3NF
SELECT 
    s.staffNo, s.name, s.position, s.salary,
    b.branchNo, b.branchAddress, b.telNo
FROM StaffBranch3NF sb
JOIN Staff3NF s ON sb.staffNo = s.staffNo
JOIN Branch3NF b ON sb.branchNo = b.branchNo;