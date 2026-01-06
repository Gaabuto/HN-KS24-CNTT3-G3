use ss07_b1;

select id,name,email, (select sum(total_amount) from orders
where customer_id = customers.id) as 'Total_Spent' from customers
where id in (
	select customer_id from orders
    group by customer_id
    having sum(total_amount) = (
		select max(total_spent) from (select sum(total_amount) as total_spent
        from orders group by customer_id) t
    )
);