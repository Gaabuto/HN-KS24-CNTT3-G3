drop database if exists ss13_ex3;
create database ss13_ex3;
use ss13_ex3;

create table users(
	user_id int auto_increment primary key,
    username varchar(50) unique not null,
    email varchar(100) unique not null,
    created_at date,
    follower_count int default(0),
    post_count int default(0)
    
)engine=InnoDB;

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
    
)engine=InnoDB;

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
    
)engine=InnoDB;
    
insert into users (username, email, created_at) 
values ('alice', 'alice@example.com', '2025-01-01'),
('bob', 'bob@example.com', '2025-01-02'),
('charlie', 'charlie@example.com', '2025-01-03');


delimiter $$
drop trigger if exists posts_after_insert $$
create trigger posts_after_insert
after insert on posts
for each row
begin 
	update users set post_count= post_count+1 where user_id=new.user_id;
end $$

drop trigger if exists posts_after_delete $$
create trigger posts_after_delete
after delete on posts
for each row
begin
	update users set post_count = if(post_count>0, post_count-1,0) where user_id = old.user_id;
end $$
delimiter ;

insert into posts (user_id, content, created_at) 
values (1, 'Hello world from Alice!', '2025-01-10 10:00:00'),
(1, 'Second post by Alice', '2025-01-10 12:00:00'),
(2, 'Bob first post', '2025-01-11 09:00:00'),
(3, 'Charlie sharing thoughts', '2025-01-12 15:00:00');

select * from users;

delete from posts where post_id = 2;

select * from users;


insert into likes (user_id, post_id, liked_at)
values (2, 1, '2025-01-10 11:00:00'),
(3, 1, '2025-01-10 13:00:00'),
(1, 3, '2025-01-11 10:00:00'),
(3, 4, '2025-01-12 16:00:00');

delimiter $$ 
drop trigger if exists likes_after_insert $$
create trigger likes_after_insert
after insert on likes
for each row
begin
  update posts set like_count = like_count + 1 where post_id = new.post_id;
end $$

drop trigger if exists likes_after_delete $$
create trigger likes_after_delete
after delete on likes
for each row
begin
  update posts set like_count = if(like_count > 0, like_count - 1, 0) where post_id = old.post_id;
end $$
delimiter ;
	
insert into likes (user_id, post_id, liked_at) 
values (2, 1, '2025-01-10 11:00:00'),
(3, 1, '2025-01-10 13:00:00'),
(1, 3, '2025-01-11 10:00:00'),
(3, 4, '2025-01-12 16:00:00');

create or replace view user_statistics as
select u.user_id, u.username, u.post_count, coalesce(sum(p.like_count), 0) as total_likes
from users u
left join posts p on p.user_id = u.user_id
group by u.user_id, u.username, u.post_count;

insert into likes (user_id, post_id, liked_at) values (2, 4, now());

select * from posts where post_id = 4;
select * from user_statistics;

delete from likes where user_id = 2 and post_id = 4;

select * from posts where post_id = 4;
select * from user_statistics;


delimiter $$
drop trigger if exists likes_before_insert $$
create trigger likes_before_insert
before insert on likes
for each row
begin
  declare v_post_owner int;
  select p.user_id into v_post_owner from posts p where p.post_id = new.post_id
  limit 1;
  if v_post_owner is null then
    signal sqlstate '45000'
      set message_text = 'post khong ton tai';
  end if;
  if new.user_id = v_post_owner then
    signal sqlstate '45000'
      set message_text = 'khong duoc like bai dang cua chinh minh';
  end if;
end $$

drop trigger if exists likes_after_insert $$
create trigger likes_after_insert
after insert on likes
for each row
begin
  update posts set like_count = like_count + 1 where post_id = new.post_id;
end $$

drop trigger if exists likes_after_delete $$
create trigger likes_after_delete
after delete on likes
for each row
begin
  update posts set like_count = if(like_count > 0, like_count - 1, 0) where post_id = old.post_id;
end $$

drop trigger if exists likes_after_update $$
create trigger likes_after_update
after update on likes
for each row
begin
  if old.post_id <> new.post_id then
    update posts set like_count = if(like_count > 0, like_count - 1, 0) where post_id = old.post_id;
    update posts set like_count = like_count + 1 where post_id = new.post_id;
  end if;
end $$
delimiter ;

insert into likes (user_id, post_id, liked_at) values (2, 1, now());
select * from posts where post_id = 1;
select * from user_statistics;

select * from likes;
update likes
set post_id = 4
where user_id = 2 and post_id = 1;
select * from posts where post_id in (1, 4);
select * from user_statistics;

delete from likes where user_id = 2 and post_id = 4;
select * from posts where post_id = 4;
select * from user_statistics;

select * from posts order by post_id;
select * from user_statistics order by user_id;