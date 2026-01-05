use ecommerce;

select o.order_date as 'Ngày',
    sum(o.total_amount) as 'Tổng Doanh Thu'
from orders o
where o.status = 'complete'
group by o.order_date;

select o.order_date as 'Ngày',
    count(o.order_id) as 'Số Lượng Đơn Hàng'
from orders o
where o.status = 'complete'
group by o.order_date;

select o.order_date as 'Ngày',
    sum(o.total_amount) as 'Tổng Doanh Thu',
    count(o.order_id) as 'Số Lượng Đơn Hàng'
from orders o
where o.status = 'complete'
group by o.order_date
having sum(o.total_amount) > 10000000;
