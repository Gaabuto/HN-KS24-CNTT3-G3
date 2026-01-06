create database if not exists bai01;
use bai01;

drop table if exists orders;
drop table if exists customers;

create table customers (
    id int primary key,
    name varchar(100),
    email varchar(100)
);

create table orders (
    id int primary key,
    customer_id int,
    order_date date,
    total_amount decimal(10,2)
);

insert into customers (id, name, email) values
(1, 'nguyen van anh', 'testa@gmail.com'),
(2, 'tran thi bao', 'testb@gmail.com'),
(3, 'le van chien', 'testc@gmail.com'),
(4, 'pham thi dung', 'testd@gmail.com'),
(5, 'hoang van en', 'teste@gmail.com'),
(6, 'do thi phuong', 'testf@gmail.com'),
(7, 'vu van ga', 'testg@gmail.com');

insert into orders (id, customer_id, order_date, total_amount) values
(101, 1, '2025-01-01', 500.00),
(102, 2, '2025-01-05', 750.50),
(103, 1, '2025-01-10', 300.00),
(104, 3, '2025-01-15', 1200.00),
(105, 5, '2025-01-18', 450.00),
(106, 2, '2025-01-20', 980.00),
(107, 6, '2025-01-22', 150.00);

select *
from customers
where id in (
    select customer_id
    from orders
);
