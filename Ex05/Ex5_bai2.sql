create database Ss5bai2;
use Ss5bai2;

create table customers (
    customer_id int auto_increment primary key,
    full_name varchar(255),
    email varchar(255),
    city varchar(255),
    status enum('active', 'inactive')
);

insert into customers (full_name, email, city, status)
values
('Chu Văn Ba', 'ba@gmail.com', 'Thanh Hóa', 'active'),
('Trần Thị B', 'b@gmail.com', 'Hà Nội', 'active'),
('Phạm Văn Sáu', 'saug@gmail.com', 'Thanh Hóa', 'inactive'),
('Hoàng Văn E', 'e@gmail.com', 'Đà Nẵng', 'active'),
('Nguyễn Văn A', 'am@gmail.com', 'TP.HCM', 'inactive');

-- 1. Lấy danh sách tất cả khách hàng
select * from customers;
-- 2. Lấy khách hàng ở TP.HCM
select * from customers
where city = 'TP.HCM';
-- 3. Lấy khách hàng đang hoạt động và ở Thanh Hóa
select * from customers
where status = 'active'
and city = 'Thanh Hóa';
-- 4. Sắp xếp danh sách khách hàng theo tên (A → Z)
select * from customers
order by full_name asc;
