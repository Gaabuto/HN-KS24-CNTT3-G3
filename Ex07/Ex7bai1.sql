use ss7_db;

-- tạo bảng customers
create table customers (
    id int primary key,
    name varchar(100),
    email varchar(100)
);

-- tạo bảng orders
create table orders (
    id int primary key,
    customer_id int,
    order_date date,
    total_amount decimal(10, 2),
    foreign key (customer_id) references customers(id)
);

-- dữ liệu khách hàng 
insert into customers (id, name, email) values
(1, 'Nguyễn Văn An', 'vana@example.com'),
(2, 'Trần Thị Bình', 'thib@example.com'),
(3, 'Lê Văn Cường', 'vanc@example.com'),
(4, 'Phạm Văn Dũng', 'vand@example.com'),
(5, 'Hoàng Thị Em', 'thie@example.com'),
(6, 'Vũ Văn Hùng', 'vanf@example.com'),
(7, 'Ngô Thị Giang', 'thig@example.com');

-- dữ liệu đơn hàng
insert into orders (id, customer_id, order_date, total_amount) values
(101, 1, '2024-08-01', 500000),
(102, 1, '2024-08-02', 120000),
(103, 2, '2024-08-03', 350000),
(104, 3, '2024-08-05', 900000),
(105, 5, '2024-08-07', 200000),
(106, 6, '2024-08-10', 450000),
(107, 2, '2024-08-12', 600000);

-- truy vấn: khách hàng đã mua hàng
select id, name, email
from customers where id in (select customer_id 
	from orders
);