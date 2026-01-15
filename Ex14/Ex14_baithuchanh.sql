CREATE DATABASE Ex14_thuchanh;
USE Ex14_thuchanh;

-- 1. Tạo bảng Users
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    total_posts INT DEFAULT 0
);

-- 2. Tạo bảng Posts
CREATE TABLE posts (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    content TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- 3. Thêm dữ liệu mẫu
INSERT INTO users (username, total_posts) VALUES ('nguyen_van_a', 0);
INSERT INTO users (username, total_posts) VALUES ('le_thi_b', 0);


DELIMITER //
CREATE PROCEDURE sp_create_post(
    IN p_user_id INT,
    IN p_content TEXT
)
BEGIN
-- Nếu gặp lỗi thì> Rollback
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Giao dịch thất bại!' ;
    END;
-- test1: Kiểm tra người dùng có tồn tại không?
    IF NOT EXISTS (SELECT 1 FROM users WHERE user_id = p_user_id) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Người dùng không tồn tại!';
-- test2: Kiểm tra nội dung có rỗng không?
    ELSEIF p_content IS NULL OR trim(p_content) = '' THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Nội dung bài viết không được để trống!';
    ELSE
        START TRANSACTION;
-- Bước 1: Insert bài viết mới
        INSERT INTO posts (user_id, content) VALUES (p_user_id, p_content);
-- Bước 2: Update số lượng bài viết
        UPDATE users SET total_posts = total_posts + 1 WHERE user_id = p_user_id;
        COMMIT;
        SELECT 'Đã cập nhật lại.';
    END IF;
END //
DELIMITER ;

-- Case 1: Thành công 
CALL sp_create_post(1, 'Bạn tuyết vời lắm CAMONVIDADEN!!!');

-- Case 2: Lỗi User không tồn tại
CALL sp_create_post(999, 'Làm gì có thằng DADEN này ní!!!');

-- Case 3: Lỗi Nội dung rỗng
CALL sp_create_post(1, '');

-- 4. xem kết quả
SELECT * FROM users; -- User 1 phải có total_posts = 1
SELECT * FROM posts; -- Phải có 1 bài viết của User 1