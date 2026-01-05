use ss6db;

alter table orders
add total_amount decimal(10,2);

-- Sửa lại thông tin dữ liệu trong bảng thêm dữ liệu cho mỗi orders có thêm dữ liệu của trường dữ liệu ở cột total_amount
update orders set total_amount = 500000 where order_id = 1;
update orders set total_amount = 1200000 where order_id = 2;
update orders set total_amount = 8500000 where order_id = 3;
update orders set total_amount = 0 where order_id = 4;
update orders set total_amount = 330000 where order_id = 5;

-- Hiển thị tổng tiền mà mỗi khách hàng đã chi tiêu
select c.customer_id, c.full_name, sum(o.total_amount)
from customers as c join orders as o on c.customer_id = o.customer_id
group by c.customer_id, c.full_name;

-- Hiển thị giá trị đơn hàng cao nhất của từng khách
select c.customer_id, c.full_name, max(o.total_amount)
from customers as c join orders as o on c.customer_id = o.customer_id
group by c.customer_id, c.full_name;

-- Sắp xếp danh sách khách hàng theo tổng tiền giảm dần
select c.customer_id, c.full_name, sum(o.total_amount) as total_money
from customers as c join orders as o on c.customer_id = o.customer_id
group by c.customer_id, c.full_name
order by total_money desc