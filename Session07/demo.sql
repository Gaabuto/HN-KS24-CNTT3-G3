/* ==========================================
   FILE: ecommerce_subquery_project.sql
   CHỦ ĐỀ: THƯƠNG MẠI ĐIỆN TỬ + SUBQUERY
   ========================================== */

-- 1. Tạo Database
CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;

-- 2. Xóa bảng nếu tồn tại
DROP TABLE IF EXISTS CHI_TIET_DON_HANG;
DROP TABLE IF EXISTS DON_HANG;
DROP TABLE IF EXISTS SAN_PHAM;
DROP TABLE IF EXISTS KHACH_HANG;

-- 3. Bảng KHACH_HANG
CREATE TABLE KHACH_HANG (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);

-- 4. Bảng SAN_PHAM
CREATE TABLE SAN_PHAM (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(12,2)
);

-- 5. Bảng DON_HANG
CREATE TABLE DON_HANG (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES KHACH_HANG(customer_id)
);

-- 6. Bảng CHI_TIET_DON_HANG
CREATE TABLE CHI_TIET_DON_HANG (
    order_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES DON_HANG(order_id),
    FOREIGN KEY (product_id) REFERENCES SAN_PHAM(product_id)
);

-- 7. Dữ liệu KHACH_HANG
INSERT INTO KHACH_HANG VALUES
(1, 'Nguyen Van A', 'Ha Noi'),
(2, 'Tran Thi B', 'Da Nang'),
(3, 'Le Van C', 'HCM'),
(4, 'Pham Thi D', 'Ha Noi'),
(5, 'Hoang Van E', 'Can Tho');

-- 8. Dữ liệu SAN_PHAM
INSERT INTO SAN_PHAM VALUES
(101, 'Laptop Dell', 'Electronics', 20000000),
(102, 'iPhone 14', 'Electronics', 25000000),
(103, 'Tai nghe Bluetooth', 'Accessories', 1500000),
(104, 'Ban phim co', 'Accessories', 2000000),
(105, 'Man hinh 27 inch', 'Electronics', 7000000),
(106, 'Chuot khong day', 'Accessories', 800000);

-- 9. Dữ liệu DON_HANG
INSERT INTO DON_HANG VALUES
(1001, 1, '2024-01-10'),
(1002, 2, '2024-01-12'),
(1003, 1, '2024-01-15'),
(1004, 3, '2024-01-18'),
(1005, 4, '2024-01-20'),
(1006, 5, '2024-01-22');

-- 10. Dữ liệu CHI_TIET_DON_HANG
INSERT INTO CHI_TIET_DON_HANG VALUES
(1001, 101, 1),
(1001, 103, 2),
(1002, 102, 1),
(1003, 104, 1),
(1003, 103, 1),
(1004, 101, 1),
(1004, 106, 2),
(1005, 105, 1),
(1006, 103, 3),
(1006, 106, 1);

/* ============================
   PHẦN TRUY VẤN SUBQUERY
   ============================ */

-- 1. Khách hàng đã mua hàng
SELECT *
FROM KHACH_HANG
WHERE customer_id IN (
    SELECT DISTINCT customer_id
    FROM DON_HANG
);

-- 2. Khách hàng chưa mua hàng
SELECT *
FROM KHACH_HANG
WHERE customer_id NOT IN (
    SELECT DISTINCT customer_id
    FROM DON_HANG
);

-- 3. Sản phẩm chưa từng bán
SELECT *
FROM SAN_PHAM
WHERE product_id NOT IN (
    SELECT DISTINCT product_id
    FROM CHI_TIET_DON_HANG
);

-- 4. Sản phẩm giá cao hơn trung bình
SELECT *
FROM SAN_PHAM
WHERE price > (
    SELECT AVG(price)
    FROM SAN_PHAM
);

-- 5. Đơn hàng có tổng số lượng > 2
SELECT *
FROM DON_HANG
WHERE order_id IN (
    SELECT order_id
    FROM CHI_TIET_DON_HANG
    GROUP BY order_id
    HAVING SUM(quantity) > 2
);
-- 6. Khách hàng có nhiều hơn 1 đơn hàng
SELECT *
FROM KHACH_HANG
WHERE customer_id IN (
    SELECT customer_id
    FROM DON_HANG
    GROUP BY customer_id
    HAVING COUNT(order_id) > 1
);
-- 7. Đơn hàng có tổng tiền cao nhất
SELECT order_id
FROM (
    SELECT 
        c.order_id,
        SUM(c.quantity * s.price) AS total_amount
    FROM CHI_TIET_DON_HANG c
    JOIN SAN_PHAM s ON c.product_id = s.product_id
    GROUP BY c.order_id
) t
WHERE total_amount = (
    SELECT MAX(total_amount)
    FROM (
        SELECT 
            c.order_id,
            SUM(c.quantity * s.price) AS total_amount
        FROM CHI_TIET_DON_HANG c
        JOIN SAN_PHAM s ON c.product_id = s.product_id
        GROUP BY c.order_id
    ) x
);

-- 8. Khách hàng chi tiêu nhiều nhất
SELECT *
FROM KHACH_HANG
WHERE customer_id = (
    SELECT customer_id
    FROM (
        SELECT 
            d.customer_id,
            SUM(c.quantity * s.price) AS total_spent
        FROM DON_HANG d
        JOIN CHI_TIET_DON_HANG c ON d.order_id = c.order_id
        JOIN SAN_PHAM s ON c.product_id = s.product_id
        GROUP BY d.customer_id
        ORDER BY total_spent DESC
        LIMIT 1
    ) t
);

-- 9. Sản phẩm bán chạy nhất
SELECT *
FROM SAN_PHAM
WHERE product_id = (
    SELECT product_id
    FROM CHI_TIET_DON_HANG
    GROUP BY product_id
    ORDER BY SUM(quantity) DESC
    LIMIT 1
);

-- 10. Khách hàng ở Hà Nội có đơn hàng
SELECT *
FROM KHACH_HANG
WHERE city = 'Ha Noi'
AND customer_id IN (
    SELECT customer_id
    FROM DON_HANG
);

/* ============================
   KẾT THÚC FILE
   ============================ */
