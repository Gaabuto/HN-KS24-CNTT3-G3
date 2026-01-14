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
delimiter //
create trigger check_likes_self
before insert
on likes for each row
begin
    if new.user_id = (
    select user_id
    from posts
    where post_id = new.post_id
    ) then
    signal sqlstate '45000'
	set message_text = 'user khong duoc like bai viet cua chinh minh';
    end if;
end //

create trigger after_insert_likecount
after insert
on likes
for each row
begin
    update posts
    set like_count = like_count + 1
    where post_id = new.post_id;
end//

create trigger after_delete_likecount
after delete
on likes
for each row
begin
    update posts
    set like_count = like_count - 1
    where post_id = old.post_id;
end//

create trigger after_update_likecount
after update
on likes
for each row
begin
    update posts
    set like_count = like_count + 1
    where post_id = new.post_id;
    
    update posts
    set like_count = like_count - 1
    where post_id = old.post_id;
end//

delimiter ;

-- bai 4

create table post_history (
    history_id int primary key auto_increment,
    post_id int not null,
    old_content text,
    new_content text,
    changed_at datetime,
    changed_by_user_id int,
    constraint fk_posthistory_posts
        foreign key (post_id)
        references posts(post_id)
        on delete cascade
);

delimiter //
create trigger before_update_post
before update
on posts
for each row
begin
	insert into post_history(post_id,old_content,new_content,changed_at,changed_by_user_id)
    values
    (old.post_id,old.content, new.content, now(), old.user_id);
end //

create trigger after_delete_post
after delete
on posts
for each row
begin
insert into post_history (post_id, old_content, changed_at, changed_by_user_id
    )
    values ( old.post_id, old.content,now(),old.user_id);
end //
delimiter ;

-- bai 5

delimiter //
create procedure addUser(name_in varchar(50), email_in varchar(100), created_at_in date)
begin
	insert into users(username, email, created_at)
    values
    (name_in, email_in,created_at_in);
end //

create trigger check_before_insert
before insert
on users
for each row
begin
if
new.email not like '%@%' or new.email not like '%.%' then
		signal sqlstate '45000'
        set message_text = 'email khong hop le';
end if;
end //
delimiter ;

-- bai 6
create table friendships (
    follower_id int not null,
    followee_id int not null,
    status enum('pending', 'accepted') default 'accepted',
    primary key (follower_id, followee_id),
    constraint fk_followers_follower
        foreign key (follower_id)
        references users(user_id)
        on delete cascade,
    constraint fk_followers_followee
        foreign key (followee_id)
        references users(user_id)
        on delete cascade
);

delimiter //
create trigger after_insert_friendship
after insert
on friendships
for each row
begin
if new.status = 'accepted' then
        update users
        set follower_count = follower_count + 1
        where user_id = new.followee_id;
    end if;
end //


create trigger after_delete_friendship
after delete
on friendships
for each row
begin
	if old.status = 'accepted' then
        update users
        set follower_count = follower_count - 1
        where user_id = old.followee_id;
    end if;
end //

create procedure follow_user(follower_id_in int, followee_id_in int, status_in enum('pending', 'accepted'))
begin
	if follower_id_in = followee_id_in then
        signal sqlstate '45000'
        set message_text = 'khong the follow ban than';
    end if;
    if exists(
		select 1
	from friendships
	where follower_id = p_follower_id
	and followee_id = p_followee_id
    ) then
	signal sqlstate '45000'
        set message_text = 'da follow';
    end if;
end //
delimiter ;