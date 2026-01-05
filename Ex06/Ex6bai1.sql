create database ss06;
use ss06;

-- tạo bảng customers
create table customers (
    customer_id int primary key auto_increment,
    full_name varchar(255),
    city varchar(255)
);

-- tạo bảng orders
create table orders (
    order_id int primary key auto_increment,
    customer_id int,
    order_date date,
    status enum('pending', 'completed', 'cancelled'),
    foreign key (customer_id) references customers(customer_id)
);

-- thêm dữ liệu vào bảng customers
insert into customers (full_name, city) values
('Nguyễn Văn A', 'Hà Nội'),
('Trần Thị B', 'Hải Phòng'),
('Lê Văn C', 'Đà Nẵng'),
('Phạm Thị D', 'Cần Thơ'),
('Hoàng Văn E', 'TP HCM');

-- thêm dữ liệu vào bảng orders
insert into orders (customer_id, order_date, status) values
(1, '2024-08-01', 'completed'),
(1, '2024-08-05', 'pending'),
(2, '2024-08-03', 'completed'),
(3, '2024-08-06', 'cancelled'),
(3, '2024-08-08', 'completed');

-- hiển thị danh sách đơn hàng kèm tên khách hàng
select o.order_id,c.full_name,o.order_date,o.status
from orders o join customers c on o.customer_id = c.customer_id;

-- hiển thị mỗi khách hàng đã đặt bao nhiêu đơn hàng
select c.customer_id,c.full_name,count(o.order_id)
from customers c left join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.full_name;

-- chỉ hiển thị khách hàng có ít nhất 1 đơn hàng
select c.customer_id,c.full_name,count(o.order_id)
from customers c join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.full_name
having count(o.order_id) >= 1;

drop table orders;
drop table customers;
