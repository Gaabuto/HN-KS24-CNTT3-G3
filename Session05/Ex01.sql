create database ss5ex01;
use ss5ex01;

create table products(
	product_id int primary key auto_increment,
    product_name varchar(255) not null,
    price decimal(10,2) not null,
    stock int check(stock>=0) not null,
    status enum('ACTIVE', 'INACTIVE')
);

INSERT INTO products (product_name, price, stock, status) 
VALUES
	('Laptop', 1500, 10, 'ACTIVE'),
	('Mouse', 20, 100, 'ACTIVE'),
	('Keyboard', 50, 50, 'ACTIVE'),
	('Monitor', 300, 20, 'ACTIVE'),
	('Printer', 200, 0, 'INACTIVE'),
	('USB Cable', 10, 200, 'ACTIVE'),
	('Webcam', 80, 15, 'ACTIVE'),
	('Headphone', 120, 0, 'INACTIVE'),
	('Tablet', 600, 8, 'ACTIVE'),
	('Speaker', 150, 12, 'ACTIVE');
    
-- 1. Lấy toàn bộ sản phẩm đang có trong hệ thống
select * from products;

-- 2. Lấy danh sách sản phẩm đang bán (status = 'active')
select * 
from products
where status = 'ACTIVE';

-- 3. Lấy các sản phẩm có giá lớn hơn 1.000.000
select *
from products
where price > 1000000;

-- 4. Hiển thị danh sách sản phẩm đang bán, sắp xếp theo giá tăng dần
select *
from products
order by price asc;




    
