use ss6db;

create table products(
	product_id int primary key auto_increment,
    product_name varchar(255) not null,
    price decimal(10,2) not null
);

create table order_items(
	order_id int not null,
    product_id int not null,
    quantity int not null,
    primary key(order_id, product_id),
    foreign key (order_id) references orders(order_id),
    foreign key (product_id) references products(product_id)
);

insert into products(product_name, price)
values
	('Áo thun', 300000),
	('Quần jean', 350000),
	('Giày adidas', 1200000),
	('Túi đeo chéo', 800000),
	('Mũ len', 250000);
    
insert into order_items (order_id, product_id, quantity)
values
	(1, 1, 5),
	(1, 2, 2),
	(2, 3, 3),
	(3, 2, 4),
	(4, 4, 2),
	(5, 3, 1),
	(5, 5, 6);
    
-- Hiển thị mỗi sản phẩm đã bán được bao nhiêu sản phẩm
select p.product_id, p.product_name, sum(oi.quantity)
from products as p join order_items as oi on p.product_id = oi.product_id
group by p.product_id, p.product_name;

-- Tính doanh thu của từng sản phẩm
select p.product_id, p.product_name, sum(oi.quantity * p.price)
from products as p join order_items as oi on p.product_id = oi.product_id
group by p.product_id, p.product_name;

-- Chỉ hiển thị các sản phẩm có doanh thu > 5.000.000
select p.product_id, p.product_name, sum(oi.quantity * p.price)
from products as p join order_items as oi on p.product_id = oi.product_id
group by p.product_id, p.product_name
having sum(oi.quantity * p.price) > 5000000










