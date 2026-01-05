-- tạo database bai01
create database bai01;
use bai01;

-- tạo bảng customers lưu thông tin khách hàng
create table customers (
    customer_id int primary key,
    full_name varchar(255),
    city varchar(255)
);

-- tạo bảng orders lưu thông tin đơn hàng
create table orders (
    order_id int primary key,
    customer_id int,
    order_date date,
    status enum('pending','completed','cancelled'),
    foreign key (customer_id) references customers(customer_id)
);

-- thêm dữ liệu mẫu cho bảng customers
insert into customers values
(1,'Nguyễn Văn An','Hà Nội'),
(2,'Trần Thị Bình','TP.HCM'),
(3,'Lê Văn Cường','Đà Nẵng'),
(4,'Phạm Thị Dung','Hải Phòng'),
(5,'Hoàng Văn Em','Cần Thơ');

-- thêm dữ liệu mẫu cho bảng orders
insert into orders values
(101,1,'2025-01-01','completed'),
(102,1,'2025-01-05','pending'),
(103,2,'2025-01-10','completed'),
(104,3,'2025-01-12','cancelled'),
(105,3,'2025-01-15','completed');

-- hiển thị danh sách đơn hàng kèm tên khách hàng
select o.order_id, c.full_name, o.order_date, o.status
from orders o join customers c on o.customer_id = c.customer_id;

-- hiển thị mỗi khách hàng có bao nhiêu đơn hàng (kể cả khách chưa có đơn)
select c.customer_id, c.full_name, count(o.order_id)
from customers c left join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.full_name;

-- chỉ hiển thị khách hàng có ít nhất 1 đơn hàng
select c.customer_id, c.full_name, count(o.order_id)
from customers c join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.full_name
having count(o.order_id) >= 1;
