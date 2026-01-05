use bai01;
-- tính số đơn hàng và tổng doanh thu theo từng ngày
-- chỉ lấy các đơn hàng đã hoàn thành
-- chỉ hiển thị ngày có doanh thu > 10.000.000
select order_date, count(order_id), sum(total_amount)
from orders
where status = 'completed'
group by order_date
having sum(total_amount) > 10000000;
