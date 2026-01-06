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
(101, 1, '2024-08-01', 200000), 
(102, 2, '2024-08-02', 200000), 
(103, 3, '2024-08-03', 5000000),
(104, 3, '2024-08-04', 1000000), 
(105, 4, '2024-08-05', 3000000),
(106, 5, '2024-08-06', 100000); 

-- 3. tìm khách có tổng tiền mua > mức trung bình của tất cả khách
select customer_id, sum(order_amount) as total_spent
from orders group by customer_id having sum(order_amount) > (select avg(total)
    from (select sum(order_amount) as total 
		from orders group by customer_id) as temp
);