-- ==========================================================
-- 1. SETUP: TẠO DATABASE VÀ HỆ THỐNG BẢNG
-- ==========================================================
CREATE DATABASE IF NOT EXISTS SocialNetworkDB;
USE SocialNetworkDB;

-- Xóa bảng cũ nếu đã tồn tại để làm mới
DROP TABLE IF EXISTS post_audits;
DROP TABLE IF EXISTS posts;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    total_posts INT DEFAULT 0
);

CREATE TABLE posts (
    post_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    content TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE post_audits (
    audit_id INT PRIMARY KEY AUTO_INCREMENT,
    post_id INT,
    old_content TEXT,
    new_content TEXT,
    changed_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ==========================================================
-- 2. TẠO CÁC TRIGGER (TASKS)
-- ==========================================================
DELIMITER //

-- Task 1: Ngăn chặn nội dung trống (BEFORE INSERT)
CREATE TRIGGER tg_CheckPostContent
BEFORE INSERT ON posts
FOR EACH ROW
BEGIN
    IF TRIM(NEW.content) = '' OR NEW.content IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Nội dung bài viết không được để trống!';
    END IF;
END //

-- Task 2: Tăng total_posts (AFTER INSERT)
CREATE TRIGGER tg_UpdatePostCountAfterInsert
AFTER INSERT ON posts
FOR EACH ROW
BEGIN
    UPDATE users 
    SET total_posts = total_posts + 1 
    WHERE user_id = NEW.user_id;
END //

-- Task 3: Lưu nhật ký chỉnh sửa (AFTER UPDATE)
CREATE TRIGGER tg_LogPostChanges
AFTER UPDATE ON posts
FOR EACH ROW
BEGIN
    IF OLD.content <> NEW.content THEN
        INSERT INTO post_audits (post_id, old_content, new_content, changed_at)
        VALUES (OLD.post_id, OLD.content, NEW.content, NOW());
    END IF;
END //

-- Task 4: Giảm total_posts (AFTER DELETE)
CREATE TRIGGER tg_UpdatePostCountAfterDelete
AFTER DELETE ON posts
FOR EACH ROW
BEGIN
    UPDATE users 
    SET total_posts = total_posts - 1 
    WHERE user_id = OLD.user_id;
END //

DELIMITER ;
-- ==========================================================
-- 3. KIỂM TRA (TESTING)
-- ==========================================================

-- A. Tạo người dùng Nguyễn Văn A
INSERT INTO users (username) VALUES ('Nguyễn Văn A');

-- B. Chèn bài viết hợp lệ -> Kiểm tra total_posts (Kỳ vọng: 1)
INSERT INTO posts (user_id, content) VALUES (1, 'Chào cả nhà, mình là thành viên mới!');
SELECT 'Sau Insert' as Step, username, total_posts FROM users WHERE user_id = 1;

-- C. Chèn bài viết TRỐNG -> Kiểm tra báo lỗi (Bỏ comment dòng dưới để test lỗi)
-- INSERT INTO posts (user_id, content) VALUES (1, '   '); 

-- D. Chỉnh sửa bài viết -> Kiểm tra post_audits
UPDATE posts SET content = 'Nội dung đã được chỉnh sửa bởi Văn A' WHERE post_id = 1;
SELECT * FROM post_audits;

-- E. Xóa bài viết -> Kiểm tra total_posts (Kỳ vọng: 0)
DELETE FROM posts WHERE post_id = 1;
SELECT 'Sau Delete' as Step, username, total_posts FROM users WHERE user_id = 1;

-- ==========================================================
-- 4. DỌN DẸP (CLEANUP - CHỈ DÙNG KHI MUỐN XÓA TRIGGER)
-- ==========================================================
-- DROP TRIGGER IF EXISTS tg_CheckPostContent;
-- DROP TRIGGER IF EXISTS tg_UpdatePostCountAfterInsert;
-- DROP TRIGGER IF EXISTS tg_LogPostChanges;
-- DROP TRIGGER IF EXISTS tg_UpdatePostCountAfterDelete;