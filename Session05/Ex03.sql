create database ss5ex03;
use ss5ex03;

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
	(5, 2500000, '2024-01-02', 'cancelled'),
	(3, 6700000, '2024-12-03', 'completed'),
	(1, 5400000, '2024-12-05', 'pending'),
	(4, 8900000, '2024-12-08', 'completed');
    
-- 1. Lấy danh sách đơn hàng đã hoàn thành
select *
from orders
where status = 'completed';

-- 2. Lấy các đơn hàng có tổng tiền > 5.000.000
select * 
from orders
where total_amount > 5000000;

-- 3. Hiển thị 5 đơn hàng mới nhất
select *
from orders
limit 5;

-- 4. Hiển thị các đơn hàng đã hoàn thành, sắp xếp theo tổng tiền giảm dần
select *
from orders
where status = 'completed'
order by total_amount desc;