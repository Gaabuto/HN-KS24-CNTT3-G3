use ss7_db;

/*
Viết 1 câu SQL để:
Tìm khách hàng có tổng số tiền mua hàng lớn nhất
Sử dụng ít nhất 2 cấp subquery
Dùng các hàm SUM và MAX
KHÔNG dùng JOIN
-- 1. Tìm tổng số tiền mua hàng lớn nhất
*/

select customer_name
from customer
where customer_id in (
	select customer_id
    from orders
    group by customer_id
    having sum(total_amount) = (
		select max(Tổng_tiền)
		from (
			select sum(total_amount) as Tổng_tiền
            from orders
            group by customer_id
        ) as a
	)
);