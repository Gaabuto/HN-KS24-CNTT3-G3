use b01;

drop table if exists likes;
create table likes(
	like_id int auto_increment not null,
    post_id int not null,
    user_id int not null,
    primary key (like_id, post_id, user_id),
    foreign key (user_id) references users(user_id)
        on update cascade
        on delete cascade,
    foreign key (post_id) references posts(post_id)
        on update cascade
        on delete cascade
)engine=InnoDB;


insert into posts(user_id, content)
values (1, 'Bài viết đầu tiên của NVA');

start transaction;
insert into likes(post_id, user_id)
values (1, 2);

update posts set like_count = like_count + 1 
    where post_id = 1;
commit;
select * from likes where post_id = 1 and user_id = 2;
select post_id, like_count from posts 
    where post_id = 1;

start transaction;
insert into likes(post_id, user_id)
values (1, 2);

update posts set like_count = like_count + 1 
    where post_id = 1;
commit;

rollback;
select * from likes 
    where post_id = 1 and user_id = 2;
select post_id, like_count from posts 
    where post_id = 1;