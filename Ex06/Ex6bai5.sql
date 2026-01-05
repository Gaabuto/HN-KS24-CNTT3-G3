use ss06;

-- tạo bảng khách hàng
create table customers (
    customer_id int primary key auto_increment,
    full_name varchar(255) not null,
    city varchar(255) not null
);

-- tạo bảng đơn hàng
create table orders (
    order_id int primary key auto_increment,
    customer_id int not null,
    order_date date not null,
    total_amount decimal(10,2) check (total_amount > 0),
    foreign key (customer_id) references customers(customer_id)
);

-- thêm dữ liệu khách hàng
insert into customers (full_name, city) values
('Nguyễn Văn A', 'Hà Nội'),
('Trần Thị B', 'Hải Phòng'),
('Lê Văn C', 'Đà Nẵng'),
('Phạm Thị D', 'Cần Thơ'),
('Hoàng Văn E', 'TP HCM');

-- thêm dữ liệu đơn hàng
insert into orders (customer_id, order_date, total_amount) values
(1, '2024-08-01', 4000000),
(1, '2024-08-05', 3500000),
(1, '2024-08-10', 3000000),

(2, '2024-08-03', 2000000),
(2, '2024-08-07', 1500000),

(3, '2024-08-02', 5000000),
(3, '2024-08-06', 4000000),
(3, '2024-08-09', 3000000),

(4, '2024-08-04', 1000000),

(5, '2024-08-01', 6000000),
(5, '2024-08-08', 5000000),
(5, '2024-08-12', 4000000);

-- truy vấn khách hàng vip
select c.customer_id,c.full_name,count(o.order_id),sum(o.total_amount),avg(o.total_amount)
from customers c join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.full_name having count(o.order_id) >= 3
   and sum(o.total_amount) > 10000000 order by sum(o.total_amount) desc;