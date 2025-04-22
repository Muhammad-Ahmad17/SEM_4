use db_E_Commerce;

-- Insert roles into the role table
INSERT INTO role (name, description, is_active)
VALUES
    ('buyer', 'Customers who purchase products', 1),
    ('vendor', 'Sellers who manage products', 1),
    ('manager', 'Oversees platform operations', 1);
		select * from role


-- Insert permissions for each role
INSERT INTO permissions (role_id, resource, action_type, is_allowed)
VALUES
    -- Buyer permissions
    ((SELECT id FROM role WHERE name = 'buyer'), 'shop_order', 'write', 1),  -- Place orders
    ((SELECT id FROM role WHERE name = 'buyer'), 'user_review', 'write', 1), -- Submit reviews
    ((SELECT id FROM role WHERE name = 'buyer'), 'address', 'write', 1),     -- Manage addresses
    ((SELECT id FROM role WHERE name = 'buyer'), 'product', 'read', 1),      -- Browse products
    ((SELECT id FROM role WHERE name = 'buyer'), 'product_item', 'read', 1), -- Browse vendor-specific products
    ((SELECT id FROM role WHERE name = 'buyer'), 'category', 'read', 1),     -- Browse categories
    -- Vendor permissions
    ((SELECT id FROM role WHERE name = 'vendor'), 'product', 'write', 1),      -- Create products
    ((SELECT id FROM role WHERE name = 'vendor'), 'product_item', 'write', 1), -- Manage vendor-specific products
    ((SELECT id FROM role WHERE name = 'vendor'), 'product_category', 'write', 1), -- Assign categories to products
    ((SELECT id FROM role WHERE name = 'vendor'), 'vendor_analytics', 'read', 1),  -- View analytics
    ((SELECT id FROM role WHERE name = 'vendor'), 'shop_order', 'read', 1),    -- View orders for their products
    -- Manager permissions
    ((SELECT id FROM role WHERE name = 'manager'), 'vendor', 'write', 1),       -- Approve/suspend vendors
    ((SELECT id FROM role WHERE name = 'manager'), 'category', 'write', 1),     -- Manage categories
    ((SELECT id FROM role WHERE name = 'manager'), 'shop_order', 'read', 1),    -- View orders
    ((SELECT id FROM role WHERE name = 'manager'), 'audit_log', 'read', 1),     -- Audit actions
    ((SELECT id FROM role WHERE name = 'manager'), 'vendor_analytics', 'read', 1); -- View vendor analytics

	select * from permissions
