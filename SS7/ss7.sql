Create database SS7;
use SS7;

/* Bài 1 */

create table customers (
	customer_id int primary key auto_increment,
    customer_name varchar(255),
    customer_email varchar(255)
);

create table orders (
	orders_id int primary key auto_increment,
    customer_id int,
    foreign key (customer_id) references customers(customer_id),
    order_date date,
    total_amount int
);

INSERT INTO customers (customer_name, customer_email) VALUES
('Nguyễn Văn An', 'an.nguyen@gmail.com'),
('Trần Thị Bình', 'binh.tran@gmail.com'),
('Lê Quốc Cường', 'cuong.le@gmail.com'),
('Phạm Minh Đức', 'duc.pham@gmail.com'),
('Hoàng Thị Em', 'em.hoang@gmail.com'),
('Vũ Thanh Hải', 'hai.vu@gmail.com'),
('Đặng Ngọc Lan', 'lan.dang@gmail.com');

INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(5, '2025-01-05', 34000),
(6, '2025-01-06', 897000),
(7, '2025-01-07', 77000),
(4, '2025-01-04', 340000),
(5, '2025-01-06', 123000),
(1, '2025-01-01', 500000),
(2, '2025-01-02', 1200000),
(3, '2025-01-03', 750000),
(4, '2025-01-04', 300000),
(5, '2025-01-05', 980000),
(6, '2025-01-06', 450000),
(7, '2025-01-07', 1600000);

SELECT cus.customer_id, cus.customer_name, ods.order_date
FROM customers cus, orders ods
WHERE cus.customer_id = ods.customer_id;

/* Bài 2 */
create table products (
	product_id int primary key auto_increment,
    product_name varchar(255),
    price decimal(10,2)
);

create table order_items (
	order_id int primary key auto_increment,
    product_id int,
    foreign key (product_id) references products (product_id),
    quantity int
);

INSERT INTO products (product_name, price) VALUES
('Laptop Dell', 15000000.00),
('Chuột Logitech', 350000.00),
('Bàn phím cơ', 1200000.00),
('Màn hình Samsung', 4500000.00),
('Tai nghe Sony', 1800000.00),
('USB 64GB', 250000.00),
('Ổ cứng SSD 512GB', 2200000.00);

INSERT INTO order_items (product_id, quantity) VALUES
(1, 1),
(2, 2),
(3, 1),
(4, 1),
(5, 3),
(6, 5),
(7, 2);

SELECT ordi.product_id
FROM order_items ordi
WHERE ordi.product_id IN (
    SELECT pro.product_id
    FROM products pro
);

/* Bài 3 */
select 
    cus.customer_id,
    cus.customer_name,
    ods.total_amount
from customers cus, orders ods
where cus.customer_id = ods.customer_id
and ods.total_amount > (
    select avg(total_amount)
    from orders
);

/* Bài 4 */
select
    cus.customer_name,
    (
        select COUNT(*)
        from orders ods
        where ods.customer_id = cus.customer_id
    ) as order_count
from customers cus;

