Below is a comprehensive documentation for your e-commerce app database project. It includes all entities, their relationships, verbs, cardinality, an ER diagram description, details on role-based access control (RBAC), stored procedures, transactions, triggers, and additional details. Since I cannot directly generate diagrams, I’ll describe the ER diagram in text format, which you can use to create the diagram in a tool like Lucidchart, Draw.io, or SQL Server Management Studio (SSMS).

---

# **E-Commerce App Database Documentation**

## **Overview**
This documentation outlines the database design and implementation for an e-commerce application. The system supports user registration, product management, cart operations, checkout, order tracking, reviews, and vendor analytics. It implements a role-based access control (RBAC) system to manage permissions, uses stored procedures and transactions for business logic, and employs triggers for data consistency and auditing.

---

## **Entities and Attributes**

### **1. user**
- **Purpose**: Stores user information.
- **Attributes**:
  - `id` (INT, PK, IDENTITY): Unique identifier for the user.
  - `full_name` (VARCHAR(255)): User’s full name.
  - `email_address` (VARCHAR(255), UNIQUE): User’s email (used for login).
  - `password` (VARCHAR(255)): Hashed password.
  - `created_at` (DATETIME): Timestamp of user creation.
  - `is_active` (BIT): Indicates if the user is active (1) or not (0).

### **2. role**
- **Purpose**: Defines roles in the system (e.g., buyer, vendor, admin).
- **Attributes**:
  - `id` (INT, PK, IDENTITY): Unique identifier for the role.
  - `name` (VARCHAR(50), UNIQUE): Role name (e.g., buyer, vendor, admin).

### **3. user_role**
- **Purpose**: Maps users to roles.
- **Attributes**:
  - `user_id` (INT, FK to `user.id`): References the user.
  - `role_id` (INT, FK to `role.id`): References the role.
  - `assigned_at` (DATETIME): Timestamp of role assignment.
  - `assigned_by` (INT, FK to `user.id`, NULLABLE): User who assigned the role (optional).
  - **Composite PK**: (`user_id`, `role_id`).

### **4. permissions**
- **Purpose**: Defines permissions for each role on specific resources.
- **Attributes**:
  - `id` (INT, PK, IDENTITY): Unique identifier for the permission.
  - `role_id` (INT, FK to `role.id`): References the role.
  - `resource` (VARCHAR(50)): Resource (e.g., product, order).
  - `action_type` (VARCHAR(50)): Action (e.g., read, write, delete).
  - `is_allowed` (BIT): Indicates if the action is allowed (1) or not (0).

### **5. vendor**
- **Purpose**: Stores vendor-specific information for users with the vendor role.
- **Attributes**:
  - `id` (INT, PK, IDENTITY): Unique identifier for the vendor.
  - `user_id` (INT, FK to `user.id`): References the user.
  - `vendor_name` (VARCHAR(255)): Name of the vendor’s store.
  - `status` (VARCHAR(50)): Vendor status (e.g., pending, approved).
  - `created_at` (DATETIME): Timestamp of vendor creation.

### **6. vendor_analytics**
- **Purpose**: Tracks analytics for vendors (e.g., total products, sales).
- **Attributes**:
  - `vendor_id` (INT, PK, FK to `vendor.id`): References the vendor.
  - `total_products` (INT): Number of active products by the vendor.
  - `total_sales_amount` (DECIMAL(10,2)): Total sales revenue.
  - `last_updated` (DATETIME): Timestamp of the last update.

### **7. product**
- **Purpose**: Stores product information.
- **Attributes**:
  - `id` (INT, PK, IDENTITY): Unique identifier for the product.
  - `name` (VARCHAR(255)): Product name.
  - `base_price` (DECIMAL(10,2)): Base price of the product.
  - `description` (VARCHAR(1000), NULLABLE): Product description.

### **8. product_item**
- **Purpose**: Represents specific items of a product sold by a vendor.
- **Attributes**:
  - `id` (INT, PK, IDENTITY): Unique identifier for the product item.
  - `product_id` (INT, FK to `product.id`): References the product.
  - `vendor_id` (INT, FK to `vendor.id`): References the vendor.
  - `stock_quantity` (INT): Current stock quantity.
  - `price` (DECIMAL(10,2)): Price set by the vendor.
  - `is_active` (BIT): Indicates if the item is active (1) or not (0).
  - `created_at` (DATETIME): Timestamp of item creation.

### **9. category**
- **Purpose**: Stores product categories.
- **Attributes**:
  - `id` (INT, PK, IDENTITY): Unique identifier for the category.
  - `name` (VARCHAR(255)): Category name.
  - `description` (VARCHAR(1000), NULLABLE): Category description.

### **10. product_category**
- **Purpose**: Maps products to categories.
- **Attributes**:
  - `product_id` (INT, FK to `product.id`): References the product.
  - `category_id` (INT, FK to `category.id`): References the category.
  - **Composite PK**: (`product_id`, `category_id`).

### **11. shop_order**
- **Purpose**: Stores customer orders.
- **Attributes**:
  - `id` (INT, PK, IDENTITY): Unique identifier for the order.
  - `user_id` (INT, FK to `user.id`): References the user who placed the order.
  - `order_status_id` (INT, FK to `order_status.id`): References the order status.
  - `total_amount` (DECIMAL(10,2)): Total amount of the order.
  - `order_date` (DATETIME): Date the order was placed.
  - `payment_method_id` (INT, FK to `payment_method.id`): References the payment method.
  - `shipping_method_id` (INT, FK to `shipping_method.id`): References the shipping method.

### **12. order_status**
- **Purpose**: Defines possible order statuses.
- **Attributes**:
  - `id` (INT, PK, IDENTITY): Unique identifier for the status.
  - `status_name` (VARCHAR(50)): Status name (e.g., Processing, Shipped, Delivered, Cancelled).

### **13. order_line**
- **Purpose**: Stores line items for each order.
- **Attributes**:
  - `id` (INT, PK, IDENTITY): Unique identifier for the line item.
  - `order_id` (INT, FK to `shop_order.id`): References the order.
  - `product_item_id` (INT, FK to `product_item.id`): References the product item.
  - `quantity` (INT): Quantity ordered.
  - `price` (DECIMAL(10,2)): Price per unit at the time of the order.

### **14. cart**
- **Purpose**: Stores items in a user’s cart.
- **Attributes**:
  - `user_id` (INT, FK to `user.id`): References the user.
  - `product_item_id` (INT, FK to `product_item.id`): References the product item.
  - `quantity` (INT): Quantity in the cart.
  - `added_at` (DATETIME): Timestamp when the item was added.
  - **Composite PK**: (`user_id`, `product_item_id`).

### **15. user_review**
- **Purpose**: Stores product reviews by users.
- **Attributes**:
  - `id` (INT, PK, IDENTITY): Unique identifier for the review.
  - `user_id` (INT, FK to `user.id`): References the user.
  - `product_id` (INT, FK to `product.id`): References the product.
  - `order_id` (INT, FK to `shop_order.id`): References the order.
  - `rating` (INT): Rating (1-5).
  - `review_text` (VARCHAR(1000)): Review text.
  - `created_at` (DATETIME): Timestamp of the review.

### **16. discount**
- **Purpose**: Stores discount codes.
- **Attributes**:
  - `id` (INT, PK, IDENTITY): Unique identifier for the discount.
  - `discount_code` (VARCHAR(50), UNIQUE): Discount code.
  - `discount_percentage` (DECIMAL(5,2)): Percentage discount (e.g., 10.00 for 10%).
  - `start_date` (DATETIME): Start date of the discount.
  - `end_date` (DATETIME): End date of the discount.
  - `is_active` (BIT): Indicates if the discount is active (1) or not (0).

### **17. payment_method**
- **Purpose**: Defines payment methods.
- **Attributes**:
  - `id` (INT, PK, IDENTITY): Unique identifier for the payment method.
  - `method_name` (VARCHAR(50)): Payment method name (e.g., Credit Card, PayPal).

### **18. shipping_method**
- **Purpose**: Defines shipping methods.
- **Attributes**:
  - `id` (INT, PK, IDENTITY): Unique identifier for the shipping method.
  - `method_name` (VARCHAR(50)): Shipping method name (e.g., Standard, Express).
  - `shipping_cost` (DECIMAL(10,2)): Cost of shipping.

### **19. address**
- **Purpose**: Stores user addresses.
- **Attributes**:
  - `id` (INT, PK, IDENTITY): Unique identifier for the address.
  - `user_id` (INT, FK to `user.id`): References the user.
  - `street` (VARCHAR(255)): Street address.
  - `city` (VARCHAR(100)): City.
  - `state` (VARCHAR(100)): State.
  - `zip_code` (VARCHAR(20)): ZIP code.
  - `country` (VARCHAR(100)): Country.

### **20. audit_log**
- **Purpose**: Logs system activities for auditing.
- **Attributes**:
  - `id` (INT, PK, IDENTITY): Unique identifier for the log entry.
  - `user_id` (INT, FK to `user.id`, NULLABLE): References the user (optional).
  - `action_type` (VARCHAR(50)): Type of action (e.g., user_created, order_placed).
  - `details` (VARCHAR(1000)): Details of the action.
  - `created_at` (DATETIME): Timestamp of the log entry.

---

## **Relationships, Verbs, and Cardinality**

| **Entity 1**      | **Verb**         | **Entity 2**      | **Cardinality**         | **Description**                                                                 |
|-------------------|------------------|-------------------|-------------------------|---------------------------------------------------------------------------------|
| `user`            | has              | `role`            | Many-to-Many (via `user_role`) | A user can have multiple roles, and a role can be assigned to multiple users.  |
| `user`            | owns             | `vendor`          | One-to-One             | A user can own one vendor (if they have the vendor role).                      |
| `vendor`          | has              | `vendor_analytics`| One-to-One             | Each vendor has one analytics record.                                          |
| `vendor`          | sells            | `product_item`    | One-to-Many            | A vendor can sell multiple product items.                                      |
| `product`         | belongs to       | `category`        | Many-to-Many (via `product_category`) | A product can belong to multiple categories, and a category can have multiple products. |
| `product`         | has              | `product_item`    | One-to-Many            | A product can have multiple product items (sold by different vendors).        |
| `product`         | reviewed by      | `user`            | Many-to-Many (via `user_review`) | A product can be reviewed by multiple users, and a user can review multiple products. |
| `user`            | places           | `shop_order`      | One-to-Many            | A user can place multiple orders.                                              |
| `shop_order`      | contains         | `order_line`      | One-to-Many            | An order can contain multiple order lines.                                     |
| `order_line`      | includes         | `product_item`    | Many-to-One            | An order line includes one product item.                                       |
| `shop_order`      | has              | `order_status`    | Many-to-One            | An order has one status.                                                       |
| `shop_order`      | uses             | `payment_method`  | Many-to-One            | An order uses one payment method.                                              |
| `shop_order`      | ships via        | `shipping_method` | Many-to-One            | An order ships via one shipping method.                                        |
| `user`            | adds to          | `cart`            | One-to-Many            | A user can add multiple items to their cart.                                   |
| `cart`            | contains         | `product_item`    | Many-to-One            | A cart item contains one product item.                                         |
| `user`            | has              | `address`         | One-to-Many            | A user can have multiple addresses.                                            |
| `user`            | performs         | `audit_log`       | One-to-Many            | A user can perform multiple actions logged in the audit log.                   |

---

## **ER Diagram (Text Description)**

You can use this description to create an ER diagram in a tool like Lucidchart or Draw.io.

### **Entities and Attributes**
- **user**: (id, full_name, email_address, password, created_at, is_active)
- **role**: (id, name)
- **user_role**: (user_id, role_id, assigned_at, assigned_by)
- **permissions**: (id, role_id, resource, action_type, is_allowed)
- **vendor**: (id, user_id, vendor_name, status, created_at)
- **vendor_analytics**: (vendor_id, total_products, total_sales_amount, last_updated)
- **product**: (id, name, base_price, description)
- **product_item**: (id, product_id, vendor_id, stock_quantity, price, is_active, created_at)
- **category**: (id, name, description)
- **product_category**: (product_id, category_id)
- **shop_order**: (id, user_id, order_status_id, total_amount, order_date, payment_method_id, shipping_method_id)
- **order_status**: (id, status_name)
- **order_line**: (id, order_id, product_item_id, quantity, price)
- **cart**: (user_id, product_item_id, quantity, added_at)
- **user_review**: (id, user_id, product_id, order_id, rating, review_text, created_at)
- **discount**: (id, discount_code, discount_percentage, start_date, end_date, is_active)
- **payment_method**: (id, method_name)
- **shipping_method**: (id, method_name, shipping_cost)
- **address**: (id, user_id, street, city, state, zip_code, country)
- **audit_log**: (id, user_id, action_type, details, created_at)

### **Relationships**
- Draw a line between `user` and `role` with a diamond labeled “has” (via `user_role`).
- Connect `user` to `vendor` with a “owns” line (1:1).
- Connect `vendor` to `vendor_analytics` with a “has” line (1:1).
- Connect `vendor` to `product_item` with a “sells” line (1:N).
- Connect `product` to `category` with a “belongs to” line (via `product_category`).
- Connect `product` to `product_item` with a “has” line (1:N).
- Connect `product` to `user` with a “reviewed by” line (via `user_review`).
- Connect `user` to `shop_order` with a “places” line (1:N).
- Connect `shop_order` to `order_line` with a “contains” line (1:N).
- Connect `order_line` to `product_item` with an “includes” line (N:1).
- Connect `shop_order` to `order_status` with a “has” line (N:1).
- Connect `shop_order` to `payment_method` with a “uses” line (N:1).
- Connect `shop_order` to `shipping_method` with a “ships via” line (N:1).
- Connect `user` to `cart` with an “adds to” line (1:N).
- Connect `cart` to `product_item` with a “contains” line (N:1).
- Connect `user` to `address` with a “has” line (1:N).
- Connect `user` to `audit_log` with a “performs” line (1:N).

### **Cardinality**
- Use crow’s foot notation:
  - 1:1 (e.g., `user` to `vendor`): Single line on both ends.
  - 1:N (e.g., `vendor` to `product_item`): Single line on the “1” side, crow’s foot on the “N” side.
  - N:N (e.g., `user` to `role`): Crow’s foot on both ends, with `user_role` as the junction table.

---

## **Role-Based Access Control (RBAC)**

### **Overview**
The system implements a customized RBAC system to manage permissions, avoiding SQL’s `GRANT` and `REVOKE` mechanisms. Access control is enforced through roles, permissions, and application logic.

### **Components**
1. **Roles**:
   - Defined in the `role` table (e.g., buyer, vendor, admin).
   - Assigned to users via the `user_role` table (`sp_register_user` assigns roles during registration).

2. **Permissions**:
   - The `permissions` table defines what each role can do (e.g., `role_id=1` (buyer) can `read` on `product`, `is_allowed=1`).
   - The `trg_permissions_after_update` trigger logs changes to permissions in `audit_log`.

3. **Enforcement**:
   - Stored procedures and triggers enforce access rules based on roles:
     - `sp_add_vendor_product`: Only users with the vendor role can add products (assumed to be checked in the front-end or back-end logic).
     - `trg_user_review_before_insert`: Ensures only buyers who purchased a product can review it.
     - `trg_role_before_delete`: Prevents deletion of roles assigned to users, maintaining integrity.

4. **Why Not GRANT/REVOKE?**:
   - A `GRANT/REVOKE` approach would involve assigning SQL permissions directly to users (e.g., `GRANT SELECT ON product TO user1`), which is not scalable for a large user base.
   - Instead, RBAC centralizes access control in the database schema (`role`, `user_role`, `permissions`) and enforces it through application logic, making it easier to manage and audit.

---

## **Stored Procedures**

### **1. sp_vendor_stock_report**
- **Purpose**: Generates a stock report for a vendor.
- **Parameters**: `@vendor_id` (INT)
- **Logic**:
  - Joins `vendor`, `product_item`, and `product` to list products, stock quantities, prices, and units sold.
  - Includes a stock status (Low Stock Warning if stock < 5).
- **Transaction**: None (read-only).

### **2. sp_checkout**
- **Purpose**: Handles the checkout process.
- **Parameters**:
  - `@user_id` (INT), `@discount_code` (VARCHAR(50)), `@payment_method_id` (INT), `@shipping_method_id` (INT), `@order_id` (INT OUTPUT)
- **Logic**:
  - Validates stock using `vw_product_stock` (initial check and re-validation for critical items).
  - Locks critical `product_item` rows (`ROWLOCK, UPDLOCK`).
  - Validates and applies discount (locks `discount` table).
  - Creates an order in `shop_order`.
  - Adds order lines to `order_line`.
  - Clears the cart.
- **Transaction**: Uses a transaction with a savepoint to ensure atomicity.

### **3. sp_submit_review**
- **Purpose**: Submits a product review.
- **Parameters**:
  - `@user_id` (INT), `@product_id` (INT), `@order_id` (INT), `@rating` (INT), `@review_text` (VARCHAR(1000))
- **Logic**:
  - Inserts a review into `user_review`.
  - Trigger `trg_user_review_before_insert` validates that the user purchased the product.
- **Transaction**: Uses a transaction with a savepoint.

### **4. sp_vendor_sales_report**
- **Purpose**: Generates a sales report for a vendor.
- **Parameters**: `@vendor_id` (INT)
- **Logic**:
  - Joins `order_line`, `product_item`, and `product` to calculate units sold and revenue per product.
- **Transaction**: None (read-only).

### **5. sp_register_user**
- **Purpose**: Registers a new user.
- **Parameters**:
  - `@full_name` (VARCHAR(255)), `@email` (VARCHAR(255)), `@password` (VARCHAR(255)), `@role` (VARCHAR(50)), `@user_id` (INT OUTPUT)
- **Logic**:
  - Looks up `role_id` dynamically.
  - Inserts into `user`.
  - Assigns a role in `user_role`.
  - Creates a `vendor` record if the role is vendor.
- **Transaction**: Uses a transaction with a savepoint.

### **6. sp_add_vendor_product**
- **Purpose**: Adds a product item for a vendor.
- **Parameters**:
  - `@product_id` (INT), `@vendor_id` (INT), `@stock_quantity` (INT), `@price` (DECIMAL(10,2)), `@is_active` (BIT)
- **Logic**:
  - Validates `product_id` and `vendor_id`.
  - Inserts into `product_item`.
- **Transaction**: Uses a transaction with a savepoint.

### **7. sp_add_to_cart**
- **Purpose**: Adds an item to the cart.
- **Parameters**:
  - `@user_id` (INT), `@product_item_id` (INT), `@quantity` (INT)
- **Logic**:
  - Checks available stock with locking (`ROWLOCK, UPDLOCK`).
  - Uses `MERGE` to update or insert into `cart`.
- **Transaction**: Uses a transaction with a savepoint.

### **8. sp_cleanup_cart**
- **Purpose**: Cleans up old cart items.
- **Parameters**: None
- **Logic**:
  - Deletes cart items older than 15 minutes in batches.
- **Transaction**: Uses a transaction with a savepoint.

---

## **Transactions**

### **Transaction Management Strategy**
- All stored procedures that modify data use transactions with savepoints to ensure atomicity and support nested transactions.
- **Pattern**:
  - Check `@@TRANCOUNT` to determine if a transaction is already active.
  - Start a new transaction (`BEGIN TRANSACTION`) if none exists, or use a savepoint (`SAVE TRANSACTION`) if nested.
  - Commit the transaction only if it was started in the procedure (`IF @trancount = 0 COMMIT TRANSACTION`).
  - Roll back on error (`ROLLBACK TRANSACTION` or `ROLLBACK TRANSACTION @savepoint`).
- **Concurrency**:
  - `sp_checkout` and `sp_add_to_cart` use `ROWLOCK, UPDLOCK` to prevent race conditions during stock checks.
  - `sp_cleanup_cart` uses batch deletes with `ROWLOCK` to minimize contention.

### **Key Transactions**
- **sp_checkout**:
  - Ensures stock validation, order creation, and cart clearing are atomic.
  - Locks critical resources (`product_item`, `discount`) to prevent race conditions.
- **sp_add_to_cart**:
  - Ensures stock checks and cart updates are atomic.
  - Locks `product_item` during stock validation.
- **sp_cleanup_cart**:
  - Deletes old cart items in batches to reduce locking duration.

---

## **Triggers**

### **Overview**
The system includes 19 triggers to enforce business rules, maintain data consistency, and audit actions.

### **List of Triggers**
1. **`trg_user_after_insert`**: Logs user creation in `audit_log`.
2. **`trg_user_role_after_insert`**: Logs role assignments in `audit_log`.
3. **`trg_vendor_after_insert`**: Initializes `vendor_analytics` for new vendors.
4. **`trg_order_line_after_insert`**: Updates stock in `product_item` and `vendor_analytics` after an order line is added.
5. **`trg_product_item_low_stock`**: Logs low stock warnings (< 5 units) in `audit_log`.
6. **`trg_product_item_after_insert`**: Updates `vendor_analytics.total_products` when a new active product item is added.
7. **`trg_product_item_before_update`**: Prevents negative stock quantities.
8. **`trg_product_item_stock_adjustment`**: Logs stock adjustments in `audit_log`.
9. **`trg_user_review_before_insert`**: Ensures reviews are only for purchased products.
10. **`trg_shop_order_after_insert`**: Logs order creation in `audit_log`.
11. **`trg_order_status_before_update`**: Prevents updates to finalized orders (Delivered, Cancelled).
12. **`trg_discount_auto_deactivate`**: Deactivates expired discounts.
13. **`trg_order_status_after_update`**: Logs order status changes in `audit_log`.
14. **`trg_audit_log_before_delete`**: Prevents deletion of audit logs.
15. **`trg_role_before_delete`**: Prevents deletion of roles assigned to users.
16. **`trg_permissions_after_update`**: Logs permission changes in `audit_log`.
17. **`trg_address_after_update`**: Logs address updates in `audit_log`.
18. **`trg_category_before_delete`**: Prevents deletion of categories with products.
19. **`trg_product_after_insert`**: Logs product creation in `audit_log`.

### **Categories**
- **Auditing** (8): Logs actions (e.g., user creation, order placement, permission changes).
- **Data Consistency** (5): Maintains integrity (e.g., stock updates, vendor analytics).
- **Validation** (5): Enforces rules (e.g., prevent negative stock, ensure purchased products are reviewed).

---

## **Additional Details**

### **Views**
- **`vw_product_stock`**:
  - **Purpose**: Calculates available stock for each product item, considering reserved stock in carts.
  - **Definition**:
    ```sql
    CREATE VIEW vw_product_stock
    AS
    SELECT 
        pi.id AS product_item_id,
        pi.stock_quantity - COALESCE(SUM(c.quantity), 0) AS available_stock
    FROM product_item pi
    LEFT JOIN cart c ON pi.id = c.product_item_id
    GROUP BY pi.id, pi.stock_quantity;
    ```

### **Indexes**
- **Suggested Indexes**:
  - `user(email_address)`: For login queries.
  - `cart(user_id, product_item_id)`: For cart operations.
  - `order_line(order_id, product_item_id)`: For order processing.
  - `product_item(vendor_id)`: For vendor stock reports.

### **Security Considerations**
- Passwords in the `user` table should be hashed (not stored in plain text).
- RBAC ensures users only perform actions allowed by their roles.
- Audit logs (`audit_log` table) track all significant actions for accountability.

### **Scalability**
- Batch deletes in `sp_cleanup_cart` prevent performance issues with large cart tables.
- Indexes on frequently queried columns improve performance.
- Two-phase stock checking in `sp_checkout` minimizes locking duration.

---

## **Conclusion**
This e-commerce database is a robust system that supports key functionalities while ensuring data consistency, security, and scalability. The RBAC system provides a scalable alternative to `GRANT/REVOKE`, stored procedures handle business logic, transactions ensure atomicity, and triggers enforce rules and auditing. You can use this documentation to present your project comprehensively, and the ER diagram description can be used to visualize the schema in a diagramming tool.

If you need further details or assistance with creating the ER diagram, let me know!