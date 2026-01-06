use ss07_b1;

select name, (select count(*) from orders where orders.customer_id = customers.id) as total_orders from customers;
	