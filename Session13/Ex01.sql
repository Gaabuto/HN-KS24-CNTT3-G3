create database ss13_db;
use ss13_db;

create table users(
	user_id int primary key auto_increment,
    username varchar(50) unique not null,
    email varchar(100) unique not null,
    created_at date,
    follower_count int default(0),
    post_count int default(0)
);

create table posts(
	post_id int primary key auto_increment,
    user_id int,
    content text,
    created_at datetime,
    like_count int default(0),
    foreign key (user_id) references users(user_id)
);

insert into users (username, email, created_at) 
values
	('alice', 'alice@example.com', '2025-01-01'),
	('bob', 'bob@example.com', '2025-01-02'),
	('charlie', 'charlie@example.com', '2025-01-03');

DELIMITER $$
create trigger after_insert_post_count
after insert
on posts for each row
begin
	update users
    set post_count = post_count + 1
    where user_id = new.user_id;
end $$

create trigger after_delete_post_count
after delete
on posts for each row
begin
	update users 
	set post_count = post_count - 1
	where  user_id = old.user_id;
end $$
DELIMITER ;

INSERT INTO posts (user_id, content, created_at) VALUES

(1, 'Hello world from Alice!', '2025-01-10 10:00:00'),

(1, 'Second post by Alice', '2025-01-10 12:00:00'),

(2, 'Bob first post', '2025-01-11 09:00:00'),

(3, 'Charlie sharing thoughts', '2025-01-12 15:00:00');

SELECT * FROM users;

delete from posts where post_id = 2;
