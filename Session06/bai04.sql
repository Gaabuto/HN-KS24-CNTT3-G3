use bai01;

-- tạo bảng products lưu thông tin sản phẩm
create table products (
    product_id int primary key,
    product_name varchar(255),
    price decimal(10,2)
);

-- tạo bảng order_items lưu sản phẩm thuộc từng đơn hàng
create table order_items (
    order_id int,
    product_id int,
    quantity int,
    foreign key (order_id) references orders(order_id),
    foreign key (product_id) references products(product_id)
);

-- thêm dữ liệu mẫu cho bảng products
insert into products values
(1,'Laptop',15000000),
(2,'Chuột',500000),
(3,'Bàn phím',1200000),
(4,'Màn hình',4500000),
(5,'Tai nghe',2500000);

-- thêm dữ liệu mẫu cho bảng order_items
insert into order_items values
(101,1,1),
(101,2,2),
(102,3,1),
(103,1,1),
(105,4,2);

-- hiển thị mỗi sản phẩm đã bán được bao nhiêu sản phẩm
select p.product_name, sum(oi.quantity)
from products p join order_items oi on p.product_id = oi.product_id
group by p.product_id, p.product_name;

-- tính doanh thu từng sản phẩm và chỉ lấy sản phẩm có doanh thu > 5.000.000
select p.product_name, sum(oi.quantity * p.price)
from products p join order_items oi on p.product_id = oi.product_id
group by p.product_id, p.product_name
having sum(oi.quantity * p.price) > 5000000;
