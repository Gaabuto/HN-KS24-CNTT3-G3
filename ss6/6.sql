-- bai 1

create database ss6;
use ss6;

create table customers (
    customer_id int primary key auto_increment,
    full_name varchar(255) not null,
    city varchar(255)
);

create table orders (
    order_id int primary key auto_increment,
    customer_id int not null,
    order_date date,
    status enum('pending', 'completed', 'cancelled') default 'pending',
    foreign key (customer_id) references customers(customer_id)
);

insert into customers (full_name, city) values
('nguyen van a', 'ha noi'),
('nguyen van b', 'hai phong'),
('nguyen van c', 'da nang'),
('nguyen van d', 'ho chi minh'),
('nguyen van e', 'can tho');

insert into orders (customer_id, order_date, status) values
(1, '2024-01-10', 'pending'),
(2, '2024-01-12', 'completed'),
(1, '2024-01-15', 'cancelled'),
(3, '2024-01-20', 'completed'),
(4, '2024-01-25', 'pending');

select o.order_id as 'id', c.full_name as 'name'
from customers c join orders o on c.customer_id = o.customer_id;

select c.full_name as 'ten', count(o.order_id) as ' so don' 
from customers c join orders o on c.customer_id = o.customer_id
group by c.customer_id;

select c.full_name as 'ten khach hang da dat hang'
from customers c join orders o on c.customer_id = o.customer_id
group by c.full_name;


-- bai 2

alter table orders
add total_amount decimal(10,2) not null;

update orders set total_amount = 500.00 where order_id = 1;
update orders set total_amount = 1200.50 where order_id = 2;
update orders set total_amount = 300.00 where order_id = 3;
update orders set total_amount = 850.75 where order_id = 4;
update orders set total_amount = 640.00 where order_id = 5;

select c.full_name as 'ten',sum(o.total_amount) as 'tong tien da tieu'
from customers c join orders o on c.customer_id = o.customer_id
group by o.customer_id;

select c.full_name as 'ten',max(o.total_amount) as 'gia tri don cao nhat'
from customers c join orders o on c.customer_id = o.customer_id
group by o.customer_id;

select c.full_name as 'ten',sum(o.total_amount) as 'tong tien da tieu'
from customers c join orders o on c.customer_id = o.customer_id
group by o.customer_id
order by sum(o.total_amount) desc;

-- bai 3
select o.order_date, sum(o.total_amount) as 'tong doanh thu'
from customers c join orders o on c.customer_id = o.customer_id
group by o.order_date;

select o.order_date, count(o.total_amount) as 'tong doanh thu'
from customers c join orders o on c.customer_id = o.customer_id
group by o.order_date;

select o.order_date, sum(o.total_amount) as 'tong doanh thu'
from customers c join orders o on c.customer_id = o.customer_id
group by o.order_date
having (sum(o.total_amount) > 10000000);


-- bai 4

create table products (
    product_id int primary key auto_increment,
    product_name varchar(255) not null,
    price decimal(10,2) not null
);


create table order_items (
    order_id int not null,
    product_id int not null,
    quantity int not null check (quantity > 0),
    primary key (order_id, product_id),
    foreign key (order_id) references orders(order_id),
    foreign key (product_id) references products(product_id)
);

insert into products (product_name, price) values
('laptop dell', 500.00),
('chuot logitech', 50.00),
('ban phim co', 300.00),
('man hinh samsung', 425.25),
('tai nghe sony', 640.00);


insert into order_items (order_id, product_id, quantity) values
(1, 1, 1),
(2, 1, 2),
(2, 2, 4),
(3, 3, 1),
(4, 4, 2),
(5, 5, 1);

select p.product_name as 'ten san pham', sum(oi.quantity) as 'so luong san pham da mua'
from order_items oi join products p on oi.product_id = p.product_id
group by p.product_id;

select p.product_name as 'ten san pham', sum(oi.quantity * p.price) as 'doanh thu tung san pham'
from order_items oi join products p on oi.product_id = p.product_id
group by p.product_id;

select p.product_name as 'ten san pham', sum(oi.quantity * p.price) as 'doanh thu tung san pham'
from order_items oi join products p on oi.product_id = p.product_id
group by p.product_id
having (sum(oi.quantity * p.price) > 5000000);

-- bai 5

select 
    c.full_name as 'ten khach hang',
    count(o.order_id) as 'tong so don'
from customers c join orders o on c.customer_id = o.customer_id
group by c.full_name;

select 
    c.full_name as 'ten khach hang',
    sum(o.total_amount) as 'tong so tien'
from customers c join orders o on c.customer_id = o.customer_id
group by c.full_name;

select 
    c.full_name as 'ten khach hang',
    avg(o.total_amount) as 'trung binh so tien'
from customers c join orders o on c.customer_id = o.customer_id
group by c.full_name;

select c.full_name
from customers c join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.full_name
having count(o.order_id) >= 3 and sum(o.total_amount) > 10000000
order by sum(oi.quantity * p.price) desc;


-- bai 6

select p.product_name, sum(oi.quantity), sum(oi.quantity * p. price), avg(oi.quantity * p. price)
from order_items oi join products p on oi.product_id = p.product_id
group by p.product_id, p.product_name
having count(quantity >= 10)
order by sum(oi.quantity * p. price) desc
limit 5;





























-- BTTH

/* =========================================================
   FILE SQL: ecommerce_practice.sql
   MÔN HỌC : CƠ SỞ DỮ LIỆU / SQL
   CHỦ ĐỀ  : JOIN – AGGREGATE – GROUP BY – HAVING
   MÔ TẢ   : CSDL mẫu hệ thống thương mại điện tử (eCommerce)
   ========================================================= */


/* =========================================================
   1. TẠO CƠ SỞ DỮ LIỆU
   ========================================================= */

CREATE DATABASE ecommerce_db;
USE ecommerce_db;


/* =========================================================
   2. TẠO BẢNG KHÁCH HÀNG
   ========================================================= */

CREATE TABLE customers (
    customer_id   INT PRIMARY KEY,        -- Mã khách hàng
    customer_name VARCHAR(100),            -- Tên khách hàng
    email         VARCHAR(100),            -- Email
    city          VARCHAR(50)               -- Thành phố
);


/* =========================================================
   3. TẠO BẢNG SẢN PHẨM
   ========================================================= */

CREATE TABLE products (
    product_id   INT PRIMARY KEY,          -- Mã sản phẩm
    product_name VARCHAR(100),              -- Tên sản phẩm
    price        DECIMAL(12,2),              -- Giá bán
    category     VARCHAR(50)                -- Loại sản phẩm
);


/* =========================================================
   4. TẠO BẢNG ĐƠN HÀNG
   ========================================================= */

CREATE TABLE orders (
    order_id    INT PRIMARY KEY,            -- Mã đơn hàng
    customer_id INT,                        -- Khách hàng đặt
    order_date  DATE,                       -- Ngày đặt hàng
    status      VARCHAR(30),                -- Trạng thái đơn
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


/* =========================================================
   5. TẠO BẢNG CHI TIẾT ĐƠN HÀNG
   ========================================================= */

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,          -- Mã chi tiết đơn
    order_id      INT,                      -- Mã đơn hàng
    product_id    INT,                      -- Mã sản phẩm
    quantity      INT,                      -- Số lượng
    unit_price    DECIMAL(12,2),             -- Giá bán tại thời điểm đặt
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


/* =========================================================
   6. DỮ LIỆU MẪU - KHÁCH HÀNG
   ========================================================= */

INSERT INTO customers VALUES
(1, 'Nguyen Van An',  'an@gmail.com',   'Ha Noi'),
(2, 'Tran Thi Binh',  'binh@gmail.com', 'Da Nang'),
(3, 'Le Van Cuong',   'cuong@gmail.com','Ho Chi Minh'),
(4, 'Pham Thi Dao',   'dao@gmail.com',  'Ha Noi'),
(5, 'Hoang Van Em',   'em@gmail.com',   'Can Tho');


/* =========================================================
   7. DỮ LIỆU MẪU - SẢN PHẨM
   ========================================================= */

INSERT INTO products VALUES
(1, 'Laptop Dell',          20000000, 'Electronics'),
(2, 'iPhone 15',            25000000, 'Electronics'),
(3, 'Tai nghe Bluetooth',    1500000, 'Accessories'),
(4, 'Chuột không dây',        500000, 'Accessories'),
(5, 'Bàn phím cơ',           2000000, 'Accessories');


/* =========================================================
   8. DỮ LIỆU MẪU - ĐƠN HÀNG
   ========================================================= */

INSERT INTO orders VALUES
(101, 1, '2025-01-05', 'Completed'),
(102, 2, '2025-01-06', 'Completed'),
(103, 3, '2025-01-07', 'Completed'),
(104, 1, '2025-01-08', 'Completed'),
(105, 4, '2025-01-09', 'Completed'),
(106, 5, '2025-01-10', 'Completed'),
(107, 2, '2025-01-11', 'Completed'),
(108, 3, '2025-01-12', 'Completed');


/* =========================================================
   9. DỮ LIỆU MẪU - CHI TIẾT ĐƠN HÀNG
   ========================================================= */

INSERT INTO order_items VALUES
-- Đơn 101
(1, 101, 1, 1, 20000000),
(2, 101, 3, 2, 1500000),

-- Đơn 102
(3, 102, 2, 1, 25000000),
(4, 102, 4, 1, 500000),

-- Đơn 103
(5, 103, 5, 2, 2000000),
(6, 103, 3, 1, 1500000),

-- Đơn 104
(7, 104, 1, 1, 20000000),
(8, 104, 5, 1, 2000000),

-- Đơn 105
(9, 105, 4, 3, 500000),

-- Đơn 106
(10, 106, 3, 5, 1500000),

-- Đơn 107
(11, 107, 2, 1, 25000000),
(12, 107, 3, 2, 1500000),

-- Đơn 108
(13, 108, 1, 1, 20000000),
(14, 108, 4, 2, 500000);


/* =========================================================
   10. KIỂM TRA NHANH DỮ LIỆU (OPTIONAL)
   ========================================================= */

-- Kiểm tra số lượng bản ghi
SELECT COUNT(*) AS total_customers FROM customers;
SELECT COUNT(*) AS total_products  FROM products;
SELECT COUNT(*) AS total_orders    FROM orders;
SELECT COUNT(*) AS total_items     FROM order_items;

/* =========================================================
   KẾT THÚC FILE SQL
   ========================================================= */
   
   -- cau 1
   select o.order_id, c.customer_name
from orders o
join customers c on o.customer_id = c.customer_id;

-- cau 2
select o.order_id, p.product_name, oi.quantity
from orders o
join order_items oi on o.order_id = oi.order_id
join products p on oi.product_id = p.product_id
order by o.order_id;

-- cau 3
select count(*) as 'tong so don hang'
from orders;
 
-- cau 4
select sum(oi.quantity * oi.unit_price) as 'tong doanh thu'
from order_items oi;

-- cau 5
select o.order_id, sum(oi.quantity * oi.unit_price) as 'tong tien don hang'
from orders o join order_items oi on o.order_id = oi.order_id
group by o.order_id;

-- cau 6

select c.customer_id, c.customer_name, sum(oi.quantity * oi.unit_price) as 'tong tien da chi'
from customers c join orders o on c.customer_id = o.customer_id
				 join order_items oi on o.order_id = oi.order_id
group by c.customer_id, c.customer_name;

-- cau 7
select p.product_id, p.product_name, sum(oi.quantity * oi.unit_price) as 'doanh thu'
from products p join order_items oi on p.product_id = oi.product_id
group by p.product_id, p.product_name;

-- cau 8

select c.customer_id, c.customer_name, sum(oi.quantity * oi.unit_price) as 'tong tien da chi'
from customers c join orders o on c.customer_id = o.customer_id
				 join order_items oi on o.order_id = oi.order_id
group by c.customer_id, c.customer_name
having sum(oi.quantity * oi.unit_price) > 5000000;

-- cau 9

select p.product_id, p.product_name, sum(oi.quantity) as 'tong so luong da ban'
from products p join order_items oi on p.product_id = oi.product_id
group by p.product_id, p.product_name
having sum(oi.quantity) > 100;

-- cau 10
select c.city, count(o.order_id) as 'so luong don hang'
from customers c join orders o on c.customer_id = o.customer_id
group by c.city
having count(o.order_id) > 5;










































-- bai tap tren lop
CREATE DATABASE ecommerce_db;
USE ecommerce_db;

CREATE TABLE customers (
    customer_id   INT PRIMARY KEY,        -- Mã khách hàng
    customer_name VARCHAR(100),            -- Tên khách hàng
    email         VARCHAR(100),            -- Email
    city          VARCHAR(50)               -- Thành phố
);

CREATE TABLE products (
    product_id   INT PRIMARY KEY,          -- Mã sản phẩm
    product_name VARCHAR(100),              -- Tên sản phẩm
    price        DECIMAL(12,2),              -- Giá bán
    category     VARCHAR(50)                -- Loại sản phẩm
);

CREATE TABLE orders (
    order_id    INT PRIMARY KEY,            -- Mã đơn hàng
    customer_id INT,                        -- Khách hàng đặt
    order_date  DATE,                       -- Ngày đặt hàng
    status      VARCHAR(30),                -- Trạng thái đơn
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,          -- Mã chi tiết đơn
    order_id      INT,                      -- Mã đơn hàng
    product_id    INT,                      -- Mã sản phẩm
    quantity      INT,                      -- Số lượng
    unit_price    DECIMAL(12,2),             -- Giá bán tại thời điểm đặt
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO customers VALUES
(1, 'Nguyen Van An',  'an@gmail.com',   'Ha Noi'),
(2, 'Tran Thi Binh',  'binh@gmail.com', 'Da Nang'),
(3, 'Le Van Cuong',   'cuong@gmail.com','Ho Chi Minh'),
(4, 'Pham Thi Dao',   'dao@gmail.com',  'Ha Noi'),
(5, 'Hoang Van Em',   'em@gmail.com',   'Can Tho');

INSERT INTO products VALUES
(1, 'Laptop Dell',          20000000, 'Electronics'),
(2, 'iPhone 15',            25000000, 'Electronics'),
(3, 'Tai nghe Bluetooth',    1500000, 'Accessories'),
(4, 'Chuột không dây',        500000, 'Accessories'),
(5, 'Bàn phím cơ',           2000000, 'Accessories');

INSERT INTO orders VALUES
(101, 1, '2025-01-05', 'Completed'),
(102, 2, '2025-01-06', 'Completed'),
(103, 3, '2025-01-07', 'Completed'),
(104, 1, '2025-01-08', 'Completed'),
(105, 4, '2025-01-09', 'Completed'),
(106, 5, '2025-01-10', 'Completed'),
(107, 2, '2025-01-11', 'Completed'),
(108, 3, '2025-01-12', 'Completed');

INSERT INTO order_items VALUES
(1, 101, 1, 1, 20000000),
(2, 101, 3, 2, 1500000),

(3, 102, 2, 1, 25000000),
(4, 102, 4, 1, 500000),

-- Đơn 103
(5, 103, 5, 2, 2000000),
(6, 103, 3, 1, 1500000),

(7, 104, 1, 1, 20000000),
(8, 104, 5, 1, 2000000),

(9, 105, 4, 3, 500000),

(10, 106, 3, 5, 1500000),

(11, 107, 2, 1, 25000000),
(12, 107, 3, 2, 1500000),

(13, 108, 1, 1, 20000000),
(14, 108, 4, 2, 500000);



/* =========================================================
   FILE SQL: ecommerce_answers.sql
   MÔN HỌC : CƠ SỞ DỮ LIỆU / SQL
   NỘI DUNG: ĐÁP ÁN 10 CÂU TRUY VẤN
   CHỦ ĐỀ  : JOIN – AGGREGATE – GROUP BY – HAVING
   ========================================================= */

USE ecommerce_db;


/* =========================================================
   CÂU 1
   Liệt kê danh sách các đơn hàng kèm theo tên khách hàng
   ========================================================= */

SELECT
    o.order_id,
    o.order_date,
    o.status,
    c.customer_name
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id;


/* =========================================================
   CÂU 2
   Cho biết mỗi đơn hàng gồm những sản phẩm nào và số lượng
   ========================================================= */

SELECT
    o.order_id,
    p.product_name,
    oi.quantity
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
ORDER BY o.order_id;


/* =========================================================
   CÂU 3
   Tính tổng số đơn hàng trong hệ thống
   ========================================================= */

SELECT COUNT(*) AS total_orders
FROM orders;


/* =========================================================
   CÂU 4
   Tính tổng doanh thu của toàn bộ hệ thống
   ========================================================= */

SELECT
    SUM(quantity * unit_price) AS total_revenue
FROM order_items;


/* =========================================================
   CÂU 5
   Cho biết tổng tiền của mỗi đơn hàng
   ========================================================= */

SELECT
    o.order_id,
    SUM(oi.quantity * oi.unit_price) AS order_total
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY o.order_id;


/* =========================================================
   CÂU 6
   Cho biết tổng số tiền mà mỗi khách hàng đã chi tiêu
   ========================================================= */

SELECT
    c.customer_id,
    c.customer_name,
    SUM(oi.quantity * oi.unit_price) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name;


/* =========================================================
   CÂU 7
   Tính doanh thu theo từng sản phẩm
   ========================================================= */

SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity * oi.unit_price) AS product_revenue
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name;


/* =========================================================
   CÂU 8
   Liệt kê các khách hàng có tổng chi tiêu > 5.000.000
   (Sử dụng HAVING)
   ========================================================= */

SELECT
    c.customer_id,
    c.customer_name,
    SUM(oi.quantity * oi.unit_price) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(oi.quantity * oi.unit_price) > 5000000;


/* =========================================================
   CÂU 9
   Liệt kê các sản phẩm có tổng số lượng bán ra > 100
   ========================================================= */

SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS total_quantity
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
HAVING SUM(oi.quantity) > 100;


/* =========================================================
   CÂU 10
   Cho biết các thành phố có số lượng đơn hàng > 5
   ========================================================= */

SELECT
    c.city,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.city
HAVING COUNT(o.order_id) > 5;


/* =========================================================
   KẾT THÚC FILE ĐÁP ÁN
   ========================================================= */
Đang hiển thị dapan.sql.