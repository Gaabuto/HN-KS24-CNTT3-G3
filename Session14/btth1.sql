drop database btth_session14;

CREATE database btth_session14;
use btth_session14;

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    total_posts INT DEFAULT 0
);
 
-- 2. Tạo bảng Posts (Bài viết)
CREATE TABLE posts (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    content TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- 3. Tạo dữ liệu mẫu
INSERT INTO users (username, total_posts) VALUES ('nguyen_van_a', 0);
INSERT INTO users (username, total_posts) VALUES ('le_thi_b', 0);

-- Task 1
Delimiter //
CREATE procedure sp_create_post(in p_user_id int, in p_content text)
begin
	declare exit handler for sqlexception 
	begin
		rollback;
		select 'Đã có lỗi xảy ra, hệ thống đã khôi phục dữ liệu' as ErrorMessage;
	end;
    
	if not exists (select 1 from users where user_id = p_user_id) then
        signal sqlstate '45000'
		set message_text = 'không có thông tin người dùng này';
    end if;

	if trim(p_content) = '' or p_content is null then
        signal sqlstate '45000'
		set message_text = 'Nội dung không được phép rỗng/null';
    end if;
    
	if p_content is null OR TRIM(p_content) = '' then signal sqlstate '45000' set message_text = 'Nội dung không được trống';
    end if;
    start transaction;
    INSERT INTO posts(user_id, content) values(p_user_id, p_content);
    UPDATE users set total_posts = total_posts + 1 where user_id = p_user_id;
end //

drop procedure sp_create_post;

call sp_create_post(1,'Học CSDL');
select * from users;
select * from posts;

call sp_create_post(3,'Bài viết của user không tồn tại ');

call sp_create_post(1,'Đầu tư vào HDPE là ngon luôn');