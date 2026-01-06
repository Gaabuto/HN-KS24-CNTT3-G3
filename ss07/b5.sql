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
(401, 1, '2025-03-01', 500.00),
(402, 1, '2025-01-05', 700.00),
(403, 2, '2025-02-03', 1200.00),
(404, 3, '2025-04-07', 300.00),
(405, 3, '2025-05-10', 400.00),
(406, 4, '2025-04-12', 900.00),
(407, 5, '2025-03-15', 1500.00);

select *
from customers
where id in (
    select customer_id
    from orders
    group by customer_id
    having sum(total_amount) = (
        select max(total_sum)
        from (
            select sum(total_amount) as 'Tổng Tiền'
            from orders
            group by customer_id
        ) as t
    )
);
