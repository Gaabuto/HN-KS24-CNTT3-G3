use ecommerce;

alter table orders drop column total_amount;
alter table orders
add column total_amount decimal(10,2);

update orders set total_amount = 200000 where order_id = 1;
update orders set total_amount = 8000000  where order_id = 2;
update orders set total_amount = 1200000 where order_id = 3;
update orders set total_amount = 500000  where order_id = 4;
update orders set total_amount = 3600000 where order_id = 5;

select c.customer_id as 'Mã Khách Hàng',c.customer_name as 'Tên Khách Hàng',
       sum(o.total_amount) as 'Tổng Tiền Đã Bỏ Tiền Ra'
from customers c
join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name;

select c.customer_id as 'Mã Khách Hàng',c.customer_name as 'Tên Khách Hàng',
	   max(o.total_amount) as 'Đơn Hàng Lớn Nhất'
from customers c
join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name;

select c.customer_id as 'Mã Khách Hàng',c.customer_name as 'Tên Khách Hàng',
    sum(o.total_amount) as 'Tổng Tiền Đã Bỏ Tiền Ra'
from customers c
join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name
order by sum(o.total_amount) desc;