-- 1. List all products purchased by a specific buyer (e.g., John Doe, user_id=1)
-- Purpose: Verify relationship between [user], shop_order, order_line, product_item, and product
SELECT 
    u.full_name AS buyer_name,
    p.name AS product_name,
    ol.quantity,
    ol.price,
    so.order_date,
    os.status_name AS order_status
FROM [user] u
JOIN shop_order so ON u.id = so.[user_id]
JOIN order_line ol ON so.id = ol.order_id
JOIN product_item pi ON ol.product_item_id = pi.id
JOIN product p ON pi.product_id = p.id
JOIN order_status os ON so.order_status_id = os.id
WHERE u.id = 1;
-- Expected: John Doe (user_id=1) purchased:
-- - Laptop Pro (quantity=1, price=1200.00, order_date='2025-04-21', status='Delivered')
-- - Headphones (quantity=1, price=110.00, order_date='2025-04-21', status='Delivered')
-- - Sci-Fi Novel (quantity=1, price=28.00, order_date='2025-04-21', status='Delivered')

-- 2. Show total sales and product count for each vendor, including vendor status
-- Purpose: Verify relationship between vendor, vendor_analytics, and user; analyze vendor performance
SELECT 
    v.vendor_name,
    u.full_name AS vendor_user,
    v.status AS vendor_status,
    va.total_products,
    va.total_sales_amount,
    va.last_updated
FROM vendor v
JOIN [user] u ON v.[user_id] = u.id
JOIN vendor_analytics va ON v.id = va.vendor_id
WHERE va.total_sales_amount > 0
ORDER BY va.total_sales_amount DESC;
-- Expected: Vendors with sales:
-- - Jane’s Tech Shop (Jane Smith, approved, 4 products, 3750.00)
-- - Mike’s Electronics (Mike Nelson, approved, 2 products, 770.00)
-- - Alice’s Gadgets (Alice Johnson, approved, 4 products, 535.00)
-- - Quincy’s Jewelry (Quincy Reed, approved, 1 product, 350.00)
-- - Ian’s Toys (Ian James, approved, 2 products, 105.00)
-- - Ethan’s Books (Ethan Fox, approved, 3 products, 113.00)
-- - Oscar’s Home Goods (Oscar Perez, approved, 1 product, 100.00)

-- 3. Find all reviews for a specific product (e.g., Laptop Pro, product_id=1)
-- Purpose: Verify relationship between user_review, product, [user], and shop_order
SELECT 
    p.name AS product_name,
    u.full_name AS reviewer,
    ur.rating,
    ur.review_text,
    ur.created_at
FROM product p
JOIN user_review ur ON p.id = ur.product_id
JOIN [user] u ON ur.[user_id] = u.id
WHERE p.id = 1;
-- Expected: Reviews for Laptop Pro (product_id=1):
-- - John Doe: rating=5, "Amazing laptop!", created_at='2025-04-22'
-- - Charlie Davis: rating=5, "Second laptop, still impressed!", created_at='2025-04-22'

-- 4. List products in a specific category (e.g., Electronics, category_id=1) with vendor details
-- Purpose: Verify relationship between category, product_category, product, product_item, and vendor
SELECT 
    c.name AS category_name,
    p.name AS product_name,
    pi.price AS vendor_price,
    v.vendor_name,
    v.status AS vendor_status
FROM category c
JOIN product_category pc ON c.id = pc.category_id
JOIN product p ON pc.product_id = p.id
JOIN product_item pi ON p.id = pi.product_id
JOIN vendor v ON pi.vendor_id = v.id
WHERE c.id = 1;
-- Expected: Products in Electronics (category_id=1):
-- - Laptop Pro, price=1200.00, Jane’s Tech Shop, status='approved'
-- - Smartphone X, price=900.00, Jane’s Tech Shop, status='approved'
-- - Tablet, price=450.00, Jane’s Tech Shop, status='approved'
-- - Headphones, price=110.00, Jane’s Tech Shop, status='approved'

-- 5. Show all orders with their shipping and payment methods
-- Purpose: Verify relationship between shop_order, payment_method, shipping_method, and order_status
SELECT 
    u.full_name AS buyer_name,
    so.order_date,
    so.total_amount,
    pm.method_name AS payment_method,
    sm.method_name AS shipping_method,
    sm.shipping_cost,
    os.status_name AS order_status
FROM shop_order so
JOIN [user] u ON so.[user_id] = u.id
JOIN payment_method pm ON so.payment_method_id = pm.id
JOIN shipping_method sm ON so.shipping_method_id = sm.id
JOIN order_status os ON so.order_status_id = os.id
ORDER BY so.order_date;
-- Expected: 20 rows, e.g.:
-- - John Doe, order_date='2025-04-21', total_amount=1296.00, payment='Credit Card', shipping='Standard Shipping', cost=5.00, status='Delivered'
-- - John Doe, order_date='2025-04-21', total_amount=118.80, payment='Debit Card', shipping='Express Shipping', cost=15.00, status='Delivered'

-- 6. List vendors with pending or suspended status and their user details
-- Purpose: Verify relationship between vendor and [user]; check vendor status
SELECT 
    v.vendor_name,
    v.status,
    u.full_name AS vendor_user,
    u.email_address
FROM vendor v
JOIN [user] u ON v.[user_id] = u.id
WHERE v.status IN ('pending', 'suspended');
-- Expected: Vendors with pending/suspended status:
-- - Diana’s Fashion, status='pending', Diana Evans, diana.e6@example.com
-- - George’s Tools, status='suspended', George Harris, george.h9@example.com
-- - Kevin’s Sports, status='pending', Kevin Lee, kevin.l13@example.com

-- 7. Show average rating and number of reviews per product
-- Purpose: Analyze product performance using user_review and product
SELECT 
    p.name AS product_name,
    COUNT(ur.id) AS review_count,
    AVG(CAST(ur.rating AS FLOAT)) AS average_rating
FROM product p
LEFT JOIN user_review ur ON p.id = ur.product_id
GROUP BY p.id, p.name
HAVING COUNT(ur.id) > 0
ORDER BY average_rating DESC;
-- Expected: Products with reviews, e.g.:
-- - Laptop Pro, review_count=2, average_rating=5.0
-- - Men’s Jacket, review_count=2, average_rating=5.0
-- - Necklace, review_count=1, average_rating=5.0
-- - Smartphone X, review_count=2, average_rating=4.0

-- 8. List audit logs for a specific user (e.g., John Doe, user_id=1)
-- Purpose: Verify relationship between audit_log and [user]; track user activity
SELECT 
    u.full_name,
    al.action_type,
    al.details,
    al.created_at
FROM audit_log al
JOIN [user] u ON al.[user_id] = u.id
WHERE u.id = 1;
-- Expected: Audit logs for John Doe (user_id=1):
-- - action_type='purchase', details='Order ID: 1, Product Item ID: 1', created_at='2025-04-21'
-- - action_type='purchase', details='Order ID: 2, Product Item ID: 4', created_at='2025-04-21'
-- - action_type='purchase', details='Order ID: 17, Product Item ID: 11', created_at='2025-04-21'

-- 9. Show stock quantity and vendor details for active products
-- Purpose: Verify relationship between product_item, product, and vendor; check inventory
SELECT 
    p.name AS product_name,
    pi.stock_quantity,
    pi.price,
    v.vendor_name,
    v.status AS vendor_status,
    pi.is_active
FROM product_item pi
JOIN product p ON pi.product_id = p.id
JOIN vendor v ON pi.vendor_id = v.id
WHERE pi.is_active = 1
ORDER BY pi.stock_quantity DESC;
-- Expected: Active products, e.g.:
-- - Smartphone X, stock_quantity=13, price=900.00, Jane’s Tech Shop, status='approved'
-- - Tablet, stock_quantity=9, price=450.00, Jane’s Tech Shop, status='approved'

-- 10. List users with their roles and addresses
-- Purpose: Verify relationship between [user], user_role, role, and address
SELECT 
    u.full_name,
    u.email_address,
    r.name AS role_name,
    a.address_line1,
    a.city,
    a.state,
    a.country
FROM [user] u
JOIN user_role ur ON u.id = ur.[user_id]
JOIN role r ON ur.role_id = r.id
JOIN address a ON u.id = a.[user_id]
ORDER BY u.full_name;
-- Expected: 29 rows (some users have multiple roles), e.g.:
-- - John Doe, email='john.doe1@example.com', role='buyer', address='123 Main St', city='New York', state='NY', country='USA'
-- - Jane Smith, email='jane.smith2@example.com', role='buyer', address='456 Elm St', city='Boston', state='MA', country='USA'
-- - Jane Smith, email='jane.smith2@example.com', role='vendor', address='456 Elm St', city='Boston', state='MA', country='USA'



select * from audit_log

select * from
product



-- Step 1: Inspect audit_log Constraints and Data
SELECT 
    name,
    definition
FROM sys.check_constraints
WHERE name = 'CK__audit_log__actio__17036CC0';

SELECT DISTINCT action_type 
FROM audit_log;

-- Step 2: Fix the trg_order_line_after_insert Trigger
ALTER TRIGGER trg_order_line_after_insert
ON order_line
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Update stock in product_item
    UPDATE product_item
    SET stock_quantity = stock_quantity - i.quantity
    FROM product_item pi
    JOIN inserted i ON pi.id = i.product_item_id;

    -- Log the action in audit_log
    INSERT INTO audit_log (user_id, action_type, details, created_at)
    SELECT 
        (SELECT user_id FROM shop_order WHERE id = i.order_id),
        'purchase',  -- Changed to an allowed value
        'Order Line ID: ' + CAST(i.id AS VARCHAR(10)) + ' added for Order ID: ' + CAST(i.order_id AS VARCHAR(10)),
        GETDATE()
    FROM inserted i;
END;

-- Step 3: Update sp_checkout to Handle NULL Values and Improve Transaction Management
ALTER PROCEDURE sp_checkout
    @user_id INT,
    @discount_code VARCHAR(50),
    @payment_method_id INT,
    @shipping_method_id INT,
    @order_id INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @subtotal DECIMAL(10, 2);
    DECLARE @discount_amount DECIMAL(10, 2) = 0;
    DECLARE @tax_rate DECIMAL(5, 2) = 0.08; -- 8% tax rate
    DECLARE @tax_amount DECIMAL(10, 2);
    DECLARE @shipping_cost DECIMAL(10, 2);
    DECLARE @total_amount DECIMAL(10, 2);
    DECLARE @shipping_address_id INT;
    DECLARE @billing_address_id INT;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validate user exists and is active
        IF NOT EXISTS (SELECT 1 FROM [user] WHERE id = @user_id AND is_active = 1)
            THROW 50001, 'User does not exist or is not active.', 1;

        -- Validate payment method
        IF NOT EXISTS (SELECT 1 FROM payment_method WHERE id = @payment_method_id AND is_active = 1)
            THROW 50002, 'Invalid or inactive payment method.', 1;

        -- Validate shipping method
        IF NOT EXISTS (SELECT 1 FROM shipping_method WHERE id = @shipping_method_id AND is_active = 1)
            THROW 50003, 'Invalid or inactive shipping method.', 1;

        -- Get shipping cost
        SELECT @shipping_cost = shipping_cost
        FROM shipping_method
        WHERE id = @shipping_method_id;

        -- Get default shipping and billing addresses
        SELECT @shipping_address_id = id
        FROM address
        WHERE user_id = @user_id AND address_type IN ('shipping', 'both') AND is_default = 1;

        SELECT @billing_address_id = id
        FROM address
        WHERE user_id = @user_id AND address_type IN ('billing', 'both') AND is_default = 1;

        IF @shipping_address_id IS NULL OR @billing_address_id IS NULL
            THROW 50004, 'User must have default shipping and billing addresses.', 1;

        -- Validate cart has items
        IF NOT EXISTS (SELECT 1 FROM cart WHERE user_id = @user_id)
            THROW 50005, 'Cart is empty.', 1;

        -- Validate stock availability using vw_product_stock
        IF EXISTS (
            SELECT 1
            FROM cart c
            JOIN vw_product_stock vps ON c.product_item_id = vps.product_item_id
            WHERE c.user_id = @user_id
            AND vps.available_stock < c.quantity
        )
            THROW 50006, 'Insufficient stock for one or more items.', 1;

        -- Create the order
        INSERT INTO shop_order (
            user_id,
            order_status_id,
            total_amount,
            order_date,
            payment_method_id,
            shipping_method_id,
            shipping_address_id,
            billing_address_id,
            subtotal,
            tax_amount,
            discount_amount
        )
        VALUES (
            @user_id,
            1, -- Pending status
            0, -- Placeholder for total_amount
            GETDATE(),
            @payment_method_id,
            @shipping_method_id,
            @shipping_address_id,
            @billing_address_id,
            0, -- Placeholder for subtotal
            0, -- Placeholder for tax_amount
            0  -- Placeholder for discount_amount
        );

        SET @order_id = SCOPE_IDENTITY();

        -- Move cart items to order_line
        INSERT INTO order_line (order_id, product_item_id, quantity, price)
        SELECT 
            @order_id,
            c.product_item_id,
            c.quantity,
            pi.price * (1 - COALESCE((
                SELECT TOP 1 discount_percentage / 100
                FROM discount d
                WHERE d.vendor_id = pi.vendor_id
                AND d.is_active = 1
                AND (d.product_item_id = pi.id OR d.product_item_id IS NULL)
                AND d.discount_code = @discount_code
                AND d.start_date <= GETDATE()
                AND d.end_date >= GETDATE()
            ), 0))
        FROM cart c
        JOIN product_item pi ON c.product_item_id = pi.id
        WHERE c.user_id = @user_id;

        -- Calculate subtotal with NULL handling
        SET @subtotal = (
            SELECT SUM(COALESCE(quantity, 0) * COALESCE(price, 0))
            FROM order_line
            WHERE order_id = @order_id
        );

        IF @subtotal IS NULL
            SET @subtotal = 0;

        -- Calculate discount amount
        SET @discount_amount = (
            SELECT SUM(COALESCE(quantity, 0) * COALESCE(pi.price, 0)) - @subtotal
            FROM cart c
            JOIN product_item pi ON c.product_item_id = pi.id
            WHERE c.user_id = @user_id
        );

        IF @discount_amount IS NULL
            SET @discount_amount = 0;

        -- Calculate tax
        SET @tax_amount = @subtotal * @tax_rate;

        -- Calculate total
        SET @total_amount = @subtotal + @tax_amount + @shipping_cost - @discount_amount;

        -- Update the order with calculated values
        UPDATE shop_order
        SET 
            subtotal = @subtotal,
            tax_amount = @tax_amount,
            discount_amount = @discount_amount,
            total_amount = @total_amount
        WHERE id = @order_id;

        -- Clear the cart
        DELETE FROM cart
        WHERE user_id = @user_id;

        -- Commit the transaction
        IF XACT_STATE() = 1
            COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Log the error
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        -- Roll back the transaction if possible
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;

        -- Re-throw the error
        THROW 50000, @ErrorMessage, @ErrorState;
    END CATCH;
END;

-- Step 4: Retest sp_checkout
DECLARE @new_order_id INT;

BEGIN TRANSACTION;

EXEC sp_checkout
    @user_id = 1,
    @discount_code = 'TECH15',
    @payment_method_id = 1,
    @shipping_method_id = 1,
    @order_id = @new_order_id OUTPUT;

-- See the result
SELECT @new_order_id AS OrderID;

-- Check the created order
SELECT * FROM shop_order WHERE id = @new_order_id;

-- Check order lines
SELECT * FROM order_line WHERE order_id = @new_order_id;

-- Check updated stock
SELECT * FROM product_item WHERE id = 1;

-- Check cart (should be cleared for user_id=1)
SELECT * FROM cart WHERE user_id = 1;

-- Check audit log entries
SELECT * FROM audit_log WHERE user_id = 1 AND action_type = 'purchase' AND created_at >= '2025-04-23';

COMMIT TRANSACTION;
############--#####################

EXEC sp_submit_review
    @user_id = 3,
    @product_id = 10,
    @order_id = 501,
    @rating = 5,
    @review_text = 'Fantastic product! Highly recommend.';

	EXEC sp_vendor_sales_report @product_id = 10;
	EXEC sp_vendor_sales_report @vendor_id = 2

-- Suppose this order has product_id 101 via a product_item in it
INSERT INTO user_review (user_id, product_id, order_id, rating, review_text, created_at)
VALUES (5, 101, 9, 4, 'Nice product!', GETDATE());
