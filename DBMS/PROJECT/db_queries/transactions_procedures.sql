-- File: stored_procedures.sql
-- Purpose: Contains all stored procedures for the e-commerce app database
-- Total Stored Procedures: 8

-- Drop existing stored procedures to avoid conflicts
IF OBJECT_ID('sp_get_product_reviews', 'P') IS NOT NULL DROP PROCEDURE sp_get_product_reviews;
IF OBJECT_ID('sp_vendor_stock_report', 'P') IS NOT NULL DROP PROCEDURE sp_vendor_stock_report;
IF OBJECT_ID('sp_checkout', 'P') IS NOT NULL DROP PROCEDURE sp_checkout;
IF OBJECT_ID('sp_submit_review', 'P') IS NOT NULL DROP PROCEDURE sp_submit_review;
IF OBJECT_ID('sp_vendor_sales_report', 'P') IS NOT NULL DROP PROCEDURE sp_vendor_sales_report;
IF OBJECT_ID('sp_register_user', 'P') IS NOT NULL DROP PROCEDURE sp_register_user;
IF OBJECT_ID('sp_add_vendor_product', 'P') IS NOT NULL DROP PROCEDURE sp_add_vendor_product;
IF OBJECT_ID('sp_add_to_cart', 'P') IS NOT NULL DROP PROCEDURE sp_add_to_cart;
IF OBJECT_ID('sp_cleanup_cart', 'P') IS NOT NULL DROP PROCEDURE sp_cleanup_cart;
GO


-- Stored Procedure: get product reviews
CREATE PROCEDURE sp_get_product_reviews
    @product_id INT
AS
BEGIN
    SELECT *
    FROM vw_user_reviews
    WHERE product_name = (SELECT name FROM product WHERE id = @product_id);
END;
GO
-- Stored Procedure: Generates a vendor stock report
CREATE PROCEDURE sp_vendor_stock_report
    @vendor_id INT
AS
BEGIN
    SELECT 
        v.vendor_name,
        p.name AS product_name,
        pi.stock_quantity,
        pi.price,
        pi.is_active,
        COALESCE(ol.units_sold, 0) AS units_sold,
        CASE WHEN pi.stock_quantity < 5 THEN 'Low Stock Warning' ELSE 'Sufficient Stock' END AS stock_status
    FROM vendor v
    JOIN product_item pi ON v.id = pi.vendor_id
    JOIN product p ON pi.product_id = p.id
    LEFT JOIN (
        SELECT product_item_id, COUNT(*) AS units_sold
        FROM order_line
        GROUP BY product_item_id
    ) ol ON pi.id = ol.product_item_id
    WHERE v.id = @vendor_id
    ORDER BY pi.stock_quantity ASC;
END;
GO

-- Stored Procedure: Handles the checkout process (with transaction/savepoint)
CREATE PROCEDURE sp_checkout
    @user_id INT,
    @discount_code VARCHAR(50),
    @payment_method_id INT,
    @shipping_method_id INT,
    @order_id INT OUTPUT
AS
BEGIN
    DECLARE @trancount INT = @@TRANCOUNT;
    DECLARE @savepoint VARCHAR(32) = 'CHECKOUT_SAVEPOINT';

    BEGIN TRY
        IF @trancount = 0
            BEGIN TRANSACTION;
        ELSE
            SAVE TRANSACTION @savepoint;

        -- Step 1: Initial stock check using available stock (considering reserved stock)
        DECLARE @cart_items TABLE (
            product_item_id INT,
            quantity INT,
            available_stock INT,
            is_critical BIT
        );

        INSERT INTO @cart_items (product_item_id, quantity, available_stock, is_critical)
        SELECT 
            c.product_item_id,
            c.quantity,
            vps.available_stock,
            CASE WHEN vps.available_stock <= c.quantity + 1 THEN 1 ELSE 0 END AS is_critical
        FROM cart c
        JOIN vw_product_stock vps ON c.product_item_id = vps.product_item_id
        WHERE c.user_id = @user_id;

        -- Step 2: Check for insufficient stock (initial check)
        DECLARE @insufficient_stock TABLE (product_item_id INT, available_stock INT);
        INSERT INTO @insufficient_stock (product_item_id, available_stock)
        SELECT product_item_id, available_stock
        FROM @cart_items
        WHERE available_stock < quantity;

        IF EXISTS (SELECT 1 FROM @insufficient_stock)
        BEGIN
            IF @trancount = 0
                ROLLBACK TRANSACTION;
            ELSE
                ROLLBACK TRANSACTION @savepoint;
            DECLARE @error_message VARCHAR(1000) = 'Insufficient available stock for items: ';
            SELECT @error_message = @error_message + 'Product Item ID=' + CAST(product_item_id AS VARCHAR) + ' (Available=' + CAST(available_stock AS VARCHAR) + '); '
            FROM @insufficient_stock;
            THROW 50004, @error_message, 1;
        END;

        -- Step 3: Lock and re-validate only critical items
        DECLARE @critical_insufficient TABLE (product_item_id INT, available_stock INT);
        INSERT INTO @critical_insufficient (product_item_id, available_stock)
        SELECT 
            ci.product_item_id,
            vps.available_stock
        FROM @cart_items ci
        JOIN product_item pi WITH (ROWLOCK, UPDLOCK) ON ci.product_item_id = pi.id
        JOIN vw_product_stock vps ON ci.product_item_id = vps.product_item_id
        WHERE ci.is_critical = 1
        AND vps.available_stock < ci.quantity;

        IF EXISTS (SELECT 1 FROM @critical_insufficient)
        BEGIN
            IF @trancount = 0
                ROLLBACK TRANSACTION;
            ELSE
                ROLLBACK TRANSACTION @savepoint;
            DECLARE @critical_error_message VARCHAR(1000) = 'Insufficient available stock for critical items: ';
            SELECT @critical_error_message = @critical_error_message + 'Product Item ID=' + CAST(product_item_id AS VARCHAR) + ' (Available=' + CAST(available_stock AS VARCHAR) + '); '
            FROM @critical_insufficient;
            THROW 50005, @critical_error_message, 1;
        END;

        -- Step 4: Validate discount code with locking
        DECLARE @discount_percentage DECIMAL(5,2);
        SELECT @discount_percentage = discount_percentage
        FROM discount WITH (ROWLOCK, UPDLOCK)
        WHERE discount_code = @discount_code AND is_active = 1 AND GETDATE() BETWEEN start_date AND end_date;

        -- Step 5: Create the order
        INSERT INTO shop_order (user_id, payment_method_id, shipping_method_id, order_status_id, total_amount, order_date)
        SELECT @user_id, @payment_method_id, @shipping_method_id, 1, 
               SUM(pi.price * c.quantity * (1 - ISNULL(@discount_percentage, 0) / 100)) + sm.shipping_cost, 
               GETDATE()
        FROM cart c
        JOIN product_item pi ON c.product_item_id = pi.id
        JOIN shipping_method sm ON sm.id = @shipping_method_id
        WHERE c.user_id = @user_id
        GROUP BY sm.shipping_cost;
        SET @order_id = SCOPE_IDENTITY();

        -- Step 6: Add order lines (trigger will update stock)
        INSERT INTO order_line (order_id, product_item_id, quantity, price)
        SELECT @order_id, c.product_item_id, c.quantity, 
               pi.price * (1 - ISNULL(@discount_percentage, 0) / 100)
        FROM cart c
        JOIN product_item pi ON c.product_item_id = pi.id
        WHERE c.user_id = @user_id;

        -- Step 7: Clear the cart
        DELETE FROM cart WHERE user_id = @user_id;

        IF @trancount = 0
            COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @trancount = 0
            ROLLBACK TRANSACTION;
        ELSE
            ROLLBACK TRANSACTION @savepoint;
        THROW;
    END CATCH;
END;
GO

-- Stored Procedure: Submits a product review (with transaction/savepoint)
CREATE PROCEDURE sp_submit_review
    @user_id INT,
    @product_id INT,
    @order_id INT,
    @rating INT,
    @review_text VARCHAR(1000)
AS
BEGIN
    DECLARE @trancount INT = @@TRANCOUNT;
    DECLARE @savepoint VARCHAR(32) = 'SUBMIT_REVIEW_SAVEPOINT';

    BEGIN TRY
        IF @trancount = 0
            BEGIN TRANSACTION;
        ELSE
            SAVE TRANSACTION @savepoint;

        INSERT INTO user_review (user_id, product_id, order_id, rating, review_text, created_at)
        VALUES (@user_id, @product_id, @order_id, @rating, @review_text, GETDATE());

        IF @trancount = 0
            COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @trancount = 0
            ROLLBACK TRANSACTION;
        ELSE
            ROLLBACK TRANSACTION @savepoint;
        THROW;
    END CATCH;
END;
GO

-- Stored Procedure: Generates a vendor sales report
CREATE PROCEDURE sp_vendor_sales_report
    @vendor_id INT
AS
BEGIN
    SELECT p.name, SUM(ol.quantity) AS units_sold, SUM(ol.price * ol.quantity) AS total_revenue
    FROM order_line ol
    JOIN product_item pi ON ol.product_item_id = pi.id
    JOIN product p ON pi.product_id = p.id
    WHERE pi.vendor_id = @vendor_id
    GROUP BY p.name;
END;
GO

-- Stored Procedure: Registers a new user (with transaction/savepoint)
CREATE PROCEDURE sp_register_user
    @full_name VARCHAR(255),
    @email VARCHAR(255),
    @password VARCHAR(255),
    @role VARCHAR(50),
    @user_id INT OUTPUT
AS
BEGIN
    DECLARE @trancount INT = @@TRANCOUNT;
    DECLARE @savepoint VARCHAR(32) = 'REGISTER_USER_SAVEPOINT';
    DECLARE @role_id INT;

    BEGIN TRY
        IF @trancount = 0
            BEGIN TRANSACTION;
        ELSE
            SAVE TRANSACTION @savepoint;

        -- Look up role_id dynamically
        SELECT @role_id = id
        FROM role
        WHERE name = @role;

        IF @role_id IS NULL
        BEGIN
            IF @trancount = 0
                ROLLBACK TRANSACTION;
            ELSE
                ROLLBACK TRANSACTION @savepoint;
            THROW 50008, 'Invalid role specified.', 1;
        END;

        INSERT INTO [user] (full_name, email_address, password, created_at, is_active)
        VALUES (@full_name, @email, @password, GETDATE(), 1);
        SET @user_id = SCOPE_IDENTITY();

        INSERT INTO user_role (user_id, role_id, assigned_at, assigned_by)
        VALUES (@user_id, @role_id, GETDATE(), NULL);

        IF @role = 'vendor'
        BEGIN
            INSERT INTO vendor (user_id, vendor_name, status, created_at)
            VALUES (@user_id, @full_name + '''s Store', 'pending', GETDATE());
        END;

        IF @trancount = 0
            COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @trancount = 0
            ROLLBACK TRANSACTION;
        ELSE
            ROLLBACK TRANSACTION @savepoint;
        THROW;
    END CATCH;
END;
GO

-- Stored Procedure: Adds a new product for a vendor (with transaction/savepoint)
CREATE PROCEDURE sp_add_vendor_product
    @product_id INT,
    @vendor_id INT,
    @stock_quantity INT,
    @price DECIMAL(10,2),
    @is_active BIT
AS
BEGIN
    DECLARE @trancount INT = @@TRANCOUNT;
    DECLARE @savepoint VARCHAR(32) = 'ADD_PRODUCT_SAVEPOINT';

    BEGIN TRY
        IF @trancount = 0
            BEGIN TRANSACTION;
        ELSE
            SAVE TRANSACTION @savepoint;

        -- Validate product_id and vendor_id
        IF NOT EXISTS (SELECT 1 FROM product WHERE id = @product_id)
        BEGIN
            IF @trancount = 0
                ROLLBACK TRANSACTION;
            ELSE
                ROLLBACK TRANSACTION @savepoint;
            THROW 50009, 'Invalid product ID.', 1;
        END;

        IF NOT EXISTS (SELECT 1 FROM vendor WHERE id = @vendor_id)
        BEGIN
            IF @trancount = 0
                ROLLBACK TRANSACTION;
            ELSE
                ROLLBACK TRANSACTION @savepoint;
            THROW 50010, 'Invalid vendor ID.', 1;
        END;

        INSERT INTO product_item (product_id, vendor_id, stock_quantity, price, is_active, created_at)
        VALUES (@product_id, @vendor_id, @stock_quantity, @price, @is_active, GETDATE());

        IF @trancount = 0
            COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @trancount = 0
            ROLLBACK TRANSACTION;
        ELSE
            ROLLBACK TRANSACTION @savepoint;
        THROW;
    END CATCH;
END;
GO

-- Stored Procedure: Adds an item to the cart (with transaction/savepoint)
CREATE PROCEDURE sp_add_to_cart
    @user_id INT,
    @product_item_id INT,
    @quantity INT
AS
BEGIN
    DECLARE @trancount INT = @@TRANCOUNT;
    DECLARE @savepoint VARCHAR(32) = 'ADD_TO_CART_SAVEPOINT';

    BEGIN TRY
        IF @trancount = 0
            BEGIN TRANSACTION;
        ELSE
            SAVE TRANSACTION @savepoint;

        -- Check available stock with locking
        DECLARE @available_stock INT;
        SELECT @available_stock = vps.available_stock
        FROM vw_product_stock vps
        JOIN product_item pi WITH (ROWLOCK, UPDLOCK) ON vps.product_item_id = pi.id
        WHERE vps.product_item_id = @product_item_id;

        IF @available_stock IS NULL
        BEGIN
            IF @trancount = 0
                ROLLBACK TRANSACTION;
            ELSE
                ROLLBACK TRANSACTION @savepoint;
            THROW 50011, 'Product item not found.', 1;
        END;

        IF @available_stock < @quantity
        BEGIN
            IF @trancount = 0
                ROLLBACK TRANSACTION;
            ELSE
                ROLLBACK TRANSACTION @savepoint;
            DECLARE @error_message VARCHAR(1000) = 'Insufficient available stock for Product Item ID=' + CAST(@product_item_id AS VARCHAR) + ' (Available=' + CAST(@available_stock AS VARCHAR) + ')';
            THROW 50006, @error_message, 1;
        END;

        -- Use MERGE to update or insert into cart
        MERGE INTO cart AS target
        USING (SELECT @user_id AS user_id, @product_item_id AS product_item_id, @quantity AS quantity) AS source
        ON target.user_id = source.user_id AND target.product_item_id = source.product_item_id
        WHEN MATCHED THEN
            UPDATE SET 
                quantity = target.quantity + source.quantity,
                added_at = GETDATE()
        WHEN NOT MATCHED THEN
            INSERT (user_id, product_item_id, quantity, added_at)
            VALUES (source.user_id, source.product_item_id, source.quantity, GETDATE());

        IF @trancount = 0
            COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @trancount = 0
            ROLLBACK TRANSACTION;
        ELSE
            ROLLBACK TRANSACTION @savepoint;
        THROW;
    END CATCH;
END;
GO

-- Stored Procedure: Cleans up old cart items
CREATE PROCEDURE sp_cleanup_cart
AS
BEGIN
    DECLARE @trancount INT = @@TRANCOUNT;
    DECLARE @savepoint VARCHAR(32) = 'CLEANUP_CART_SAVEPOINT';
    DECLARE @batch_size INT = 1000;
    DECLARE @rows_affected INT = 1;

    BEGIN TRY
        IF @trancount = 0
            BEGIN TRANSACTION;
        ELSE
            SAVE TRANSACTION @savepoint;

        WHILE @rows_affected > 0
        BEGIN
            DELETE TOP (@batch_size)
            FROM cart WITH (ROWLOCK)
            WHERE added_at < DATEADD(MINUTE, -15, GETDATE());
            SET @rows_affected = @@ROWCOUNT;
        END;

        IF @trancount = 0
            COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @trancount = 0
            ROLLBACK TRANSACTION;
        ELSE
            ROLLBACK TRANSACTION @savepoint;
        THROW;
    END CATCH;
END;
GO