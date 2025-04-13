
---

### 💾 **Issues with Traditional File-Based Systems**

Before DBMS came into widespread use, data was stored using **file-based systems**, where each application had its own data files. This led to several problems:

#### 1. **Data Redundancy and Inconsistency**
- **Issue**: The same data is stored in multiple places (e.g., customer info in billing and shipping files).
- **Problem**: If one file is updated and the other is not, the data becomes inconsistent.
  
#### 2. **Difficulty in Accessing Data**
- **Issue**: File systems don’t support complex queries.
- **Problem**: Users had to write custom programs to retrieve specific data, which is inefficient.

#### 3. **Data Isolation**
- **Issue**: Data is scattered in various files, often in different formats.
- **Problem**: Integrating data from multiple sources is complex and error-prone.

#### 4. **Integrity Problems**
- **Issue**: No central mechanism to enforce rules (like a valid age range).
- **Problem**: It’s easy to enter invalid or conflicting data.

#### 5. **Atomicity Issues**
- **Issue**: File systems lack transaction management.
- **Problem**: If a process fails midway, data can be left in an inconsistent state.

#### 6. **Concurrent Access Anomalies**
- **Issue**: No control over multiple users accessing the same data.
- **Problem**: Leads to problems like lost updates or dirty reads.

#### 7. **Security Problems**
- **Issue**: File systems provide basic read/write permissions.
- **Problem**: Cannot enforce fine-grained access control (e.g., user can view salary but not edit it).

#### 8. **Scalability and Maintenance**
- **Issue**: As data grows, managing large sets of files becomes harder.
- **Problem**: Poor performance, difficult upgrades.

---

### ✅ **How Modern DBMS Address These Issues**

| **Issue**                         | **How DBMS Solves It**                                                                 |
|----------------------------------|----------------------------------------------------------------------------------------|
| Data Redundancy & Inconsistency  | Centralized database with normalization techniques avoids duplication.               |
| Difficult Data Access            | Query languages like **SQL** make data retrieval flexible and powerful.              |
| Data Isolation                   | Logical data models unify formats; data is accessed via common interfaces.           |
| Integrity Problems               | **Constraints** (e.g., primary key, foreign key, CHECK) enforce rules on data.       |
| Atomicity Issues                 | **Transactions** in DBMS ensure all-or-nothing updates (ACID properties).            |
| Concurrent Access                | Concurrency control and locking mechanisms prevent conflicts.                        |
| Security                         | Fine-grained **access control** (roles, permissions) ensures secure data access.     |
| Scalability & Maintenance        | DBMS support **indexing**, **partitioning**, and **backup/recovery** mechanisms.     |

---

### ⚖️ **Limitations of DBMS (Things Not Fully Solved)**

- **Complex setup**: DBMS are more complex and need trained personnel.
- **Cost**: Licensing and maintenance costs can be high.
- **Performance**: For very simple applications, file systems may perform faster.
- **Learning curve**: For small teams, it may be overkill.

---

### 🔚 Conclusion

Modern DBMS have **largely solved** the major issues with traditional file-based systems, offering **consistency**, **integrity**, **security**, and **efficient data access**. However, they come with trade-offs in terms of complexity and cost, which may or may not be justified depending on the application.


# 📘 Relational Algebra Queries for Hotel Database

## 🧩 Schema

We are working with the following relational schema:

```
Hotel(hotelNo, hotelName, city)
Room(roomNo, hotelNo, type, price)
Booking(hotelNo, guestNo, dateFrom, dateTo, roomNo)
Guest(guestNo, guestName, guestAddress)
```

## Adding different type of constraints

```sql

CREATE TABLE Room (
    roomNo INT PRIMARY KEY,  
    hotelNo INT,  
    type VARCHAR(20) CHECK (type IN ('Single', 'Double','Family')), 
    price DECIMAL(10, 2) CHECK (price BETWEEN 10 AND 100), 
    roomNo INT CHECK (roomNo BETWEEN 1 AND 100),  
    dateTo DATE,
    dateFrom DATE CHECK (dateFrom > CURRENT_DATE),  
    FOREIGN KEY (hotelNo) REFERENCES Hotel(hotelNo)  
);


```

## ✅ Question 1: Describe the relations produced by the following Relational Algebra Operations

### (a) Π hotelNo (σ price > 50 (Room))
- **Description**: Projects the `hotelNo` of rooms that cost more than 50.
- **Result**: A relation of hotel numbers having at least one room priced above 50.

### (b) σ Hotel.hotelNo = Room.hotelNo (Hotel × Room)
- **Description**: Performs a Cartesian product of `Hotel` and `Room`, then filters to only include tuples where `hotelNo` matches.
- **Result**: Natural join of `Hotel` and `Room` based on `hotelNo`.

### (c) Π hotelName (Hotel ⨝ Hotel.hotelNo = Room.hotelNo (σ price > 50 (Room)))
- **Description**: Select hotels that have at least one room with price > 50.
- **Result**: Names of such hotels.

### (d) Guest ⨝ (σ dateTo ≥ '1-Jan-2002' (Booking))
- **Description**: Join Guest with Booking where the checkout date is on or after 1-Jan-2002.
- **Result**: Guests with such bookings.

### (e) Hotel ⟕ Hotel.hotelNo = Room.hotelNo (σ price > 50 (Room))
- **Description**: Left outer join of Hotel with Room, for rooms priced above 50.
- **Result**: All hotels along with their expensive rooms (if any).

### (f) Π guestName, hotelNo ((Booking ⨝ Guest) ÷ Π hotelNo (σ city = 'London'(Hotel)))
- **Description**: Retrieves names of guests who have bookings in *all* London hotels.
- **Note**: Hotel name is not included due to the requirement of division operator only involving `guestName` and `hotelNo`.

---

## ✅ Question 2: Relational Algebra for Queries

### (a) List all hotels.
```relational-algebra
Hotel
```

### (b) List all single rooms with price < £20
```relational-algebra
σ type = 'Single' ∧ price < 20 (Room)
```

### (c) List names and cities of all guests.
```relational-algebra
Π guestName, guestAddress (Guest)
```

### (d) List price and type of rooms at Grosvenor Hotel.
```relational-algebra
Π type, price (
  σ hotelName = 'Grosvenor Hotel' (Hotel) ⨝ Hotel.hotelNo = Room.hotelNo Room
)
```

### (e) List all guests currently staying at Grosvenor Hotel.
```relational-algebra
Π guestNo, guestName, guestAddress (
  Guest ⨝ Guest.guestNo = Booking.guestNo (
    σ hotelName = 'Grosvenor Hotel' ∧ dateFrom ≤ 'today' ∧ dateTo ≥ 'today' (
      Hotel ⨝ Hotel.hotelNo = Booking.hotelNo
    )
  )
)
```

### (f) List details of all rooms at Grosvenor Hotel, with guest name if occupied.
```relational-algebra
Π roomNo, type, price, guestName (
  σ hotelName = 'Grosvenor Hotel' (Hotel)
  ⨝ Hotel.hotelNo = Room.hotelNo Room
  ⟕ (Booking ⨝ Booking.guestNo = Guest.guestNo)
)
```

### (g) List guest details of all guests staying at Grosvenor Hotel.
```relational-algebra
Π guestNo, guestName, guestAddress (
  Guest ⨝ Guest.guestNo = Booking.guestNo (
    σ hotelName = 'Grosvenor Hotel' (Hotel) ⨝ Hotel.hotelNo = Booking.hotelNo
  )
)
```

---
---

# 📚 Basic SQL Command Syntax Guide

This guide provides the formal syntax for the most common SQL operations: **SELECT**, **INSERT**, **UPDATE**, and **DELETE**. These commands are essential for interacting with data stored in a relational database.

---

## 🔍 SELECT – Retrieve Data from a Table

The `SELECT` statement is used to query data from one or more tables.

**Syntax:**

```sql
SELECT column1, column2, ...
FROM table_name
WHERE condition;
```

**Example:**

```sql
SELECT guestName, guestAddress
FROM Guest
WHERE guestName LIKE 'A%';
```

---

## ➕ INSERT – Insert Data into a Table

The `INSERT` statement is used to add new records to a table.

**Syntax:**

```sql
INSERT INTO table_name (column1, column2, ...)
VALUES (value1, value2, ...);
```

**Example:**

```sql
INSERT INTO Guest (guestNo, guestName, guestAddress)
VALUES (101, 'John Doe', '123 London St');
```

---

## 🔄 UPDATE – Modify Existing Records

The `UPDATE` statement is used to change existing data in a table.

**Syntax:**

```sql
UPDATE table_name
SET column1 = value1, column2 = value2, ...
WHERE condition;
```

**Example:**

```sql
UPDATE Room
SET price = price * 1.1
WHERE type = 'Single';
```

---

## ❌ DELETE – Remove Records from a Table

The `DELETE` statement is used to remove records that match a condition.

**Syntax:**

```sql
DELETE FROM table_name
WHERE condition;
```

**Example:**

```sql
DELETE FROM Booking
WHERE dateTo < '2024-01-01';
```

---
---

## 🧠 SQL Filtering Conditions (One-Liner Use Cases)

- **`AND`**: Retrieve rooms that are single and priced below £50.
  ```sql
  SELECT * FROM Room WHERE type = 'Single' AND price < 50;
  ```

- **`OR`**: Retrieve hotels located either in London or Bristol.
  ```sql
  SELECT * FROM Hotel WHERE city = 'London' OR city = 'Bristol';
  ```

- **`IN`**: Retrieve guests whose names are either Alice, Bob, or Charlie.
  ```sql
  SELECT * FROM Guest WHERE guestName IN ('Alice', 'Bob', 'Charlie');
  ```

- **`BETWEEN`**: Retrieve rooms with prices between £30 and £70.
  ```sql
  SELECT * FROM Room WHERE price BETWEEN 30 AND 70;
  ```

- **`NOT`**: Retrieve rooms that are not of type 'Double'.
  ```sql
  SELECT * FROM Room WHERE NOT type = 'Double';
  ```

---
---

# 📚 SQL Pattern-Match Search Condition: `LIKE` / `NOT LIKE`

In SQL, the `LIKE` and `NOT LIKE` operators are used to search for specific patterns in a column’s data. The `%` (percent) and `_` (underscore) are special characters, also known as **wildcards**, that allow for flexible pattern matching.

## Wildcard Characters:
- **`%`**: Represents **any sequence of zero or more characters**.
- **`_`**: Represents **any single character**.
- All other characters in the pattern represent themselves.

## Use Case: Find All Owners with "Glasgow" in Their Address

To search for the string `'Glasgow'` appearing anywhere within the `address` column of the `PrivateOwner` table, we can use the following pattern match:

### SQL Query:
```sql
SELECT * FROM PrivateOwner
WHERE address LIKE '%Glasgow%';
```
*This query retrieves all owners whose address contains the string ‘Glasgow’ anywhere within it.*

### Pattern Examples:

1. **`address LIKE 'H%'`**:
   - The first character must be 'H', and the rest of the string can be anything.
   - Example: `'Hamburg'`, `'Hawaii'`

2. **`address LIKE 'H___'`**:
   - There must be exactly four characters in the string, the first of which must be 'H'.
   - Example: `'Hope'`, `'Hill'`

3. **`address LIKE '%e'`**:
   - Any sequence of characters of length at least 1, with the last character being 'e'.
   - Example: `'Lake'`, `'Wine'`

4. **`address LIKE '%Glasgow%'`**:
   - A sequence of characters of any length, containing the string 'Glasgow' anywhere within it.
   - Example: `'123 Glasgow St'`, `'Near Glasgow Road'`

5. **`address NOT LIKE 'H%'`**:
   - The first character cannot be 'H'.
   - Example: This would exclude `'Hamburg'`, `'Hawaii'`, but match `'London'`, `'Paris'`.

---

## Escaping Special Characters

If the search string can include the pattern-matching characters (`%` or `_`), we can use an **escape character** to treat these symbols as regular characters. For instance, to search for the string `15%`, we can define an escape character (e.g., `#`).

### SQL Query:
```sql
SELECT * FROM PrivateOwner
WHERE address LIKE '15#%' ESCAPE '#';
```
*This query looks for the string `'15%'` (including the percent symbol) in the `address` column.*

---

### Summary:
- **`LIKE`**: Use to search for patterns with wildcards (e.g., `%`, `_`).
- **`NOT LIKE`**: Use to exclude patterns with wildcards.
- **Escape Character**: If searching for special characters (`%`, `_`), use `ESCAPE` to specify an escape character.


###  What if we want % as argument in query but it is used as wild card??

You can choose any character as your escape character (not limited to `#`), as long as it doesn't interfere with your data or query.

For example, you can use a backslash (`\`) as an escape character:

```sql
SELECT * FROM Documents
WHERE content LIKE '10\%' ESCAPE '\';
-- escape : 
--    'x/y' escape '/'  
-- result :
--    'xy'
```
In this query, `\%` is treated as a literal percent symbol, not as a wildcard.

---
---
### `ORDER BY` in SQL

The `ORDER BY` clause is used to **sort the result set** of a SQL query by one or more columns. You can sort in **ascending** (default) or **descending** order.

---

### 🔹 Syntax:
```sql
SELECT column1, column2, ...
FROM table_name
ORDER BY column1 [ASC|DESC], column2 [ASC|DESC], ...;
-- when you are appling order by you must first check that coloumn 
-- must be selected on which you are appling.
```

---

### 🔹 Options:
- **`ASC`**: Ascending order (default) – smallest to largest, A to Z.
- **`DESC`**: Descending order – largest to smallest, Z to A.

---

### 🔹 One-liner Use Cases:

1. **Sort hotels by city name in ascending order:**
   ```sql
   SELECT * FROM Hotel ORDER BY city ASC;
   ```

2. **Sort rooms by price from highest to lowest:**
   ```sql
   SELECT * FROM Room ORDER BY price DESC;
   ```

3. **Sort bookings by hotel number and then by date:**
   ```sql
   SELECT * FROM Booking ORDER BY hotelNo ASC, dateFrom DESC;
   ```

---
---

### 📊 SQL Aggregate Functions

Aggregate functions perform a **calculation on a set of values** and return a **single value**. These are commonly used with `GROUP BY` clauses to summarize data.

---

### 🔹 Common Aggregate Functions:

| Function | Description                          | Example Use Case |
|----------|--------------------------------------|------------------|
| `COUNT()` | Counts the number of rows            | Total bookings in a hotel |
| `SUM()`   | Calculates the total sum of a column | Total revenue from room prices |
| `AVG()`   | Calculates the average value         | Average room price |
| `MIN()`   | Finds the minimum value              | Cheapest room price |
| `MAX()`   | Finds the maximum value              | Most expensive room |

---

### 🔹 One-liner Use Cases:

1. **Count number of guests:**
   ```sql
   SELECT COUNT(*) FROM Guest;
   ```

2. **Find total booking count per hotel:**
   ```sql
   SELECT hotelNo, COUNT(*) 
   FROM Booking 
   GROUP BY hotelNo;
   ```

3. **Find distinct booking count per hotel:**
   ```sql
   SELECT hotelNo, COUNT(distinct bookingId) 
   FROM Booking 
   GROUP BY hotelNo;
   ```

4. **Calculate average room price:**
   ```sql
   SELECT AVG(price) FROM Room;
   ```

5. **Find minimum price of single rooms:**
   ```sql
   SELECT MIN(price) 
   FROM Room 
   WHERE type = 'Single';
   ```

6. **Get highest room price in 'Ritz' hotel:**
   ```sql
   SELECT MAX(price) 
   FROM Room 
   WHERE hotelNo = (
     SELECT hotelNo FROM Hotel WHERE hotelName = 'Ritz'
   );
   ```

---
---

## 🔎 What is the `HAVING` Clause?

The `HAVING` clause is used **to filter groups** of data **after aggregation**.

- Use `WHERE` to filter **rows before grouping**.
- Use `HAVING` to filter **groups after grouping**.

---

### 🧠 Why Not Use `WHERE` for Aggregates?

You **can't** use aggregate functions (`SUM()`, `AVG()`, `COUNT()`, etc.) in a `WHERE` clause because that clause runs **before** data is grouped.

That’s why SQL provides `HAVING`.

---

### 🧱 Syntax:

```sql
SELECT column, AGG_FUNC(column)
FROM table
GROUP BY column
HAVING condition_on_aggregate;
```

---

## ✅ Example 1: Hotels with More Than 3 Bookings

```sql
SELECT hotelNo, COUNT(*) AS totalBookings
FROM Booking
GROUP BY hotelNo
HAVING COUNT(*) > 3;
```

🧠 What it does:
- Groups data **by hotelNo**
- Counts how many bookings each hotel has
- **Shows only those with more than 3 bookings**

---

## ✅ Example 2: Room Types with Average Price Over £100

```sql
SELECT type, AVG(price) AS avgPrice
FROM Room
GROUP BY type
HAVING AVG(price) > 100;
```

---

## ✅ Example 3: Hotels in 'London' with more than 2 rooms priced over 50

```sql
SELECT h.hotelName, COUNT(*) AS countExpRooms
FROM Hotel h
JOIN Room r ON h.hotelNo = r.hotelNo
WHERE h.city = 'London' AND r.price > 50
GROUP BY h.hotelName
HAVING COUNT(*) > 2;
```

---

## 🔄 Quick Summary Table

| Clause  | When it's used           | Can use aggregates? |
|---------|--------------------------|----------------------|
| `WHERE` | Before grouping rows     | ❌ No                |
| `HAVING`| After grouping rows      | ✅ Yes               |

---
## Both WHERE and HAVING

### 🔍 **Scenario:**

> Find all **hotels in London** that have **more than 3 rooms priced above £100**.

---

### ✅ **SQL Query:**
```sql
SELECT h.hotelName, COUNT(*) AS expensiveRooms
FROM Hotel h
JOIN Room r ON h.hotelNo = r.hotelNo
WHERE h.city = 'London'        -- Filters rows before grouping
  AND r.price > 100            -- Filters rooms before aggregation
GROUP BY h.hotelName
HAVING COUNT(*) > 3;           -- Filters groups after aggregation
```

---

### 🔄 Explanation:

| Clause       | Purpose                                                                 |
|--------------|-------------------------------------------------------------------------|
| `WHERE`      | Filters only rooms from **London hotels** and **rooms priced over £100** |
| `GROUP BY`   | Groups the result **by hotelName**                                       |
| `HAVING`     | Filters groups to include only those with **more than 3 such rooms**     |

---

### 💡 Tip:
Think of it like this:
- `WHERE` → filter raw data (rows).
- `GROUP BY` → organize into groups.
- `HAVING` → filter whole groups.

---

---

## 🔸SubQuery 

### `ANY` / `SOME`

- They are **synonyms** — work exactly the same.
- Used to compare a value to **any single value** in a subquery result.
- Returns `TRUE` if **any one** of the comparisons is true.

### ✅ Example:

```sql
SELECT * 
FROM Room 
WHERE price > ANY (
  SELECT price 
  FROM Room 
  WHERE type = 'Single'
);
```

🧠 Meaning: Get rooms **with a price greater than the **lowest** priced single room**.

You can also use `= ANY`, `< ANY`, etc.

---

## 🔸 `ALL`

- Returns `TRUE` only if the condition is **true for every value** in the subquery.
- Think of it as "match **every** value in the set".

### ✅ Example:

```sql
SELECT * 
FROM Room 
WHERE price > ALL (
  SELECT price 
  FROM Room 
  WHERE type = 'Single'
);
```

🧠 Meaning: Get rooms **with a price greater than the **highest** priced single room**.

---

## 💡 Use Case Table

| Keyword | Meaning                              | Example Use Case                          |
|---------|--------------------------------------|-------------------------------------------|
| `ANY`   | True if it matches **at least one**  | Rooms priced above **any single** single room |
| `SOME`  | Same as `ANY`                        | (Just a synonym for `ANY`)                |
| `ALL`   | True if it matches **all**           | Rooms priced above **every** single room  |

---

## 🔍 Visual Comparison

Let's say the subquery returns prices: `30, 50, 100`

| Condition             | Result Description                  |
|-----------------------|-------------------------------------|
| `price > ANY (...)`   | True if price > 30                  |
| `price > ALL (...)`   | True if price > 100                 |
| `price = ANY (...)`   | True if price is 30 OR 50 OR 100    |

---

---

## 🟦 Simple Queries 

### 🔹 **5.7** List full details of all hotels.
```sql
SELECT * 
FROM Hotel;
```

---

### 🔹 **5.8** List full details of all hotels in London.
```sql
SELECT * 
FROM Hotel 
WHERE city = 'London';
```

---

### 🔹 **5.9** List the names and addresses of all guests living in London, alphabetically ordered by name.
```sql
SELECT guestName, guestAddress 
FROM Guest 
WHERE guestAddress LIKE '%London%' 
ORDER BY guestName ASC;
```

> 📝 You can use `LIKE '%London%'` to allow partial address matches.

---

### 🔹 **5.10** List all double or family rooms with a price below £40.00 per night, in ascending order of price.
```sql
SELECT * 
FROM Room 
WHERE (type = 'Double' OR type = 'Family') 
  AND price < 40 
ORDER BY price ASC;
```

---

### 🔹 **5.11** List the bookings for which no `dateTo` has been specified.
```sql
SELECT * 
FROM Booking 
WHERE dateTo IS NULL;
```

---

## 🟦 Aggregate Function Queries

### 🔹 **5.12** How many hotels are there?
```sql
SELECT COUNT(*) AS totalHotels
FROM Hotel;
```

📝 `COUNT(*)` counts all rows in the table.

---

### 🔹 **5.13** What is the average price of a room?
```sql
SELECT AVG(price) AS averageRoomPrice
FROM Room;
```

📝 `AVG()` returns the average of the `price` column.

---

### 🔹 **5.14** What is the total revenue per night from all double rooms?
```sql
SELECT SUM(price) AS totalDoubleRoomRevenue
FROM Room
WHERE type = 'Double';
```

📝 `SUM()` adds up all prices of double rooms.

---

### 🔹 **5.15** How many different guests have made bookings for August?
```sql
SELECT COUNT(DISTINCT guestNo) AS augustGuestCount
FROM Booking
WHERE MONTH(dateFrom) = 8;
```

📝 `COUNT(DISTINCT guestNo)` ensures **unique guests** are counted.
- Assumes `dateFrom` is of type `DATE`.
- Works in SQL Server. If you’re using another DBMS, `EXTRACT(MONTH FROM dateFrom)` may be used.

---

## 🟦 Subqueries and Joins

---

### 🔹 **5.16** List the price and type of all rooms at the Grosvenor Hotel.
```sql
SELECT R.price, R.type
FROM Room R
JOIN Hotel H ON R.hotelNo = H.hotelNo
WHERE H.hotelName = 'Grosvenor Hotel';
```

---

### 🔹 **5.17** List all guests currently staying at the Grosvenor Hotel.
```sql
SELECT DISTINCT G.guestNo, G.guestName, G.guestAddress
FROM Guest G
JOIN Booking B ON G.guestNo = B.guestNo
JOIN Hotel H ON B.hotelNo = H.hotelNo
WHERE H.hotelName = 'Grosvenor Hotel'
  AND GETDATE() BETWEEN B.dateFrom AND B.dateTo;
```

> 📝 `GETDATE()` gets the current system date in SQL Server. Adjust for other DBMS if needed.

---

### 🔹 **5.18** List the details of all rooms at the Grosvenor Hotel, including the name of the guest staying in the room, if the room is occupied.
```sql
SELECT R.roomNo, R.type, R.price, G.guestName
FROM Room R
JOIN Hotel H ON R.hotelNo = H.hotelNo
LEFT JOIN Booking B ON R.roomNo = B.roomNo AND R.hotelNo = B.hotelNo 
                     AND GETDATE() BETWEEN B.dateFrom AND B.dateTo
LEFT JOIN Guest G ON B.guestNo = G.guestNo
WHERE H.hotelName = 'Grosvenor Hotel';
```

> 📝 `LEFT JOIN` ensures even unoccupied rooms are listed with `NULL` in `guestName`.

---

### 🔹 **5.19** What is the total income from bookings for the Grosvenor Hotel today?
```sql
SELECT SUM(R.price) AS todayIncome
FROM Booking B
JOIN Room R ON B.roomNo = R.roomNo AND B.hotelNo = R.hotelNo
JOIN Hotel H ON B.hotelNo = H.hotelNo
WHERE H.hotelName = 'Grosvenor Hotel'
  AND GETDATE() BETWEEN B.dateFrom AND B.dateTo;
```

---

### 🔹 **5.20** List the rooms that are currently unoccupied at the Grosvenor Hotel.
```sql
SELECT R.roomNo, R.type, R.price
FROM Room R
JOIN Hotel H ON R.hotelNo = H.hotelNo
WHERE H.hotelName = 'Grosvenor Hotel'
  AND R.roomNo NOT IN (
    SELECT B.roomNo
    FROM Booking B
    WHERE GETDATE() BETWEEN B.dateFrom AND B.dateTo
      AND B.hotelNo = R.hotelNo
  );
```

---

### 🔹 **5.21** What is the lost income from unoccupied rooms at the Grosvenor Hotel?
```sql
SELECT SUM(R.price) AS lostIncome
FROM Room R
JOIN Hotel H ON R.hotelNo = H.hotelNo
WHERE H.hotelName = 'Grosvenor Hotel'
  AND R.roomNo NOT IN (
    SELECT B.roomNo
    FROM Booking B
    WHERE GETDATE() BETWEEN B.dateFrom AND B.dateTo
      AND B.hotelNo = R.hotelNo
  );
```

---
---

## 🟦 Grouping Queries
---

### 🔹 **5.22** List the number of rooms in each hotel.
```sql
SELECT hotelNo, COUNT(roomNo) AS numRooms
FROM Room
GROUP BY hotelNo;
```

---

### 🔹 **5.23** List the number of rooms in each hotel in London.
```sql
SELECT R.hotelNo, COUNT(R.roomNo) AS numRooms
FROM Room R
JOIN Hotel H ON R.hotelNo = H.hotelNo
WHERE H.city = 'London'
GROUP BY R.hotelNo;
```

---

### 🔹 **5.24** What is the average number of bookings for each hotel in August?
```sql
SELECT hotelNo, AVG(bookingsPerHotel) AS avgBookings
FROM (
    SELECT hotelNo, COUNT(*) AS bookingsPerHotel
    FROM Booking
    WHERE MONTH(dateFrom) = 8
    GROUP BY hotelNo
) AS subquery
GROUP BY hotelNo;
```

> 📝 The inner query calculates the number of bookings for each hotel in August, and the outer query calculates the average of those counts.

---

### 🔹 **5.25** What is the most commonly booked room type for each hotel in London?
```sql
SELECT hotelNo, type, COUNT(*) AS roomTypeCount
FROM Room R
JOIN Booking B ON R.roomNo = B.roomNo AND R.hotelNo = B.hotelNo
JOIN Hotel H ON R.hotelNo = H.hotelNo
WHERE H.city = 'London'
GROUP BY R.hotelNo, type
ORDER BY roomTypeCount DESC;
```

> 📝 This query returns all room types for each hotel in London, ordered by the number of bookings. If you want to limit it to only the most commonly booked type, use `LIMIT` or adjust the query accordingly for your DBMS.

---

### 🔹 **5.26** What is the lost income from unoccupied rooms at each hotel today?
```sql
SELECT R.hotelNo, SUM(R.price) AS lostIncome
FROM Room R
JOIN Hotel H ON R.hotelNo = H.hotelNo
WHERE R.roomNo NOT IN (
    SELECT B.roomNo
    FROM Booking B
    WHERE GETDATE() BETWEEN B.dateFrom AND B.dateTo
      AND B.hotelNo = R.hotelNo
)
GROUP BY R.hotelNo;
```

> 📝 This query calculates the total lost income from unoccupied rooms at each hotel by comparing the rooms with bookings for the current date (`GETDATE()`).

---