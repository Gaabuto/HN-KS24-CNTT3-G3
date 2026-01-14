use ss13_1;

drop trigger if exists trigger_notlikeForMyself_bfis;
drop trigger if exists trigger_notlikeForMyself_bfup;
drop trigger if exists trigger_like_afis;
drop trigger if exists trigger_like_afde;

delimiter //
create trigger trigger_notlikeForMyself_bfis before insert on likes for each row
begin
    declare v_post_owner int;
    select user_id into v_post_owner from posts
    where post_id = new.post_id;
    if v_post_owner is null then
        signal sqlstate '45000'
        set message_text = "Không được like bài viết chính mình";
    end if;
end//

create trigger trigger_notlikeForMyself_bfup before update on likes for each row
begin
    declare v_post_owner int;
    select user_id into v_post_owner from posts
    where post_id = new.post_id;
    if v_post_owner is null then
        signal sqlstate '45000'
        set message_text = 'post_id does not exists';
    end if;

    if new.user_id = v_post_owner then
        signal sqlstate '45000'
        set message_text = 'Không được like bài viết chính mình';
    end if;
end //

create trigger trigger_like_afis after insert on likes for each row
begin 
    update posts
    set like_count = like_count + 1
    where post_id = new.post_id;
end //

create trigger trigger_like_afde after delete on likes for each row
begin
    update posts
    set like_count = if(like_count > 0, like_count - 1, 0)
    where post_id = old.post_id;
end//

create trigger trigger_like_afup after update on likes for each row
begin
    if old.post_id <> new.post_id then
        update posts
        set like_count = if(like_count > 0, like_count - 1, 0)
        where post_id = old.post_id;
        update posts
        set like_count = like_count + 1
        where post_id = new.post_id;
    end if;
end //
delimiter ;

insert into likes (user_id, post_id, liked_at) values (1, 1, now());
insert into likes (user_id, post_id, liked_at) values (2, 1, now());
select post_id, user_id, like_count from posts
where post_id = 1;

update likes
set post_id = 4
where user_id = 2 and post_id = 1 limit 1;
select post_id, like_count from posts where post_id in (1, 4);

delete from likes
where user_id = 2 and post_id = 4 order by like_id desc limit 1;
select post_id, like_count from posts where post_id = 4;

select * from posts order by post_id;
select * from user_statistics order by user_id;