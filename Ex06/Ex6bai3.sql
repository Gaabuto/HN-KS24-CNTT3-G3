use ss06;

create table orders (
    order_id int primary key auto_increment,
    order_date date,
    total_amount decimal(10,2)
);

insert into orders (order_date, total_amount) values
('2024-08-01', 3000000),
('2024-08-01', 4000000),
('2024-08-01', 3500000),
('2024-08-02', 2000000),
('2024-08-02', 1500000),
('2024-08-03', 6000000),
('2024-08-03', 5000000),
('2024-08-04', 1000000);

-- tính tổng doanh thu theo từng ngày
select order_date,sum(total_amount)
from orders 
group by order_date;

-- tính số lượng đơn hàng theo từng ngày
select order_date,count(order_id)
from orders 
group by order_date;

-- chỉ hiển thị các ngày có doanh thu > 10tr
select order_date,sum(total_amount),count(order_id)
from orders
group by order_date having sum(total_amount) > 10000000;
