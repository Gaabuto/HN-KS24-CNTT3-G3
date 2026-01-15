-- 1. Tạo bảng Users (Người dùng)
create database btthss13;
use btthss13;
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


delimiter //
create Procedure  sp_create_post(id_in int ,content_in text)
begin
start transaction;
set autocommit = 0;

select user_id into @check_user from users where user_id = id_in;
if (   @check_user is null or @check_user = '') then
        signal sqlstate '45000'
        set message_text = 'id khong ton tai';
        rollback;
end if;

if
trim(content_in) = '' or content_in is null
then
        signal sqlstate '45000'
        set message_text = 'context khong the rong';
        rollback;
else

		insert into posts(user_id, content)
		values (id_in, content_in);

		update users
        set total_posts = total_posts + 1
        where user_id = id_in;
        commit;
end if;
end //
delimiter ;

call sp_create_post(1,'hom nay troi dep qua');

call sp_create_post(9999,'caonimanicao');

-- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`btthss13`.`posts`, CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`))
