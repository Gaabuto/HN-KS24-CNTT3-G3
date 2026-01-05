use ss6db;

select 
    c.customer_id,
    c.full_name,
    count(o.order_id), -- Tổng số đơn hàng của mỗi khách
    sum(o.total_amount),-- Tổng số tiền đã chi
    avg(o.total_amount) -- Giá trị đơn hàng trung bình
from customers as c join orders as o on c.customer_id = o.customer_id
group by c.customer_id, c.full_name
having 
    count(o.order_id) >= 1 -- Có từ 3 đơn hàng trở lên
    and sum(o.total_amount) > 10000000 -- Tổng tiền > 10.000.000
order by sum(o.total_amount) desc; -- Sắp xếp theo tổng tiền giảm dần