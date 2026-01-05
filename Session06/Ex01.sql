create database ss6db;
use ss6db;

create table customers(
	customer_id int primary key auto_increment,
    full_name varchar(255) not null,
    city varchar(255) not null
);

create table orders(
	order_id int primary key auto_increment,
    customer_id int not null,
    order_date date not null,
    status enum('pending', 'completed', 'cancelled'),
    foreign key (customer_id) references customers(customer_id)
);

-- Thêm dữ liệu vào bảng customers và orders tối thiếu 5 dữ liệu
insert into customers(full_name, city)
values
	('Nguyễn Văn An', 'Hà Nội'),
    ('Đặng Anh Bình', 'Thanh Hóa'),
    ('Trần Quốc Cường', 'Nam Định'),
    ('Vi Trung Dương', 'Hải Phòng'),
    ('Hoàng Thanh Long', 'Quảng Ninh');
    
insert into orders(customer_id, order_date, status)
values
	(1, '2025-01-01', 'pending'),
	(1, '2025-01-03', 'completed'),
	(2, '2025-01-05', 'completed'),
	(3, '2025-01-06', 'cancelled'),
	(4, '2025-01-07', 'pending');
    
-- Hiển thị danh sách đơn hàng kèm tên khách hàng
select o.order_id, c.full_name, o.order_date, o.status
from orders as o join customers as c on o.customer_id = c.customer_id;

-- Hiển thị mỗi khách hàng đã đặt bao nhiêu đơn hàng
select c.customer_id, c.full_name, count(o.order_id)
from orders as o right join customers as c on o.customer_id = c.customer_id
group by c.customer_id, c.full_name;

-- Chỉ hiển thị các khách hàng có ít nhất 1 đơn hàng
select c.customer_id, c.full_name, count(o.order_id)
from orders as o join customers as c on o.customer_id = c.customer_id
group by c.customer_id, c.full_name
having count(o.order_id) >= 1