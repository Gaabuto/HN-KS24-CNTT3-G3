create database ss7_db;
use ss7_db;

create table customer(
	customer_id int primary key auto_increment,
    customer_name varchar(100) not null,
    customer_email varchar(100) not null unique
);

create table orders(
	id int primary key auto_increment,
    customer_id int not null,
    order_date date not null,
    total_amount decimal(10,2) not null,
    foreign key (customer_id) references customer(customer_id)
);

insert into customer(customer_name, customer_email)
values
	('Nguyễn Văn An', 'an@gmail.com'),
	('Trần Thị Bình', 'binh@gmail.com'),
	('Lê Văn Cường', 'cuong@gmail.com'),
	('Phạm Thị Dương', 'duongpham@gmail.com'),
	('Hoàng Văn Em', 'em@gmail.com'),
	('Vũ Thị Yến', 'yen@gmail.com'),
	('Đặng Văn Giang', 'giang@gmail.com'),
	('Bùi Thị Hường', 'huong@gmail.com'),
	('Đỗ Văn Kiên', 'kien@gmail.com'),
	('Ngô Thị Hồng', 'hong@gmail.com');

insert into orders(customer_id, order_date, total_amount)
values
	(1, '2025-01-01', 150000.00),
	(1, '2025-01-02', 230000.50),
	(3, '2025-01-03', 320000.00),
	(3, '2025-01-04', 120000.75),
	(4, '2025-01-05', 540000.00),
	(5, '2025-01-06', 98000.00),
	(6, '2025-01-07', 410000.25),
	(6, '2025-01-08', 275000.00),
	(8, '2025-01-09', 660000.00),
	(9,'2025-01-10', 199000.99),
    (10,'2025-01-11', 199000.99);
    
/*
	Viết 1 câu SQL để:
	Lấy danh sách khách hàng đã từng đặt đơn hàng
	Sử dụng subquery trong WHERE
	KHÔNG dùng JOIN
*/

select *
from customer
where customer_id in 
	(select customer_id
    from orders);