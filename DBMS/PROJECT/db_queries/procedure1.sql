-- procedurs


-- Drop existing procedures if they exist
IF OBJECT_ID('sp_register_user', 'P') IS NOT NULL
    DROP PROCEDURE sp_register_user;
GO
IF OBJECT_ID('sp_assign_role', 'P') IS NOT NULL
    DROP PROCEDURE sp_assign_role;
GO
IF OBJECT_ID('sp_update_vendor_status', 'P') IS NOT NULL
    DROP PROCEDURE sp_update_vendor_status;
GO
IF OBJECT_ID('sp_add_product', 'P') IS NOT NULL
    DROP PROCEDURE sp_add_product;
GO
IF OBJECT_ID('sp_add_product_item', 'P') IS NOT NULL
    DROP PROCEDURE sp_add_product_item;
GO
IF OBJECT_ID('sp_update_product_item_stock', 'P') IS NOT NULL
    DROP PROCEDURE sp_update_product_item_stock;
GO
IF OBJECT_ID('sp_add_to_cart', 'P') IS NOT NULL
    DROP PROCEDURE sp_add_to_cart;
GO
IF OBJECT_ID('sp_checkout', 'P') IS NOT NULL
    DROP PROCEDURE sp_checkout;
GO
IF OBJECT_ID('sp_update_order_status', 'P') IS NOT NULL
    DROP PROCEDURE sp_update_order_status;
GO

-- Procedure 1: Registers a new user
CREATE PROCEDURE sp_register_user
    @full_name VARCHAR(100),
    @email_address VARCHAR(100),
    @password VARCHAR(255),
    @user_id INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validate email uniqueness
        IF EXISTS (SELECT 1 FROM [user] WHERE email_address = @email_address)
            THROW 50001, 'Email address already exists.', 1;

        -- Insert user
        INSERT INTO [user] (full_name, email_address, password, created_at, is_active)
        VALUES (@full_name, @email_address, @password, GETDATE(), 1);

        SET @user_id = SCOPE_IDENTITY();

        -- Assign default role (buyer)
        INSERT INTO user_role ([user_id], role_id, assigned_at, assigned_by)
        VALUES (@user_id, 1, GETDATE(), NULL);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO

-- Procedure 2: Assigns a role to a user
CREATE PROCEDURE sp_assign_role
    @user_id INT,
    @role_id INT,
    @assigned_by INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validate user
        IF NOT EXISTS (SELECT 1 FROM [user] WHERE id = @user_id AND is_active = 1)
            THROW 50002, 'User does not exist or is not active.', 1;

        -- Validate role
        IF NOT EXISTS (SELECT 1 FROM role WHERE id = @role_id)
            THROW 50003, 'Role does not exist.', 1;

        -- Validate assigned_by user
        IF NOT EXISTS (SELECT 1 FROM [user] WHERE id = @assigned_by AND is_active = 1)
            THROW 50004, 'Assigning user does not exist or is not active.', 1;

        -- Check if role is already assigned
        IF EXISTS (SELECT 1 FROM user_role WHERE [user_id] = @user_id AND role_id = @role_id)
            THROW 50005, 'Role already assigned to user.', 1;

        -- Assign role
        INSERT INTO user_role ([user_id], role_id, assigned_at, assigned_by)
        VALUES (@user_id, @role_id, GETDATE(), @assigned_by);

        -- If assigning vendor role, create vendor entry
        IF @role_id = 2 -- Vendor role
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM vendor WHERE [user_id] = @user_id)
            BEGIN
                INSERT INTO vendor ([user_id], vendor_name, status, created_at)
                VALUES (@user_id, 'Vendor ' + (SELECT full_name FROM [user] WHERE id = @user_id), 'pending', GETDATE());

                -- Initialize vendor analytics
                INSERT INTO vendor_analytics (vendor_id, total_products, total_sales_amount, last_updated)
                VALUES (SCOPE_IDENTITY(), 0, 0.00, GETDATE());
            END;
        END;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO

-- Procedure 3: Updates vendor status
CREATE PROCEDURE sp_update_vendor_status
    @vendor_id INT,
    @status VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validate vendor
        IF NOT EXISTS (SELECT 1 FROM vendor WHERE id = @vendor_id)
            THROW 50006, 'Vendor does not exist.', 1;

        -- Validate status
        IF @status NOT IN ('pending', 'approved', 'suspended')
            THROW 50007, 'Invalid vendor status.', 1;

        -- Update vendor status
        UPDATE vendor
        SET status = @status
        WHERE id = @vendor_id;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO

-- Procedure 4: Adds a new product
CREATE PROCEDURE sp_add_product
    @name VARCHAR(100),
    @description TEXT,
    @base_price DECIMAL(10, 2),
    @category_id INT,
    @product_id INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validate base price
        IF @base_price < 0
            THROW 50008, 'Base price cannot be negative.', 1;

        -- Validate category
        IF NOT EXISTS (SELECT 1 FROM category WHERE id = @category_id AND is_active = 1)
            THROW 50009, 'Category does not exist or is not active.', 1;

        -- Insert product
        INSERT INTO product (name, description, base_price, is_active, created_at)
        VALUES (@name, @description, @base_price, 1, GETDATE());

        SET @product_id = SCOPE_IDENTITY();

        -- Map product to category
        INSERT INTO product_category (product_id, category_id, created_at)
        VALUES (@product_id, @category_id, GETDATE());

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO

-- Procedure 5: Adds a product item (vendor-specific)
CREATE PROCEDURE sp_add_product_item
    @product_id INT,
    @vendor_id INT,
    @stock_quantity INT,
    @price DECIMAL(10, 2),
    @product_item_id INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validate product
        IF NOT EXISTS (SELECT 1 FROM product WHERE id = @product_id AND is_active = 1)
            THROW 50010, 'Product does not exist or is not active.', 1;

        -- Validate vendor
        IF NOT EXISTS (SELECT 1 FROM vendor WHERE id = @vendor_id AND status = 'approved')
            THROW 50011, 'Vendor does not exist or is not approved.', 1;

        -- Validate stock and price
        IF @stock_quantity < 0 OR @price < 0
            THROW 50012, 'Stock quantity and price must be non-negative.', 1;

        -- Insert product item
        INSERT INTO product_item (product_id, vendor_id, stock_quantity, price, is_active, created_at)
        VALUES (@product_id, @vendor_id, @stock_quantity, @price, 1, GETDATE());

        SET @product_item_id = SCOPE_IDENTITY();

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO

-- Procedure 6: Updates stock for a product item
CREATE PROCEDURE sp_update_product_item_stock
    @product_item_id INT,
    @new_stock_quantity INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validate product item
        IF NOT EXISTS (SELECT 1 FROM product_item WHERE id = @product_item_id AND is_active = 1)
            THROW 50013, 'Product item does not exist or is not active.', 1;

        -- Validate stock quantity
        IF @new_stock_quantity < 0
            THROW 50014, 'Stock quantity cannot be negative.', 1;

        -- Update stock
        UPDATE product_item
        SET stock_quantity = @new_stock_quantity
        WHERE id = @product_item_id;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO

-- Procedure 7: Adds items to the cart
CREATE PROCEDURE sp_add_to_cart
    @user_id INT,
    @product_item_id INT,
    @quantity INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @available_stock INT;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validate user
        IF NOT EXISTS (SELECT 1 FROM [user] WHERE id = @user_id AND is_active = 1)
            THROW 50015, 'User does not exist or is not active.', 1;

        -- Validate product item
        IF NOT EXISTS (SELECT 1 FROM product_item WHERE id = @product_item_id AND is_active = 1)
            THROW 50016, 'Product item does not exist or is not active.', 1;

        -- Check stock availability
        SELECT @available_stock = stock_quantity - COALESCE((
            SELECT SUM(quantity)
            FROM cart
            WHERE product_item_id = @product_item_id
        ), 0)
        FROM product_item
        WHERE id = @product_item_id;

        IF @available_stock < @quantity
            THROW 50017, 'Insufficient stock available.', 1;

        -- Add or update cart
        IF EXISTS (SELECT 1 FROM cart WHERE user_id = @user_id AND product_item_id = @product_item_id)
        BEGIN
            UPDATE cart
            SET quantity = quantity + @quantity,
                added_at = GETDATE()
            WHERE user_id = @user_id AND product_item_id = @product_item_id;
        END
        ELSE
        BEGIN
            INSERT INTO cart (user_id, product_item_id, quantity, added_at)
            VALUES (@user_id, @product_item_id, @quantity, GETDATE());
        END;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO

-- Procedure 8: Processes checkout and creates an order
CREATE PROCEDURE sp_checkout
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

        -- Validate user
        IF NOT EXISTS (SELECT 1 FROM [user] WHERE id = @user_id AND is_active = 1)
            THROW 50018, 'User does not exist or is not active.', 1;

        -- Validate payment method
        IF NOT EXISTS (SELECT 1 FROM payment_method WHERE id = @payment_method_id AND is_active = 1)
            THROW 50019, 'Invalid or inactive payment method.', 1;

        -- Validate shipping method
        IF NOT EXISTS (SELECT 1 FROM shipping_method WHERE id = @shipping_method_id AND is_active = 1)
            THROW 50020, 'Invalid or inactive shipping method.', 1;

        -- Get shipping cost
        SELECT @shipping_cost = COALESCE(shipping_cost, 0)
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
            THROW 50021, 'User must have default shipping and billing addresses.', 1;

        -- Validate cart has items
        IF NOT EXISTS (SELECT 1 FROM cart WHERE user_id = @user_id)
            THROW 50022, 'Cart is empty.', 1;

        -- Validate stock availability
        IF EXISTS (
            SELECT 1
            FROM cart c
            JOIN product_item pi ON c.product_item_id = pi.id
            WHERE c.user_id = @user_id
            AND pi.stock_quantity < c.quantity
        )
            THROW 50023, 'Insufficient stock for one or more items.', 1;

        -- Create the order
        INSERT INTO shop_order (
            [user_id],
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

        -- Move cart items to order_line with discount applied
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
            SELECT SUM(COALESCE(c.quantity, 0) * COALESCE(pi.price, 0))
            FROM cart c
            JOIN product_item pi ON c.product_item_id = pi.id
            WHERE c.user_id = @user_id
        ) - @subtotal;

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

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO

-- Procedure 9: Updates order status
CREATE PROCEDURE sp_update_order_status
    @order_id INT,
    @order_status_id INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validate order
        IF NOT EXISTS (SELECT 1 FROM shop_order WHERE id = @order_id)
            THROW 50024, 'Order does not exist.', 1;

        -- Validate order status
        IF NOT EXISTS (SELECT 1 FROM order_status WHERE id = @order_status_id)
            THROW 50025, 'Order status does not exist.', 1;

        -- Update order status
        UPDATE shop_order
        SET order_status_id = @order_status_id
        WHERE id = @order_id;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO