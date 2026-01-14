DROP DATABASE IF EXISTS session13_ex2;
CREATE DATABASE session13_ex2;
USE session13_ex2;

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
(3, 4, '2025-01-12 16:00:00');

DELIMITER //

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

CREATE TRIGGER trigger_after_insert_like
AFTER insert ON likes
for each row
begin
	update posts SET like_count = like_count + 1 WHERE post_id = new.post_id;
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

-- bài 1
drop view user_statistics;
SELECT * FROM users;
DELETE FROM posts WHERE post_id = 2;

-- bài 2
INSERT INTO likes (user_id, post_id, liked_at) VALUES (2, 4, NOW());
SELECT * FROM posts WHERE post_id = 4;
SELECT * FROM user_statistics;
delete from likes where like_id = 1;