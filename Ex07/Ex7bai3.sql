drop table if exists orders;
-- 1. tạo bảng orders
create table orders (
    id int primary key,
    customer_id int,
    order_date date,
    total_amount decimal(15, 2)
);

-- 2. thêm 5 dữ liệu mẫu
insert into orders (id, customer_id, order_date, total_amount) values
(1, 101, '2024-08-01', 500000),
(2, 102, '2024-08-02', 1500000),
(3, 103, '2024-08-03', 300000),
(4, 101, '2024-08-04', 2000000), 
(5, 104, '2024-08-05', 700000);

-- 3. lấy đơn hàng có giá trị > trung bình
select id, customer_id, order_date, total_amount
from orders where total_amount > (select avg(total_amount) 
	from orders
);