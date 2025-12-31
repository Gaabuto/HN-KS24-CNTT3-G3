create database bai01;
use bai01;
create table Product (
	product_id int,
    product_name varchar(255),
    price decimal(10,2),
    stock int,
    status enum('active','inactive')
);
-- Lấy toàn bộ sản phẩm đang có trong hệ thống
SELECT * FROM Product;

-- Lấy danh sách sản phẩm đang bán (status = 'active')
SELECT * 
FROM Product
WHERE status = 'active';

-- Lấy các sản phẩm có giá lớn hơn 1.000.000
SELECT * 
FROM Product
WHERE price > 1000000;

-- Hiển thị danh sách sản phẩm đang bán, sắp xếp theo giá tăng dần
SELECT * 
FROM Product
WHERE status = 'active'
ORDER BY price ASC;

