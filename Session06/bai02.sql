use bai01;

-- thêm cột total_amount để lưu tổng tiền đơn hàng
alter table orders add total_amount decimal(10,2);

-- cập nhật tổng tiền cho từng đơn hàng
update orders set total_amount = 1500000 where order_id = 101;
update orders set total_amount = 2300000 where order_id = 102;
update orders set total_amount = 1800000 where order_id = 103;
update orders set total_amount = 900000 where order_id = 104;
update orders set total_amount = 3200000 where order_id = 105;

-- tính tổng tiền mỗi khách hàng đã chi
select c.customer_id, c.full_name, sum(o.total_amount)
from customers c join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.full_name;

-- tìm giá trị đơn hàng cao nhất của từng khách
select c.customer_id, c.full_name, max(o.total_amount)
from customers c join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.full_name;

-- sắp xếp khách hàng theo tổng tiền chi tiêu giảm dần
select c.customer_id, c.full_name, sum(o.total_amount)
from customers c join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.full_name
order by sum(o.total_amount) desc;
