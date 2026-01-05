use ecommerce;

select p.product_name as 'Tên Sản Phẩm',
    sum(i.quantity) as 'Tổng Số Lượng Bán',
    sum(i.quantity * p.price) as 'Tổng Doanh Thu',
    avg(p.price) as 'Giá Bán Trung Bình'
from products p
join order_items i on p.product_id = i.product_id
join orders o on i.order_id = o.order_id
where o.status = 'complete'
group by p.product_id, p.product_name
having sum(i.quantity) >= 10
order by sum(i.quantity * p.price) desc
limit 5;