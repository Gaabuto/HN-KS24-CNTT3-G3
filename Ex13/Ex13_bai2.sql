create database ss13_ex2;
use ss13_ex2;

-- 2. tạo các bảng dữ liệu
create table users(
    user_id int auto_increment primary key,
    username varchar(50) unique not null,
    email varchar(100) unique not null,
    created_at date,
    follower_count int default(0),
    post_count int default(0)
) engine=InnoDB;

create table posts(
    post_id int auto_increment,
    user_id int not null,
    content text,
    created_at datetime,
    like_count int default(0),
    primary key(post_id, user_id),
    foreign key (user_id) references users(user_id)
    on update cascade
    on delete cascade
) engine=InnoDB;

create table likes(
    like_id int auto_increment,
    user_id int not null,
    post_id int not null,
    liked_at datetime,
    primary key(like_id, user_id, post_id),
    foreign key (user_id) references users(user_id)
    on update cascade
    on delete cascade,
    foreign key (post_id) references posts(post_id)
    on update cascade
    on delete cascade
) engine=InnoDB;

-- 3. tạo trigger cho bảng posts
delimiter $$
-- trigger 1: tăng post_count khi user đăng bài mới
drop trigger if exists posts_after_insert $$
create trigger posts_after_insert
after insert on posts
for each row
begin 
    update users set post_count = post_count + 1 where user_id = new.user_id;
end $$
-- trigger 2: giảm post_count khi xóa bài đăng
drop trigger if exists posts_after_delete $$
create trigger posts_after_delete
after delete on posts
for each row
begin
    update users set post_count = if(post_count > 0, post_count - 1, 0) where user_id = old.user_id;
end $$
delimiter ;

-- 4. thêm dữ liệu mẫu users và posts
insert into users (username, email, created_at) values 
('alice', 'alice@example.com', '2025-01-01'),
('bob', 'bob@example.com', '2025-01-02'),
('charlie', 'charlie@example.com', '2025-01-03');

insert into posts (user_id, content, created_at) values 
(1, 'Hello world from Alice!', '2025-01-10 10:00:00'),
(1, 'Second post by Alice', '2025-01-10 12:00:00'),
(2, 'Bob first post', '2025-01-11 09:00:00'),
(3, 'Charlie sharing thoughts', '2025-01-12 15:00:00');

-- 5. tạo trigger cho bảng likes
delimiter $$ 
-- trigger 3: tăng like_count khi ai đó thích bài viết
drop trigger if exists likes_after_insert $$
create trigger likes_after_insert
after insert on likes
for each row
begin
    update posts set like_count = like_count + 1 where post_id = new.post_id;
end $$
-- trigger 4: giảm like_count khi ai đó bỏ thích
drop trigger if exists likes_after_delete $$
create trigger likes_after_delete
after delete on likes
for each row
begin
    update posts set like_count = if(like_count > 0, like_count - 1, 0) where post_id = old.post_id;
end $$
delimiter ;

-- 6. thêm dữ liệu mẫu vào likes
insert into likes (user_id, post_id, liked_at) values 
(2, 1, '2025-01-10 11:00:00'),
(3, 1, '2025-01-10 13:00:00'),
(1, 3, '2025-01-11 10:00:00'),
(3, 4, '2025-01-12 16:00:00');

-- 7. tạo view thống kê (user_statistics)
-- hiển thị: thông tin user, số bài đăng, tổng lượt like nhận được
create or replace view user_statistics as
select u.user_id, u.username, u.post_count, coalesce(sum(p.like_count), 0) as total_likes
from users u
left join posts p on p.user_id = u.user_id
group by u.user_id, u.username, u.post_count;

-- 8. kiểm chứng trigger insert: thêm 1 like mới vào post 4
insert into likes (user_id, post_id, liked_at) values (2, 4, now());
-- kiểm tra bảng posts 
select post_id, user_id, content, like_count from posts where post_id = 4;
-- kiểm tra view thống kê
select user_id, username, post_count, total_likes from user_statistics;

-- 9. kiểm chứng delete
delete from likes where user_id = 2 and post_id = 4;
-- kiểm tra lại bảng posts
select post_id, user_id, content, like_count from posts where post_id = 4;
-- kiểm tra lại view thống kê
select user_id, username, post_count, total_likes from user_statistics;