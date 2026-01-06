use bai01;

drop table if exists orders;

create table orders (
    id int primary key,
    customer_id int,
    order_date date,
    total_amount decimal(10,2)
);

insert into orders (id, customer_id, order_date, total_amount) values
(201, 1, '2025-01-01', 5000.00),
(202, 2, '2025-02-03', 1200.00),
(203, 3, '2025-03-05', 750.00),
(204, 4, '2025-01-07', 300.00),
(205, 5, '2025-05-10', 900.00);

select *
from orders
where total_amount > (
    select avg(total_amount)
    from orders
);
