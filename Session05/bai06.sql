create database bai06;
use bai06;
-- Tìm các sản phẩm đang bán
SELECT * FROM Product WHERE status = 'active';
-- Tìm các sản phẩm có giá từ 1.000.000 đến 3.000.000
SELECT * FROM Product WHERE price >= 1000000 AND price <= 3000000;
-- Sắp xếp sản phẩm theo giá tăng dần
SELECT * FROM Product ORDER BY price ASC;
-- Hiển thị 10 sản phẩm mỗi trang (Trang 1)
SELECT * FROM Product LIMIT 10 OFFSET 0;
-- Hiển thị 10 sản phẩm mỗi trang (Trang 2)
SELECT * FROM Product LIMIT 10 OFFSET 10;