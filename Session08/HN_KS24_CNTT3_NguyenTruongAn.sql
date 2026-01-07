CREATE DATABASE mini_project_ss08;
USE mini_project_ss08;

-- Xóa bảng nếu đã tồn tại (để chạy lại nhiều lần)
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS guests;

-- Bảng khách hàng
CREATE TABLE guests (
    guest_id INT PRIMARY KEY AUTO_INCREMENT,
    guest_name VARCHAR(100),
    phone VARCHAR(20)
);

-- Bảng phòng
CREATE TABLE rooms (
    room_id INT PRIMARY KEY AUTO_INCREMENT,
    room_type VARCHAR(50),
    price_per_day DECIMAL(10,0)
);

-- Bảng đặt phòng
CREATE TABLE bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    guest_id INT,
    room_id INT,
    check_in DATE,
    check_out DATE,
    FOREIGN KEY (guest_id) REFERENCES guests(guest_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);

INSERT INTO guests (guest_name, phone) VALUES
('Nguyễn Văn An', '0901111111'),
('Trần Thị Bình', '0902222222'),
('Lê Văn Cường', '0903333333'),
('Phạm Thị Dung', '0904444444'),
('Hoàng Văn Em', '0905555555');

INSERT INTO rooms (room_type, price_per_day) VALUES
('Standard', 500000),
('Standard', 500000),
('Deluxe', 800000),
('Deluxe', 800000),
('VIP', 1500000),
('VIP', 2000000);

INSERT INTO bookings (guest_id, room_id, check_in, check_out) VALUES
(1, 1, '2024-01-10', '2024-01-12'), -- 2 ngày
(1, 3, '2024-03-05', '2024-03-10'), -- 5 ngày
(2, 2, '2024-02-01', '2024-02-03'), -- 2 ngày
(2, 5, '2024-04-15', '2024-04-18'), -- 3 ngày
(3, 4, '2023-12-20', '2023-12-25'), -- 5 ngày
(3, 6, '2024-05-01', '2024-05-06'), -- 5 ngày
(4, 1, '2024-06-10', '2024-06-11'); -- 1 ngày
-- PHẦN I – TRUY VẤN DỮ LIỆU CƠ BẢN
-- 1. Liệt kê tên khách và số điện thoại của tất cả khách hàng
SELECT guest_name, phone
FROM guests;
-- 2. Liệt kê các loại phòng khác nhau trong khách sạn
SELECT room_type
FROM rooms
GROUP BY room_type;
-- 3. Hiển thị loại phòng và giá thuê theo ngày, sắp xếp theo giá tăng dần
SELECT room_type, price_per_day
FROM rooms
ORDER BY price_per_day ASC;
-- 4. Hiển thị các phòng có giá thuê lớn hơn 1.000.000
SELECT *
FROM rooms
WHERE price_per_day > 1000000;
-- 5. Liệt kê các lần đặt phòng diễn ra trong năm 2024
SELECT *
FROM bookings
WHERE YEAR(check_in) = 2024;
-- 6. Cho biết số lượng phòng của từng loại phòng
SELECT room_type, COUNT(*) AS 'so_phong'
FROM rooms
GROUP BY room_type;
-- PHẦN II – TRUY VẤN NÂNG CAO
-- 7. Danh sách các lần đặt phòng (tên khách – loại phòng – ngày nhận)
SELECT g.guest_name, r.room_type, b.check_in
FROM bookings b JOIN guests g ON b.guest_id = g.guest_id
				JOIN rooms r ON b.room_id = r.room_id;
-- 8. Cho biết mỗi khách đã đặt phòng bao nhiêu lần
SELECT g.guest_name, COUNT(b.booking_id) AS 'dat_bao_nhieu_phong'
FROM guests g LEFT JOIN bookings b ON g.guest_id = b.guest_id
GROUP BY g.guest_id, g.guest_name; 
-- 9. Tính doanh thu của mỗi phòng, với công thức: “Doanh thu = số ngày ở × giá thuê theo ngày”
SELECT 
    r.room_id,
    r.room_type,
    SUM((b.check_out - b.check_in) * r.price_per_day) AS 'doanh_thu'
FROM rooms r JOIN bookings b ON r.room_id = b.room_id
GROUP BY r.room_id, r.room_type;
-- 10. Hiển thị tổng doanh thu của từng loại phòng
SELECT 
    r.room_type,
    SUM((b.check_out - b.check_in) * r.price_per_day) AS 'tong_doanh_thu'
FROM rooms r JOIN bookings b ON r.room_id = b.room_id
GROUP BY r.room_type;
-- 11. Tìm những khách đã đặt phòng từ 2 lần trở lên
SELECT g.guest_name, COUNT(b.booking_id) AS 'so_lan_dat'
FROM guests g JOIN bookings b ON g.guest_id = b.guest_id
GROUP BY g.guest_id, g.guest_name
HAVING COUNT(b.booking_id) >= 2;
-- 12. Tìm loại phòng có số lượt đặt phòng nhiều nhất
-- PHẦN III – TRUY VẤN LỒNG
-- 13. Hiển thị những phòng có giá thuê cao hơn giá trung bình
SELECT *
FROM rooms
WHERE price_per_day > (
    SELECT AVG(price_per_day)
    FROM rooms
);
-- 14. Hiển thị những khách chưa từng đặt phòng
SELECT *
FROM guests
WHERE guest_id NOT IN (
    SELECT guest_id
    FROM bookings
);
-- 15. Tìm phòng được đặt nhiều lần nhất
