create database products;
use products;

create table products(
	productId int primary key,
    productName varchar(255) not null,
    price decimal (10,2),
    stock int not null check(stock >= 0),
    status enum('active', 'inactive')
);

insert into products(productId, productName, price, stock, status)
values
	(1, 'Laptop', 		25000000, 	12, 'active'),
    (2, 'Keycap', 		110000,		20, 'active'),
    (3, 'Main board', 	14000000, 	10, 'inactive'),
    (4, 'Mouse', 		1500000, 	20, 'active');
    
select * from products;
select * from products where status = 'active';
select * from products where price > 10000000;
select * from products where status = 'active' order by price asc;