DROP DATABASE IF EXISTS social_network_pro;

CREATE DATABASE social_network_pro
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE social_network_pro;

CREATE TABLE users (
  user_id INT AUTO_INCREMENT PRIMARY KEY,             -- Mã người dùng (ID), tự động tăng
  username VARCHAR(50) UNIQUE NOT NULL,                -- Tên người dùng, duy nhất và không được rỗng
  full_name VARCHAR(100) NOT NULL,                     -- Họ tên đầy đủ
  gender ENUM('Nam', 'Nữ') NOT NULL DEFAULT 'Nam',    -- Giới tính, mặc định là 'Nam'
  email VARCHAR(100) UNIQUE NOT NULL,                  -- Email, duy nhất và không được rỗng
  password VARCHAR(100) NOT NULL,                      -- Mật khẩu, không được rỗng
  birthdate DATE,                                      -- Ngày sinh
  hometown VARCHAR(100),                               -- Quê quán
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP       -- Thời gian tạo tài khoản, mặc định là thời gian hiện tại
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE posts (
  post_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  content TEXT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT posts_fk_users
    FOREIGN KEY (user_id) REFERENCES users(user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE comments (
  comment_id INT AUTO_INCREMENT PRIMARY KEY,
  post_id INT NOT NULL,
  user_id INT NOT NULL,
  content TEXT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT comments_fk_posts
    FOREIGN KEY (post_id) REFERENCES posts(post_id)
    ON DELETE CASCADE,
  CONSTRAINT comments_fk_users
    FOREIGN KEY (user_id) REFERENCES users(user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE likes (
  post_id INT NOT NULL,
  user_id INT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (post_id, user_id),
  CONSTRAINT likes_fk_posts
    FOREIGN KEY (post_id) REFERENCES posts(post_id)
    ON DELETE CASCADE,
  CONSTRAINT likes_fk_users
    FOREIGN KEY (user_id) REFERENCES users(user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE friends (
  user_id INT NOT NULL,
  friend_id INT NOT NULL,
  status ENUM('pending','accepted','blocked') DEFAULT 'pending',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (user_id, friend_id),
  CONSTRAINT friends_fk_user1 FOREIGN KEY (user_id) REFERENCES users(user_id),
  CONSTRAINT friends_fk_user2 FOREIGN KEY (friend_id) REFERENCES users(user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE messages (
  message_id INT AUTO_INCREMENT PRIMARY KEY,
  sender_id INT NOT NULL,
  receiver_id INT NOT NULL,
  content TEXT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT messages_fk_sender FOREIGN KEY (sender_id) REFERENCES users(user_id),
  CONSTRAINT messages_fk_receiver FOREIGN KEY (receiver_id) REFERENCES users(user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE notifications (
  notification_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  type VARCHAR(50),
  content VARCHAR(255),
  is_read BOOLEAN DEFAULT FALSE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT notifications_fk_users
    FOREIGN KEY (user_id) REFERENCES users(user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX posts_created_at_ix ON posts (created_at DESC);
CREATE INDEX messages_created_at_ix ON messages (created_at DESC);


-- ========= DATA =========

INSERT INTO users(username, full_name, gender, email, password, birthdate, hometown) VALUES
('an', 'Nguyễn Văn An', 'Nam', 'an@gmail.com', '123', '1990-01-01', 'Hà Nội'),
('binh', 'Trần Thị Bình', 'Nữ', 'binh@gmail.com', '123', '1992-02-15', 'TP.HCM'),
('chi', 'Lê Minh Chi', 'Nữ', 'chi@gmail.com', '123', '1991-03-10', 'Đà Nẵng'),
('duy', 'Phạm Quốc Duy', 'Nam', 'duy@gmail.com', '123', '1990-05-20', 'Hải Phòng'),
('ha', 'Vũ Thu Hà', 'Nữ', 'ha@gmail.com', '123', '1994-07-25', 'Hà Nội'),
('hieu', 'Đặng Hữu Hiếu', 'Nam', 'hieu@gmail.com', '123', '1993-11-30', 'TP.HCM'),
('hoa', 'Ngô Mai Hoa', 'Nữ', 'hoa@gmail.com', '123', '1995-04-18', 'Đà Nẵng'),
('khanh', 'Bùi Khánh Linh', 'Nữ', 'khanh@gmail.com', '123', '1992-09-12', 'TP.HCM'),
('lam', 'Hoàng Đức Lâm', 'Nam', 'lam@gmail.com', '123', '1991-10-05', 'Hà Nội'),
('linh', 'Phan Mỹ Linh', 'Nữ', 'linh@gmail.com', '123', '1994-06-22', 'Đà Nẵng'),
('minh', 'Nguyễn Minh', 'Nam', 'minh@gmail.com', '123', '1990-12-01', 'Hà Nội'),
('nam', 'Trần Quốc Nam', 'Nam', 'nam@gmail.com', '123', '1992-02-05', 'TP.HCM'),
('nga', 'Lý Thúy Nga', 'Nữ', 'nga@gmail.com', '123', '1993-08-16', 'Hà Nội'),
('nhan', 'Đỗ Hoàng Nhân', 'Nam', 'nhan@gmail.com', '123', '1991-04-20', 'TP.HCM'),
('phuong', 'Tạ Kim Phương', 'Nữ', 'phuong@gmail.com', '123', '1990-05-14', 'Đà Nẵng'),
('quang', 'Lê Quang', 'Nam', 'quang@gmail.com', '123', '1992-09-25', 'Hà Nội'),
('son', 'Nguyễn Thành Sơn', 'Nam', 'son@gmail.com', '123', '1994-03-19', 'TP.HCM'),
('thao', 'Trần Thảo', 'Nữ', 'thao@gmail.com', '123', '1993-11-07', 'Đà Nẵng'),
('trang', 'Phạm Thu Trang', 'Nữ', 'trang@gmail.com', '123', '1995-06-02', 'Hà Nội'),
('tuan', 'Đinh Minh Tuấn', 'Nam', 'tuan@gmail.com', '123', '1990-07-30', 'TP.HCM');



INSERT INTO posts(user_id, content) VALUES
(1,'Chào mọi người! Hôm nay mình bắt đầu học MySQL.'),
(2,'Ai có tài liệu SQL cơ bản cho người mới không?'),
(3,'Mình đang luyện JOIN, hơi rối nhưng vui.'),
(4,'Thiết kế ERD xong thấy dữ liệu rõ ràng hơn hẳn.'),
(5,'Học chuẩn hoá (normalization) giúp tránh trùng dữ liệu.'),
(6,'Tối ưu truy vấn: nhớ tạo index đúng chỗ.'),
(7,'Mình đang làm mini mạng xã hội bằng MySQL.'),
(8,'Bạn nào biết khác nhau giữa InnoDB và MyISAM không?'),
(9,'Uống cà phê rồi mới code tiếp thôi ☕'),
(10,'Hôm nay học GROUP BY và HAVING.'),
(11,'Subquery khó nhưng dùng quen sẽ “đã”.'),
(12,'Mình vừa tạo VIEW để xem thống kê bài viết.'),
(13,'Trigger dùng để tự tạo thông báo khi có comment.'),
(14,'Transaction quan trọng để tránh lỗi dữ liệu giữa chừng.'),
(15,'ACID là nền tảng của hệ quản trị CSDL.'),
(16,'Mình đang luyện câu truy vấn top bài nhiều like nhất.'),
(17,'Có ai muốn cùng luyện SQL mỗi ngày không?'),
(18,'Tạo bảng có khoá ngoại giúp dữ liệu “sạch” hơn.'),
(19,'Đang tìm cách sinh dữ liệu giả để test hiệu năng.'),
(20,'Backup database thường xuyên nhé mọi người!'),
(1,'Bài 2: hôm nay mình luyện insert dữ liệu tiếng Việt.'),
(2,'Lưu tiếng Việt nhớ dùng utf8mb4.'),
(3,'Đừng quên kiểm tra collation nữa.'),
(4,'Query phức tạp thì chia nhỏ ra debug dễ hơn.'),
(5,'Viết query xong nhớ EXPLAIN để xem plan.'),
(6,'Index nhiều quá cũng không tốt, phải cân bằng.'),
(7,'Mình thêm chức năng kết bạn: pending/accepted.'),
(8,'Nhắn tin (messages) cũng là quan hệ 2 user.'),
(9,'Notification giúp mô phỏng giống Facebook.'),
(10,'Cuối tuần mình tổng hợp 50 bài tập SQL.');

INSERT INTO comments(post_id, user_id, content) VALUES
(1,2,'Ủng hộ bạn! Cố lên nhé.'),
(1,3,'Hay đó, mình cũng đang học.'),
(2,4,'Mình có tài liệu, bạn cần phần nào?'),
(2,5,'Bạn tìm “SQL basics + MySQL” là ra nhiều lắm.'),
(3,6,'JOIN đầu khó, sau quen sẽ dễ.'),
(3,7,'Bạn thử vẽ bảng ra giấy cho dễ hình dung.'),
(4,8,'ERD đúng là cứu cánh.'),
(5,9,'Chuẩn hoá giúp giảm lỗi cập nhật dữ liệu.'),
(6,10,'Index đặt đúng cột hay lọc/ join là ổn.'),
(7,11,'Mini mạng xã hội nghe thú vị đấy!'),
(8,12,'InnoDB hỗ trợ transaction và FK tốt hơn.'),
(9,13,'Cà phê là chân ái ☕'),
(10,14,'GROUP BY nhớ cẩn thận HAVING nhé.'),
(11,15,'Subquery dùng vừa đủ thôi kẻo chậm.'),
(12,16,'VIEW tiện để tái sử dụng truy vấn.'),
(13,17,'Trigger nhớ tránh loop vô hạn.'),
(14,18,'Transaction giúp rollback khi lỗi.'),
(15,19,'ACID rất quan trọng cho dữ liệu tiền bạc.'),
(16,20,'Top bài nhiều like: GROUP BY + ORDER BY.'),
(20,2,'Backup xong nhớ test restore nữa.'),
(21,3,'Tiếng Việt ok khi dùng utf8mb4.'),
(22,4,'Chuẩn rồi, mình từng bị lỗi mất dấu.'),
(23,5,'Collation ảnh hưởng sắp xếp và so sánh.'),
(24,6,'Chia nhỏ query là cách debug tốt.'),
(25,7,'EXPLAIN giúp hiểu vì sao query chậm.'),
(26,8,'Index dư thừa sẽ làm insert/update chậm.'),
(27,9,'Pending/accepted giống Facebook đó.'),
(28,10,'Messages thì nên index theo created_at.'),
(29,11,'Notification nhìn “pro” hẳn.'),
(30,12,'50 bài tập SQL nghe hấp dẫn!'),
(2,13,'Bạn thử dùng sách Murach cũng ổn.'),
(3,14,'JOIN nhiều bảng thì đặt alias cho gọn.'),
(4,15,'Ràng buộc FK giúp tránh dữ liệu mồ côi.'),
(5,16,'Bạn nhớ thêm UNIQUE cho like (post_id,user_id).'),
(6,17,'Đúng rồi, mình cũng làm vậy.'),
(7,18,'Khi cần hiệu năng, cân nhắc denormalize một chút.'),
(8,19,'MySQL 8 có nhiều cải tiến optimizer.'),
(9,20,'Chúc bạn học tốt!');

INSERT INTO likes(post_id, user_id) VALUES
(1,2),(1,3),(1,4),
(2,1),(2,5),(2,6),
(3,7),(3,8),
(4,9),(4,10),
(5,11),(5,12),
(6,13),(6,14),
(7,15),(7,16),
(8,17),(8,18),
(9,19),(9,20),
(10,2),(11,3),(12,4),(13,5),(14,6);

INSERT INTO friends(user_id, friend_id, status) VALUES
(1,2,'accepted'),
(1,3,'accepted'),
(2,4,'accepted'),
(3,5,'pending'),
(4,6,'accepted'),
(5,7,'blocked'),
(6,8,'accepted'),
(7,9,'accepted'),
(8,10,'accepted'),
(9,11,'pending');

INSERT INTO messages(sender_id, receiver_id, content) VALUES
(1,2,'Chào Bình, hôm nay bạn học tới đâu rồi?'),
(2,1,'Mình đang luyện JOIN, hơi chóng mặt 😅'),
(3,4,'Duy ơi, share mình tài liệu MySQL 8 nhé.'),
(4,3,'Ok Chi, để mình gửi link sau.'),
(5,6,'Hiếu ơi, tối nay học transaction không?'),
(6,5,'Ok Hà, 8h nhé!');

INSERT INTO notifications(user_id, type, content) VALUES
(1,'like','Bình đã thích bài viết của bạn.'),
(1,'comment','Chi đã bình luận bài viết của bạn.'),
(2,'friend','An đã gửi lời mời kết bạn.'),
(3,'message','Bạn có tin nhắn mới từ Duy.'),
(4,'like','Hà đã thích bài viết của bạn.'),
(5,'comment','Hiếu đã bình luận bài viết của bạn.'),
(6,'friend','Hoa đã chấp nhận lời mời kết bạn.');

create or replace view view_user_firstname as select user_id ,  username,full_name,email,created_at
from users 
where full_name like "Nguyễn%";
select * from view_user_firstname;
insert into users(username, full_name, gender, email, password, birthdate, hometown)
values ('nguyen_new', 'Nguyễn Văn Mới', 'Nam', 'nguyen_new@gmail.com', '123', '1999-01-01', 'Hà Nội');
select * from view_user_firstname;
delete from users
where username = 'nguyen_new';
select * from view_user_firstname;