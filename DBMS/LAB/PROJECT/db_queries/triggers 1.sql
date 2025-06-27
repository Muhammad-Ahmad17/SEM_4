-- triggers
-- Drop existing triggers if they exist
IF OBJECT_ID('trg_shop_order_after_insert', 'TR') IS NOT NULL
    DROP TRIGGER trg_shop_order_after_insert;
GO
IF OBJECT_ID('trg_order_line_after_insert', 'TR') IS NOT NULL
    DROP TRIGGER trg_order_line_after_insert;
GO
IF OBJECT_ID('trg_product_item_stock_adjustment', 'TR') IS NOT NULL
    DROP TRIGGER trg_product_item_stock_adjustment;
GO
IF OBJECT_ID('trg_discount_auto_deactivate', 'TR') IS NOT NULL
    DROP TRIGGER trg_discount_auto_deactivate;
GO
IF OBJECT_ID('trg_vendor_analytics_update', 'TR') IS NOT NULL
    DROP TRIGGER trg_vendor_analytics_update;
GO
IF OBJECT_ID('trg_user_role_after_insert', 'TR') IS NOT NULL
    DROP TRIGGER trg_user_role_after_insert;
GO
IF OBJECT_ID('trg_vendor_after_update', 'TR') IS NOT NULL
    DROP TRIGGER trg_vendor_after_update;
GO
IF OBJECT_ID('trg_product_item_after_insert', 'TR') IS NOT NULL
    DROP TRIGGER trg_product_item_after_insert;
GO

-- Trigger 1: Logs order creation in audit_log
CREATE TRIGGER trg_shop_order_after_insert
ON shop_order
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO audit_log ([user_id], action_type, details, created_at)
    SELECT 
        i.[user_id],
        'order_creation',
        'Order ID: ' + CAST(i.id AS VARCHAR(10)) + ' created with total amount: ' + CAST(i.total_amount AS VARCHAR(20)),
        GETDATE()
    FROM inserted i;
END;
GO

-- Trigger 2: Updates stock and logs order line creation
CREATE TRIGGER trg_order_line_after_insert
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
    INSERT INTO audit_log ([user_id], action_type, details, created_at)
    SELECT 
        (SELECT [user_id] FROM shop_order WHERE id = i.order_id),
        'purchase',
        'Order Line ID: ' + CAST(i.id AS VARCHAR(10)) + ' added for Order ID: ' + CAST(i.order_id AS VARCHAR(10)),
        GETDATE()
    FROM inserted i;
END;
GO

-- Trigger 3: Logs stock changes
CREATE TRIGGER trg_product_item_stock_adjustment
ON product_item
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO audit_log ([user_id], action_type, details, created_at)
    SELECT 
        NULL,
        'stock_update',
        'Product Item ID: ' + CAST(i.id AS VARCHAR(10)) + ' stock changed from ' + 
        CAST(d.stock_quantity AS VARCHAR(10)) + ' to ' + CAST(i.stock_quantity AS VARCHAR(10)),
        GETDATE()
    FROM inserted i
    JOIN deleted d ON i.id = d.id
    WHERE i.stock_quantity <> d.stock_quantity;
END;
GO

-- Trigger 4: Deactivates expired discounts
CREATE TRIGGER trg_discount_auto_deactivate
ON discount
AFTER UPDATE, INSERT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE discount
    SET is_active = 0
    WHERE end_date < GETDATE()
    AND is_active = 1;
END;
GO

-- Trigger 5: Updates vendor analytics after order line insertion
CREATE TRIGGER trg_vendor_analytics_update
ON order_line
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE va
    SET 
        total_products = (
            SELECT COUNT(*) 
            FROM product_item pi 
            WHERE pi.vendor_id = va.vendor_id AND pi.is_active = 1
        ),
        total_sales_amount = (
            SELECT COALESCE(SUM(ol.price * ol.quantity), 0)
            FROM order_line ol
            JOIN product_item pi ON ol.product_item_id = pi.id
            WHERE pi.vendor_id = va.vendor_id
        ),
        last_updated = GETDATE()
    FROM vendor_analytics va
    JOIN product_item pi ON pi.vendor_id = va.vendor_id
    JOIN inserted i ON i.product_item_id = pi.id;
END;
GO

-- Trigger 6: Logs role assignment in audit_log
CREATE TRIGGER trg_user_role_after_insert
ON user_role
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO audit_log ([user_id], action_type, details, created_at)
    SELECT 
        i.[user_id],
        'role_assignment',
        'Role ID: ' + CAST(i.role_id AS VARCHAR(10)) + ' assigned to User ID: ' + CAST(i.[user_id] AS VARCHAR(10)) + 
        ' by User ID: ' + COALESCE(CAST(i.assigned_by AS VARCHAR(10)), 'NULL'),
        GETDATE()
    FROM inserted i;
END;
GO

-- Trigger 7: Logs vendor status changes
CREATE TRIGGER trg_vendor_after_update
ON vendor
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO audit_log ([user_id], action_type, details, created_at)
    SELECT 
        i.[user_id],
        'vendor_approval',
        'Vendor ID: ' + CAST(i.id AS VARCHAR(10)) + ' status changed from ' + 
        d.status + ' to ' + i.status,
        GETDATE()
    FROM inserted i
    JOIN deleted d ON i.id = d.id
    WHERE i.status <> d.status;
END;
GO

-- Trigger 8: Updates vendor analytics when a new product item is added
CREATE TRIGGER trg_product_item_after_insert
ON product_item
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE va
    SET 
        total_products = (
            SELECT COUNT(*) 
            FROM product_item pi 
            WHERE pi.vendor_id = va.vendor_id AND pi.is_active = 1
        ),
        last_updated = GETDATE()
    FROM vendor_analytics va
    JOIN inserted i ON i.vendor_id = va.vendor_id;
END;
GO