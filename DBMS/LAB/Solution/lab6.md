# SQL Operators Comparison

## 🔍 Comparison Table of SQL Operators

| Operator   | Purpose | Behavior | Performance | Key Considerations |
|------------|---------|----------|--------------|--------------------|
| `EXISTS`  | Checks if a subquery returns **at least one row** | Stops execution as soon as it finds a match | Efficient for large datasets | Best for checking existence without retrieving large result sets |
| `NOT EXISTS` | Checks if **no rows** exist in a subquery | Stops execution as soon as it finds a match | Efficient for finding missing data | Preferred over `NOT IN` (avoids `NULL` issues) |
| `IN` | Checks if a value exists in a **list or subquery result** | Compares all values in the list | Can be slow if the subquery returns many values | Works well for small datasets; avoid with large lists |
| `NOT IN` | Checks if a value **does not exist** in a list | Compares all values in the list | **Fails if NULLs exist in the subquery result** | Avoid when `NULL` values are possible; use `NOT EXISTS` instead |
| `ANY` | Compares a value with **any value** in a subquery result (like OR condition) | Returns `TRUE` if at least one condition is met | Efficient when used correctly | Used for conditions like `> ANY`, `= ANY` (acts like `IN`) |
| `ALL` | Compares a value with **all values** in a subquery result (like AND condition) | Returns `TRUE` only if the condition is met for **every value** in the list | Can be slow for large result sets | Used for conditions like `> ALL`, `< ALL` |

## 🛠 When to Use Each Operator
- ✅ **Use `EXISTS` / `NOT EXISTS`** for existence checks (more efficient).
- ✅ **Use `IN` / `NOT IN`** for value comparison, but **avoid `NOT IN` if `NULL` values exist**.
- ✅ **Use `ANY`** for comparisons with **at least one match** (`> ANY`, `= ANY`).
- ✅ **Use `ALL`** for comparisons where **all values must satisfy the condition** (`> ALL`, `< ALL`).

## 📌 Examples for `ANY` vs `ALL`
### `ANY` Example:
```sql
SELECT * FROM Employee WHERE Salary > ANY (SELECT Salary FROM Employee WHERE Dept_ID = 2);
```
- This selects employees whose salary is **greater than at least one salary** in Dept_ID 2.

### `ALL` Example:
```sql
SELECT * FROM Employee WHERE Salary > ALL (SELECT Salary FROM Employee WHERE Dept_ID = 2);
```
- This selects employees whose salary is **greater than every salary** in Dept_ID 2 (i.e., the highest salary in Dept_ID 2).

---
Would you like to expand this with more practical examples? 🚀

