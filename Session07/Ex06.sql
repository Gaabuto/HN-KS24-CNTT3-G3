use ss7_db;

/*
Viết 1 câu SQL để:
Lấy danh sách khách hàng có tổng tiền mua hàng lớn hơn tổng tiền trung bình của tất cả khách hàng
Subquery dùng hàm AVG
Truy vấn chính dùng GROUP BY và HAVING
KHÔNG dùng JOIN
*/

select customer_id
from orders
group by customer_id
having sum(total_amount) > (
	select avg(Tổng_tiền)
    from (
		select sum(total_amount) as Tổng_tiền
        from orders
        group by customer_id
    ) as ts
);