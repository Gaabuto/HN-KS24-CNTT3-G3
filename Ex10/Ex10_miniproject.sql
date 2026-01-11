-- ==============================
-- DATABASE: Social Network Mini Project
-- TOPIC: VIEW & INDEX (MySQL)
-- ==============================

DROP DATABASE IF EXISTS social_network;
CREATE DATABASE social_network;
USE social_network;

-- ==============================
-- 1. TABLE: users
-- ==============================
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ==============================
-- 2. TABLE: posts
-- ==============================
CREATE TABLE posts (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    content TEXT,
    privacy ENUM('PUBLIC', 'FRIEND', 'PRIVATE') DEFAULT 'PUBLIC',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- ==============================
-- 3. TABLE: comments
-- ==============================
CREATE TABLE comments (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    content TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(post_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- ==============================
-- 4. TABLE: likes
-- ==============================
CREATE TABLE likes (
    like_id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(post_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- ==============================
-- INSERT SAMPLE DATA
-- ==============================

-- Users
INSERT INTO users (username, email, phone) VALUES
('alice', 'alice@gmail.com', '0901111111'),
('bob', 'bob@gmail.com', '0902222222'),
('charlie', 'charlie@gmail.com', '0903333333'),
('david', 'david@gmail.com', '0904444444');

-- Posts
INSERT INTO posts (user_id, content, privacy, created_at) VALUES
(1, 'Hello world from Alice', 'PUBLIC', '2024-01-10'),
(2, 'Bob private post', 'PRIVATE', '2024-02-01'),
(3, 'Charlie public sharing', 'PUBLIC', '2024-03-05'),
(1, 'Alice friend-only post', 'FRIEND', '2024-03-20'),
(4, 'David public post', 'PUBLIC', '2024-04-01');

-- Comments
INSERT INTO comments (post_id, user_id, content) VALUES
(1, 2, 'Nice post!'),
(1, 3, 'Welcome Alice'),
(3, 1, 'Good content'),
(5, 2, 'Great post David');

-- Likes
INSERT INTO likes (post_id, user_id) VALUES
(1, 2),
(1, 3),
(3, 1),
(3, 2),
(5, 1),
(5, 3);

-- ==============================
-- END OF FILE
-- ==============================

-- Phần A:
-- Câu 1: View hồ sơ người dùng công khai (Public User Profile)
-- Mục đích: Ẩn thông tin nhạy cảm (phone)
CREATE OR REPLACE VIEW view_public_profiles AS
SELECT username, email, created_at
FROM users;

-- Kiểm tra:
SELECT * FROM view_public_profiles;


-- Câu 2: View News Feed bài viết công khai
CREATE OR REPLACE VIEW view_public_news_feed AS
SELECT u.username AS author,p.content,p.created_at,COUNT(l.like_id) AS total_likes
FROM posts p
JOIN users u ON p.user_id = u.user_id
LEFT JOIN likes l ON p.post_id = l.post_id
WHERE p.privacy = 'PUBLIC'
GROUP BY p.post_id, u.username, p.content, p.created_at;
SELECT * FROM view_public_news_feed;


-- Câu 3: View có WITH CHECK OPTION
-- Mục đích: Đảm bảo tính toàn vẹn dữ liệu khi thao tác qua View
CREATE OR REPLACE VIEW view_strictly_public_posts AS
SELECT * FROM posts
WHERE privacy = 'PUBLIC'
WITH CHECK OPTION;

-- Kiểm tra thao tác không hợp lệ (Sẽ báo lỗi):
-- INSERT INTO view_strictly_public_posts (user_id, content, privacy) 
-- VALUES (1, 'Test private post via view', 'PRIVATE');


-- Phần B:
-- Câu 4. Phân tích truy vấn News Feed
-- Chạy câu lệnh phân tích
EXPLAIN SELECT *
FROM posts
WHERE privacy = 'PUBLIC'
ORDER BY created_at DESC;

-- Câu 5. Tạo INDEX tối ưu
-- 1. Index cho News Feed (Kết hợp lọc privacy và sắp xếp created_at)
CREATE INDEX idx_privacy_createdat ON posts(privacy, created_at);

-- 2. Index cho việc truy vấn bài viết theo người dùng
CREATE INDEX idx_user_id ON posts(user_id);

-- Kiểm tra lại sau khi tạo Index:
EXPLAIN SELECT *
FROM posts
WHERE privacy = 'PUBLIC'
ORDER BY created_at DESC;

/*
Câu 6. Phân tích hạn chế của INDEX
Khi nào không nên tạo index?
Bảng quá nhỏ (dữ liệu ít thì quét toàn bộ bảng nhanh hơn).
Cột có độ chọn lọc thấp (ví dụ: giới tính Nam/Nữ, giá trị trùng lặp quá nhiều).
Bảng thường xuyên phải ghi (Insert/Update) liên tục với số lượng cực lớn.
Vì sao không nên index cột nội dung bài viết?
Cột nội dung (TEXT) có kích thước rất lớn. Index trên toàn bộ nội dung sẽ làm file index phình to, lãng phí bộ nhớ và làm chậm quá trình ghi. Nếu muốn tìm kiếm văn bản, nên dùng Full-Text Search thay vì B-Tree Index thông thường.
Index ảnh hưởng thế nào đến INSERT / UPDATE?
Làm chậm quá trình ghi dữ liệu. Bởi vì mỗi khi thêm hoặc sửa một bản ghi, hệ điều hành CSDL phải cập nhật lại cấu trúc cây của các Index tương ứng.
*/