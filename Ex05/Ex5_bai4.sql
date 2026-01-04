create database Ss5bai4;
use Ss5bai4;

create table products(
	product_id int primary key auto_increment,
    product_name varchar(255) not null,
    price decimal(10,2) not null,
    stock int check(stock>=0) not null,
    status enum('ACTIVE', 'INACTIVE')
);

insert into products (product_name, price, stock, status) 
values
	('laptop', 1500, 10, 'ACTIVE'),
	('mouse', 20, 100, 'ACTIVE'),
	('keyboard', 50, 50, 'ACTIVE'),
	('monitor', 300, 20, 'ACTIVE'),
	('printer', 200, 0, 'INACTIVE'),
	('usb cable', 10, 200, 'ACTIVE'),
	('webcam', 80, 15, 'ACTIVE'),
	('headphone', 120, 0, 'INACTIVE'),
	('tablet', 600, 8, 'ACTIVE'),
	('speaker', 150, 12, 'ACTIVE');
alter table products
add sold_quantity int check(sold_quantity >= 0) default 0;

update products set sold_quantity = 250 where product_id = 1;
update products set sold_quantity = 150 where product_id = 2;
update products set sold_quantity = 400 where product_id = 3;
update products set sold_quantity = 250 where product_id = 4;
update products set sold_quantity = 750 where product_id = 5;
update products set sold_quantity = 950 where product_id = 6;
update products set sold_quantity = 800 where product_id = 7;
update products set sold_quantity = 600 where product_id = 8;
update products set sold_quantity = 200 where product_id = 9;
update products set sold_quantity = 750 where product_id = 10;
-- 1. Laays 10 ra sanr phaamr bans chayj nhaats
select *
from products
order by sold_quantity desc
limit 10;
-- 2. Lấy 5 sản phẩm bán chạy tiếp theo
select *
from products
order by sold_quantity desc
limit 5 offset 10;
-- 3. Hiển thị danh sách sản phẩm giá < 2tr, sắp xếp theo số lượng bán giảm
select *
from products
where price < 2000000
order by sold_quantity desc;
