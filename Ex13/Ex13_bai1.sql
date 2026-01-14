create database ss13_ex1;
use ss13_ex1;

-- 1. tạo bảng users và posts
create table users (
    user_id int primary key auto_increment,
    username varchar(50) unique not null,
    email varchar(100) unique not null,
    created_at date,
    follower_count int default 0,
    post_count int default 0
);
create table posts (
    post_id int primary key auto_increment,
    user_id int,
    content text,
    created_at datetime,
    like_count int default 0,
    foreign key (user_id) references users(user_id) on delete cascade
);

-- 2. thêm dữ liệu mẫu user
insert into users (username, email, created_at) values
('alice', 'alice@example.com', '2025-01-01'),
('bob', 'bob@example.com', '2025-01-02'),
('charlie', 'charlie@example.com', '2025-01-03');

-- 3. tạo 2 trigger cập nhật post_count
delimiter $$
-- trigger 1: tăng post_count khi thêm bài đăng
drop trigger if exists update_post_count_insert $$
create trigger update_post_count_insert
after insert on posts
for each row
begin
    update users
    set post_count = post_count + 1
    where user_id = new.user_id;
end $$
-- trigger 2: giảm post_count khi xóa bài đăng
drop trigger if exists update_post_count_delete $$
create trigger update_post_count_delete
after delete on posts
for each row
begin
    update users
    set post_count = post_count - 1
    where user_id = old.user_id;
end $$
delimiter ;

-- 4. thực hiện insert bài đăng và kiểm tra
insert into posts (user_id, content, created_at) values
(1, 'Hello world from Alice!', '2025-01-10 10:00:00'),
(1, 'Second post by Alice', '2025-01-10 12:00:00'),
(2, 'Bob first post', '2025-01-11 09:00:00'),
(3, 'Charlie sharing thoughts', '2025-01-12 15:00:00');

-- hiển thị bảng users để kiểm chứng
select user_id, username, email, created_at, follower_count, post_count from users;

-- 5. xóa một bài đăng và kiểm tra lại
delete from posts where post_id = 2;

-- hiển thị lại bảng users 
select user_id, username, email, created_at, follower_count, post_count from users;