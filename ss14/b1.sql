create database b01;
use b01;

drop table if exists users;
drop table if exists posts;
create table users(
	user_id int primary key auto_increment,
    username varchar(50) not null,
    posts_count int default(0),
    following_count int default(0),
    followers_count int default(0)
)engine=InnoDB;

create table posts(
	post_id int auto_increment not null,
    user_id int not null,
    content text not null,
    like_count int default(0),
    comments_count int default(0),
    created_at datetime default(current_timestamp()),
    primary key(post_id, user_id),
    foreign key (user_id) references users(user_id)
        on update cascade
        on delete cascade
)engine=InnoDB;

insert into users(username, posts_count)
values 
    ('NVA', 0), 
    ('NVB', 0);

select * from users;
select * from posts;

start transaction;
insert into posts(user_id, content)
values (1, 'First post');

update users set posts_count = posts_count + 1 
    where user_id = 1;
commit;

select * from users;
select * from posts;

start transaction;
insert into posts(user_id, content)
values (999, 'Check rollback');

update users set posts_count = posts_count + 1 
    where user_id = 999;
rollback;

select * from users;
select * from posts;