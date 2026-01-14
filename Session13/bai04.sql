DROP DATABASE IF EXISTS session13_ex4;
CREATE DATABASE session13_ex4;
USE session13_ex4;

CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at DATE,
    follower_count INT DEFAULT 0,
    post_count INT DEFAULT 0
);

CREATE TABLE posts (
    post_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    content TEXT,
    created_at DATETIME,
    like_count INT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE table likes(
	like_id int primary key auto_increment,
    user_id int,
    post_id int,
    liked_at datetime default '2026-01-01',
    foreign key(user_id) references users(user_id) on delete cascade,
    foreign key(post_id) references posts(post_id) on delete cascade
);

CREATE table post_history(
	history_id int primary key auto_increment,
    post_id int,
    old_content text,
    new_content text,
    changed_at datetime,
    changed_by_user_id int,
    foreign key(post_id) references posts(post_id) on delete cascade
);

INSERT INTO users (username, email, created_at) VALUES
('alice', 'alice@example.com', '2025-01-01'),
('bob', 'bob@example.com', '2025-01-02'),
('charlie', 'charlie@example.com', '2025-01-03');

INSERT INTO posts (user_id, content, created_at) VALUES
(1, 'Hello world from Alice!', '2025-01-10 10:00:00'),
(1, 'Second post by Alice', '2025-01-10 12:00:00'),
(2, 'Bob first post', '2025-01-11 09:00:00'),
(3, 'Charlie sharing thoughts', '2025-01-12 15:00:00');

INSERT INTO likes (user_id, post_id, liked_at) VALUES
(2, 1, '2025-01-10 11:00:00'),
(3, 1, '2025-01-10 13:00:00'),
(1, 3, '2025-01-11 10:00:00'),
(3, 1, '2025-01-12 16:00:00');

DELIMITER //

-- POST
CREATE TRIGGER trigger_after_insert_post
AFTER INSERT ON posts
FOR EACH ROW
BEGIN 
    UPDATE users SET post_count = post_count + 1 WHERE user_id = NEW.user_id;
END //

CREATE TRIGGER trigger_after_delete_post
AFTER DELETE ON posts
FOR EACH ROW
BEGIN 
    UPDATE users SET post_count = post_count - 1 WHERE user_id = OLD.user_id;
END //

CREATE TRIGGER trigger_before_update_post
BEFORE UPDATE ON posts
for each row
begin
	if old.content <> new.content then
		INSERT INTO post_history(post_id, old_content, new_content, changed_at, changed_by_user_id)
        VALUES (old.post_id, old.content, new.content, now(), old.user_id);
	end if;
end //

-- LIKE
CREATE TRIGGER trigger_before_insert_like
BEFORE insert ON likes
for each row
begin
	if (SELECT user_id FROM posts WHERE post_id = NEW.post_id) = NEW.user_id then signal sqlstate '45000' set message_text = 'Không thể like bài đăng của chính mình';
    end if;
end //

CREATE TRIGGER trigger_after_insert_like
AFTER insert ON likes
for each row
begin
	update posts SET like_count = like_count + 1 WHERE post_id = new.post_id;
end //

CREATE TRIGGER trigger_after_update_like
AFTER update ON likes
for each row
begin
    UPDATE posts SET like_count = like_count - 1 WHERE post_id = OLD.post_id;
    UPDATE posts SET like_count = like_count + 1 WHERE post_id = NEW.post_id;
end //

CREATE TRIGGER trigger_after_delete_like
AFTER delete ON likes
for each row
begin
	update posts SET like_count = like_count - 1 WHERE post_id = old.post_id;
end //

DELIMITER ;

CREATE view user_statistics AS
SELECT u.user_id, u.username, u.post_count, ifnull(SUM(p.like_count),0) as total_likes
FROM users as u
JOIN posts as p ON u.user_id = p.user_id
GROUP BY u.user_id;

-- Bài 1
drop view user_statistics;
SELECT * FROM users;
DELETE FROM posts WHERE post_id = 2;

-- Bài 2
INSERT INTO likes (user_id, post_id, liked_at) VALUES (2, 4, NOW());
SELECT * FROM posts WHERE post_id = 4;
SELECT * FROM user_statistics;
delete from likes where like_id = 1;

-- Bài 3
INSERT INTO likes (user_id, post_id, liked_at) VALUES (1, 1, NOW());
INSERT INTO likes (user_id, post_id, liked_at) VALUES (1, 4, NOW());
SELECT * FROM posts;
UPDATE likes SET post_id = 4 WHERE like_id = 1;
DELETE FROM likes WHERE like_id = 2;
SELECT * FROM user_statistics;

-- Bài 4
UPDATE posts 
SET content = 'Nội dung đã được Alice chỉnh sửa!' 
WHERE post_id = 1;
SELECT * FROM post_history;
INSERT INTO likes (user_id, post_id) VALUES (2, 1);
SELECT * FROM posts WHERE post_id = 1;
SELECT * FROM user_statistics;