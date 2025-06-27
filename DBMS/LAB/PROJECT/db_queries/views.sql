-- vw_product_stock
-- vw_user_reviews


CREATE VIEW vw_product_stock
AS
SELECT 
    pi.id AS product_item_id,
    pi.stock_quantity - COALESCE(SUM(c.quantity), 0) AS available_stock
FROM product_item pi
LEFT JOIN cart c ON pi.id = c.product_item_id
GROUP BY pi.id, pi.stock_quantity;
-- 
SELECT * FROM vw_product_stock;
-- use : sp_checkout and sp_add_to_cart
go

CREATE VIEW vw_user_reviews
AS
SELECT 
    ur.id AS review_id,
    u.full_name AS user_name,
    p.name AS product_name,
    ur.rating,
    ur.review_text,
    ur.created_at,
    CASE WHEN ur.rating >= 4 THEN 'High' ELSE 'Low' END AS rating_category
FROM user_review ur
JOIN [user] u ON ur.user_id = u.id
JOIN product p ON ur.product_id = p.id;

SELECT * FROM vw_user_reviews












