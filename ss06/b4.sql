use ecommerce;

drop table if exists order_items;
drop table if exists products;

create table products (
    product_id int primary key,
    product_name varchar(255),
    price decimal(10,2)
);

create table order_items (
    order_id int,
    product_id int,
    quantity int,
    foreign key (order_id) references orders(order_id),
    foreign key (product_id) references products(product_id)
);

insert into products (product_id, product_name, price) values
(1, 'laptop lenovo', 15000000),
(2, 'chuot dareu', 500000),
(3, 'aula f75', 1200000),
(4, 'man hinh', 3500000),
(5, 'tai nghe airpod', 900000);

insert into order_items (order_id, product_id, quantity) values
(1, 1, 1),
(1, 2, 2),
(2, 3, 1),
(3, 1, 1),
(3, 4, 2),
(4, 5, 3),
(5, 4, 1),
(5, 3, 2);

select p.product_id as 'Mã Sản Phẩm',p.product_name as 'Tên Sản Phẩm',
    sum(oi.quantity) as 'Tổng Số Lượng Đã Bán'
from products p
join order_items oi on p.product_id = oi.product_id
group by p.product_id, p.product_name;

select p.product_id as 'Mã Sản Phẩm',p.product_name as 'Tên Sản Phẩm',
    sum(oi.quantity * p.price) as 'Doanh Thu',
    avg(oi.quantity) as 'Số Lượng Trung Bình'
from products p
join order_items oi on p.product_id = oi.product_id
group by p.product_id, p.product_name;

select p.product_id as 'Mã Sản Phẩm',p.product_name as 'Tên Sản Phẩm',
    sum(oi.quantity * p.price) as 'Doanh Thu'
from products p
join order_items oi on p.product_id = oi.product_id
group by p.product_id, p.product_name
having sum(oi.quantity * p.price) > 5000000;
