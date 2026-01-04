create database ss5ex02;
use ss5ex02;

create table customers (
	customer_id int primary key auto_increment,
    full_name varchar(255) not null,
    email varchar(255) not null unique,
    city varchar(255) not null,
    status enum('active', 'inactive') default('active')
);

insert into customers (full_name, email, city, status)
values
	('Bàng Trọng Tú', 'tu@gmail.com', 'Cao Bằng', 'active'),
    ('Ngô Xuân Hoàng', 'hoang@gmail.com', 'Thanh Hóa', 'active'),
    ('Nguyễn Tiến Thành', 'thanh@gmail.com', 'Hà Nội', 'active'),
    ('Nguyễn Trường An', 'an@gmail.com', 'TP.HCM', 'inactive');
    
-- 1. Lấy danh sách tất cả khách hàng
select * from customers;

-- 2. Lấy khách hàng ở TP.HCM
select * 
from customers
where city = 'TP.HCM';

-- 3. Lấy khách hàng đang hoạt động và ở Hà Nội
select *
from customers
where city = 'Hà Nội' and status = 'active';
-- 4. Sắp xếp danh sách khách hàng theo tên (A → Z)
select *
from customers
order by full_name asc;