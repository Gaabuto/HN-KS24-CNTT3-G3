use ecommerce;

select c.customer_id as 'Mã Khách Hàng',c.customer_name as 'Tên Khách Hàng',
    count(o.order_id) as 'Tổng Số Đơn Hàng',
    sum(o.total_amount) as 'Tổng Tiền Đã Chi',
    avg(o.total_amount) as 'Giá Trị Đơn Hàng Trung Bình'
from customers c
join orders o on c.customer_id = o.customer_id
where o.status = 'complete'
group by c.customer_id, c.customer_name
having count(o.order_id) >= 3
   and sum(o.total_amount) > 10000000
order by sum(o.total_amount) desc;
