SELECT 
    c.category_name, 
    AVG(p.price) AS avg_price, 
    MIN(p.price) AS min_price, 
    MAX(p.price) AS max_price
FROM products p
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_id, c.category_name;
Nguyễn Trần Bảo
-- 1. Tạo Database
DROP DATABASE IF EXISTS ss8;
CREATE DATABASE ss8;
USE ss8;

-- 2. Tạo bảng Customers
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(10) NOT NULL UNIQUE
);

-- 3. Tạo bảng Categories
CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(255) NOT NULL UNIQUE
);

-- 4. Tạo bảng Products
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(255) NOT NULL UNIQUE,
    price DECIMAL(10,2) NOT NULL CHECK (price > 0),
    category_id INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- 5. Tạo bảng Orders
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Pending', 'Completed', 'Cancel') DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 6. Tạo bảng Order_Items
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL CHECK (quantity > 0),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Thêm danh mục
INSERT INTO categories (category_name) VALUES 
('Laptop'), ('Smartphone'), ('Tablet'), ('Accessories');

-- Thêm sản phẩm
INSERT INTO products (product_name, price, category_id) VALUES 
('MacBook Pro M3', 3000.00, 1),
('Dell XPS 15', 2500.00, 1),
('iPhone 15 Pro', 1200.00, 2),
('Samsung S24 Ultra', 1100.00, 2),
('iPad Air', 600.00, 3),
('Logitech Mouse', 50.00, 4),
('Keyboard Keychron', 100.00, 4),
('AirPods Pro', 250.00, 4);

-- Thêm khách hàng
INSERT INTO customers (customer_name, email, phone) VALUES 
('Nguyen Van A', 'a@gmail.com', '0901111111'),
('Tran Thi B', 'b@gmail.com', '0902222222'),
('Le Van C', 'c@gmail.com', '0903333333'), -- Khách này chưa mua gì
('Pham Van D', 'd@gmail.com', '0904444444');

-- Thêm đơn hàng
INSERT INTO orders (customer_id, status, order_date) VALUES 
(1, 'Completed', '2024-08-01 10:00:00'),
(1, 'Pending', '2024-08-02 11:00:00'),
(2, 'Completed', '2024-08-03 14:00:00'),
(2, 'Cancel', '2024-08-04 09:00:00'),
(4, 'Completed', '2024-08-05 16:00:00');

-- Thêm chi tiết đơn hàng
INSERT INTO order_items (order_id, product_id, quantity) VALUES 
(1, 1, 1), (1, 6, 2), -- Đơn 1: Mua MacBook + 2 Chuột
(2, 3, 1),            -- Đơn 2: Mua iPhone
(3, 2, 1), (3, 7, 1), -- Đơn 3: Mua Dell + Phím
(4, 5, 2),            -- Đơn 4: Mua 2 iPad (Đã hủy)
(5, 1, 5);            -- Đơn 5: Mua 5 MacBook (Số lượng lớn nhất)

-- PHẦN 3: GIẢI BÀI TẬP (QUERY)
-- A. Truy vấn cơ bản

-- 1. Lấy danh sách tất cả danh mục
SELECT * FROM categories;

-- 2. Lấy danh sách đơn hàng có trạng thái là COMPLETED
SELECT * FROM orders WHERE status = 'Completed';

-- 3. Lấy danh sách sản phẩm sắp xếp theo giá giảm dần
SELECT * FROM products ORDER BY price DESC;

-- 4. Lấy 5 sản phẩm giá cao nhất, bỏ qua 2 sản phẩm đầu
SELECT * FROM products ORDER BY price DESC LIMIT 5 OFFSET 2;

-- B. Truy vấn nâng cao

-- 1. Lấy danh sách sản phẩm kèm tên danh mục
SELECT p.product_name, p.price, c.category_name
FROM products p
JOIN categories c ON p.category_id = c.category_id;

-- 2. Lấy danh sách đơn hàng chi tiết
SELECT o.order_id, o.order_date, c.customer_name, o.status
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

-- 3. Tính tổng số lượng sản phẩm trong từng đơn hàng
SELECT order_id, SUM(quantity) AS total_items
FROM order_items
GROUP BY order_id;

-- 4. Thống kê số đơn hàng của mỗi khách hàng (kể cả chưa mua)
SELECT c.customer_name, COUNT(o.order_id) AS order_count
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- 5. Lấy danh sách khách hàng có tổng số đơn hàng >= 2
SELECT c.customer_name, COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) >= 2;

-- 6. Thống kê giá TB, Min, Max theo danh mục
SELECT 
    c.category_name, 
    AVG(p.price) AS avg_price, 
    MIN(p.price) AS min_price, 
    MAX(p.price) AS max_price
FROM products p
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_id, c.category_name;
-- C. Truy vấn lồng (Subquery)

-- 1. Sản phẩm có giá cao hơn giá trung bình toàn hệ thống
SELECT * FROM products
WHERE price > (SELECT AVG(price) FROM products);

-- 2. Khách hàng đã từng đặt ít nhất 1 đơn
SELECT * FROM customers
WHERE customer_id IN (SELECT DISTINCT customer_id FROM orders);

-- 3. Đơn hàng có tổng số lượng sản phẩm lớn nhất
SELECT order_id, SUM(quantity) AS total_quantity
FROM order_items
GROUP BY order_id
ORDER BY total_quantity DESC
LIMIT 1;

-- 4. Khách hàng mua sản phẩm thuộc danh mục có giá TB cao nhất
-- (Laptop là danh mục giá cao nhất -> Tìm người mua Laptop)
SELECT DISTINCT c.customer_name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE p.category_id = (
    SELECT category_id 
    FROM products 
    GROUP BY category_id 
    ORDER BY AVG(price) DESC 
    LIMIT 1
);