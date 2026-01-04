create database Ss5bai6;
use Ss5bai6;

create table products (
	product_id int primary key auto_increment,
	product_name varchar(255) not null,
	price decimal(10,2) not null,
	stock int check(stock >= 0) not null,
	status enum('active', 'inactive') not null
);

insert into products (product_name, price, stock, status)
values
	('laptop', 15000000, 10, 'active'),
	('chuột không dây', 350000, 50, 'active'),
	('bàn phím cơ', 1200000, 20, 'active'),
	('tai nghe bluetooth', 1800000, 30, 'active'),
	('màn hình', 3200000, 15, 'active'),
	('usb', 250000, 100, 'active'),
	('ổ cứng ssd', 2000000, 25, 'active'),
	('webcam', 900000, 40, 'inactive'),
	('loa bluetooth', 1500000, 35, 'active'),
	('balo laptop', 700000, 60, 'active'),
	('đế tản nhiệt', 1300000, 45, 'active'),
	('chuột gaming', 2500000, 30, 'active'),
	('bàn phím thường', 1000000, 70, 'active'),
	('tai nghe có dây', 1100000, 40, 'inactive'),
	('ổ cứng hdd', 2800000, 20, 'active');

select *
from products
where status = 'active'
and price between 1000000 and 3000000
order by price asc
limit 10 offset 0;

select *
from products
where status = 'active'
and price between 1000000 and 3000000
order by price asc
limit 10 offset 10;
