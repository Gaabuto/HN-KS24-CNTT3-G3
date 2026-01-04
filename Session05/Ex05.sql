create database ss5ex05;
use ss5ex05;

create table orders (
	order_id int primary key auto_increment,
    customer_id int not null,
    total_amount decimal(10,2) not null,
    order_date date not null,
    status enum('pending', 'completed', 'cancelled') default('pending')
);

insert into orders (customer_id, total_amount, order_date, status)
values
	(1, 3500000, '2024-12-12', 'pending'),
	(2, 7200000, '2024-12-15', 'completed'),
	(3, 1500000, '2024-12-21', 'cancelled'),
	(1, 9800000, '2024-12-23', 'completed'),
	(4, 4300000, '2024-12-26', 'pending'),
	(2, 12000000, '2024-12-31', 'completed'),
	(5, 2500000, '2025-01-02', 'cancelled'),
	(3, 6700000, '2025-01-03', 'completed'),
	(1, 5400000, '2025-01-05', 'pending'),
	(4, 8900000, '2025-01-08', 'completed'),
    (5, 4500000, '2025-01-14', 'completed'),
    (3, 9800000, '2025-01-20', 'pending'),
    (2, 1200000, '2025-01-28', 'cancelled');
    
-- 1. Trang 1: hiển thị 5 đơn hàng mới nhất
select *
from orders
where status != 'cancelled'
order by order_date desc
limit 5 offset 0;

-- 2. Trang 2: hiển thị 5 đơn hàng tiếp theo
select *
from orders
where status != 'cancelled'
order by order_date desc
limit 5 offset 5;

-- 3. Trang 3: hiển thị 5 đơn hàng tiếp theo
select *
from orders
where status != 'cancelled'
order by order_date desc
limit 5 offset 10;
-- Chỉ hiển thị các đơn hàng chưa bị hủy