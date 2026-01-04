create database ss5ex06;
use ss5ex06;

create table products(
	product_id int primary key auto_increment,
    product_name varchar(255) not null,
    price decimal(10,2) not null,
    stock int check(stock>=0) not null,
    status enum('ACTIVE', 'INACTIVE')
);

INSERT INTO products (product_name, price, stock, status) 
VALUES
	('Laptop', 1500000, 10, 'ACTIVE'),
	('Mouse', 2000000, 100, 'ACTIVE'),
	('Keyboard', 5000000, 50, 'ACTIVE'),
	('Monitor', 3000000, 20, 'ACTIVE'),
	('Printer', 2000000, 0, 'INACTIVE'),
	('USB Cable', 1000000, 200, 'ACTIVE'),
	('Webcam', 8000000, 15, 'ACTIVE'),
	('Headphone', 1200000, 0, 'INACTIVE'),
	('Tablet', 6000000, 8, 'ACTIVE'),
	('Speaker', 150000, 12, 'ACTIVE'),
    ('Smartphone', 7000000, 25, 'ACTIVE'),
    ('Power Bank', 900000, 60, 'ACTIVE'),
    ('External HDD', 2500000, 30, 'ACTIVE'),
    ('SSD 1TB', 4500000, 18, 'ACTIVE'),
    ('Router WiFi', 1800000, 22, 'ACTIVE'),
    ('Graphics Card', 12000000, 5, 'ACTIVE'),
    ('RAM 16GB', 2000000, 40, 'ACTIVE'),
    ('CPU Intel i5', 5500000, 10, 'ACTIVE'),
    ('Microphone', 1600000, 14, 'ACTIVE'),
    ('Projector', 9000000, 6, 'INACTIVE');
    
select * 
from products
where status = 'ACTIVE' and price between 1000000 and 3000000
order by price asc
limit 10 offset 0; -- Trang 1

select * 
from products
where status = 'ACTIVE' and price between 1000000 and 3000000
order by price asc
limit 10 offset 10; -- Trang 2

    
