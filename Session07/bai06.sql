use ss07_b1;

select id, name, email
from customers
where id in (
    select customer_id
    from orders
    group by customer_id
    having sum(total_amount) >
    (
        select avg(total_per_customer)
        from (
            select sum(total_amount) as total_per_customer
            from orders
            group by customer_id
        ) as temp
    )
);