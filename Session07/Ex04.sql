use ss7_db;

/*
Viết 1 câu SQL để:
Hiển thị tên khách hàng
Hiển thị số lượng đơn hàng của từng khách
Sử dụng subquery trong SELECT
KHÔNG dùng JOIN, KHÔNG dùng GROUP BY
*/
select 
	c.customer_name as 'Tên Khách Hàng',
		(select count(*)
        from orders as o
        where o.customer_id = c.customer_id) as 'Tổng đơn'
from customer as c;
