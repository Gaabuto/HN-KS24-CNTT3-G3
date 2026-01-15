@ -0,0 +1,304 @@
drop database session14_ex6;

CREATE database session14_ex6;

use session14_ex6;

CREATE table users(
	user_id int primary key auto_increment,
    username varchar(50) not null,
    posts_count int default 0,
    following_count INT DEFAULT 0,
    followers_count INT DEFAULT 0,
    friends_count int default 0
);

CREATE table posts(
	post_id int primary key auto_increment,
    user_id int not null,
    content text not null,
    created_at datetime default current_timestamp,
    likes_count int default 0,
    comments_count int default 0,
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

CREATE table follows(
	follower_id int not null,
    followed_id int not null,
	primary key(follower_id, followed_id)
);

CREATE table comments(
	comment_id int primary key auto_increment,
    post_id int not null,
    user_id int not null,
    content text not null,
    created_at datetime default current_timestamp,
    foreign key(post_id) references posts(post_id),
    foreign key(user_id) references users(user_id)
);

CREATE table delete_log (
    log_id int primary key auto_increment,
    post_id int,
    deleted_at datetime default current_timestamp,
    deleted_by int
);

CREATE table friend_requests(
	request_id INT PRIMARY KEY AUTO_INCREMENT,
    from_user_id INT,
    to_user_id INT, 
    status ENUM('pending','accepted','rejected') DEFAULT 'pending'
);

CREATE table friends(
	user_id INT,
    friend_id INT, 
    PRIMARY KEY(user_id, friend_id)
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

-- Bài 3
DELIMITER //
CREATE PROCEDURE sp_follow_user(IN p_follower_id INT, IN p_followed_id INT)
BEGIN
    declare exit handler for sqlexception
    BEGIN
        ROLLBACK;
        SELECT 'Lỗi: Đã xảy ra lỗi hệ thống, thao tác đã được khôi phục.' AS Message;
    END;

    start transaction;
    IF not exists (SELECT 1 FROM users WHERE user_id = p_follower_id) OR 
       not exists (SELECT 1 FROM users WHERE user_id = p_followed_id) THEN
        rollback;
        SELECT 'Một trong hai User ID không tồn tại trên hệ thống.' AS Message;

    ELSEIF p_follower_id = p_followed_id THEN
        rollback;
        SELECT 'Không thể tự follow chính mình.' AS Message;

    ELSEIF exists (SELECT 1 FROM follows WHERE follower_id = p_follower_id AND followed_id = p_followed_id) THEN
        rollback;
        SELECT 'Đã theo dõi' AS Message;

    ELSE
        INSERT INTO follows (follower_id, followed_id) 
        VALUES (p_follower_id, p_followed_id);
        
        UPDATE users 
        SET following_count = following_count + 1 
        WHERE user_id = p_follower_id;

        UPDATE users 
        SET followers_count = followers_count + 1 
        WHERE user_id = p_followed_id;

        COMMIT;
        SELECT 'Đã theo dõi người dùng.' AS Message;
    END IF;
END //
DELIMITER ;

CALL sp_follow_user(1, 2);
SELECT * FROM users WHERE user_id IN (1, 2);

CALL sp_follow_user(1, 1);

CALL sp_follow_user(1, 2);

-- Bài 4
DELIMITER //
CREATE PROCEDURE sp_add_comment(in p_post_id INT, in p_user_id int, in p_content text)
BEGIN
    START TRANSACTION;
    
        INSERT INTO comments (post_id, user_id, content) 
        VALUES (p_post_id, p_user_id, p_content);

        SAVEPOINT after_insert;

        if p_content = 'lỗi' THEN
            ROLLBACK TO after_insert;
            SELECT 'Đã có lỗi sau khi thêm bình luận' AS Message;
        else
            UPDATE posts 
            SET comments_count = comments_count + 1 
            WHERE post_id = p_post_id;
            SELECT 'Đã thêm bình luận và cập nhật số lượng.' AS Message;
        end if;

        COMMIT;
END //
DELIMITER ;
CALL sp_add_comment(1, 2, 'Bài viết rất hay!');
SELECT * FROM comments;
SELECT post_id, comments_count FROM posts WHERE post_id = 1;

CALL sp_add_comment(1, 3, 'lỗi');
SELECT * FROM comments;
SELECT post_id, comments_count FROM posts WHERE post_id = 1;

-- Bài 5
DELIMITER //
CREATE PROCEDURE sp_delete_post(IN p_post_id INT, IN p_user_id INT)
BEGIN
    declare exit handler for sqlexception
    BEGIN
        ROLLBACK;
        SELECT 'Lỗi khi xóa bài viết' AS Message;
    END;

    START TRANSACTION;
    IF NOT EXISTS (SELECT 1 FROM posts WHERE post_id = p_post_id AND user_id = p_user_id) THEN
        ROLLBACK;
        SELECT 'Bài viết không tồn tại hoặc bạn không có quyền xóa!' AS Message;
    ELSE
        DELETE FROM likes WHERE post_id = p_post_id;
        DELETE FROM comments WHERE post_id = p_post_id;
        DELETE FROM posts WHERE post_id = p_post_id;

        UPDATE users SET posts_count = posts_count - 1 WHERE user_id = p_user_id;

        INSERT INTO delete_log (post_id, deleted_by) VALUES (p_post_id, p_user_id);

        COMMIT;
        SELECT 'Xóa bài viết thành công!' AS Message;
    END IF;
END //
DELIMITER ;

CALL sp_delete_post(1, 1);
SELECT * FROM delete_log;

CALL sp_delete_post(2, 2);

-- Bài 6
INSERT INTO friend_requests (from_user_id, to_user_id, status) VALUES (2, 1, 'pending');

DELIMITER //
CREATE PROCEDURE sp_accept_friend_request(IN p_request_id INT, IN p_to_user_id INT)
BEGIN
    -- Biến lưu trữ ID người gửi để thực hiện kết bạn 2 chiều
    DECLARE v_from_user_id INT;
    DECLARE v_status ENUM('pending','accepted','rejected');

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Lỗi' AS Message;
    END;

    SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

    START TRANSACTION;

    -- 1. Kiểm tra request tồn tại và thuộc về người nhận đúng
    SELECT from_user_id, status INTO v_from_user_id, v_status 
    FROM friend_requests 
    WHERE request_id = p_request_id AND to_user_id = p_to_user_id;

    IF v_from_user_id IS NULL OR v_status != 'pending' THEN
        ROLLBACK;
        SELECT 'Yêu cầu không tồn tại hoặc đã được xử lý' AS Message;
    ELSE
        -- 2. INSERT vào bảng friends (2 bản ghi để kết bạn 2 chiều A-B và B-A)
        INSERT INTO friends (user_id, friend_id) VALUES (v_from_user_id, p_to_user_id);
        INSERT INTO friends (user_id, friend_id) VALUES (p_to_user_id, v_from_user_id);

        -- 3. UPDATE tăng friends_count cho cả hai user
        UPDATE users SET friends_count = friends_count + 1 WHERE user_id = v_from_user_id;
        UPDATE users SET friends_count = friends_count + 1 WHERE user_id = p_to_user_id;

        -- 4. UPDATE trạng thái lời mời thành 'accepted'
        UPDATE friend_requests SET status = 'accepted' WHERE request_id = p_request_id;

        COMMIT;
        SELECT 'Thành công: Đã chấp nhận lời mời kết bạn.' AS Message;
    END IF;
END //

DELIMITER ;

-- 1. Trường hợp thành công: User 1 chấp nhận lời mời từ User 2 
CALL sp_accept_friend_request(1, 1);

SELECT * FROM friends;
SELECT user_id, username, friends_count FROM users WHERE user_id IN (1, 2);
SELECT * FROM friend_requests;

-- 2. Trường hợp thất bại: Thử chấp nhận lại yêu cầu đã xử lý
CALL sp_accept_friend_request(1, 1);

-- 3. Trường hợp thất bại: Sai người nhận chấp nhận
CALL sp_accept_friend_request(1, 3);