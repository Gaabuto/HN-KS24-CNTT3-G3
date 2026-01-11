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

/*
Câu 1. View hồ sơ người dùng công khai 
Tạo một VIEW hiển thị thông tin người dùng dùng cho trang xem hồ sơ, gồm: 
● Tên người dùng 
● Email 
● Ngày tạo tài khoản 
Không hiển thị số điện thoại.
*/

create view vw_users_info
as
select username, email, created_at
from users;

/*
Câu 2. View News Feed bài viết công khai 
Tạo một VIEW hiển thị danh sách bài viết công khai, gồm: 
● Tên người đăng 
● Nội dung bài viết 
● Ngày đăng 
● Số lượt thích 
Chỉ hiển thị các bài viết có privacy = 'PUBLIC'. 
*/
create view vw_users_info_public
as
select u.username, p.content, p.created_at, count(l.post_id) as 'So luot thich'
from posts as p join users as u on p.user_id = u.user_id
					left join likes as l on p.post_id = l.post_id
where p.privacy = 'PUBLIC'
group by u.username, p.content, p.created_at;

/*
Câu 3. View có CHECK OPTION 
Tạo một VIEW cho phép: 
● Hiển thị các bài viết công khai 
● Chỉ cho phép INSERT / UPDATE dữ liệu thỏa điều kiện privacy = 'PUBLIC' 
Kiểm tra bằng cách thử thao tác dữ liệu không hợp lệ. 
*/
create view vw_post_public
as
select user_id, content, privacy, created_at
from posts 
where privacy = 'PUBLIC'
with check option;

insert into vw_post_public (user_id, content, privacy, created_at) 
values (2, 'Bài viết riêng tư', 'PRIVATE', '2024-04-06'); -- Không hợp lệ;

insert into vw_post_public (user_id, content, privacy, created_at) 
values (3, 'Bài viết riêng tư', 'PUBLIC', '2024-04-08'); -- Hợp lệ;

/*
Câu 4. Phân tích truy vấn News Feed Cho truy vấn:

SELECT * 
FROM posts
WHERE privacy = 'PUBLIC'
ORDER BY created_at DESC;

Yêu cầu:

Sử dụng EXPLAIN
Nhận xét về hiệu năng truy vấn
*/

explain select * 

FROM posts

WHERE privacy = 'PUBLIC'

ORDER BY created_at DESC; -- có type = all nên mysql phải quét toàn bộ bảng khiến cho tốc độ chậm

/*
Câu 5. Tạo INDEX tối ưu
Tạo các index phù hợp để:

Tăng tốc truy vấn hiển thị news feed
Tăng tốc truy vấn lấy bài viết theo người dùng
So sánh kết quả EXPLAIN trước và sau khi tạo index.
*/
create index idx_newfeed on post(user_id);

select content
from posts
where user_id = 1;
/*
Câu 6. Phân tích hạn chế của INDEX
Trả lời ngắn gọn:

Khi nào không nên tạo index? Trả lời: Khi bảng có ít dữ liệu, dữ liệu trong cột thường xuyên thay đổi
Vì sao không nên index cột nội dung bài viết? Trả lời: Vì nội dung bài viêt thường rất dài index trên bột này sẽ tốn rất nhiều bộ nhớ mà lại không hiệu quả
Index ảnh hưởng thế nào đến thao tác INSERT / UPDATE? Trả lời: Index làm cho thao tác INSERT / UPDATE chậm hơn
*/
