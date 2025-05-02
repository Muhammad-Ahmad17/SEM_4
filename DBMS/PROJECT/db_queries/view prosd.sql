-- Drop existing view if it exists
IF OBJECT_ID('vw_product_stock', 'V') IS NOT NULL
    DROP VIEW vw_product_stock;
GO

-- View: Calculates available stock for product items
CREATE VIEW vw_product_stock
AS
SELECT 
    pi.id AS product_item_id,
    pi.stock_quantity - COALESCE(SUM(c.quantity), 0) AS available_stock
FROM product_item pi
LEFT JOIN cart c ON c.product_item_id = pi.id
GROUP BY pi.id, pi.stock_quantity;
GO