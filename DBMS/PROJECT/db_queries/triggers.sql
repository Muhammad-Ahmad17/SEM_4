-- File: triggers.sql
-- Purpose: Contains all triggers for the e-commerce app database
-- Total Triggers: 19
-- Note: Execute this file in SQL Server Management Studio (SSMS) to apply all triggers

-- Drop existing triggers to avoid conflicts
IF OBJECT_ID('trg_user_after_insert', 'TR') IS NOT NULL DROP TRIGGER trg_user_after_insert;
IF OBJECT_ID('trg_user_role_after_insert', 'TR') IS NOT NULL DROP TRIGGER trg_user_role_after_insert;
IF OBJECT_ID('trg_vendor_after_insert', 'TR') IS NOT NULL DROP TRIGGER trg_vendor_after_insert;
IF OBJECT_ID('trg_order_line_after_insert', 'TR') IS NOT NULL DROP TRIGGER trg_order_line_after_insert;
IF OBJECT_ID('trg_product_item_low_stock', 'TR') IS NOT NULL DROP TRIGGER trg_product_item_low_stock;
IF OBJECT_ID('trg_product_item_after_insert', 'TR') IS NOT NULL DROP TRIGGER trg_product_item_after_insert;
IF OBJECT_ID('trg_product_item_before_update', 'TR') IS NOT NULL DROP TRIGGER trg_product_item_before_update;
IF OBJECT_ID('trg_product_item_stock_adjustment', 'TR') IS NOT NULL DROP TRIGGER trg_product_item_stock_adjustment;
IF OBJECT_ID('trg_user_review_before_insert', 'TR') IS NOT NULL DROP TRIGGER trg_user_review_before_insert;
IF OBJECT_ID('trg_shop_order_after_insert', 'TR') IS NOT NULL DROP TRIGGER trg_shop_order_after_insert;
IF OBJECT_ID('trg_order_status_before_update', 'TR') IS NOT NULL DROP TRIGGER trg_order_status_before_update;
IF OBJECT_ID('trg_discount_auto_deactivate', 'TR') IS NOT NULL DROP TRIGGER trg_discount_auto_deactivate;
IF OBJECT_ID('trg_order_status_after_update', 'TR') IS NOT NULL DROP TRIGGER trg_order_status_after_update;
IF OBJECT_ID('trg_audit_log_before_delete', 'TR') IS NOT NULL DROP TRIGGER trg_audit_log_before_delete;
IF OBJECT_ID('trg_role_before_delete', 'TR') IS NOT NULL DROP TRIGGER trg_role_before_delete;
IF OBJECT_ID('trg_permissions_after_update', 'TR') IS NOT NULL DROP TRIGGER trg_permissions_after_update;
IF OBJECT_ID('trg_address_after_update', 'TR') IS NOT NULL DROP TRIGGER trg_address_after_update;
IF OBJECT_ID('trg_category_before_delete', 'TR') IS NOT NULL DROP TRIGGER trg_category_before_delete;
IF OBJECT_ID('trg_product_after_insert', 'TR') IS NOT NULL DROP TRIGGER trg_product_after_insert;
GO

-- 1. Trigger on [user]: Log user creation in audit_log
CREATE TRIGGER trg_user_after_insert
ON [user]
AFTER INSERT
AS
BEGIN
    INSERT INTO audit_log (user_id, action_type, details, created_at)
    SELECT 
        i.id,
        'user_created',
        'New user created: ' + i.full_name,
        GETDATE()
    FROM inserted i;
END;
GO
-- Purpose: Logs whenever a new user is created.
-- Example: Inserting a new user 'Sam Wilson' will add an audit_log entry like:
-- user_id=21, action_type='user_created', details='New user created: Sam Wilson', created_at=GETDATE()

-- 2. Trigger on user_role: Log role assignment changes
CREATE TRIGGER trg_user_role_after_insert
ON user_role
AFTER INSERT
AS
BEGIN
    INSERT INTO audit_log (user_id, action_type, details, created_at)
    SELECT 
        i.user_id,
        'role_assigned',
        'Role assigned: ' + r.name,
        GETDATE()
    FROM inserted i
    JOIN role r ON i.role_id = r.id;
END;
GO
-- Purpose: Logs when a role is assigned to a user.
-- Example: Assigning 'vendor' role to user_id=21 will log:
-- user_id=21, action_type='role_assigned', details='Role assigned: vendor', created_at=GETDATE()

-- 3. Trigger on vendor: Update vendor_analytics on vendor creation
CREATE TRIGGER trg_vendor_after_insert
ON vendor
AFTER INSERT
AS
BEGIN
    INSERT INTO vendor_analytics (vendor_id, total_products, total_sales_amount, last_updated)
    SELECT 
        i.id,
        0, -- New vendor starts with 0 products
        0.00, -- New vendor starts with 0 sales
        GETDATE()
    FROM inserted i;
END;
GO
-- Purpose: Initializes a vendor_analytics entry when a new vendor is created.
-- Example: Creating a new vendor 'Sam’s Store' (id=11) will insert:
-- vendor_id=11, total_products=0, total_sales_amount=0.00, last_updated=GETDATE()

-- 4. Trigger on order_line: Update stock quantity and vendor_analytics after order line insertion
CREATE TRIGGER trg_order_line_after_insert
ON order_line
AFTER INSERT
AS
BEGIN
    -- Update stock quantity in product_item
    UPDATE pi
    SET stock_quantity = pi.stock_quantity - i.quantity
    FROM product_item pi
    JOIN inserted i ON pi.id = i.product_item_id;

    -- Update vendor_analytics total_sales_amount
    UPDATE va
    SET 
        total_sales_amount = (
            SELECT SUM(ol.price * ol.quantity)
            FROM order_line ol
            JOIN product_item pi ON ol.product_item_id = pi.id
            WHERE pi.vendor_id = va.vendor_id
        ),
        last_updated = GETDATE()
    FROM vendor_analytics va
    JOIN inserted i ON i.product_item_id IN (
        SELECT id FROM product_item pi WHERE pi.vendor_id = va.vendor_id
    );
END;
GO
-- Purpose: Reduces stock quantity and updates vendor sales after an order line is added.
-- Example: Adding an order line (product_item_id=1, quantity=1) will reduce stock of Laptop Pro to 7 and update Jane’s Tech Shop sales.

-- 5. Trigger on product_item: Log low stock warnings
CREATE TRIGGER trg_product_item_low_stock
ON product_item
AFTER UPDATE
AS
BEGIN
    INSERT INTO audit_log (user_id, action_type, details, created_at)
    SELECT 
        NULL,
        'low_stock_warning',
        'Low stock for product_item_id=' + CAST(i.id AS VARCHAR) + ': ' + CAST(i.stock_quantity AS VARCHAR) + ' units remaining',
        GETDATE()
    FROM inserted i
    JOIN deleted d ON i.id = d.id
    WHERE i.stock_quantity < 5 AND i.stock_quantity < d.stock_quantity;
END;
GO
-- Purpose: Logs a warning in audit_log if the stock quantity of a product item falls below 5.
-- Example: Updating stock of product_item_id=1 from 10 to 3 will log:
-- action_type='low_stock_warning', details='Low stock for product_item_id=1: 3 units remaining'

-- 6. Trigger on product_item: Update vendor_analytics on product item addition
CREATE TRIGGER trg_product_item_after_insert
ON product_item
AFTER INSERT
AS
BEGIN
    UPDATE va
    SET 
        total_products = (
            SELECT COUNT(*) 
            FROM product_item pi 
            WHERE pi.vendor_id = va.vendor_id AND pi.is_active = 1
        ),
        last_updated = GETDATE()
    FROM vendor_analytics va
    JOIN inserted i ON va.vendor_id = i.vendor_id
    WHERE i.is_active = 1;
END;
GO
-- Purpose: Updates the total_products count in vendor_analytics when a new active product item is added.
-- Example: Adding a new active product item for vendor_id=1 (Jane’s Tech Shop) will update:
-- vendor_id=1, total_products=5 (if there were 4 before)

-- 7. Trigger on product_item: Prevent negative stock on update
CREATE TRIGGER trg_product_item_before_update
ON product_item
INSTEAD OF UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM inserted i 
        WHERE i.stock_quantity < 0
    )
    BEGIN
        RAISERROR ('Stock quantity cannot be negative.', 16, 1);
        ROLLBACK;
    END
    ELSE
    BEGIN
        UPDATE pi
        SET 
            stock_quantity = i.stock_quantity,
            price = i.price,
            is_active = i.is_active,
            created_at = i.created_at
        FROM product_item pi
        JOIN inserted i ON pi.id = i.id;
    END
END;
GO
-- Purpose: Prevents stock_quantity from going negative and updates stock.
-- Example: Attempting to update stock_quantity to -1 will fail with an error.

-- 8. Trigger on product_item: Log stock quantity adjustments
CREATE TRIGGER trg_product_item_stock_adjustment
ON product_item
AFTER UPDATE
AS
BEGIN
    INSERT INTO audit_log (user_id, action_type, details, created_at)
    SELECT 
        NULL,
        'stock_adjusted',
        'Stock adjusted for product_item_id=' + CAST(i.id AS VARCHAR) + ': Old=' + CAST(d.stock_quantity AS VARCHAR) + ', New=' + CAST(i.stock_quantity AS VARCHAR),
        GETDATE()
    FROM inserted i
    JOIN deleted d ON i.id = d.id
    WHERE i.stock_quantity != d.stock_quantity;
END;
GO
-- Purpose: Logs changes to stock quantity in audit_log with details of the old and new stock values.
-- Example: Updating stock of product_item_id=1 from 10 to 8 will log:
-- action_type='stock_adjusted', details='Stock adjusted for product_item_id=1: Old=10, New=8'

-- 9. Trigger on user_review: Ensure reviews are only for purchased products
CREATE TRIGGER trg_user_review_before_insert
ON user_review
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM inserted i
        WHERE NOT EXISTS (
            SELECT 1 
            FROM shop_order so
            JOIN order_line ol ON so.id = ol.order_id
            JOIN product_item pi ON ol.product_item_id = pi.id
            WHERE so.user_id = i.user_id
            AND pi.product_id = i.product_id
            AND so.id = i.order_id
        )
    )
    BEGIN
        RAISERROR ('Cannot review a product that was not purchased.', 16, 1);
        ROLLBACK;
    END
    ELSE
    BEGIN
        INSERT INTO user_review (user_id, product_id, order_id, rating, review_text, created_at)
        SELECT user_id, product_id, order_id, rating, review_text, created_at
        FROM inserted;
    END
END;
GO
-- Purpose: Ensures users can only review products they’ve purchased.
-- Example: Attempting to review product_id=1 by user_id=2 (who didn’t buy it) will fail.

-- 10. Trigger on shop_order: Log order creation
CREATE TRIGGER trg_shop_order_after_insert
ON shop_order
AFTER INSERT
AS
BEGIN
    INSERT INTO audit_log (user_id, action_type, details, created_at)
    SELECT 
        i.user_id,
        'order_placed',
        'New order placed: Order ID=' + CAST(i.id AS VARCHAR) + ', Total=' + CAST(i.total_amount AS VARCHAR),
        GETDATE()
    FROM inserted i;
END;
GO
-- Purpose: Logs when a new order is placed.
-- Example: Placing a new order (id=21) by user_id=1 will log:
-- user_id=1, action_type='order_placed', details='New order placed: Order ID=21, Total=500.00'

-- 11. Trigger on shop_order: Prevent updates to finalized orders
CREATE TRIGGER trg_order_status_before_update
ON shop_order
INSTEAD OF UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM deleted d
        JOIN order_status os ON d.order_status_id = os.id
        JOIN inserted i ON d.id = i.id
        WHERE os.status_name IN ('Delivered', 'Cancelled')
        AND (i.order_status_id != d.order_status_id)
    )
    BEGIN
        RAISERROR ('Cannot update order status for orders that are already Delivered or Cancelled.', 16, 1);
        ROLLBACK;
    END
    ELSE
    BEGIN
        UPDATE so
        SET 
            order_status_id = i.order_status_id,
            total_amount = i.total_amount
        FROM shop_order so
        JOIN inserted i ON so.id = i.id;
    END
END;
GO
-- Purpose: Prevents updating an order’s status if it is already 'Delivered' or 'Cancelled'.
-- Example: Attempting to update an order with status 'Delivered' to 'Shipped' will fail.

-- 12. Trigger on discount: Auto-deactivate expired discounts
CREATE TRIGGER trg_discount_auto_deactivate
ON discount
AFTER UPDATE
AS
BEGIN
    UPDATE d
    SET is_active = 0
    FROM discount d
    JOIN inserted i ON d.id = i.id
    WHERE i.end_date < GETDATE() AND i.is_active = 1;
END;
GO
-- Purpose: Deactivates discounts by setting is_active to 0 if their end_date is in the past.
-- Example: Updating a discount with end_date='2024-12-01' on 2025-01-01 will set is_active=0.

-- 13. Trigger on shop_order: Log order status changes
CREATE TRIGGER trg_order_status_after_update
ON shop_order
AFTER UPDATE
AS
BEGIN
    INSERT INTO audit_log (user_id, action_type, details, created_at)
    SELECT 
        i.user_id,
        'order_status_updated',
        'Order ID=' + CAST(i.id AS VARCHAR) + ' status updated to ' + os.status_name,
        GETDATE()
    FROM inserted i
    JOIN deleted d ON i.id = d.id
    JOIN order_status os ON i.order_status_id = os.id
    WHERE i.order_status_id != d.order_status_id;
END;
GO
-- Purpose: Logs changes to an order’s status in audit_log.
-- Example: Updating order_id=1 from 'Processing' to 'Shipped' will log:
-- user_id=1, action_type='order_status_updated', details='Order ID=1 status updated to Shipped'

-- 14. Trigger on audit_log: Prevent deletion of audit logs
CREATE TRIGGER trg_audit_log_before_delete
ON audit_log
INSTEAD OF DELETE
AS
BEGIN
    RAISERROR ('Deletion of audit logs is not allowed.', 16, 1);
    ROLLBACK;
END;
GO
-- Purpose: Protects audit logs from being deleted to maintain an audit trail.
-- Example: Attempting to delete an audit log entry will fail.

-- 15. Trigger on role: Prevent deletion of roles with assigned users
CREATE TRIGGER trg_role_before_delete
ON role
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM deleted d
        JOIN user_role ur ON d.id = ur.role_id
    )
    BEGIN
        RAISERROR ('Cannot delete role because it is assigned to users.', 16, 1);
        ROLLBACK;
    END
    ELSE
    BEGIN
        DELETE FROM role WHERE id IN (SELECT id FROM deleted);
    END
END;
GO
-- Purpose: Protects roles that are currently assigned to users from being deleted.
-- Example: Attempting to delete role 'buyer' (id=1) will fail because it’s assigned to users.

-- 16. Trigger on permissions: Log changes to permissions
CREATE TRIGGER trg_permissions_after_update
ON permissions
AFTER UPDATE
AS
BEGIN
    INSERT INTO audit_log (user_id, action_type, details, created_at)
    SELECT 
        NULL, -- No specific user tied to permissions
        'permissions_updated',
        'Permission updated for role_id=' + CAST(i.role_id AS VARCHAR) + ': ' + i.resource + ' ' + i.action_type + ' set to ' + CAST(i.is_allowed AS VARCHAR),
        GETDATE()
    FROM inserted i
    JOIN deleted d ON i.id = d.id
    WHERE i.is_allowed != d.is_allowed;
END;
GO
-- Purpose: Logs changes to permissions (e.g., when a role’s access is modified).
-- Example: Updating buyer role to allow 'write' on 'product' will log:
-- action_type='permissions_updated', details='Permission updated for role_id=1: product write set to 1'

-- 17. Trigger on address: Log address updates
CREATE TRIGGER trg_address_after_update
ON address
AFTER UPDATE
AS
BEGIN
    INSERT INTO audit_log (user_id, action_type, details, created_at)
    SELECT 
        i.user_id,
        'address_updated',
        'Address updated for user: ' + u.full_name + ', new city: ' + i.city,
        GETDATE()
    FROM inserted i
    JOIN deleted d ON i.id = d.id
    JOIN [user] u ON i.user_id = u.id
    WHERE i.city != d.city;
END;
GO
-- Purpose: Logs changes to a user’s address (e.g., city change).
-- Example: Updating John Doe’s address city from 'New York' to 'Chicago' will log:
-- user_id=1, action_type='address_updated', details='Address updated for user: John Doe, new city: Chicago'

-- 18. Trigger on category: Prevent deletion of categories with products
CREATE TRIGGER trg_category_before_delete
ON category
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM deleted d
        JOIN product_category pc ON d.id = pc.category_id
    )
    BEGIN
        RAISERROR ('Cannot delete category because it contains products.', 16, 1);
        ROLLBACK;
    END
    ELSE
    BEGIN
        DELETE FROM category WHERE id IN (SELECT id FROM deleted);
    END
END;
GO
-- Purpose: Prevents deletion of categories that are associated with products.
-- Example: Attempting to delete 'Electronics' (id=1) will fail because it has products (via product_category).

-- 19. Trigger on product: Log product creation
CREATE TRIGGER trg_product_after_insert
ON product
AFTER INSERT
AS
BEGIN
    INSERT INTO audit_log (user_id, action_type, details, created_at)
    SELECT 
        NULL, -- No user tied to product creation
        'product_created',
        'New product created: ' + i.name + ', base price: ' + CAST(i.base_price AS VARCHAR),
        GETDATE()
    FROM inserted i;
END;
GO
-- Purpose: Logs when a new product is added.
-- Example: Inserting a new product 'Smartwatch' will log:
-- action_type='product_created', details='New product created: Smartwatch, base price: 200.00'