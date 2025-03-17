--task--
create database lab3
use lab3
---------------------------  A  ---------------------------

--task1
CREATE TABLE Table2 (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(255),
    ContactName VARCHAR(255),
    Address VARCHAR(255),
    City VARCHAR(255),
    PostalCode VARCHAR(50),
    Country VARCHAR(255)
);

SELECT * FROM Table2;

INSERT INTO Table2 
VALUES
(1, 'Alfreds Futterkiste', 'Maria Anders', 'Obere Str. 57', 'Berlin', '12209', 'Germany'),
(2, 'Ana Trujillo Emparedados y helados', 'Ana Trujillo', 'Avda. de la Constitución 2222', 'México D.F.', '05021', 'Mexico'),
(3, 'Antonio Moreno Taqueria', 'Antonio Moreno', 'Mataderos 2312', 'México D.F.', '05023', 'Mexico'),
(4, 'Around the Horn', 'Thomas Hardy', '120 Hanover Sq.', 'London', 'WA1 1DP', 'UK'),
(5, 'Berglunds snabbköp', 'Christina Berglund', 'Berguvsvägen 8', 'Lulea', 'S-958 22', 'Sweden');



--task2(starting with the letter “s”)
SELECT * FROM Table2 
WHERE City LIKE 'S%';
--prctise
SELECT * FROM Table2 
WHERE City LIKE '__n___'


--task3(end with the letter “s”)
SELECT * FROM Table2 
WHERE City LIKE '%s';

--task4(containing the pattern “land”)
SELECT * FROM Table2 
WHERE City LIKE '%land%';

--task5(not containing the pattern “land”)
SELECT * FROM Table2 
WHERE City NOT LIKE '%land%';

--task6( belong to “Germany” or “Sweden
--using in
SELECT TOP 2 * FROM Table2 
WHERE Country IN ('Mexico', 'Sweden');
--using or
SELECT TOP 2 * 
FROM Table2 
WHERE Country = 'Germany' OR Country = 'Sweden';
--task7
SELECT * FROM Table2 
WHERE City IN ('Paris', 'London');


---------------------------  B  ---------------------------
--TASK1
CREATE TABLE Table3 (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(255),
    SupplierID INT,
    CategoryID INT,
    Unit VARCHAR(255),
    Price DECIMAL(10,2)
);
INSERT INTO Table3
VALUES
(1, 'Chais', 1, 1, '10 boxes x 20 bags', 18),
(2, 'Chang', 1, 1, '24 - 12 oz bottles', 19),
(3, 'Aniseed Syrup', 1, 2, '12 - 550 ml bottles', 10),
(4, 'Chef Anton''s Cajun Seasoning', 1, 2, '48 - 6 oz jars', 22),
(5, 'Chef Anton''s Gumbo Mix', 1, 2, '36 boxes', 21.35);

--TASK2(products with a price from 10 to 20.)
SELECT ProductName,Price FROM Table3 
WHERE Price BETWEEN 10 AND 20;

--TASK3(products with a price from 20 to 30.)
SELECT ProductName,Price FROM Table3 
WHERE Price BETWEEN 20 AND 30;

--TASK4
SELECT * FROM Table3 
WHERE Price BETWEEN 10 AND 22 
AND Unit NOT LIKE '%bags%';

SELECT * FROM Table3 
WHERE Price BETWEEN 10 AND 22 
AND (Unit LIKE '%' AND Unit NOT LIKE '%bags%');

--TASK5
SELECT * FROM Table3 
WHERE ProductName NOT BETWEEN 'C' AND 'M';


-- MO0O00REEEEEEEE

SELECT * FROM Table3 
WHERE Price > 15
ORDER BY Price DESC;

SELECT DISTINCT Price FROM Table3 
WHERE Price > 20
ORDER BY Price DESC;

SELECT CategoryID, COUNT(*) AS NumProducts
FROM Table3
GROUP BY CategoryID;

-- Select rows from a Table or View '' in schema 'SchemaName'
SELECT AVG(Price) AvgPrice FROM Table3
GROUP BY CategoryID
ORDER BY AvgPrice ASC;

