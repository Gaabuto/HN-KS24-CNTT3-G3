use bai01;

drop table if exists order_items;
drop table if exists products;

create table products (
    id int primary key,
    name varchar(100),
    price decimal(10,2)
);

create table order_items (
    order_id int,
    product_id int,
    quantity int
);

insert into products (id, name, price) values
(1, 'laptop gamming', 1500.00),
(2, 'mouse corsair', 25.50),
(3, 'keyboard aula', 45.00),
(4, 'monitor potato', 300.00),
(5, 'printer', 200.00),
(6, 'usa', 15.00);

insert into order_items (order_id, product_id, quantity) values
(101, 1, 1),
(101, 2, 2),
(102, 3, 1),
(103, 1, 1),
(104, 4, 2),
(105, 6, 5);

select *
from products
where id in (
    select product_id
    from order_items
);