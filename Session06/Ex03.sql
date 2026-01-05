use ss6db;

-- Tính tổng doanh thu theo từng ngày
select order_date, sum(total_amount)
from orders
group by order_date;

-- Tính số lượng đơn hàng theo từng ngày
select order_date, count(total_amount)
from orders
group by order_date;

-- Chỉ hiển thị các ngày có doanh thu > 10.000.000
select order_date, sum(total_amount)
from orders
group by order_date
having sum(total_amount) > 10000000