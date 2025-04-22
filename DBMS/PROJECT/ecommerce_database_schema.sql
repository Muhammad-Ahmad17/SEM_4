-- Table: country
CREATE TABLE country (
    id INT PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL
);

-- Table: address
CREATE TABLE address (
    id INT PRIMARY KEY,
    unit_number VARCHAR(20),
    street_number VARCHAR(20),
    address_line1 VARCHAR(255),
    address_line2 VARCHAR(255),
    city VARCHAR(100),
    region VARCHAR(100),
    postal_code VARCHAR(20),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES country(id) ON DELETE SET NULL
);

-- Table: site_user
CREATE TABLE site_user (
    id INT PRIMARY KEY,
    email_address VARCHAR(255) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    password VARCHAR(100) NOT NULL
);

-- Table: role
CREATE TABLE role (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- Table: user_role
CREATE TABLE user_role (
    user_id INT,
    role_id INT,
    PRIMARY KEY (user_id, role_id),
    FOREIGN KEY (user_id) REFERENCES site_user(id) ON DELETE CASCADE,
    FOREIGN KEY (role_id) REFERENCES role(id) ON DELETE CASCADE
);

-- Table: vendor
CREATE TABLE vendor (
    id INT PRIMARY KEY,
    user_id INT UNIQUE,
    company_name VARCHAR(255) NOT NULL,
    description TEXT,
    address_id INT,
    FOREIGN KEY (user_id) REFERENCES site_user(id) ON DELETE CASCADE,
    FOREIGN KEY (address_id) REFERENCES address(id) ON DELETE SET NULL
);

-- Table: user_address
CREATE TABLE user_address (
    user_id INT,
    address_id INT,
    is_default BIT,
    PRIMARY KEY (user_id, address_id),
    FOREIGN KEY (user_id) REFERENCES site_user(id) ON DELETE CASCADE,
    FOREIGN KEY (address_id) REFERENCES address(id) ON DELETE CASCADE
);

-- Table: payment_type
CREATE TABLE payment_type (
    id INT PRIMARY KEY,
    value VARCHAR(50) NOT NULL
);

-- Table: user_payment_method
CREATE TABLE user_payment_method (
    id INT PRIMARY KEY,
    user_id INT,
    payment_type_id INT,
    provider VARCHAR(50),
    account_number VARCHAR(100),
    expiry_date DATE,
    is_default BIT,
    FOREIGN KEY (user_id) REFERENCES site_user(id) ON DELETE CASCADE,
    FOREIGN KEY (payment_type_id) REFERENCES payment_type(id) ON DELETE SET NULL
);

-- Table: product_category
CREATE TABLE product_category (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    parent_category_id INT,
    FOREIGN KEY (parent_category_id) REFERENCES product_category(id) ON DELETE SET NULL
);

-- Table: product
CREATE TABLE product (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    description TEXT,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES product_category(id) ON DELETE SET NULL
);

-- Table: product_item
CREATE TABLE product_item (
    id INT PRIMARY KEY,
    product_id INT,
    sku VARCHAR(100),
    quantity_in_stock INT,
    price DECIMAL(10, 2),
    vendor_id INT,
    FOREIGN KEY (product_id) REFERENCES product(id) ON DELETE CASCADE,
    FOREIGN KEY (vendor_id) REFERENCES vendor(id) ON DELETE SET NULL
);

-- Table: variation
CREATE TABLE variation (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES product_category(id) ON DELETE CASCADE
);

-- Table: variation_option
CREATE TABLE variation_option (
    id INT PRIMARY KEY,
    value VARCHAR(100),
    variation_id INT,
    FOREIGN KEY (variation_id) REFERENCES variation(id) ON DELETE CASCADE
);

-- Table: product_configuration
CREATE TABLE product_configuration (
    product_item_id INT,
    variation_option_id INT,
    PRIMARY KEY (product_item_id, variation_option_id),
    FOREIGN KEY (product_item_id) REFERENCES product_item(id) ON DELETE CASCADE,
    FOREIGN KEY (variation_option_id) REFERENCES variation_option(id) ON DELETE CASCADE
);

-- Table: promotion
CREATE TABLE promotion (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    description TEXT,
    discount_percent DECIMAL(5, 2)
);

-- Table: promotion_category
CREATE TABLE promotion_category (
    category_id INT,
    promotion_id INT,
    PRIMARY KEY (category_id, promotion_id),
    FOREIGN KEY (category_id) REFERENCES product_category(id) ON DELETE CASCADE,
    FOREIGN KEY (promotion_id) REFERENCES promotion(id) ON DELETE CASCADE
);

-- Table: shopping_cart
CREATE TABLE shopping_cart (
    id INT PRIMARY KEY,
    user_id INT UNIQUE,
    FOREIGN KEY (user_id) REFERENCES site_user(id) ON DELETE CASCADE
);

-- Table: shopping_cart_item
CREATE TABLE shopping_cart_item (
    id INT PRIMARY KEY,
    cart_id INT,
    product_item_id INT,
    quantity INT,
    FOREIGN KEY (cart_id) REFERENCES shopping_cart(id) ON DELETE CASCADE,
    FOREIGN KEY (product_item_id) REFERENCES product_item(id) ON DELETE CASCADE
);

-- Table: shipping_method
CREATE TABLE shipping_method (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    cost DECIMAL(10, 2)
);

-- Table: order_status
CREATE TABLE order_status (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);

-- Table: shop_order
CREATE TABLE shop_order (
    id INT PRIMARY KEY,
    user_id INT,
    payment_method_id INT,
    shipping_method_id INT,
    order_status_id INT,
    order_date DATETIME,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (user_id) REFERENCES site_user(id) ON DELETE CASCADE,
    FOREIGN KEY (payment_method_id) REFERENCES user_payment_method(id) ON DELETE SET NULL,
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(id) ON DELETE SET NULL,
    FOREIGN KEY (order_status_id) REFERENCES order_status(id) ON DELETE SET NULL
);

-- Table: order_line
CREATE TABLE order_line (
    id INT PRIMARY KEY,
    order_id INT,
    product_item_id INT,
    quantity INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES shop_order(id) ON DELETE CASCADE,
    FOREIGN KEY (product_item_id) REFERENCES product_item(id) ON DELETE SET NULL
);

-- Table: user_review
CREATE TABLE user_review (
    id INT PRIMARY KEY,
    user_id INT,
    ordered_product_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    review_date DATETIME,
    FOREIGN KEY (user_id) REFERENCES site_user(id) ON DELETE CASCADE,
    FOREIGN KEY (ordered_product_id) REFERENCES product_item(id) ON DELETE SET NULL
);

-- Insert Roles: User, Manager, Vendor
INSERT INTO role (name) VALUES ('User'), ('Manager'), ('Vendor');

-- Assign User Role to Users
INSERT INTO user_role (user_id, role_id)
SELECT su.id, r.id
FROM site_user su
JOIN role r ON r.name = 'User'
WHERE su.email_address IN ('alice@example.com', 'charlie@example.com'); -- Replace with actual emails

-- Assign Manager Role to Managers
INSERT INTO user_role (user_id, role_id)
SELECT su.id, r.id
FROM site_user su
JOIN role r ON r.name = 'Manager'
WHERE su.email_address = 'bob@example.com'; -- Replace with actual email

-- Assign Vendor Role to Vendors
INSERT INTO user_role (user_id, role_id)
SELECT su.id, r.id
FROM site_user su
JOIN role r ON r.name = 'Vendor'
WHERE su.email_address IN ('vendor1@example.com', 'vendor2@example.com'); -- Replace with actual emails

-- Grant Permissions (Example)

-- Allow User to View Products (SELECT)
GRANT SELECT ON product TO User;

-- Allow Manager to Manage Products (INSERT, UPDATE, DELETE)
GRANT INSERT, UPDATE, DELETE ON product TO Manager;

-- Allow Vendor to Manage Products (INSERT, UPDATE, DELETE)
GRANT INSERT, UPDATE, DELETE ON product TO Vendor;

-- Additional Permissions can be added as needed for other tables, e.g., vendor, product_item, orders, etc.
