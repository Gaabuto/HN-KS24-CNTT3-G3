create database if not exists ecommerce;
use ecommerce;

drop table if exists orders;
drop table if exists customers;
drop table if exists orders, customers, products;


create table customers (
    customer_id int primary key,
    customer_name varchar(255),
    city varchar(255)
);

create table orders (
    order_id int primary key,
    customer_id int,
    order_date date,
    status enum('pending', 'complete', 'cancel'),
    foreign key (customer_id) references customers(customer_id)
);

insert into customers (customer_id, customer_name, city) values
(1, 'nguyen van a', 'ha noi'),
(2, 'tran thi b', 'da nang'),
(3, 'le van c', 'ho chi minh'),
(4, 'pham thi d', 'can tho'),
(5, 'hoang van e', 'ha noi');

insert into orders (order_id, customer_id, order_date, status) values
(001, 1, '2024-01-01', 'complete'),
(002, 1, '2024-01-05', 'pending'),
(003, 2, '2024-01-03', 'complete'),
(004, 3, '2024-01-06', 'cancel'),
(005, 3, '2024-01-07', 'complete');

select o.order_id,o.order_date,o.status,c.customer_name
from orders o
join customers c on o.customer_id = c.customer_id;

select c.customer_id as 'Mã Khách Hàng',c.customer_name as 'Tên Khách Hàng',count(o.order_id) as 'Tổng Đơn Hàng'
from customers c
left join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name;

select c.customer_id as 'Mã Khách Hàng',c.customer_name as 'Tên Khách Hàng',count(o.order_id) as 'Tổng Đơn Hàng'
from customers c
join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name
having count(o.order_id) >= 1;
