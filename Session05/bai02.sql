create database bai02;
use bai02;
create table Customers(
	customer_id int,
	full_name varchar(255),
    email varchar(255),
    city varchar(255),
    status enum('active', 'inactive')
);
-- Lấy danh sách tất cả khách hàng
select * from Customers;
-- Lấy khách hàng ở TP.HCM
select * from Customers where city ='TP.HCM'; 
-- Lấy khách hàng đang hoạt động và ở Hà Nội
select * from Customers where status = 'active' and city ='Hà Nội';
-- Sắp xếp danh sách khách hàng theo tên (A → Z)
SELECT * FROM Customers ORDER BY full_name ASC;