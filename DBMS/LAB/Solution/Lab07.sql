create database lab_7a
use lab_7a

CREATE TABLE orchestras (
    id INT PRIMARY KEY,
    name VARCHAR(32),
    rating DECIMAL(5,2),
    city_origin VARCHAR(32),
    country_origin VARCHAR(32),
    year INT
);

CREATE TABLE concerts (
    id INT PRIMARY KEY,
    city VARCHAR(64),
    country VARCHAR(32),
    year INT,
    rating DECIMAL(5,2),
    orchestra_id INT,
    FOREIGN KEY (orchestra_id) REFERENCES orchestras(id)
);

CREATE TABLE members (
    id INT PRIMARY KEY,
    name VARCHAR(64),
    position VARCHAR(32),
    experience INT,
    orchestra_id INT,
    wage INT,
    FOREIGN KEY (orchestra_id) REFERENCES orchestras(id)
);

INSERT INTO orchestras (id, name, rating, city_origin, country_origin, year) VALUES
(1, 'Symphony Stars', 4.8, 'New York', 'USA', 1995),
(2, 'Melody Masters', 4.6, 'London', 'UK', 1980),
(3, 'Harmonic Waves', 4.7, 'Berlin', 'Germany', 1990),
(4, 'Orchestra A', 4.5, 'Paris', 'France', 2000);

INSERT INTO concerts (id, city, country, year, rating, orchestra_id) VALUES
(1, 'Paris', 'France', 2013, 4.9, 1),
(2, 'Tokyo', 'Japan', 2023, 4.7, 2),
(3, 'Sydney', 'Australia', 2021, 4.6, 3),
(4, 'New York', 'USA', 2022, 4.8, 1);

INSERT INTO members (id, name, position, experience, orchestra_id, wage) VALUES
(1, 'Alice Johnson', 'Violinist', 10, 1, 60000),
(2, 'Bob Smith', 'Pianist', 12, 1, 70000),
(3, 'Charlie Davis', 'Cellist', 8, 2, 55000),
(4, 'David Wilson', 'Trumpet', 15, 3, 75000),
(5, 'Emma Brown', 'Drummer', 9, 2, 58000),
(6, 'Frank White', 'Violinist', 7, 3, 62000), 
(7, 'Grace Kelly', 'Violinist', 5, 4, 59000),
(8, 'Henry Adams', 'Pianist', 6, 4, 61000);
INSERT INTO members (id, name, position, experience, orchestra_id, wage) VALUES

(9, 'Henry Adams', 'Pianist', 6, 1, 61000),
(10, 'Henry Adams', 'Pianist', 6, 1, 61000);

-- 1. Find orchestras from cities where concerts were held in 2013
SELECT DISTINCT o.name 
FROM orchestras o
WHERE o.city_origin IN (
    SELECT DISTINCT c.city 
    FROM concerts c
    WHERE c.year = 2013
);

-- 2. Find members with experience >10 and from orchestras with rating ≥ 4.5
SELECT m.name, m.position 
FROM members m
JOIN orchestras o ON m.orchestra_id = o.id
WHERE m.experience > 10 AND o.rating >= 4.5;

-- 3. Find members earning more than the highest-paid violinist
SELECT m.name, m.position 
FROM members m
WHERE m.wage > (
    SELECT MAX(wage)  
    FROM members 
    WHERE position = 'Violinist'
);

-- 4. Find orchestras with more members than the average
SELECT o.name, COUNT(m.id) AS member_count 
FROM orchestras o
JOIN members m ON o.id = m.orchestra_id
GROUP BY o.name
HAVING COUNT(m.id) > (
    SELECT AVG(member_count)
    FROM (
        SELECT COUNT(id) AS member_count 
        FROM members 
        GROUP BY orchestra_id
    ) AS avg_members
);

-- 5. Find orchestras with ≤3 members
SELECT o.name 
FROM orchestras o
JOIN members m ON o.id = m.orchestra_id
GROUP BY o.id, o.name
HAVING COUNT(m.id) <= 3;
