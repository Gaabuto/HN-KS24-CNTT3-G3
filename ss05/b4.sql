drop table if exists products;

create table products(
	productId int primary key,
    productName varchar(255) not null,
    price decimal (10,2),
    stock int not null check(stock >= 0),
    status enum('active', 'inactive')
);

ALTER table products add COLUMN soldQuantity int not null check(soldQuantity >= 0);

insert into products(productId, productName, price, stock, status, soldQuantity)
values
    (1, 'Laptop', 		25000000, 	12, 'active', 5),
    (2, 'Keycap', 		110000,		20, 'active', 15),
    (3, 'Main board', 	14000000, 	10, 'active', 2),
    (4, 'Mouse', 		1500000, 	20, 'active', 8),
    (5, 'Keyboard', 	800000, 	15, 'active', 10),
    (6, 'Monitor', 		3000000, 	7,  'inactive', 3),
    (7, 'Headset', 		600000, 	25, 'active', 12),
    (8, 'Webcam', 		450000, 	30, 'active', 7),
    (9, 'USB Hub', 		200000, 	18, 'inactive', 4),
    (10,'External HDD', 1200000, 	9,  'active', 6),
    (11,'Graphics Card',50000000, 	5,  'active', 1),
    (12,'RAM 16GB',     7500000, 	14, 'active', 9),
    (13,'SSD 1TB', 		9000000, 	11, 'active', 11),
    (14,'Power Supply', 1300000, 	8,  'active', 13),
    (15,'Cooling Fan', 	300000, 	22, 'inactive', 0);

select * from products;
select * from products ORDER BY soldQuantity DESC LIMIT 10;
select * from products ORDER BY soldQuantity DESC LIMIT 5 offset 10;
select * from products where price < 2000000 ORDER BY price DESC;