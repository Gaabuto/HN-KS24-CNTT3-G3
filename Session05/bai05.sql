create database bai05;
use bai05;
-- Trang 1: 5 đơn hàng mới nhất
SELECT *
FROM Orders WHERE status = 'cancelled' ORDER BY order_date DESC LIMIT 5 OFFSET 0;
-- Trang 2: 5 đơn hàng tiếp theo
SELECT * FROM Orders WHERE status = 'cancelled' ORDER BY order_date DESC LIMIT 5 OFFSET 5;
-- Trang 3: 5 đơn hàng tiếp theo
SELECT * FROM Orders WHERE status = 'cancelled' ORDER BY order_date DESC LIMIT 5 OFFSET 10;