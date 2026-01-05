use ss06;

-- tạo bảng sản phẩm (có điều kiện)
create table products (
    product_id int primary key auto_increment,
    product_name varchar(255) not null,
    price decimal(10,2) check (price > 0)
);

-- tạo bảng chi tiết đơn hàng (có điều kiện)
create table order_items (
    order_id int not null,
    product_id int not null,
    quantity int check (quantity > 0),
    foreign key (product_id) references products(product_id)
);

-- thêm dữ liệu sản phẩm
insert into products (product_name, price) values
('Điện thoại samsung', 7000000),
('Laptop dell', 15000000),
('Tai nghe bluetooth', 800000),
('Chuột không dây', 500000),
('Bàn phím cơ', 1200000),
('Máy tính bảng', 9000000),
('Đồng hồ thông minh', 3000000);

-- thêm dữ liệu chi tiết đơn hàng
insert into order_items (order_id, product_id, quantity) values
(1, 1, 3),
(2, 1, 4),
(3, 1, 5),

(4, 2, 2),
(5, 2, 3),
(6, 2, 5),

(7, 3, 6),
(8, 3, 5),

(9, 4, 10),
(10, 4, 5),

(11, 5, 4),
(12, 5, 6),

(13, 6, 3),
(14, 6, 4),
(15, 6, 5),

(16, 7, 2),
(17, 7, 4),
(18, 7, 5);

-- báo cáo kinh doanh tổng hợp
select p.product_name,sum(oi.quantity),sum(oi.quantity * p.price),avg(p.price)
from products p join order_items oi on p.product_id = oi.product_id
group by p.product_id, p.product_name having sum(oi.quantity) >= 10
order by sum(oi.quantity * p.price) desc limit 5;
