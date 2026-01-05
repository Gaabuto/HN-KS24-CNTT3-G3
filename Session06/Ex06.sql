use ss6db;

select 
    p.product_name, -- Tên sản phẩm
    sum(oi.quantity), -- Tổng số lượng bán
    sum(oi.quantity * p.price), -- Tổng doanh thu
    avg(p.price) -- Giá bán trung bình
from products as p join order_items as oi on p.product_id = oi.product_id
group by p.product_id, p.product_name
having sum(oi.quantity) >= 10 -- Đã bán ít nhất 10 sản phẩm
order by sum(oi.quantity * p.price) desc -- Doanh thu giảm dần
limit 5; -- Chỉ lấy 5 sản phẩm đứng đầu