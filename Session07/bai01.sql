create database ss07_b1;
use ss07_b1;

create table customers (
	id int primary key,
    name varchar(50) not null,
    email varchar(50) not null unique
);

create table orders (
	id int primary key auto_increment,
    customer_id int not null,
    order_date date not null,
    total_amount double not null
);

insert into customers (id, name, email) values
(1,'Nguyễn Văn A', 'a@gmail.com'),
(2,'Nguyễn Văn B', 'b@gmail.com'),
(3,'Nguyễn Văn C', 'c@gmail.com'),
(4,'Nguyễn Văn D', 'd@gmail.com'),
(5,'Nguyễn Văn E','e@gmail.com'),
(6,'Nguyễn Văn F','f@gmail.com'),
(7,'Nguyễn Văn G','g@gmail.com');

insert into orders (customer_id, order_date, total_amount) values
(1, '2026-01-02', 100),
(1, '2026-01-03', 200),
(1, '2026-01-04', 300),
(2, '2026-01-04', 400),
(2, '2026-01-05', 500),
(3, '2026-01-11', 600),
(5, '2026-01-23', 700),
(5, '2026-01-12', 400),
(7, '2026-01-04', 900),
(7, '2026-01-31', 150);

select id, name, email from customers 
where id in (select distinct customer_id from orders);