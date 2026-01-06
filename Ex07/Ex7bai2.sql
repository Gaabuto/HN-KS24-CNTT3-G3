drop table if exists order_items;
drop table if exists products;

-- bảng product
create table products (
    id int primary key,
    name varchar(100),
    price decimal(10, 2)
);

-- bảng order_items
create table order_items (
    order_id int,
    product_id int,
    quantity int,
    foreign key (product_id) references products(id)
);

-- dữ liệu sản phẩm
insert into products (id, name, price) values
(1, 'Laptop Gaming Asus', 25000000),
(2, 'Chuột Không Dây', 350000),
(3, 'Bàn Phím Cơ', 1200000),
(4, 'Tai Nghe Chống Ồn', 4500000), 
(5, 'Lót Chuột RGB', 200000);

-- thông tin sản phẩm đã bán
insert into order_items (order_id, product_id, quantity) values
(1001, 1, 1),
(1001, 2, 2),
(1002, 1, 1),
(1003, 3, 5);

-- lấy sản phẩm đã bán
select id, name, price
from products where id in (select product_id
    from order_items
);