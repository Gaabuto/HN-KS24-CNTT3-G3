create database ss13_1;
use ss13_1;

drop table if exists posts;
drop table if exists users;

create table users (
    user_id int auto_increment primary key,
    username varchar(50) not null, 
    email varchar(100) not null unique,
    created_at date,
    follower_count int default 0,
    post_count int default 0
);

create table posts(
    post_id int auto_increment primary key,
    user_id int not null,
    content text,
    created_at datetime,
    like_count int default 0,
    constraint fk_posts_users foreign key(user_id) references users(user_id)
    on delete cascade
);

insert into users(username, email, created_at)
values 
    ('alice', 'alice@example.com', '2025-01-01'),
    ('bob', 'bob@example.com', '2025-01-02'),
    ('charlie', 'charlie@example.com', '2025-01-03');

drop trigger if exists trigger_posts_atis;
drop trigger if exists trigger_posts_afdl;

delimiter //
create trigger trigger_posts_atis after insert on posts for each row
begin
    update users
    set post_count = post_count + 1
    where user_id = new.user_id;
end//

create trigger trigger_posts_afdl after delete on posts for each row
begin
    update users
    set post_count = if(post_count > 0, post_count - 1, 0)
    where user_id = old.user_id;
end//
delimiter ;

insert into posts(user_id, content, created_at)
values
    (1, 'Hello world from Alice!', '2025-01-10 10:00:00'),
    (1, 'Second post by Alice', '2025-01-10 12:00:00'),
    (2, 'Bob first post', '2025-01-11 09:00:00'),
    (3, 'Charlie sharing thoughts', '2025-01-12 15:00:00');

select * from users;
select * from posts;
delete from posts where post_id = 2;
select * from users;
