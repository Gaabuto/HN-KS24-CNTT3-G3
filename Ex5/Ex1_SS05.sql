create database b1;
use b1;

create table products (
	product_id int primary key auto_increment,
    product_name varchar(255),
    price decimal(10,2),
    stock int,
    status enum('active', 'inactive')
);

insert into products (product_name, price, stock, status)
values 
('Car', 50000, 4, 'active'),
('Bike', 36000, 6, 'inactive'),
('Rocket', 18000, 3, 'active'),
('Tank', 34000, 5, 'active');

select * from products;

select * from products where status = 'active';

select * from products where price > 1000000;

select * from products order by price ASC;