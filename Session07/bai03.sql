use ss07_b1;

select id, customer_id, order_date, total_amount from orders
where total_amount > (select avg(total_amount) from orders);