create database Ss5bai3;
use Ss5bai3;

create table orders (
	order_id int primary key auto_increment,
    customer_id int not null,
    total_amount decimal(10,2) not null,
    order_date date not null,
    status enum('pending', 'completed', 'cancelled') default('pending')
);

insert into orders (customer_id, total_amount, order_date, status)
values
(1, 3000000, '2024-07-01', 'completed'),
(2, 8000000, '2024-07-05', 'completed'),
(3, 1500000, '2024-07-10', 'pending'),
(1, 12000000, '2024-07-15', 'completed'),
(4, 4000000, '2024-07-18', 'cancelled'),
(2, 9500000, '2024-07-20', 'completed'),
(5, 6000000, '2024-07-22', 'pending');

-- 1. Lấy danh sách đơn hàng đã hoàn tghnahf
select * from orders
where status = 'completed';
-- 2. Lấy các ra đơn hàng có tổng tiền > 5tr
select * from orders
where total_amount > 5000000;
-- 3. Hiển thị ra 5 đơn hàng mới nhất
select * from orders
order by order_date desc
limit 5;
-- 4. Hiển thị các đơn hàng đã hoàn thành, sắp xếp theo tổng tiền giảm
select * from orders
where status = 'completed'
order by total_amount desc;
