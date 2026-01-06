drop table if exists order_details;
drop table if exists orders;
drop table if exists customers;

-- 1. tạo bảng
create table customers (
    customer_id int primary key,
    customer_name varchar(100),
    customer_email varchar(100)
);

create table orders (
    order_id int primary key,
    customer_id int,
    order_date date,
    order_amount decimal(15, 2),
    foreign key (customer_id) references customers(customer_id)
);

-- 2. thêm dữ liệu
insert into customers (customer_id, customer_name, customer_email) values
(1, 'Nguyễn Văn A', 'a@mail.com'),
(2, 'Trần Thị B', 'b@mail.com'),
(3, 'Lê Văn C', 'c@mail.com'),
(4, 'Phạm Thị D', 'd@mail.com'),
(5, 'Hoàng Văn E', 'e@mail.com');

insert into orders (order_id, customer_id, order_date, order_amount) values
(101, 1, '2024-08-01', 500000), 
(102, 1, '2024-08-02', 200000), 
(103, 2, '2024-08-03', 100000), 
(104, 2, '2024-08-04', 100000), 
(105, 3, '2024-08-05', 5000000), 
(106, 4, '2024-08-06', 2000000), 
(107, 3, '2024-08-07', 1000000); 

-- tìm khách mua nhiều tiền nhất
select customer_id, customer_name, customer_email
from customers where (select sum(order_amount) 
	from orders where orders.customer_id = customers.customer_id) = (select max(total) 
		from (select sum(order_amount) as total 
			from orders group by customer_id) as temp);