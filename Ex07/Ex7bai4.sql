drop table if exists order_details;
drop table if exists orders;
drop table if exists customers;

-- 1. tạo bảng customers
create table customers (
    id_customer int primary key,
    name_customer varchar(100),
    email_customer varchar(100)
);

-- 2. tạo bảng orders
create table orders (
    id int primary key,
    customer_id int,
    order_date date,
    total_amount decimal(15, 2),
    foreign key (customer_id) references customers(id_customer)
);

-- 3. thêm dữ liệu mẫu
insert into customers (id_customer, name_customer, email_customer) values
(1, 'Nguyễn Văn A', 'a@mail.com'),
(2, 'Trần Thị B', 'b@mail.com'),
(3, 'Lê Văn C', 'c@mail.com'),
(4, 'Phạm Thị D', 'd@mail.com'),
(5, 'Hoàng Văn E', 'e@mail.com');

insert into orders (id, customer_id, order_date, total_amount) values
(101, 1, '2024-08-01', 500000), 
(102, 1, '2024-08-02', 200000), 
(103, 2, '2024-08-03', 150000), 
(104, 2, '2024-08-04', 300000), 
(105, 4, '2024-08-05', 900000); 

-- 4. lấy tên khách và số lượng đơn hàng
select name_customer,
	(select count(*) 
	from orders 
	where orders.customer_id = customers.id_customer) as order_count 
from customers;