use bai01;
-- thống kê số đơn hàng, tổng tiền và giá trị trung bình mỗi đơn
-- chỉ lấy khách có từ 3 đơn trở lên và tổng tiền > 10.000.000
-- sắp xếp theo tổng tiền giảm dần
select
    c.customer_id,
    c.full_name,
    count(o.order_id),
    sum(o.total_amount),
    avg(o.total_amount)
from customers c join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.full_name
having count(o.order_id) >= 3
   and sum(o.total_amount) > 10000000
order by sum(o.total_amount) desc;
