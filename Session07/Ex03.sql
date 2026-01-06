use ss7_db;

select *
from orders
where total_amount >
	(select avg(total_amount)
    from orders);