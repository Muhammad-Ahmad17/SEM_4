create database db_E_Commerce;
use db_E_Commerce;
-- E-Commerce Database Schema
-- Supports a multi-vendor platform with three roles: buyer, vendor, manager.
-- Users start as generic users and are assigned roles later.
-- Uses [user] to escape reserved keyword in SQL Server.
-- All CHECK constraint names are unique to avoid conflicts.
-- Includes address table for shipping/billing, category for product organization, and audit_log for tracking actions.

-- 1. [user]
-- Stores all users (buyers, vendors, managers).
CREATE TABLE [user] (
    id INT PRIMARY KEY IDENTITY,
    full_name VARCHAR(100) NOT NULL,
    email_address VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    is_active BIT DEFAULT 1
);

go 

-- 2. role
-- Defines the three roles: buyer, vendor, manager.
CREATE TABLE role (
    id INT PRIMARY KEY IDENTITY,
    name VARCHAR(50) UNIQUE NOT NULL,
    description VARCHAR(255),
    is_active BIT DEFAULT 1,
    created_at DATETIME DEFAULT GETDATE(),
    CONSTRAINT chk_role_name CHECK (name IN ('buyer', 'vendor', 'manager'))
);

 go 
-- 3. user_role
-- Maps users to roles (many-to-many).
CREATE TABLE user_role (
    id INT PRIMARY KEY IDENTITY,
    [user_id] INT NOT NULL,
    role_id INT NOT NULL,
    assigned_at DATETIME DEFAULT GETDATE(),
    assigned_by INT,
    FOREIGN KEY ([user_id]) REFERENCES [user](id) ON DELETE CASCADE,
    FOREIGN KEY (role_id) REFERENCES role(id) ON DELETE CASCADE,
    FOREIGN KEY (assigned_by) REFERENCES [user](id),
    CONSTRAINT uq_user_role UNIQUE ([user_id], role_id)
);

-- 4. permissions
-- Defines role-based permissions for RBAC.
CREATE TABLE permissions (
    id INT PRIMARY KEY IDENTITY,
    role_id INT NOT NULL,
    resource VARCHAR(50) NOT NULL,
    action_type VARCHAR(20) NOT NULL,
    is_allowed BIT DEFAULT 1,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (role_id) REFERENCES role(id) ON DELETE CASCADE,
    CONSTRAINT uq_permission UNIQUE (role_id, resource, action_type)
);

-- 5. vendor
-- Stores vendor-specific data for users with the 'vendor' role.
CREATE TABLE vendor (
    id INT PRIMARY KEY IDENTITY,
    [user_id] INT UNIQUE NOT NULL,
    vendor_name VARCHAR(100) NOT NULL,
    status VARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending', 'approved', 'suspended')),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY ([user_id]) REFERENCES [user](id) ON DELETE CASCADE
);

-- 6. address
-- Stores user addresses for shipping and billing.
CREATE TABLE address (
    id INT PRIMARY KEY IDENTITY,
    [user_id] INT NOT NULL,
    address_line1 VARCHAR(255) NOT NULL,
    address_line2 VARCHAR(100),
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100),
    postal_code VARCHAR(20) NOT NULL,
    country VARCHAR(100) NOT NULL,
    address_type VARCHAR(20) NOT NULL CHECK (address_type IN ('shipping', 'billing', 'both')),
    is_default BIT DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY ([user_id]) REFERENCES [user](id)
);

-- 7. category
-- Stores product categories with hierarchical support.
CREATE TABLE category (
    id INT PRIMARY KEY IDENTITY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    parent_id INT,
    is_active BIT DEFAULT 1,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (parent_id) REFERENCES category(id),
    CONSTRAINT uq_category_name UNIQUE (name, parent_id)
);

-- 8. product
-- Stores generic product information.
CREATE TABLE product (
    id INT PRIMARY KEY IDENTITY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    base_price DECIMAL(10, 2) NOT NULL,
    is_active BIT DEFAULT 1,
    created_at DATETIME DEFAULT GETDATE(),
    CONSTRAINT chk_product_base_price CHECK (base_price >= 0)
);

-- 9. product_category
-- Maps products to categories (many-to-many).
CREATE TABLE product_category (
    id INT PRIMARY KEY IDENTITY,
    product_id INT NOT NULL,
    category_id INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (product_id) REFERENCES product(id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES category(id) ON DELETE CASCADE,
    CONSTRAINT uq_product_category UNIQUE (product_id, category_id)
);

-- 10. product_item
-- Vendor-specific product instances (stock, pricing).
CREATE TABLE product_item (
    id INT PRIMARY KEY IDENTITY,
    product_id INT NOT NULL,
    vendor_id INT NOT NULL,
    stock_quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    is_active BIT DEFAULT 1,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (product_id) REFERENCES product(id) ON DELETE CASCADE,
    FOREIGN KEY (vendor_id) REFERENCES vendor(id) ON DELETE CASCADE,
    CONSTRAINT chk_product_item_stock_quantity CHECK (stock_quantity >= 0),
    CONSTRAINT chk_product_item_price CHECK (price >= 0)
);

-- 11. payment_method
-- Available payment options.
CREATE TABLE payment_method (
    id INT PRIMARY KEY IDENTITY,
    method_name VARCHAR(50) NOT NULL,
    is_active BIT DEFAULT 1
);

-- 12. shipping_method
-- Available shipping options.
CREATE TABLE shipping_method (
    id INT PRIMARY KEY IDENTITY,
    method_name VARCHAR(50) NOT NULL,
    shipping_cost DECIMAL(10, 2) NOT NULL,
    is_active BIT DEFAULT 1,
    CONSTRAINT chk_shipping_method_cost CHECK (shipping_cost >= 0)
);

-- 13. order_status
-- Tracks order states.
CREATE TABLE order_status (
    id INT PRIMARY KEY IDENTITY,
    status_name VARCHAR(50) NOT NULL,
    is_final BIT DEFAULT 0
);

-- 14. shop_order
-- Stores user orders with shipping and billing addresses.
CREATE TABLE shop_order (
    id INT PRIMARY KEY IDENTITY,
    [user_id] INT NOT NULL,
    payment_method_id INT,
    shipping_method_id INT,
    order_status_id INT,
    shipping_address_id INT,
    billing_address_id INT,
    order_date DATETIME DEFAULT GETDATE(),
    subtotal DECIMAL(10, 2),
    tax_amount DECIMAL(10, 2) DEFAULT 0.00,
    discount_amount DECIMAL(10, 2) DEFAULT 0.00,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY ([user_id]) REFERENCES [user](id),
    FOREIGN KEY (payment_method_id) REFERENCES payment_method(id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(id),
    FOREIGN KEY (order_status_id) REFERENCES order_status(id),
    FOREIGN KEY (shipping_address_id) REFERENCES address(id),
    FOREIGN KEY (billing_address_id) REFERENCES address(id),
    CONSTRAINT chk_shop_order_subtotal CHECK (subtotal >= 0),
    CONSTRAINT chk_shop_order_tax_amount CHECK (tax_amount >= 0),
    CONSTRAINT chk_shop_order_discount_amount CHECK (discount_amount >= 0),
    CONSTRAINT chk_shop_order_total_amount CHECK (total_amount >= 0)
);

-- 15. order_line
-- Line items in an order.
CREATE TABLE order_line (
    id INT PRIMARY KEY IDENTITY,
    order_id INT NOT NULL,
    product_item_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES shop_order(id) ON DELETE CASCADE,
    FOREIGN KEY (product_item_id) REFERENCES product_item(id),
    CONSTRAINT chk_order_line_quantity CHECK (quantity > 0),
    CONSTRAINT chk_order_line_price CHECK (price >= 0)
);

-- 16. user_review
-- Product reviews by users.
CREATE TABLE user_review (
    id INT PRIMARY KEY IDENTITY,
    [user_id] INT NOT NULL,
    product_id INT NOT NULL,
    order_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY ([user_id]) REFERENCES [user](id),
    FOREIGN KEY (product_id) REFERENCES product(id),
    FOREIGN KEY (order_id) REFERENCES shop_order(id)
    -- Note: Preventing vendors from reviewing their own products should be enforced in the application layer,
    -- as CHECK constraints cannot use subqueries. Alternatively, a trigger can be added later.
);

-- 17. audit_log
-- Tracks actions like purchases and stock updates.
CREATE TABLE audit_log (
    id INT PRIMARY KEY IDENTITY,
    [user_id] INT,
    action_type VARCHAR(50) NOT NULL CHECK (action_type IN ('purchase', 'stock_update', 'role_assignment', 'order_creation', 'vendor_approval')),
    details TEXT,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY ([user_id]) REFERENCES [user](id)
);

-- 18. vendor_analytics
-- Vendor performance metrics.
CREATE TABLE vendor_analytics (
    id INT PRIMARY KEY IDENTITY,
    vendor_id INT NOT NULL,
    total_products INT DEFAULT 0,
    total_sales_amount DECIMAL(12, 2) DEFAULT 0.00,
    last_updated DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (vendor_id) REFERENCES vendor(id),
    CONSTRAINT chk_vendor_analytics_total_products CHECK (total_products >= 0),
    CONSTRAINT chk_vendor_analytics_total_sales_amount CHECK (total_sales_amount >= 0)
);