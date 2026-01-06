create database ss07b2;
use ss07b2;

create table products (
	id int auto_increment primary key,
    name varchar(55) not null,
    price double not null
);

create table order_items(
	order_id int auto_increment primary key,
    product_id int not null,
    quantity double not null
);

insert into products (name, price) values
('Bàn phím', 100),
('Chuột không dây',50),
('Màn hình', 500),
('Card đồ họa', 305),
('Latop Gaming',800),
('Tai nghe', 250);

insert into order_items(product_id, quantity) values
(1,2),
(2,5),
(3,1),
(4,3),
(5,1),
(2,2);

select id, name from products 
where id in (select distinct product_id from order_items);