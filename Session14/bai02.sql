drop database session14_ex2;

CREATE database session14_ex2;

use session14_ex2;

CREATE table users(
	user_id int primary key auto_increment,
    username varchar(50) not null,
    posts_count int default 0
);

CREATE table posts(
	post_id int primary key auto_increment,
    user_id int not null,
    content text not null,
    created_at datetime default current_timestamp,
    likes_count int default 0,
    foreign key(user_id) references users(user_id)
);

CREATE table likes(
	like_id int primary key auto_increment,
    post_id int not null,
    user_id int not null,
    foreign key(post_id) references posts(post_id),
    foreign key(user_id) references users(user_id),
    unique key unique_like (post_id, user_id)
);

insert into users (username) values 
('nguyenvana'),
('tran_thi_b'),
('le_van_c'),
('pham_dang_d'),
('hoang_thi_e'),
('minh_tuan_99');

-- Bài 1
Delimiter //
CREATE procedure add_posts(in p_user_id int, in p_content text)
begin
	declare exit handler for sqlexception 
	begin
		rollback;
		select 'Đã có lỗi xảy ra, hệ thống đã khôi phục dữ liệu' as ErrorMessage;
	end;
	start transaction;
    if not exists (select 1 from users where user_id = p_user_id) then
		rollback;
        select 'User ID không tồn tại!' as errormessage;
	end if;
	INSERT INTO posts(user_id, content) values(p_user_id, p_content);
	UPDATE users set posts_count = posts_count + 1 where user_id = p_user_id;
    
    commit;
end//

call add_posts(1, 'Học CSDL');
call add_posts(20, 'Học CSDL');
select * from posts;
select * from users;

-- Bài 2
DELIMITER //
CREATE PROCEDURE sp_like_post(IN p_user_id INT, IN p_post_id INT)
BEGIN
    declare exit handler for sqlexception
    BEGIN
        ROLLBACK;
        SELECT 'Bài viết đã được like' AS Message;
    END;

    start transaction;
    INSERT INTO likes (post_id, user_id) 
    VALUES (p_post_id, p_user_id);
    UPDATE posts 
    SET likes_count = likes_count + 1 
    WHERE post_id = p_post_id;
    COMMIT;
    SELECT 'Like bài viết thành công!' AS Message;

END //
DELIMITER ;
CALL add_posts(1, 'Chào buổi chiều'); 
CALL sp_like_post(1, 1); 
SELECT * FROM likes;
SELECT post_id, content, likes_count FROM posts;
CALL sp_like_post(1, 1); 