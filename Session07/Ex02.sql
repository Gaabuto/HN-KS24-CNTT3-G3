use ss7_db;

create table products(
	product_id int primary key auto_increment,
    product_name varchar(100) not null,
    product_price decimal(10,2) not null
);

create table order_items(
	order_id int primary key auto_increment,
    product_id int not null,
    quantity int not null,
    foreign key (product_id) references products(product_id)
);

insert into products (product_name, product_price)
values
	('Laptop Dell', 15000000.00),
	('Chuột Logitech', 350000.00),
	('Bàn phím cơ', 1200000.00),
	('Màn hình Samsung', 4500000.00),
	('Tai nghe Sony', 1800000.00),
	('USB 32GB', 250000.00),
	('Ổ cứng SSD 512GB', 2200000.00),
	('Webcam Logitech', 1600000.00),
	('Loa Bluetooth', 900000.00),
	('Sạc dự phòng', 700000.00);
    
insert into order_items (product_id, quantity)
values
	(1, 6),
	(2, 2),
	(3, 1),
	(4, 4),
	(5, 7),
	(6, 3),
	(7, 9),
	(8, 5),
	(9, 6),
	(10, 7);
    
/*
Viết 1 câu SQL để:
Lấy danh sách sản phẩm đã từng được bán
Subquery lấy product_id từ bảng order_items
Sử dụng IN
KHÔNG dùng JOIN
*/

select *
from products
where product_id in
	(select product_id
	from order_items);