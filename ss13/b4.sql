
use ss13_1;
drop table if exists post_history;

create table post_history (
    history_id int auto_increment primary key,
    post_id int not null,
    old_content text,
    new_content text,
    changed_at datetime,
    changed_by_user_id int,
    constraint fk_history_posts foreign key(post_id) references posts(post_id)
        on delete cascade
);

drop trigger if exists trigger_posts_bfup;
delimiter //
create trigger trigger_posts_bfup before update on posts for each row
begin
    if not (old.content <=> new.content) then
        insert into post_history(post_id, old_content, new_content, changed_at, changed_by_user_id)
        values (old.post_id, old.content, new.content, now(), old.user_id);
    end if;
end//
delimiter ;

insert into likes(user_id, post_id) 
values
    (2, 1),
    (3, 1),
    (1, 3);

update posts
set content = 'Hello from alice (edited)' 
where post_id = 1;

update posts set content = 'First post (edited)'
where post_id = 3;

update posts
set created_at = now()
where post_id = 1;

update posts
set content = 'Hello from alice (edited v2)' 
where post_id = 1;

select * from post_history order by changed_at desc;

select post_id, user_id, content, like_count from posts order by post_id;
insert into likes(user_id, post_id) values (2, 3);
select post_id, like_count from posts where post_id in (1, 3);

select database() as current_db;
select count(*) as total_posts from posts;
select post_id, user_id, left(content, 50) as content_preview from posts order by post_id;