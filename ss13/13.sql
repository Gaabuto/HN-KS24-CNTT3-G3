create database if not exists socialnetworkdb;
use socialnetworkdb;


-- bai 1
-- bảng users
create table users (
    user_id int primary key auto_increment,
    username varchar(50) not null unique,
    email varchar(100) not null unique,
    created_at date,
    follower_count int default 0,
    post_count int default 0
);

-- bảng posts
create table posts (
    post_id int primary key auto_increment,
    user_id int,
    content text,
    created_at datetime,
    like_count int default 0,
    constraint fk_posts_users
        foreign key (user_id)
        references users(user_id)
        on delete cascade
);

insert into users (username, email, created_at) values
('alice', 'alice@example.com', '2025-01-01'),
('bob', 'bob@example.com', '2025-01-02'),
('charlie', 'charlie@example.com', '2025-01-03');

delimiter //
create trigger after_create_count_posts
after insert
on posts for each row
begin
update users 
set post_count = post_count + 1
where user_id = new.user_id;
end //

create trigger after_delete_count_posts
after delete
on posts for each row
begin
update users 
set post_count = post_count - 1
where  user_id = old.user_id;
end //
delimiter ;

INSERT INTO posts (user_id, content, created_at) VALUES

(1, 'Hello world from Alice!', '2025-01-10 10:00:00'),

(1, 'Second post by Alice', '2025-01-10 12:00:00'),

(2, 'Bob first post', '2025-01-11 09:00:00'),

(3, 'Charlie sharing thoughts', '2025-01-12 15:00:00');

SELECT * FROM users;

delete from posts where post_id = 2;

-- bai 2

create table likes (
    like_id int primary key auto_increment,
    user_id int not null,
    post_id int not null,
    liked_at datetime default current_timestamp,
    constraint fk_likes_users
        foreign key (user_id)
        references users(user_id)
        on delete cascade,
    constraint fk_likes_posts
        foreign key (post_id)
        references posts(post_id)
        on delete cascade
);

INSERT INTO likes (user_id, post_id, liked_at) VALUES

(2, 1, '2025-01-10 11:00:00'),

(3, 1, '2025-01-10 13:00:00'),

(1, 3, '2025-01-11 10:00:00'),

(3, 4, '2025-01-12 16:00:00');

delimiter //
create trigger after_insert_like
after insert
on likes for each row
begin
update likes
set like_count = like_count  + 1
where post_id = new.post_id;
end //

create trigger after_delete_like
after delete
on likes for each row
begin
update likes
set like_count = like_count - 1
where post_id = old.post_id;
end //
delimiter ;

create view user_statistics 
as
select u.user_id, u.username, count(u.like_count) as 'total_likes'
from users u;

INSERT INTO likes (user_id, post_id, liked_at) VALUES (2, 4, NOW());

SELECT * FROM posts WHERE post_id = 4;

SELECT * FROM user_statistics;

-- bai 3