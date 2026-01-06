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
(5, 'hoang van en', 'teste@gmail.com');

insert into orders (id, customer_id, order_date, total_amount) values
(301, 1, '2025-01-01', 500.00),
(302, 1, '2025-02-03', 300.00),
(303, 2, '2025-01-05', 1200.00),
(304, 3, '2025-04-07', 750.00),
(305, 3, '2025-03-10', 400.00),
(306, 5, '2025-01-12', 900.00);

select
    name,
    (
        select count(*)
        from orders
        where orders.customer_id = customers.id
    ) as 'Tổng Đơn'
from customers;
