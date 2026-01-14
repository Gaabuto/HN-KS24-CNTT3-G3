use ss13_1;
drop table if exists likes;
create table likes(
    like_id int auto_increment primary key,
    user_id int not null,
    post_id int not null,
    liked_at datetime default current_timestamp,
    constraint fk_likes_users foreign key(user_id) references users(user_id)
        on delete cascade,
    constraint fk_likes_posts foreign key(post_id) references posts(post_id)
        on delete cascade
);

insert into likes(user_id, post_id, liked_at)
values
    (2, 1, '2025-01-10 11:00:00'),
    (3, 1, '2025-01-10 13:00:00'),
    (1, 3, '2025-01-11 10:00:00'),
    (3, 4, '2025-01-12 16:00:00');

drop trigger if exists trigger_like_afis;
drop trigger if exists trigger_like_afdl;

delimiter //
create trigger trigger_like_afis after insert on likes for each row
begin
    update posts
    set like_count = like_count + 1
    where post_id = new.post_id;
end//

create trigger trigger_like_afdl after delete on likes for each row
begin
    update posts
    set like_count = if(like_count > 0, like_count - 1, 0)
    where post_id = old.post_id;
end//

delimiter ;

update posts p
join (
    select post_id, count(*) as cnt from likes group by post_id
) x on x.post_id = p.post_id
set p.like_count = x.cnt;

create or replace view user_statistics as
select u.user_id, u.username, u.post_count, ifnull(sum(p.like_count), 0) as total_likes from users u
left join posts p on p.user_id = u.user_id group by u.user_id, u.username, u.post_count;

insert into likes(user_id, post_id, liked_at) values(2, 4, now());

select * from posts where post_id = 4;
select * from user_statistics;

delete from likes where user_id = 2 and post_id = 4 order by like_id desc limit 1;

select * from posts where post_id = 4;
select * from user_statistics;