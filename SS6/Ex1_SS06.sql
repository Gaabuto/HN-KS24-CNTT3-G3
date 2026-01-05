create database Ex1_SS06;
use Ex1_SS06;

/* CÂU 1 */

create table customers (
	customer_id int primary key auto_increment,
    full_name varchar(255),
    city varchar(255)
);

create table orders (
	order_id int primary key auto_increment,
    customer_id int,
    foreign key (customer_id) references customers(customer_id),
    order_date date,
    status ENUM('pending', 'completed', 'cancelled'),
    total_amount DECIMAL(10,2)
);

INSERT INTO customers (full_name, city) VALUES
('Nguyễn Văn An', 'Hà Nội'),
('Trần Thị Bình', 'TP.HCM'),
('Lê Quốc Cường', 'Đà Nẵng'),
('Phạm Thu Dung', 'Hải Phòng'),
('Hoàng Minh Đức', 'Cần Thơ');


INSERT INTO orders (customer_id, order_date, status, total_amount) VALUES
(1, '2025-01-05', 'pending', 60000),
(2, '2025-01-06', 'completed', 36000),
(1, '2025-01-07', 'completed', 18000),
(3, '2025-01-08', 'cancelled', 29000),
(4, '2025-01-09', 'pending', 45000);

SELECT 
    o.order_id,
    c.full_name,
    o.order_date,
    o.status
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

select
    c.full_name,
    count(o.order_id) as total_orders
from customers c
left join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.full_name;

SELECT 
    c.full_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name;

/* CÂU 2 */
select SUM(total_amount) from


