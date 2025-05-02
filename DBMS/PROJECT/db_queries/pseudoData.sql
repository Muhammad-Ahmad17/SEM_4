use db_E_Commerce

select * from [user]
-- 1. [user] - 20 users (buyers, vendors, managers)
INSERT INTO [user] (full_name, email_address, password, created_at, is_active)
VALUES
    ('John Doe', 'john.doe1@example.com', 'hashed_pass1', '2025-04-01', 1),
    ('Jane Smith', 'jane.smith2@example.com', 'hashed_pass2', '2025-04-02', 1),
    ('Alice Johnson', 'alice.j3@example.com', 'hashed_pass3', '2025-04-03', 1),
    ('Bob Brown', 'bob.brown4@example.com', 'hashed_pass4', '2025-04-04', 1),
    ('Charlie Davis', 'charlie.d5@example.com', 'hashed_pass5', '2025-04-05', 1),
    ('Diana Evans', 'diana.e6@example.com', 'hashed_pass6', '2025-04-06', 1),
    ('Ethan Fox', 'ethan.f7@example.com', 'hashed_pass7', '2025-04-07', 1),
    ('Fiona Green', 'fiona.g8@example.com', 'hashed_pass8', '2025-04-08', 1),
    ('George Harris', 'george.h9@example.com', 'hashed_pass9', '2025-04-09', 1),
    ('Hannah Ivy', 'hannah.i10@example.com', 'hashed_pass10', '2025-04-10', 1),
    ('Ian James', 'ian.j11@example.com', 'hashed_pass11', '2025-04-11', 1),
    ('Julia King', 'julia.k12@example.com', 'hashed_pass12', '2025-04-12', 1),
    ('Kevin Lee', 'kevin.l13@example.com', 'hashed_pass13', '2025-04-13', 1),
    ('Laura Miller', 'laura.m14@example.com', 'hashed_pass14', '2025-04-14', 1),
    ('Mike Nelson', 'mike.n15@example.com', 'hashed_pass15', '2025-04-15', 1),
    ('Nina Owen', 'nina.o16@example.com', 'hashed_pass16', '2025-04-16', 1),
    ('Oscar Perez', 'oscar.p17@example.com', 'hashed_pass17', '2025-04-17', 1),
    ('Paula Quinn', 'paula.q18@example.com', 'hashed_pass18', '2025-04-18', 1),
    ('Quincy Reed', 'quincy.r19@example.com', 'hashed_pass19', '2025-04-19', 1),
    ('Rachel Stone', 'rachel.s20@example.com', 'hashed_pass20', '2025-04-20', 1);

-- 2. role - Already populated with 3 roles (buyer, vendor, manager)
-- For reference: buyer (id=1), vendor (id=2), manager (id=3)

-- 3. user_role - Assign roles to users (20 users, some with multiple roles)

INSERT INTO user_role ([user_id], role_id, assigned_at, assigned_by)
VALUES
    (1, 1, '2025-04-01', NULL),  -- John: buyer
    (2, 1, '2025-04-02', NULL),  -- Jane: buyer
    (2, 2, '2025-04-02', 3),     -- Jane: vendor
    (3, 1, '2025-04-03', NULL),  -- Alice: buyer
    (3, 2, '2025-04-03', 3),     -- Alice: vendor
    (4, 1, '2025-04-04', NULL),  -- Bob: buyer
    (4, 3, '2025-04-04', NULL),  -- Bob: manager
    (5, 1, '2025-04-05', NULL),  -- Charlie: buyer
    (6, 1, '2025-04-06', NULL),  -- Diana: buyer
    (6, 2, '2025-04-06', 4),     -- Diana: vendor
    (7, 1, '2025-04-07', NULL),  -- Ethan: buyer
    (7, 2, '2025-04-07', 4),     -- Ethan: vendor
    (8, 1, '2025-04-08', NULL),  -- Fiona: buyer
    (9, 1, '2025-04-09', NULL),  -- George: buyer
    (9, 2, '2025-04-09', 4),     -- George: vendor
    (10, 1, '2025-04-10', NULL), -- Hannah: buyer
    (11, 1, '2025-04-11', NULL), -- Ian: buyer
    (11, 2, '2025-04-11', 4),    -- Ian: vendor
    (12, 1, '2025-04-12', NULL), -- Julia: buyer
    (12, 3, '2025-04-12', NULL), -- Julia: manager
    (13, 1, '2025-04-13', NULL), -- Kevin: buyer
    (13, 2, '2025-04-13', 4),    -- Kevin: vendor
    (14, 1, '2025-04-14', NULL), -- Laura: buyer
    (15, 1, '2025-04-15', NULL), -- Mike: buyer
    (15, 2, '2025-04-15', 4),    -- Mike: vendor
    (16, 1, '2025-04-16', NULL), -- Nina: buyer
    (17, 1, '2025-04-17', NULL), -- Oscar: buyer
    (17, 2, '2025-04-17', 4),    -- Oscar: vendor
    (18, 1, '2025-04-18', NULL), -- Paula: buyer
    (19, 1, '2025-04-19', NULL), -- Quincy: buyer
    (19, 2, '2025-04-19', 4),    -- Quincy: vendor
    (20, 1, '2025-04-20', NULL); -- Rachel: buyer

	select * from user_role

-- 4. permissions - Already populated, skipping

-- 5. vendor - 10 vendors (users 2, 3, 6, 7, 9, 11, 13, 15, 17, 19)
INSERT INTO vendor ([user_id], vendor_name, status, created_at)
VALUES
    (2, 'Jane’s Tech Shop', 'approved', '2025-04-02'),
    (3, 'Alice’s Gadgets', 'approved', '2025-04-03'),
    (6, 'Diana’s Fashion', 'pending', '2025-04-06'),
    (7, 'Ethan’s Books', 'approved', '2025-04-07'),
    (9, 'George’s Tools', 'suspended', '2025-04-09'),
    (11, 'Ian’s Toys', 'approved', '2025-04-11'),
    (13, 'Kevin’s Sports', 'pending', '2025-04-13'),
    (15, 'Mike’s Electronics', 'approved', '2025-04-15'),
    (17, 'Oscar’s Home Goods', 'approved', '2025-04-17'),
    (19, 'Quincy’s Jewelry', 'approved', '2025-04-19');


		select * from vendor

-- 6. address - 20 addresses for users
INSERT INTO address ([user_id], address_line1, address_line2, city, state, postal_code, country, address_type, is_default, created_at)
VALUES
    (1, '123 Main St', NULL, 'New York', 'NY', '10001', 'USA', 'both', 1, '2025-04-01'),
    (2, '456 Elm St', 'Apt 5B', 'Boston', 'MA', '02108', 'USA', 'shipping', 1, '2025-04-02'),
    (3, '789 Pine Rd', NULL, 'Chicago', 'IL', '60601', 'USA', 'billing', 1, '2025-04-03'),
    (4, '101 Oak Ave', NULL, 'Los Angeles', 'CA', '90001', 'USA', 'both', 1, '2025-04-04'),
    (5, '202 Birch Ln', 'Unit 3', 'Seattle', 'WA', '98101', 'USA', 'shipping', 1, '2025-04-05'),
    (6, '303 Cedar Dr', NULL, 'Miami', 'FL', '33101', 'USA', 'billing', 1, '2025-04-06'),
    (7, '404 Maple St', NULL, 'Austin', 'TX', '73301', 'USA', 'both', 1, '2025-04-07'),
    (8, '505 Willow Rd', 'Apt 12', 'Denver', 'CO', '80201', 'USA', 'shipping', 1, '2025-04-08'),
    (9, '606 Spruce Ave', NULL, 'Portland', 'OR', '97201', 'USA', 'billing', 1, '2025-04-09'),
    (10, '707 Ash St', NULL, 'Atlanta', 'GA', '30301', 'USA', 'both', 1, '2025-04-10'),
    (11, '808 Beech Ln', NULL, 'Houston', 'TX', '77001', 'USA', 'shipping', 1, '2025-04-11'),
    (12, '909 Chestnut Dr', 'Unit 8', 'Phoenix', 'AZ', '85001', 'USA', 'billing', 1, '2025-04-12'),
    (13, '1010 Elm St', NULL, 'San Diego', 'CA', '92101', 'USA', 'both', 1, '2025-04-13'),
    (14, '1111 Pine Rd', NULL, 'Philadelphia', 'PA', '19101', 'USA', 'shipping', 1, '2025-04-14'),
    (15, '1212 Oak Ave', NULL, 'Dallas', 'TX', '75201', 'USA', 'billing', 1, '2025-04-15'),
    (16, '1313 Birch Ln', NULL, 'San Antonio', 'TX', '78201', 'USA', 'both', 1, '2025-04-16'),
    (17, '1414 Cedar Dr', NULL, 'San Jose', 'CA', '95101', 'USA', 'shipping', 1, '2025-04-17'),
    (18, '1515 Maple St', NULL, 'San Francisco', 'CA', '94101', 'USA', 'billing', 1, '2025-04-18'),
    (19, '1616 Willow Rd', NULL, 'Columbus', 'OH', '43201', 'USA', 'both', 1, '2025-04-19'),
    (20, '1717 Spruce Ave', NULL, 'Charlotte', 'NC', '28201', 'USA', 'shipping', 1, '2025-04-20');

					select * from address

-- 7. category - 20 categories with hierarchy
INSERT INTO category (name, description, parent_id, is_active, created_at)
VALUES
    ('Electronics', 'Electronic devices', NULL, 1, '2025-04-01'),
    ('Laptops', 'Portable computers', 1, 1, '2025-04-01'),
    ('Phones', 'Smartphones', 1, 1, '2025-04-01'),
    ('Fashion', 'Clothing and accessories', NULL, 1, '2025-04-02'),
    ('Men’s Fashion', 'Men’s clothing', 4, 1, '2025-04-02'),
    ('Women’s Fashion', 'Women’s clothing', 4, 1, '2025-04-02'),
    ('Books', 'Literature and textbooks', NULL, 1, '2025-04-03'),
    ('Fiction', 'Fiction books', 7, 1, '2025-04-03'),
    ('Non-Fiction', 'Non-fiction books', 7, 1, '2025-04-03'),
    ('Tools', 'Hardware tools', NULL, 1, '2025-04-04'),
    ('Power Tools', 'Electric tools', 10, 1, '2025-04-04'),
    ('Hand Tools', 'Manual tools', 10, 1, '2025-04-04'),
    ('Toys', 'Children’s toys', NULL, 1, '2025-04-05'),
    ('Board Games', 'Family board games', 13, 1, '2025-04-05'),
    ('Action Figures', 'Collectible figures', 13, 1, '2025-04-05'),
    ('Sports', 'Sporting goods', NULL, 1, '2025-04-06'),
    ('Fitness', 'Fitness equipment', 16, 1, '2025-04-06'),
    ('Outdoor', 'Outdoor sports gear', 16, 1, '2025-04-06'),
    ('Home Goods', 'Household items', NULL, 1, '2025-04-07'),
    ('Jewelry', 'Fashion jewelry', NULL, 1, '2025-04-08');


						select * from category

-- 8. product - 20 products
INSERT INTO product (name, description, base_price, is_active, created_at)
VALUES
    ('Laptop Pro', 'High-performance laptop', 1000.00, 1, '2025-04-01'),
    ('Smartphone X', 'Latest smartphone', 800.00, 1, '2025-04-01'),
    ('Men’s Jacket', 'Winter jacket for men', 150.00, 1, '2025-04-02'),
    ('Women’s Dress', 'Elegant dress for women', 120.00, 1, '2025-04-02'),
    ('Fiction Novel', 'Bestselling fiction novel', 20.00, 1, '2025-04-03'),
    ('History Book', 'Non-fiction history book', 30.00, 1, '2025-04-03'),
    ('Power Drill', 'Electric power drill', 80.00, 1, '2025-04-04'),
    ('Hammer', 'Heavy-duty hammer', 15.00, 1, '2025-04-04'),
    ('Chess Set', 'Classic chess set', 25.00, 1, '2025-04-05'),
    ('Superhero Figure', 'Collectible superhero figure', 40.00, 1, '2025-04-05'),
    ('Treadmill', 'Home treadmill', 500.00, 1, '2025-04-06'),
    ('Camping Tent', 'Outdoor camping tent', 200.00, 1, '2025-04-06'),
    ('Kitchen Mixer', 'Electric kitchen mixer', 90.00, 1, '2025-04-07'),
    ('Necklace', 'Gold necklace', 300.00, 1, '2025-04-08'),
    ('Tablet', '10-inch tablet', 400.00, 1, '2025-04-01'),
    ('Headphones', 'Wireless headphones', 100.00, 1, '2025-04-01'),
    ('T-Shirt', 'Casual men’s t-shirt', 25.00, 1, '2025-04-02'),
    ('Scarf', 'Women’s silk scarf', 50.00, 1, '2025-04-02'),
    ('Sci-Fi Novel', 'Sci-fi novel', 22.00, 1, '2025-04-03'),
    ('Screwdriver Set', 'Set of screwdrivers', 30.00, 1, '2025-04-04');

						select * from product
-- 9. product_category - 20 product-category mappings
INSERT INTO product_category (product_id, category_id, created_at)
VALUES
    (1, 2, '2025-04-01'),  -- Laptop Pro -> Laptops
    (2, 3, '2025-04-01'),  -- Smartphone X -> Phones
    (3, 5, '2025-04-02'),  -- Men’s Jacket -> Men’s Fashion
    (4, 6, '2025-04-02'),  -- Women’s Dress -> Women’s Fashion
    (5, 8, '2025-04-03'),  -- Fiction Novel -> Fiction
    (6, 9, '2025-04-03'),  -- History Book -> Non-Fiction
    (7, 11, '2025-04-04'), -- Power Drill -> Power Tools
    (8, 12, '2025-04-04'), -- Hammer -> Hand Tools
    (9, 14, '2025-04-05'), -- Chess Set -> Board Games
    (10, 15, '2025-04-05'), -- Superhero Figure -> Action Figures
    (11, 17, '2025-04-06'), -- Treadmill -> Fitness
    (12, 18, '2025-04-06'), -- Camping Tent -> Outdoor
    (13, 19, '2025-04-07'), -- Kitchen Mixer -> Home Goods
    (14, 20, '2025-04-08'), -- Necklace -> Jewelry
    (15, 1, '2025-04-01'),  -- Tablet -> Electronics
    (16, 1, '2025-04-01'),  -- Headphones -> Electronics
    (17, 5, '2025-04-02'),  -- T-Shirt -> Men’s Fashion
    (18, 6, '2025-04-02'),  -- Scarf -> Women’s Fashion
    (19, 8, '2025-04-03'),  -- Sci-Fi Novel -> Fiction
    (20, 12, '2025-04-04'); -- Screwdriver Set -> Hand Tools
							select * from product_category

-- 10. product_item - 20 vendor-specific product items (vendors 1-10)
INSERT INTO product_item (product_id, vendor_id, stock_quantity, price, is_active, created_at)
VALUES
    (1, 1, 8, 1200.00, 1, '2025-04-02'),   -- Jane’s Tech Shop: Laptop Pro (sold 2)
    (2, 1, 13, 900.00, 1, '2025-04-02'),   -- Jane’s Tech Shop: Smartphone X (sold 2)
    (15, 1, 9, 450.00, 1, '2025-04-02'),   -- Jane’s Tech Shop: Tablet (sold 1)
    (16, 1, 9, 110.00, 1, '2025-04-02'),   -- Jane’s Tech Shop: Headphones (sold 1)
    (3, 2, 8, 160.00, 1, '2025-04-03'),    -- Alice’s Gadgets: Men’s Jacket (sold 2)
    (4, 2, 9, 130.00, 1, '2025-04-03'),    -- Alice’s Gadgets: Women’s Dress (sold 1)
    (17, 2, 9, 30.00, 1, '2025-04-03'),    -- Alice’s Gadgets: T-Shirt (sold 1)
    (18, 2, 9, 55.00, 1, '2025-04-03'),    -- Alice’s Gadgets: Scarf (sold 1)
    (5, 4, 8, 25.00, 1, '2025-04-07'),     -- Ethan’s Books: Fiction Novel (sold 2)
    (6, 4, 9, 35.00, 1, '2025-04-07'),     -- Ethan’s Books: History Book (sold 1)
    (19, 4, 9, 28.00, 1, '2025-04-07'),    -- Ethan’s Books: Sci-Fi Novel (sold 1)
    (7, 5, 10, 90.00, 0, '2025-04-09'),    -- George’s Tools: Power Drill (inactive)
    (8, 5, 10, 20.00, 0, '2025-04-09'),    -- George’s Tools: Hammer (inactive)
    (20, 5, 10, 35.00, 0, '2025-04-09'),   -- George’s Tools: Screwdriver Set (inactive)
    (9, 6, 8, 30.00, 1, '2025-04-11'),     -- Ian’s Toys: Chess Set (sold 2)
    (10, 6, 9, 45.00, 1, '2025-04-11'),    -- Ian’s Toys: Superhero Figure (sold 1)
    (11, 8, 9, 550.00, 1, '2025-04-15'),   -- Mike’s Electronics: Treadmill (sold 1)
    (12, 8, 9, 220.00, 1, '2025-04-15'),   -- Mike’s Electronics: Camping Tent (sold 1)
    (13, 9, 9, 100.00, 1, '2025-04-17'),   -- Oscar’s Home Goods: Kitchen Mixer (sold 1)
    (14, 10, 9, 350.00, 1, '2025-04-19');  -- Quincy’s Jewelry: Necklace (sold 1)
								select * from product_item

-- 11. payment_method - 20 payment methods
INSERT INTO payment_method (method_name, is_active)
VALUES
    ('Credit Card', 1),
    ('Debit Card', 1),
    ('PayPal', 1),
    ('Apple Pay', 1),
    ('Google Pay', 1),
    ('Bank Transfer', 1),
    ('Cash on Delivery', 1),
    ('Venmo', 1),
    ('Stripe', 1),
    ('Klarna', 1),
    ('Afterpay', 1),
    ('Affirm', 1),
    ('Zelle', 1),
    ('Bitcoin', 0),
    ('Gift Card', 1),
    ('Check', 1),
    ('Wire Transfer', 1),
    ('Paytm', 1),
    ('WeChat Pay', 1),
    ('Alipay', 1);
									select * from payment_method

-- 12. shipping_method - 20 shipping methods
INSERT INTO shipping_method (method_name, shipping_cost, is_active)
VALUES
    ('Standard Shipping', 5.00, 1),
    ('Express Shipping', 15.00, 1),
    ('Overnight Shipping', 25.00, 1),
    ('Free Shipping', 0.00, 1),
    ('Pickup in Store', 0.00, 1),
    ('Two-Day Shipping', 10.00, 1),
    ('International Shipping', 50.00, 1),
    ('Priority Mail', 8.00, 1),
    ('Flat Rate Shipping', 7.00, 1),
    ('Expedited Shipping', 20.00, 1),
    ('Ground Shipping', 4.00, 1),
    ('Next-Day Air', 30.00, 1),
    ('Economy Shipping', 3.00, 1),
    ('Same-Day Delivery', 40.00, 1),
    ('Freight Shipping', 100.00, 1),
    ('Drone Delivery', 60.00, 0),
    ('Courier Service', 12.00, 1),
    ('Local Delivery', 5.00, 1),
    ('Express International', 70.00, 1),
    ('Standard International', 40.00, 1);
										select * from shipping_method

-- 13. order_status - 20 order statuses
INSERT INTO order_status (status_name, is_final)
VALUES
    ('Pending', 0),
    ('Processing', 0),
    ('Shipped', 0),
    ('Delivered', 1),
    ('Cancelled', 1),
    ('Returned', 1),
    ('On Hold', 0),
    ('Awaiting Payment', 0),
    ('Payment Failed', 0),
    ('Refunded', 1),
    ('Backordered', 0),
    ('Partially Shipped', 0),
    ('Awaiting Shipment', 0),
    ('In Transit', 0),
    ('Out for Delivery', 0),
    ('Failed Delivery', 0),
    ('Picked Up', 1),
    ('Exchange Requested', 0),
    ('Exchange Processed', 1),
    ('Disputed', 0);
											select * from order_status

-- 14. shop_order - 20 orders by buyers (user_ids 1, 5, 8, 10, 14, 16, 18, 20)
INSERT INTO shop_order ([user_id], payment_method_id, shipping_method_id, order_status_id, shipping_address_id, billing_address_id, order_date, subtotal, tax_amount, discount_amount, total_amount)
VALUES
    (1, 1, 1, 4, 1, 1, '2025-04-21', 1200.00, 96.00, 0.00, 1296.00),  -- John: Laptop Pro
    (1, 2, 2, 4, 1, 1, '2025-04-21', 110.00, 8.80, 0.00, 118.80),    -- John: Headphones
    (5, 3, 3, 4, 5, 5, '2025-04-21', 900.00, 72.00, 0.00, 972.00),   -- Charlie: Smartphone X
    (5, 4, 4, 4, 5, 5, '2025-04-21', 30.00, 2.40, 0.00, 32.40),      -- Charlie: Chess Set
    (8, 5, 5, 4, 8, 8, '2025-04-21', 160.00, 12.80, 0.00, 172.80),   -- Fiona: Men’s Jacket
    (8, 6, 6, 4, 8, 8, '2025-04-21', 45.00, 3.60, 0.00, 48.60),      -- Fiona: Superhero Figure
    (10, 7, 7, 4, 10, 10, '2025-04-21', 130.00, 10.40, 0.00, 140.40), -- Hannah: Women’s Dress
    (10, 8, 8, 4, 10, 10, '2025-04-21', 160.00, 12.80, 0.00, 172.80), -- Hannah: Men’s Jacket
    (14, 9, 9, 4, 14, 14, '2025-04-21', 25.00, 2.00, 0.00, 27.00),   -- Laura: Fiction Novel
    (14, 10, 10, 4, 14, 14, '2025-04-21', 220.00, 17.60, 0.00, 237.60), -- Laura: Camping Tent
    (16, 11, 11, 4, 16, 16, '2025-04-21', 35.00, 2.80, 0.00, 37.80), -- Nina: History Book
    (16, 12, 12, 4, 16, 16, '2025-04-21', 100.00, 8.00, 0.00, 108.00), -- Nina: Kitchen Mixer
    (18, 13, 13, 4, 18, 18, '2025-04-21', 30.00, 2.40, 0.00, 32.40), -- Paula: T-Shirt
    (18, 14, 14, 4, 18, 18, '2025-04-21', 350.00, 28.00, 0.00, 378.00), -- Paula: Necklace
    (20, 15, 15, 4, 20, 20, '2025-04-21', 55.00, 4.40, 0.00, 59.40), -- Rachel: Scarf
    (20, 16, 16, 4, 20, 20, '2025-04-21', 450.00, 36.00, 0.00, 486.00), -- Rachel: Tablet
    (1, 17, 17, 4, 1, 1, '2025-04-21', 28.00, 2.24, 0.00, 30.24),   -- John: Sci-Fi Novel
    (5, 18, 18, 4, 5, 5, '2025-04-21', 1200.00, 96.00, 0.00, 1296.00), -- Charlie: Laptop Pro
    (8, 19, 19, 4, 8, 8, '2025-04-21', 900.00, 72.00, 0.00, 972.00), -- Fiona: Smartphone X
    (10, 20, 20, 4, 10, 10, '2025-04-21', 25.00, 2.00, 0.00, 27.00); -- Hannah: Fiction Novel
												select * from shop_order

-- 15. order_line - 20 order lines for the orders
INSERT INTO order_line (order_id, product_item_id, quantity, price)
VALUES
    (1, 1, 1, 1200.00),  -- Order 1: Laptop Pro (vendor 1)
    (2, 4, 1, 110.00),   -- Order 2: Headphones (vendor 1)
    (3, 2, 1, 900.00),   -- Order 3: Smartphone X (vendor 1)
    (4, 15, 1, 30.00),   -- Order 4: Chess Set (vendor 6)
    (5, 5, 1, 160.00),   -- Order 5: Men’s Jacket (vendor 2)
    (6, 16, 1, 45.00),   -- Order 6: Superhero Figure (vendor 6)
    (7, 6, 1, 130.00),   -- Order 7: Women’s Dress (vendor 2)
    (8, 5, 1, 160.00),   -- Order 8: Men’s Jacket (vendor 2)
    (9, 9, 1, 25.00),    -- Order 9: Fiction Novel (vendor 4)
    (10, 18, 1, 220.00), -- Order 10: Camping Tent (vendor 8)
    (11, 10, 1, 35.00),  -- Order 11: History Book (vendor 4)
    (12, 19, 1, 100.00), -- Order 12: Kitchen Mixer (vendor 9)
    (13, 7, 1, 30.00),   -- Order 13: T-Shirt (vendor 2)
    (14, 20, 1, 350.00), -- Order 14: Necklace (vendor 10)
    (15, 8, 1, 55.00),   -- Order 15: Scarf (vendor 2)
    (16, 3, 1, 450.00),  -- Order 16: Tablet (vendor 1)
    (17, 11, 1, 28.00),  -- Order 17: Sci-Fi Novel (vendor 4)
    (18, 1, 1, 1200.00), -- Order 18: Laptop Pro (vendor 1)
    (19, 2, 1, 900.00),  -- Order 19: Smartphone X (vendor 1)
    (20, 9, 1, 25.00);   -- Order 20: Fiction Novel (vendor 4)
													select * from order_line

-- 16. user_review - 20 reviews by buyers for purchased products
INSERT INTO user_review ([user_id], product_id, order_id, rating, review_text, created_at)
VALUES
    (1, 1, 1, 5, 'Amazing laptop!', '2025-04-22'),
    (1, 16, 2, 5, 'Headphones have great sound.', '2025-04-22'),
    (5, 2, 3, 4, 'Great phone, but battery life could be better.', '2025-04-22'),
    (5, 9, 4, 4, 'Fun chess set for the family.', '2025-04-22'),
    (8, 3, 5, 5, 'Warm and stylish jacket.', '2025-04-22'),
    (8, 10, 6, 5, 'My kid loves this figure!', '2025-04-22'),
    (10, 4, 7, 4, 'Beautiful dress, fits well.', '2025-04-22'),
    (10, 3, 8, 5, 'Jacket is perfect for winter.', '2025-04-22'),
    (14, 5, 9, 5, 'Loved this novel!', '2025-04-22'),
    (14, 12, 10, 4, 'Tent is sturdy but heavy.', '2025-04-22'),
    (16, 6, 11, 3, 'Informative but dense.', '2025-04-22'),
    (16, 13, 12, 5, 'Mixer is a kitchen game-changer.', '2025-04-22'),
    (18, 17, 13, 5, 'Comfortable t-shirt.', '2025-04-22'),
    (18, 14, 14, 5, 'Stunning necklace!', '2025-04-22'),
    (20, 18, 15, 4, 'Nice scarf, good quality.', '2025-04-22'),
    (20, 15, 16, 4, 'Tablet is fast, good value.', '2025-04-22'),
    (1, 19, 17, 5, 'Great sci-fi read!', '2025-04-22'),
    (5, 1, 18, 5, 'Second laptop, still impressed!', '2025-04-22'),
    (8, 2, 19, 4, 'Phone is sleek, camera is amazing.', '2025-04-22'),
    (10, 5, 20, 5, 'Really enjoyed this book.', '2025-04-22');
														select * from user_review

-- 17. audit_log - 20 audit log entries
INSERT INTO audit_log ([user_id], action_type, details, created_at)
VALUES
    (1, 'purchase', 'Order ID: 1, Product Item ID: 1', '2025-04-21'),
    (1, 'purchase', 'Order ID: 2, Product Item ID: 4', '2025-04-21'),
    (5, 'purchase', 'Order ID: 3, Product Item ID: 2', '2025-04-21'),
    (5, 'purchase', 'Order ID: 4, Product Item ID: 15', '2025-04-21'),
    (8, 'purchase', 'Order ID: 5, Product Item ID: 5', '2025-04-21'),
    (8, 'purchase', 'Order ID: 6, Product Item ID: 16', '2025-04-21'),
    (10, 'purchase', 'Order ID: 7, Product Item ID: 6', '2025-04-21'),
    (10, 'purchase', 'Order ID: 8, Product Item ID: 5', '2025-04-21'),
    (14, 'purchase', 'Order ID: 9, Product Item ID: 9', '2025-04-21'),
    (14, 'purchase', 'Order ID: 10, Product Item ID: 18', '2025-04-21'),
    (16, 'purchase', 'Order ID: 11, Product Item ID: 10', '2025-04-21'),
    (16, 'purchase', 'Order ID: 12, Product Item ID: 19', '2025-04-21'),
    (18, 'purchase', 'Order ID: 13, Product Item ID: 7', '2025-04-21'),
    (18, 'purchase', 'Order ID: 14, Product Item ID: 20', '2025-04-21'),
    (20, 'purchase', 'Order ID: 15, Product Item ID: 8', '2025-04-21'),
    (20, 'purchase', 'Order ID: 16, Product Item ID: 3', '2025-04-21'),
    (1, 'purchase', 'Order ID: 17, Product Item ID: 11', '2025-04-21'),
    (5, 'purchase', 'Order ID: 18, Product Item ID: 1', '2025-04-21'),
    (8, 'purchase', 'Order ID: 19, Product Item ID: 2', '2025-04-21'),
    (10, 'purchase', 'Order ID: 20, Product Item ID: 9', '2025-04-21');
															select * from audit_log

-- 18. vendor_analytics - 10 entries for vendors (vendors 1-10), calculated from orders
INSERT INTO vendor_analytics (vendor_id, total_products, total_sales_amount, last_updated)
VALUES
    (1, 4, 3750.00, '2025-04-22'),  -- Jane’s Tech Shop: 2x Laptop Pro (2400), 2x Smartphone X (1800), 1x Tablet (450), 1x Headphones (110)
    (2, 4, 535.00, '2025-04-22'),   -- Alice’s Gadgets: 2x Men’s Jacket (320), 1x Women’s Dress (130), 1x T-Shirt (30), 1x Scarf (55)
    (3, 0, 0.00, '2025-04-22'),     -- Diana’s Fashion: pending
    (4, 3, 113.00, '2025-04-22'),   -- Ethan’s Books: 2x Fiction Novel (50), 1x History Book (35), 1x Sci-Fi Novel (28)
    (5, 3, 0.00, '2025-04-22'),     -- George’s Tools: suspended
    (6, 2, 105.00, '2025-04-22'),   -- Ian’s Toys: 2x Chess Set (60), 1x Superhero Figure (45)
    (7, 0, 0.00, '2025-04-22'),     -- Kevin’s Sports: pending
    (8, 2, 770.00, '2025-04-22'),   -- Mike’s Electronics: 1x Treadmill (550), 1x Camping Tent (220)
    (9, 1, 100.00, '2025-04-22'),   -- Oscar’s Home Goods: 1x Kitchen Mixer (100)
    (10, 1, 350.00, '2025-04-22');  -- Quincy’s Jewelry: 1x Necklace (350)
																select * from vendor_analytics

INSERT INTO discount (vendor_id, product_item_id, discount_percentage, discount_code, start_date, end_date, is_active)
VALUES
    (1, NULL, 15.00, 'TECH15', '2025-04-01 00:00:00', '2025-04-30 23:59:59', 1),  -- Vendor 1 (Jane’s Tech Shop), 15% off all products, active
    (1, 1, 20.00, 'LAPTOP20', '2025-04-10 00:00:00', '2025-04-20 23:59:59', 0),   -- Vendor 1, 20% off Laptop Pro, inactive (ended)
    (2, NULL, 10.00, 'GADGET10', '2025-04-05 00:00:00', '2025-04-25 23:59:59', 1), -- Vendor 2 (Alice’s Gadgets), 10% off all products, active
    (4, 9, 25.00, 'BOOK25', '2025-04-15 00:00:00', '2025-04-22 23:59:59', 0),     -- Vendor 4 (Ethan’s Books), 25% off Fiction Novel, inactive (ended)
    (6, 15, 30.00, 'TOY30', '2025-04-20 00:00:00', '2025-04-29 23:59:59', 1);    -- Vendor 6 (Ian’s Toys), 30% off Chess Set, active


INSERT INTO cart (user_id, product_item_id, quantity, added_at)
VALUES
    (1, 1, 2, '2025-04-23 09:00:00'),  -- John Doe adds 2 Laptop Pros (vendor 1)
    (5, 2, 1, '2025-04-23 09:30:00'),  -- Charlie Davis adds 1 Smartphone X (vendor 1)
    (8, 5, 1, '2025-04-23 10:00:00'),  -- Fiona Green adds 1 Men’s Jacket (vendor 2)
    (10, 15, 3, '2025-04-23 10:30:00'), -- Hannah Ivy adds 3 Chess Sets (vendor 6)
    (14, 19, 1, '2025-04-23 11:00:00'); -- Laura Miller adds 1 Kitchen Mixer (vendor 9)

-- 1. [user] - 20 users (buyers, vendors, managers)
SELECT * FROM [user];
-- Expected: 20 rows with columns id, full_name, email_address, password, created_at, is_active.
-- Example: id=1, full_name='John Doe', email_address='john.doe1@example.com', etc.

-- 2. role - 3 roles (buyer, vendor, manager)
SELECT * FROM role;
-- Expected: 3 rows (already populated earlier).
-- Example: id=1, name='buyer', description='Customers who purchase products', etc.

-- 3. user_role - Role assignments for users
SELECT * FROM user_role;
-- Expected: 29 rows (some users have multiple roles).
-- Example: user_id=1, role_id=1 (John as buyer), user_id=2, role_id=2 (Jane as vendor), etc.

-- 4. permissions - Permissions for roles
SELECT * FROM permissions;
-- Expected: 17 rows (already populated earlier).
-- Example: role_id=1 (buyer), resource='shop_order', action_type='write', is_allowed=1, etc.

-- 5. vendor - 10 vendors
SELECT * FROM vendor;
-- Expected: 10 rows (users with vendor role).
-- Example: id=1, user_id=2, vendor_name='Jane’s Tech Shop', status='approved', etc.

-- 6. address - 20 addresses for users
SELECT * FROM address;
-- Expected: 20 rows, one address per user.
-- Example: user_id=1, address_line1='123 Main St', city='New York', address_type='both', etc.

-- 7. category - 20 categories with hierarchy
SELECT * FROM category;
-- Expected: 20 rows with parent-child relationships.
-- Example: id=1, name='Electronics', parent_id=NULL; id=2, name='Laptops', parent_id=1, etc.

-- 8. product - 20 products
SELECT * FROM product;
-- Expected: 20 rows.
-- Example: id=1, name='Laptop Pro', base_price=1000.00, is_active=1, etc.

-- 9. product_category - 20 product-category mappings
SELECT * FROM product_category;
-- Expected: 20 rows linking products to categories.
-- Example: product_id=1, category_id=2 (Laptop Pro in Laptops), etc.

-- 10. product_item - 20 vendor-specific product items
SELECT * FROM product_item;
-- Expected: 20 rows.
-- Example: product_id=1, vendor_id=1, stock_quantity=8, price=1200.00 (Jane’s Tech Shop: Laptop Pro), etc.

-- 11. payment_method - 20 payment methods
SELECT * FROM payment_method;
-- Expected: 20 rows.
-- Example: id=1, method_name='Credit Card', is_active=1, etc.

-- 12. shipping_method - 20 shipping methods
SELECT * FROM shipping_method;
-- Expected: 20 rows.
-- Example: id=1, method_name='Standard Shipping', shipping_cost=5.00, is_active=1, etc.

-- 13. order_status - 20 order statuses
SELECT * FROM order_status;
-- Expected: 20 rows.
-- Example: id=1, status_name='Pending', is_final=0, etc.

-- 14. shop_order - 20 orders by buyers
SELECT * FROM shop_order;
-- Expected: 20 rows.
-- Example: id=1, user_id=1, payment_method_id=1, shipping_method_id=1, order_status_id=4 (Delivered), total_amount=1296.00, etc.

-- 15. order_line - 20 order lines for the orders
SELECT * FROM order_line;
-- Expected: 20 rows.
-- Example: order_id=1, product_item_id=1, quantity=1, price=1200.00 (Laptop Pro), etc.

-- 16. user_review - 20 reviews by buyers
SELECT * FROM user_review;
-- Expected: 20 rows.
-- Example: user_id=1, product_id=1, order_id=1, rating=5, review_text='Amazing laptop!', etc.

-- 17. audit_log - 20 audit log entries
SELECT * FROM audit_log;
-- Expected: 20 rows.
-- Example: user_id=1, action_type='purchase', details='Order ID: 1, Product Item ID: 1', etc.

-- 18. vendor_analytics - 10 entries for vendors
SELECT * FROM vendor_analytics;
-- Expected: 10 rows.
-- Example: vendor_id=1, total_products=4, total_sales_amount=3750.00 (Jane’s Tech Shop), etc.

