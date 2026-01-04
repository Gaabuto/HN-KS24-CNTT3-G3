create database products;
use products;

drop table if exists products;

create table products (
    productid int primary key,
    productname varchar(255) not null,
    price decimal(10,2) not null,
    stock int not null check (stock >= 0),
    status enum('active', 'inactive') not null,
    soldquantity int not null check (soldquantity >= 0)
);

insert into products (productid, productname, price, stock, status, soldquantity)
values
    (1, 'laptop', 25000000, 12, 'active', 5),
    (2, 'keycap', 110000, 20, 'active', 15),
    (3, 'main board', 14000000, 10, 'active', 2),
    (4, 'mouse', 1500000, 20, 'active', 8),
    (5, 'keyboard', 800000, 15, 'active', 10),
    (6, 'monitor', 3000000, 7, 'inactive', 3),
    (7, 'headset', 600000, 25, 'active', 12),
    (8, 'webcam', 450000, 30, 'active', 7),
    (9, 'usb hub', 200000, 18, 'inactive', 4),
    (10, 'external hdd', 1200000, 9, 'active', 6),
    (11, 'graphics card', 50000000, 5, 'active', 1),
    (12, 'ram 16gb', 7500000, 14, 'active', 9),
    (13, 'ssd 1tb', 9000000, 11, 'active', 11),
    (14, 'power supply', 1300000, 8, 'active', 13),
    (15, 'cooling fan', 300000, 22, 'inactive', 0);

select * from products;

select * from products
order by soldquantity desc
limit 10;

select * from products
order by soldquantity desc
limit 5 offset 10;

select * from products
where price < 2000000
order by price desc;

select * from products
where status = 'active'
and price between 1000000 and 3000000
order by price asc
limit 10 offset 0;
