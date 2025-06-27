# 📘 E-Commerce Database Schema Documentation

## 🎯 Overview
This schema represents a robust, scalable e-commerce platform supporting multiple user roles (user, vendor, manager), product management, orders, payments, and review systems.

---

## 🧩 Tables and Relationships

### 1. role
Defines available roles in the system (e.g., user, vendor, manager).
```sql
CREATE TABLE role (
    id INT PRIMARY KEY IDENTITY,
    name VARCHAR(100) UNIQUE NOT NULL
);
```

### 2. site_user
Holds primary information about all users.
```sql
CREATE TABLE site_user (
    id INT PRIMARY KEY IDENTITY,
    full_name VARCHAR(100) NOT NULL,
    email_address VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT GETDATE()
);
```

### 3. user_role
Many-to-many relationship between users and roles.
```sql
CREATE TABLE user_role (
    id INT PRIMARY KEY IDENTITY,
    user_id INT NOT NULL,
    role_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES site_user(id) ON DELETE CASCADE,
    FOREIGN KEY (role_id) REFERENCES role(id) ON DELETE CASCADE
);
```

### 4. permissions
(Advanced RBAC) Stores allowed actions for each role.
```sql
CREATE TABLE permissions (
    id INT PRIMARY KEY IDENTITY,
    role_id INT NOT NULL,
    action VARCHAR(100) NOT NULL,
    FOREIGN KEY (role_id) REFERENCES role(id) ON DELETE CASCADE
);
```

### 5. vendor
Extends site_user for vendor-specific data.
```sql
CREATE TABLE vendor (
    id INT PRIMARY KEY IDENTITY,
    user_id INT UNIQUE NOT NULL,
    vendor_name VARCHAR(100) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES site_user(id) ON DELETE CASCADE
);
```

### 6. product
Stores all products offered on the platform.
```sql
CREATE TABLE product (
    id INT PRIMARY KEY IDENTITY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    base_price DECIMAL(10, 2) NOT NULL,
    created_at DATETIME DEFAULT GETDATE()
);
```

### 7. product_item
Vendor-specific instance of a product.
```sql
CREATE TABLE product_item (
    id INT PRIMARY KEY IDENTITY,
    product_id INT NOT NULL,
    vendor_id INT NOT NULL,
    stock_quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    is_active BIT DEFAULT 1,
    FOREIGN KEY (product_id) REFERENCES product(id) ON DELETE CASCADE,
    FOREIGN KEY (vendor_id) REFERENCES vendor(id) ON DELETE CASCADE
);
```

### 8. payment_method
Available payment options.
```sql
CREATE TABLE payment_method (
    id INT PRIMARY KEY IDENTITY,
    method_name VARCHAR(50) NOT NULL
);
```

### 9. shipping_method
Available shipping options.
```sql
CREATE TABLE shipping_method (
    id INT PRIMARY KEY IDENTITY,
    method_name VARCHAR(50) NOT NULL,
    shipping_cost DECIMAL(10, 2) NOT NULL
);
```

### 10. order_status
Tracks the current state of an order.
```sql
CREATE TABLE order_status (
    id INT PRIMARY KEY IDENTITY,
    status_name VARCHAR(50) NOT NULL
);
```

### 11. shop_order
Stores user orders.
```sql
CREATE TABLE shop_order (
    id INT PRIMARY KEY IDENTITY,
    user_id INT NOT NULL,
    payment_method_id INT,
    shipping_method_id INT,
    order_status_id INT,
    order_date DATETIME DEFAULT GETDATE(),
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (user_id) REFERENCES site_user(id),
    FOREIGN KEY (payment_method_id) REFERENCES payment_method(id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(id),
    FOREIGN KEY (order_status_id) REFERENCES order_status(id)
);
```

### 12. order_line
Line items of an order.
```sql
CREATE TABLE order_line (
    id INT PRIMARY KEY IDENTITY,
    order_id INT NOT NULL,
    product_item_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES shop_order(id) ON DELETE CASCADE,
    FOREIGN KEY (product_item_id) REFERENCES product_item(id)
);
```

### 13. user_review
Reviews left by users on products.
```sql
CREATE TABLE user_review (
    id INT PRIMARY KEY IDENTITY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES site_user(id),
    FOREIGN KEY (product_id) REFERENCES product(id)
);
```

### 14. vendor_analytics
Performance tracking for vendors.
```sql
CREATE TABLE vendor_analytics (
    id INT PRIMARY KEY IDENTITY,
    vendor_id INT NOT NULL,
    total_products INT DEFAULT 0,
    total_sales_amount DECIMAL(12, 2) DEFAULT 0.00,
    last_updated DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (vendor_id) REFERENCES vendor(id)
);
```

---

## 🔐 Roles & Permissions

| Role     | Capabilities                                    |
|----------|-------------------------------------------------|
| User     | Browse, buy, review                             |
| Vendor   | Manage products, view analytics                 |
| Manager  | Full access to users, orders, products, reviews|

---

## 📊 Ready for Python Analysis
- Load this schema into Python using pandas.read_sql()
- Use for:
  - Vendor performance analysis
  - Sales forecasting
  - Product popularity trends
  - Role-based usage breakdown

Let me know if you want the ERD visual as well!

---
---
---
Great! Here's a comprehensive list of **stored procedures** and **triggers** that you can add to your existing SQL architecture to enhance functionality, automation, and scalability — especially for managing users, vendors, and products.

---

## ✅ **Stored Procedures**

### 1. **Add New Site User**
```sql
CREATE PROCEDURE add_site_user
    @Email VARCHAR(255),
    @Phone VARCHAR(20),
    @Password VARCHAR(100),
    @RoleId INT
AS
BEGIN
    DECLARE @UserId INT;

    INSERT INTO site_user (email_address, phone_number, password)
    VALUES (@Email, @Phone, @Password);

    SET @UserId = SCOPE_IDENTITY();

    INSERT INTO user_role (user_id, role_id)
    VALUES (@UserId, @RoleId);
END;
```

---

### 2. **Add Vendor**
```sql
CREATE PROCEDURE add_vendor
    @UserId INT,
    @CompanyName VARCHAR(255),
    @Description TEXT,
    @AddressId INT
AS
BEGIN
    INSERT INTO vendor (user_id, company_name, description, address_id)
    VALUES (@UserId, @CompanyName, @Description, @AddressId);

    INSERT INTO user_role (user_id, role_id)
    SELECT @UserId, id FROM role WHERE name = 'vendor';
END;
```

---

### 3. **Add Product by Vendor**
```sql
CREATE PROCEDURE add_product_by_vendor
    @VendorId INT,
    @ProductId INT,
    @SKU VARCHAR(100),
    @Stock INT,
    @Price DECIMAL(10,2)
AS
BEGIN
    INSERT INTO product_item (product_id, sku, quantity_in_stock, price, vendor_id)
    VALUES (@ProductId, @SKU, @Stock, @Price, @VendorId);
END;
```

---

### 4. **Place Order**
(*Updated version of previous one*)
```sql
CREATE PROCEDURE place_order
    @UserId INT,
    @PaymentMethodId INT,
    @ShippingMethodId INT,
    @ProductItemId INT,
    @Quantity INT
AS
BEGIN
    DECLARE @Price DECIMAL(10,2), @Total DECIMAL(10,2);

    SELECT @Price = price FROM product_item WHERE id = @ProductItemId;
    SET @Total = @Price * @Quantity;

    INSERT INTO shop_order (user_id, payment_method_id, shipping_method_id, order_status_id, order_date, total_amount)
    VALUES (@UserId, @PaymentMethodId, @ShippingMethodId, 1, GETDATE(), @Total);

    DECLARE @OrderId INT = SCOPE_IDENTITY();

    INSERT INTO order_line (order_id, product_item_id, quantity, price)
    VALUES (@OrderId, @ProductItemId, @Quantity, @Price);

    UPDATE product_item
    SET quantity_in_stock = quantity_in_stock - @Quantity
    WHERE id = @ProductItemId;
END;
```

---

### 5. **Add Product Review**
```sql
CREATE PROCEDURE add_review
    @UserId INT,
    @ProductItemId INT,
    @Rating INT,
    @Comment TEXT
AS
BEGIN
    INSERT INTO user_review (user_id, ordered_product_id, rating, comment, review_date)
    VALUES (@UserId, @ProductItemId, @Rating, @Comment, GETDATE());
END;
```

---

## 🔁 **Triggers**

### 1. **Trigger: Log Product Additions**
```sql
CREATE TRIGGER trg_product_added
ON product_item
AFTER INSERT
AS
BEGIN
    PRINT 'New product item added by a vendor.';
END;
```

---

### 2. **Trigger: Ensure Product Stock Not Negative**
```sql
CREATE TRIGGER trg_stock_check
ON product_item
AFTER UPDATE
AS
BEGIN
    IF EXISTS (SELECT * FROM inserted WHERE quantity_in_stock < 0)
    BEGIN
        RAISERROR('Stock cannot be negative.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
```

---

### 3. **Trigger: Default Order Status**
```sql
CREATE TRIGGER trg_default_order_status
ON shop_order
AFTER INSERT
AS
BEGIN
    UPDATE shop_order
    SET order_status_id = 1
    WHERE order_status_id IS NULL;
END;
```

---

### 4. **Trigger: Auto-assign Role to New User**
```sql
CREATE TRIGGER trg_assign_default_role
ON site_user
AFTER INSERT
AS
BEGIN
    INSERT INTO user_role (user_id, role_id)
    SELECT id, (SELECT id FROM role WHERE name = 'user') FROM inserted;
END;
```

---

### 5. **Trigger: Track Vendor Changes**
```sql
CREATE TRIGGER trg_vendor_change_log
ON vendor
AFTER UPDATE
AS
BEGIN
    PRINT 'Vendor profile was updated.';
    -- Optionally insert into a vendor_log table
END;
```

---

Let me know if you want:
- Role-based access control examples
- Procedures for admins (like promoting users)
- Triggers for advanced actions like audit trails or logs

Want me to generate a complete SQL script with all of these combined?



----
---
---
Great! Based on your updated SQL schema and the need for role-based functionality, here are **stored procedures and triggers** that support **user and vendor roles**, along with **admin functions** like promoting users, managing products, and auditing actions.

---

## 🔐 **Stored Procedures for Role-Based Access**

### 1. `promote_user_to_vendor`
Promotes a `site_user` to `vendor` by inserting into the `vendor` table and assigning the vendor role.

```sql
CREATE PROCEDURE promote_user_to_vendor
    @UserId INT,
    @CompanyName VARCHAR(255),
    @Description TEXT,
    @AddressId INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM site_user WHERE id = @UserId)
    BEGIN
        INSERT INTO vendor (user_id, company_name, description, address_id)
        VALUES (@UserId, @CompanyName, @Description, @AddressId);

        DECLARE @VendorRoleId INT;
        SELECT @VendorRoleId = id FROM role WHERE name = 'vendor';

        INSERT INTO user_role (user_id, role_id) VALUES (@UserId, @VendorRoleId);
    END
END;
```

---

### 2. `assign_role_to_user`
General-purpose procedure to assign any role to any user.

```sql
CREATE PROCEDURE assign_role_to_user
    @UserId INT,
    @RoleName VARCHAR(50)
AS
BEGIN
    DECLARE @RoleId INT;
    SELECT @RoleId = id FROM role WHERE name = @RoleName;

    IF @RoleId IS NOT NULL
    BEGIN
        INSERT INTO user_role (user_id, role_id)
        VALUES (@UserId, @RoleId);
    END
END;
```

---

### 3. `add_product_by_vendor`
Allows a vendor to add a product and associate it with themselves.

```sql
CREATE PROCEDURE add_product_by_vendor
    @VendorId INT,
    @ProductName VARCHAR(255),
    @Description TEXT,
    @CategoryId INT,
    @SKU VARCHAR(100),
    @QuantityInStock INT,
    @Price DECIMAL(10, 2)
AS
BEGIN
    DECLARE @ProductId INT;

    INSERT INTO product (name, description, category_id)
    VALUES (@ProductName, @Description, @CategoryId);

    SET @ProductId = SCOPE_IDENTITY();

    INSERT INTO product_item (product_id, sku, quantity_in_stock, price, vendor_id)
    VALUES (@ProductId, @SKU, @QuantityInStock, @Price, @VendorId);
END;
```

---

## ⚙️ **Triggers**

### 1. Audit Trigger: `trg_audit_product_insert`
Logs all product additions.

```sql
CREATE TABLE product_audit (
    id INT IDENTITY(1,1) PRIMARY KEY,
    product_name VARCHAR(255),
    action_type VARCHAR(50),
    action_time DATETIME DEFAULT GETDATE()
);

CREATE TRIGGER trg_audit_product_insert
ON product
AFTER INSERT
AS
BEGIN
    INSERT INTO product_audit (product_name, action_type)
    SELECT name, 'INSERT' FROM inserted;
END;
```

---

### 2. Validation Trigger: Prevent duplicate SKU
```sql
CREATE TRIGGER trg_prevent_duplicate_sku
ON product_item
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM product_item p JOIN inserted i ON p.sku = i.sku)
    BEGIN
        RAISERROR ('Duplicate SKU is not allowed.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        INSERT INTO product_item (id, product_id, sku, quantity_in_stock, price, vendor_id)
        SELECT id, product_id, sku, quantity_in_stock, price, vendor_id FROM inserted;
    END
END;
```

---

## 🧑‍💻 Admin-Only Stored Procedure

### `get_all_users_with_roles`
Lists all users with their roles.

```sql
CREATE PROCEDURE get_all_users_with_roles
AS
BEGIN
    SELECT su.id AS user_id, su.email_address, r.name AS role
    FROM site_user su
    JOIN user_role ur ON su.id = ur.user_id
    JOIN role r ON ur.role_id = r.id
    ORDER BY su.id;
END;
```

---

Want me to add more like:

- Order tracking procedures?
- Review moderation?
- Login simulation or hashed password insertions?

Let me know what areas you want to focus on next!

----
---
---
---
Great choice! 🚚📦 Let's implement **Order Tracking Procedures** that allow users and admins to:

1. **Track order status by order ID**
2. **View order history by user**
3. **Update order status (admin-only / vendor-controlled)**
4. **See full order details (line items + shipping + status)**

---

## ✅ 1. `get_order_status_by_order_id`

Returns the current status of a specific order.

```sql
CREATE PROCEDURE get_order_status_by_order_id
    @OrderId INT
AS
BEGIN
    SELECT o.id AS order_id,
           os.name AS status,
           o.order_date,
           o.total_amount
    FROM shop_order o
    JOIN order_status os ON o.order_status_id = os.id
    WHERE o.id = @OrderId;
END;
```

---

## 📜 2. `get_user_order_history`

Lists all orders placed by a specific user.

```sql
CREATE PROCEDURE get_user_order_history
    @UserId INT
AS
BEGIN
    SELECT o.id AS order_id,
           o.order_date,
           os.name AS status,
           o.total_amount
    FROM shop_order o
    JOIN order_status os ON o.order_status_id = os.id
    WHERE o.user_id = @UserId
    ORDER BY o.order_date DESC;
END;
```

---

## 🔄 3. `update_order_status`

Updates the order status (admin or vendor should call this after validation).

```sql
CREATE PROCEDURE update_order_status
    @OrderId INT,
    @NewStatusId INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM shop_order WHERE id = @OrderId)
    BEGIN
        UPDATE shop_order
        SET order_status_id = @NewStatusId
        WHERE id = @OrderId;
    END
END;
```

✅ You can integrate **role-checking logic** in application layer (Node.js, .NET, etc.) to restrict access.

---

## 📦 4. `get_order_full_details`

Returns everything about the order: user, payment, shipping, status, and line items.

```sql
CREATE PROCEDURE get_order_full_details
    @OrderId INT
AS
BEGIN
    SELECT 
        o.id AS order_id,
        o.order_date,
        su.email_address AS user_email,
        os.name AS status,
        sm.name AS shipping_method,
        pm.provider AS payment_provider,
        ol.product_item_id,
        p.name AS product_name,
        ol.quantity,
        ol.price
    FROM shop_order o
    JOIN site_user su ON o.user_id = su.id
    JOIN order_status os ON o.order_status_id = os.id
    LEFT JOIN shipping_method sm ON o.shipping_method_id = sm.id
    LEFT JOIN user_payment_method pm ON o.payment_method_id = pm.id
    JOIN order_line ol ON o.id = ol.order_id
    JOIN product_item pi ON ol.product_item_id = pi.id
    JOIN product p ON pi.product_id = p.id
    WHERE o.id = @OrderId;
END;
```

---

Want to add **order cancellation**, **returns**, or **email alerts** next? Or should we move to **reporting procedures for admins**?




How Vendors Can Track Stock
View Current Stock:
Use the query or stored procedure (sp_vendor_stock_report) to see current stock levels, units sold, and stock status.
Example: Jane’s Tech Shop can run the query to see that Laptop Pro has 8 units left.
Monitor Stock Changes:
The trg_order_line_after_insert trigger automatically reduces stock when orders are placed.
The trg_product_item_stock_adjustment trigger logs manual stock changes for transparency.
Receive Low Stock Alerts:
The trg_product_item_low_stock trigger logs warnings in audit_log when stock drops below 5 units.
Vendors can query audit_log to see these warnings:
sql

Copy
SELECT * 
FROM audit_log 
WHERE action_type = 'low_stock_warning' 
AND [user_id] = 2; -- Jane Smith’s user_id
Analyze Sales and Stock Trends:
Use vendor_analytics to see total sales and product counts.
Combine with order_line data to analyze sales trends:
sql

Copy
SELECT 
    p.name AS product_name,
    SUM(ol.quantity) AS total_units_sold,
    SUM(ol.price * ol.quantity) AS total_revenue
FROM order_line ol
JOIN product_item pi ON ol.product_item_id = pi.id
JOIN product p ON pi.product_id = p.id
WHERE pi.vendor_id = 1
GROUP BY p.name;
Expected Output for Jane’s Tech Shop:
Laptop Pro, total_units_sold=2, total_revenue=2400.00
Smartphone X, total_units_sold=2, total_revenue=1800.00
Summary of Methods for Vendors to Track Stock
Existing Features:
product_item.stock_quantity tracks units left.
Triggers (trg_order_line_after_insert, trg_product_item_before_update) automate stock updates and prevent negative stock.
vendor_analytics tracks total active products.
New Features Added:
Query and stored procedure (sp_vendor_stock_report) for detailed stock reports.
Trigger (trg_product_item_low_stock) for low stock warnings.
Trigger (trg_product_item_stock_adjustment) to log manual stock changes.
How to Use:
Run queries or the stored procedure to view stock levels.
Monitor audit_log for low stock warnings and stock adjustments.
Analyze sales trends to plan restocking.
Example Scenario
Let’s say Jane’s Tech Shop (vendor id=1) wants to track their stock:

Run the Stock Report:
EXEC sp_vendor_stock_report @vendor_id = 1;
Sees Laptop Pro has 8 units, Smartphone X has 13 units, etc.
Place a New Order:
A customer orders 5 units of Laptop Pro (product_item_id=1).
The trg_order_line_after_insert trigger reduces stock from 8 to 3.
The trg_product_item_low_stock trigger logs a warning in audit_log since stock is now below 5.
Check Audit Logs:
Jane queries audit_log and sees the low stock warning.
Decides to restock by updating stock to 10.
The trg_product_item_stock_adjustment trigger logs this change.
Analyze Sales:
Jane uses the sales trend query to see that Laptop Pro has generated 2400.00 in revenue, indicating it’s a popular item worth restocking.
Summary of Arguments
Stock Tracking:
Vendors can track stock via product_item.stock_quantity, updated automatically by triggers.
Automation:
Triggers ensure stock is updated after orders and prevent invalid updates (e.g., negative stock).
Enhanced Features:
Added low stock alerts, manual adjustment logging, and a detailed stock report procedure.
Practical Use:
Vendors can use queries and audit logs to monitor stock levels, receive alerts, and plan inventory management.
If you’d like to implement more features (e.g., email notifications for low stock, a dashboard view for vendors), or move on to stored procedures as you mentioned earlier, let me know!