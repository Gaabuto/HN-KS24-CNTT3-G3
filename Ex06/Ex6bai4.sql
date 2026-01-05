use ss06;

-- tạo bảng sản phẩm
create table products (
    product_id int primary key auto_increment,
    product_name varchar(255) not null,
    price decimal(10,2) check (price > 0)
);

-- tạo bảng chi tiết đơn hàng
create table order_items (
    order_id int not null,
    product_id int not null,
    quantity int check (quantity > 0),
    foreign key (product_id) references products(product_id)
);

-- thêm dữ liệu bảng products
insert into products (product_name, price) values
('Điện thoại samsung', 7000000),
('Laptop dell', 15000000),
('Tai nghe bluetooth', 800000),
('Chuột không dây', 500000),
('Bàn phím cơ', 1200000);

-- thêm dữ liệu bảng order_items
insert into order_items (order_id, product_id, quantity) values
(1, 1, 1),
(1, 3, 2),
(2, 2, 1),
(2, 5, 1),
(3, 1, 2),
(3, 4, 3),
(4, 2, 1),
(4, 1, 1),
(5, 5, 2);

-- hiển thị mỗi sản phẩm đã bán được bao nhiêu sản phẩm
select p.product_id,p.product_name,sum(oi.quantity)
from products p join order_items oi on p.product_id = oi.product_id
group by p.product_id, p.product_name;

-- tính doanh thu của từng sản phẩm
select p.product_id,p.product_name,sum(oi.quantity * p.price)
from products p join order_items oi on p.product_id = oi.product_id
group by p.product_id, p.product_name;

-- chỉ hiển thị các sản phẩm có doanh thu > 5tr
select p.product_id,p.product_name,sum(oi.quantity * p.price)
from products p join order_items oi on p.product_id = oi.product_id
group by p.product_id, p.product_name 
having sum(oi.quantity * p.price) > 5000000;
