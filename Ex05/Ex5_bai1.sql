create database Ss5bai1;
use Ss5bai1;

create table products (
    product_id int auto_increment primary key,
    product_name varchar(255),
    price decimal(10,2),
    stock int,
    status enum('active', 'inactive')
);

insert into products (product_name, price, stock, status)
values
('laptop dell', 15000000, 10, 'active'),
('chuột không dây', 350000, 50, 'active'),
('bàn phím cơ', 1200000, 20, 'active'),
('tai nghe bluetooth', 800000, 30, 'inactive'),
('màn hình 24 inch', 3200000, 15, 'active');
--
-- 1. Lấy toàn bộ sản phẩm trong hệ thống
select * from products;
-- 2. Lấy danh sách sản phẩm đang bán
select * from products
where status = 'active';
-- 3. Lấy các sản phẩm có giá lớn hơn 1tr
select * from products
where price > 1000000;
-- 4. Danh sách sản phẩm đang bán, sắp xếp theo giá tăng dần
select * from products
where status = 'active'
order by price asc;
