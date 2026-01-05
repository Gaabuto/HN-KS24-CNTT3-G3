use bai01;

-- hiển thị tổng số lượng bán, tổng doanh thu và giá bán trung bình của sản phẩm
-- chỉ lấy sản phẩm đã bán ít nhất 10 sản phẩm
-- sắp xếp theo doanh thu giảm dần và lấy 5 sản phẩm đứng đầu
select
    p.product_name,
    sum(oi.quantity),
    sum(oi.quantity * p.price),
    avg(p.price)
from products p join order_items oi on p.product_id = oi.product_id
group by p.product_id, p.product_name
having sum(oi.quantity) >= 10
order by sum(oi.quantity * p.price) desc
limit 5;
