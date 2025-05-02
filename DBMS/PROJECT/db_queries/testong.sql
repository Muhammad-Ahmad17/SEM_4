-- Unit Tests for db_E_Commerce Procedures and Triggers
USE db_E_Commerce;
GO

-- Test 1: Register User (sp_register_user)
BEGIN
    PRINT 'Test 1: Register User';
    DECLARE @user_id INT;

    -- Execute sp_register_user
    EXEC sp_register_user 
        @full_name = 'Test User',
        @email_address = 'test.user@example.com',
        @password = 'hashed_pass_test',
        @user_id = @user_id OUTPUT;

    -- Validate user creation
    IF EXISTS (SELECT 1 FROM [user] WHERE id = @user_id AND email_address = 'test.user@example.com')
        PRINT 'PASS: User registered successfully.';
    ELSE
        PRINT 'FAIL: User not registered.';

    -- Validate role assignment
    IF EXISTS (SELECT 1 FROM user_role WHERE [user_id] = @user_id AND role_id = 1)
        PRINT 'PASS: Buyer role assigned successfully.';
    ELSE
        PRINT 'FAIL: Buyer role not assigned.';

    -- Validate audit log
    IF EXISTS (SELECT 1 FROM audit_log WHERE action_type = 'role_assignment' AND [user_id] = @user_id)
        PRINT 'PASS: Role assignment logged in audit_log.';
    ELSE
        PRINT 'FAIL: Role assignment not logged.';
END;
GO

-- Test 2: Assign Role (sp_assign_role)
BEGIN
    PRINT 'Test 2: Assign Role';
    DECLARE @user_id INT;

    -- Register a new user
    EXEC sp_register_user 
        @full_name = 'Test Vendor',
        @email_address = 'test.vendor@example.com',
        @password = 'hashed_pass_vendor',
        @user_id = @user_id OUTPUT;

    -- Assign vendor role
    EXEC sp_assign_role @user_id, 2, 4; -- Assigned by user_id 4 (manager)

    -- Validate role assignment
    IF EXISTS (SELECT 1 FROM user_role WHERE [user_id] = @user_id AND role_id = 2)
        PRINT 'PASS: Vendor role assigned successfully.';
    ELSE
        PRINT 'FAIL: Vendor role not assigned.';

    -- Validate vendor entry
    IF EXISTS (SELECT 1 FROM vendor WHERE [user_id] = @user_id)
        PRINT 'PASS: Vendor entry created successfully.';
    ELSE
        PRINT 'FAIL: Vendor entry not created.';

    -- Validate vendor analytics
    IF EXISTS (SELECT 1 FROM vendor_analytics WHERE vendor_id = (SELECT id FROM vendor WHERE [user_id] = @user_id))
        PRINT 'PASS: Vendor analytics initialized.';
    ELSE
        PRINT 'FAIL: Vendor analytics not initialized.';

    -- Validate audit log
    IF EXISTS (SELECT 1 FROM audit_log WHERE action_type = 'role_assignment' AND [user_id] = @user_id AND details LIKE '%Role ID: 2%')
        PRINT 'PASS: Role assignment logged in audit_log.';
    ELSE
        PRINT 'FAIL: Role assignment not logged.';
END;
GO

-- Test 3: Update Vendor Status (sp_update_vendor_status)
BEGIN
    PRINT 'Test 3: Update Vendor Status';
    DECLARE @user_id INT;
    DECLARE @vendor_id INT;

    -- Register a new user and assign vendor role
    EXEC sp_register_user 
        @full_name = 'Test Vendor 2',
        @email_address = 'test.vendor2@example.com',
        @password = 'hashed_pass_vendor2',
        @user_id = @user_id OUTPUT;

    EXEC sp_assign_role @user_id, 2, 4;
    SELECT @vendor_id = id FROM vendor WHERE [user_id] = @user_id;

    -- Update vendor status
    EXEC sp_update_vendor_status @vendor_id, 'approved';

    -- Validate status update
    IF EXISTS (SELECT 1 FROM vendor WHERE id = @vendor_id AND status = 'approved')
        PRINT 'PASS: Vendor status updated successfully.';
    ELSE
        PRINT 'FAIL: Vendor status not updated.';

    -- Validate audit log
    IF EXISTS (SELECT 1 FROM audit_log WHERE action_type = 'vendor_approval' AND details LIKE '%Vendor ID: ' + CAST(@vendor_id AS VARCHAR) + '%')
        PRINT 'PASS: Vendor status change logged in audit_log.';
    ELSE
        PRINT 'FAIL: Vendor status change not logged.';
END;
GO

-- Test 4: Add Product (sp_add_product)
BEGIN
    PRINT 'Test 4: Add Product';
    DECLARE @product_id INT;

    -- Execute sp_add_product
    EXEC sp_add_product 
        @name = 'Test Product',
        @description = 'Test Description',
        @base_price = 50.00,
        @category_id = 1,
        @product_id = @product_id OUTPUT;

    -- Validate product creation
    IF EXISTS (SELECT 1 FROM product WHERE id = @product_id AND name = 'Test Product')
        PRINT 'PASS: Product added successfully.';
    ELSE
        PRINT 'FAIL: Product not added.';

    -- Validate category mapping
    IF EXISTS (SELECT 1 FROM product_category WHERE product_id = @product_id AND category_id = 1)
        PRINT 'PASS: Product mapped to category successfully.';
    ELSE
        PRINT 'FAIL: Product not mapped to category.';
END;
GO

-- Test 5: Add Product Item (sp_add_product_item)
BEGIN
    PRINT 'Test 5: Add Product Item';
    DECLARE @product_id INT;
    DECLARE @product_item_id INT;

    -- Add a product
    EXEC sp_add_product 
        @name = 'Test Product 2',
        @description = 'Test Description 2',
        @base_price = 75.00,
        @category_id = 1,
        @product_id = @product_id OUTPUT;

    -- Add product item (using vendor_id 1, Jane’s Tech Shop, which is approved)
    EXEC sp_add_product_item 
        @product_id = @product_id,
        @vendor_id = 1,
        @stock_quantity = 10,
        @price = 80.00,
        @product_item_id = @product_item_id OUTPUT;

    -- Validate product item creation
    IF EXISTS (SELECT 1 FROM product_item WHERE id = @product_item_id AND product_id = @product_id AND vendor_id = 1)
        PRINT 'PASS: Product item added successfully.';
    ELSE
        PRINT 'FAIL: Product item not added.';

    -- Validate vendor analytics update
    IF EXISTS (SELECT 1 FROM vendor_analytics WHERE vendor_id = 1 AND total_products = (SELECT COUNT(*) FROM product_item WHERE vendor_id = 1 AND is_active = 1))
        PRINT 'PASS: Vendor analytics updated for new product item.';
    ELSE
        PRINT 'FAIL: Vendor analytics not updated.';
END;
GO

-- Test 6: Update Product Item Stock (sp_update_product_item_stock)
BEGIN
    PRINT 'Test 6: Update Product Item Stock';
    DECLARE @product_item_id INT = 1; -- Existing product item (Laptop Pro, vendor_id 1)
    DECLARE @initial_stock INT;
    DECLARE @new_stock INT = 15;

    -- Get initial stock
    SELECT @initial_stock = stock_quantity
    FROM product_item
    WHERE id = @product_item_id;

    -- Update stock
    EXEC sp_update_product_item_stock @product_item_id, @new_stock;

    -- Validate stock update
    IF EXISTS (SELECT 1 FROM product_item WHERE id = @product_item_id AND stock_quantity = @new_stock)
        PRINT 'PASS: Product item stock updated successfully.';
    ELSE
        PRINT 'FAIL: Product item stock not updated.';

    -- Validate audit log
    IF EXISTS (SELECT 1 FROM audit_log WHERE action_type = 'stock_update' AND details LIKE '%Product Item ID: ' + CAST(@product_item_id AS VARCHAR) + '%')
        PRINT 'PASS: Stock update logged in audit_log.';
    ELSE
        PRINT 'FAIL: Stock update not logged.';
END;
GO

-- Test 7: Add to Cart (sp_add_to_cart)
BEGIN
    PRINT 'Test 7: Add to Cart';
    DECLARE @user_id INT = 1;
    DECLARE @product_item_id INT = 1;
    DECLARE @quantity INT = 1;

    -- Clear cart for user
    DELETE FROM cart WHERE user_id = @user_id;

    -- Execute sp_add_to_cart
    EXEC sp_add_to_cart @user_id, @product_item_id, @quantity;

    -- Validate cart entry
    IF EXISTS (SELECT 1 FROM cart WHERE user_id = @user_id AND product_item_id = @product_item_id AND quantity = @quantity)
        PRINT 'PASS: Item added to cart successfully.';
    ELSE
        PRINT 'FAIL: Item not added to cart.';
END;
GO

-- Test 8: Insufficient Stock (sp_add_to_cart)
BEGIN
    PRINT 'Test 8: Insufficient Stock Check';
    DECLARE @user_id INT = 1;
    DECLARE @product_item_id INT = 1;
    DECLARE @quantity INT = 100; -- More than available stock (8)

    BEGIN TRY
        EXEC sp_add_to_cart @user_id, @product_item_id, @quantity;
        PRINT 'FAIL: sp_add_to_cart allowed adding more items than available stock.';
    END TRY
    BEGIN CATCH
        IF ERROR_MESSAGE() LIKE '%Insufficient stock%'
            PRINT 'PASS: sp_add_to_cart correctly blocked adding items due to insufficient stock.';
        ELSE
            PRINT 'FAIL: Unexpected error: ' + ERROR_MESSAGE();
    END CATCH;
END;
GO

-- Test 9: Checkout Process (sp_checkout)
BEGIN
    PRINT 'Test 9: Checkout Process';
    DECLARE @user_id INT = 1;
    DECLARE @discount_code VARCHAR(50) = 'TECH15';
    DECLARE @payment_method_id INT = 1;
    DECLARE @shipping_method_id INT = 1;
    DECLARE @order_id INT;
    DECLARE @initial_stock INT;
    DECLARE @final_stock INT;

    -- Clear cart and add an item
    DELETE FROM cart WHERE user_id = @user_id;
    EXEC sp_add_to_cart @user_id, 1, 1; -- Add 1 Laptop Pro

    -- Get initial stock
    SELECT @initial_stock = stock_quantity
    FROM product_item
    WHERE id = 1;

    -- Execute checkout
    EXEC sp_checkout @user_id, @discount_code, @payment_method_id, @shipping_method_id, @order_id OUTPUT;

    -- Get final stock
    SELECT @final_stock = stock_quantity
    FROM product_item
    WHERE id = 1;

    -- Validate order creation
    IF EXISTS (SELECT 1 FROM shop_order WHERE id = @order_id AND [user_id] = @user_id)
        PRINT 'PASS: Order created successfully.';
    ELSE
        PRINT 'FAIL: Order not created.';

    -- Validate stock update
    IF @final_stock = @initial_stock - 1
        PRINT 'PASS: Stock updated correctly.';
    ELSE
        PRINT 'FAIL: Stock not updated correctly. Initial: ' + CAST(@initial_stock AS VARCHAR) + ', Final: ' + CAST(@final_stock AS VARCHAR);

    -- Validate audit log entries (order_creation, purchase, stock_update)
    IF EXISTS (SELECT 1 FROM audit_log WHERE action_type = 'order_creation' AND details LIKE '%Order ID: ' + CAST(@order_id AS VARCHAR) + '%')
        AND EXISTS (SELECT 1 FROM audit_log WHERE action_type = 'purchase' AND details LIKE '%Order ID: ' + CAST(@order_id AS VARCHAR) + '%')
        AND EXISTS (SELECT 1 FROM audit_log WHERE action_type = 'stock_update' AND details LIKE '%Product Item ID: 1%')
        PRINT 'PASS: Audit logs created correctly.';
    ELSE
        PRINT 'FAIL: Audit logs not created correctly.';

    -- Validate vendor analytics update
    IF EXISTS (
        SELECT 1 
        FROM vendor_analytics 
        WHERE vendor_id = 1 
        AND total_sales_amount = (
            SELECT SUM(ol.price * ol.quantity)
            FROM order_line ol
            JOIN product_item pi ON ol.product_item_id = pi.id
            WHERE pi.vendor_id = 1
        )
    )
        PRINT 'PASS: Vendor analytics updated correctly.';
    ELSE
        PRINT 'FAIL: Vendor analytics not updated correctly.';
END;
GO

-- Test 10: Update Order Status (sp_update_order_status)
BEGIN
    PRINT 'Test 10: Update Order Status';
    DECLARE @order_id INT;
    DECLARE @user_id INT = 1;
    DECLARE @discount_code VARCHAR(50) = 'TECH15';
    DECLARE @payment_method_id INT = 1;
    DECLARE @shipping_method_id INT = 1;

    -- Create an order
    DELETE FROM cart WHERE user_id = @user_id;
    EXEC sp_add_to_cart @user_id, 1, 1; -- Add 1 Laptop Pro
    EXEC sp_checkout @user_id, @discount_code, @payment_method_id, @shipping_method_id, @order_id OUTPUT;

    -- Update order status to 'Shipped' (id=3)
    EXEC sp_update_order_status @order_id, 3;

    -- Validate status update
    IF EXISTS (SELECT 1 FROM shop_order WHERE id = @order_id AND order_status_id = 3)
        PRINT 'PASS: Order status updated successfully.';
    ELSE
        PRINT 'FAIL: Order status not updated.';
END;
GO

-- Test 11: Discount Application (sp_checkout)
BEGIN
    PRINT 'Test 11: Discount Application';
    DECLARE @user_id INT = 1;
    DECLARE @discount_code VARCHAR(50) = 'TECH15';
    DECLARE @payment_method_id INT = 1;
    DECLARE @shipping_method_id INT = 1;
    DECLARE @order_id INT;

    -- Clear cart and add an item
    DELETE FROM cart WHERE user_id = @user_id;
    EXEC sp_add_to_cart @user_id, 1, 1; -- Add 1 Laptop Pro (price: 1200)

    -- Execute checkout
    EXEC sp_checkout @user_id, @discount_code, @payment_method_id, @shipping_method_id, @order_id OUTPUT;

    -- Validate discount (15% off 1200 = 180 discount, subtotal = 1020)
    DECLARE @discount_amount DECIMAL(10, 2);
    SELECT @discount_amount = discount_amount
    FROM shop_order
    WHERE id = @order_id;

    IF @discount_amount = 180.00
        PRINT 'PASS: Discount applied correctly.';
    ELSE
        PRINT 'FAIL: Discount not applied correctly. Expected 180.00, got ' + CAST(@discount_amount AS VARCHAR);
END;
GO